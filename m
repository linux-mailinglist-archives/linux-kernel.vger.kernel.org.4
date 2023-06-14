Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E172F952
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbjFNJfj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244141AbjFNJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:35:04 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906042102
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:34:50 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-56d2b7a9465so5808457b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735289; x=1689327289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbNw7KSFt9rA0O4w0LVl8suouqVzbOa7coQNBiypPBM=;
        b=JTDrFibA8eApskNYgHS6f8awjHwK7EsQDIetlaMN+M+9+bBWbJgQsdrpI7KOE8Gt36
         UDDSuPxXizaBnWavOhKrsDwBuCZy46+Yi+hUBrfbwfeIeLoSUl9yAtDdOu2hl7pr84rC
         bgaOTrLix3CN5OjIF47MDFQevIi8YQimlCBL/PxTRKdS9HAG5emsgRn5LqpVjAWBUIi1
         J+hoz6KKfO0HetSxerGtLLVvsb4WfdOS4TQxIIc4aEvUyIelZnRFmFrQCV0bN36bh8C/
         doWjU6FnYbqqYDp+CE14y1xgOJl1+Ylt0uPRJiN1HzPoUtVGcvsKs7U+n4twidcDUS46
         LDfw==
X-Gm-Message-State: AC+VfDz5dPa09sbwwjJsWM3rEOPQTaB5Pxd9OBG5tQUe4vNbpqzsKA37
        C2BmwYRIyfLoXrCzAW/g2XDcZ6h26lqREA==
X-Google-Smtp-Source: ACHHUZ47C5LhshIfGrtYSDPT5cBZabOhzuYpm311meyiPqrTNTZemILJOWWAwBVhjvw+Zyye8/Clqw==
X-Received: by 2002:a81:5ac4:0:b0:56c:fe54:4183 with SMTP id o187-20020a815ac4000000b0056cfe544183mr857221ywb.52.1686735289560;
        Wed, 14 Jun 2023 02:34:49 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id y205-20020a817dd6000000b00565374c5962sm714494ywc.98.2023.06.14.02.34.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:34:49 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-56cfce8862aso5894257b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:34:49 -0700 (PDT)
X-Received: by 2002:a25:b096:0:b0:bac:69be:9494 with SMTP id
 f22-20020a25b096000000b00bac69be9494mr1910027ybj.36.1686735289225; Wed, 14
 Jun 2023 02:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230614032446.8391-1-zhanglibing@cdjrlc.com> <4c81c6406707cf2e26b43bd4c5caca3a@208suo.com>
 <74ed374c5d5ec504d3bbecef656c1b37@208suo.com>
In-Reply-To: <74ed374c5d5ec504d3bbecef656c1b37@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Jun 2023 11:34:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEOxVs1YOnmhbgqWMqpG-erahs8_OdpL1Jhck7KK+F0g@mail.gmail.com>
Message-ID: <CAMuHMdVEOxVs1YOnmhbgqWMqpG-erahs8_OdpL1Jhck7KK+F0g@mail.gmail.com>
Subject: Re: [PATCH] m68k/q40: Fix syntax error
To:     wuyonggang001@208suo.com
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonggang,

Thanks for your patch!

On Wed, Jun 14, 2023 at 8:16 AM <wuyonggang001@208suo.com> wrote:
>
> Fix the following checkpatch error:

The patch subject does not match the description.

>
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
>
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>

scripts/checkpatch.pl says:

    WARNING: From:/Signed-off-by: email name mismatch: 'From:
wuyonggang001@208suo.com' != 'Signed-off-by: Yonggang Wu
<wuyonggang001@208suo.com>'

> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c

> @@ -270,7 +270,7 @@ static int q40_set_rtc_pll(struct rtc_pll_info *pll)
>       if (!pll->pll_ctrl) {
>           /* the docs are a bit unclear so I am doublesetting */
>           /* RTC_WRITE here ... */
> -        int tmp = (pll->pll_value & 31) | (pll->pll_value<0 ? 32 : 0) |
> +        int tmp = (pll->pll_value & 31) | (pll->pll_value < 0 ? 32 : 0)
> |

ERROR: patch seems to be corrupt (line wrapped?)

>                 Q40_RTC_WRITE;
>           Q40_RTC_CTRL |= Q40_RTC_WRITE;
>           Q40_RTC_CTRL = tmp;


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
