Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6D748452
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGEMjE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGEMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:39:03 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7848C12F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:39:02 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57916e0badcso56962067b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688560741; x=1691152741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODdZw5w6iGqiraBXY4M8X7yrPsBvzOP0DzF3PrDV5GE=;
        b=Jf9deYRBkdFlmzM9xHyz+t8ZQXgwz1UA9B+rYFN54wUyh8h7CFas0XsUwFDNG78gus
         yyBJFMj3F3h02k8SH4vUPw+ElfVeS6TmqrkRTl4fd7JmPWHFIlioJwol/4ycf/OmVz+1
         z27ZlYqkir9D8+osh0YZh9wmrK3QzQvCA18LyZb8EIubJyNlgr1ru6lUhd3oK5WHO6jw
         sRUzxjk7U8a7xFw0xUx7ZFGGLFmDS5Eoric4WD4Wt7ga+BAXC1fRIfRUnfjgKIHYizbi
         SgmRv6Auw5xNms6m/5DZfqjTZ0hUA2ecWSs/Nj5dCCcZibJF4seDZC2BLgITbzrXaLjA
         sJ/A==
X-Gm-Message-State: ABy/qLZdZRDytMJQZsBnnEgIaGkoQh0Cwhzh4KNOrHRLAnIIpNrKK5RO
        cri7RV9qCFn+OSQ8CZFuKIiRd5Y61AL7cQ==
X-Google-Smtp-Source: APBJJlFOTwgZhjAE+8MwqJ7fiHvTQXuuXRywAQv8lbcqg2z9VC9npn496nvnxUEBRzs+dIae2mYRJQ==
X-Received: by 2002:a81:8416:0:b0:56f:ecc4:7dbe with SMTP id u22-20020a818416000000b0056fecc47dbemr15604357ywf.34.1688560741256;
        Wed, 05 Jul 2023 05:39:01 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id n145-20020a0dcb97000000b005707b90331dsm6145490ywd.10.2023.07.05.05.39.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 05:39:00 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c5c03379a76so2110820276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:39:00 -0700 (PDT)
X-Received: by 2002:a25:42c6:0:b0:c4e:f358:4dd6 with SMTP id
 p189-20020a2542c6000000b00c4ef3584dd6mr8280017yba.25.1688560740643; Wed, 05
 Jul 2023 05:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230705121307.17204-1-duminjie@vivo.com>
In-Reply-To: <20230705121307.17204-1-duminjie@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 14:38:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCyO5JUpMExBK0OgoGfe0MYhP4WcOfrwqQkbb7FUsrxw@mail.gmail.com>
Message-ID: <CAMuHMdVCyO5JUpMExBK0OgoGfe0MYhP4WcOfrwqQkbb7FUsrxw@mail.gmail.com>
Subject: Re: [PATCH v1] m68k: apollo: Remove a duplicate assignment in dn_timer_int
To:     Minjie Du <duminjie@vivo.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minjie,

On Wed, Jul 5, 2023 at 2:13 PM Minjie Du <duminjie@vivo.com> wrote:
> Delete a duplicate statement from this function implementation.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Thanks for your patch, which is presumably untested on real hardware?

> --- a/arch/m68k/apollo/config.c
> +++ b/arch/m68k/apollo/config.c
> @@ -173,7 +173,6 @@ irqreturn_t dn_timer_int(int irq, void *dev_id)
>         legacy_timer_tick(1);
>         timer_heartbeat();
>
> -       x = *(volatile unsigned char *)(apollo_timer + 3);
>         x = *(volatile unsigned char *)(apollo_timer + 5);

This is intentional: the use of volatile makes sure the registers at
offsets 3 and 5 are read, in that order.

I agree this could be made more obvious by converting the code to the
more modern READ_ONCE() helper.
But please do not send such a patch without testing.

>
>         return IRQ_HANDLED;

NAKed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
