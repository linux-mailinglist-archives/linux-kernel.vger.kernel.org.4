Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3E6B7797
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCMMe3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCMMe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:34:26 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8D42BEB;
        Mon, 13 Mar 2023 05:34:06 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id t13so1191556qvn.2;
        Mon, 13 Mar 2023 05:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txUNeUXSkINlsmXbzrnBl+u3YlAFA225dm1gz5Yqp08=;
        b=aL29uLJ7vOhSMOD6IRdQNmIrtfRB08IMM1azBFhVoDvjRMggXRDjamU4OzyjFehq0w
         6CaanwFM19TC21pfKjc6YS0YhH/kNZSPk/jcHz+n72IQgaYx9RB4jgELDlfRvyewQwQS
         M/RC+JKWCljJ31i6FLnlsTMwJn4NPsK4buk3ElrySx6taVmWm3isiuuyPMRg+cSZ5Dwy
         Z2Sn1TUztQKpqLKuixrt8tuoG6aOcZ+W5VLbpCzopv0jNgDLSBavHEakND5dNZ90sNIi
         m/7u/o55qrPgP3/683quYqDJ3NCVoX47c5EL3pQ3B6aQGY6HsymCgM11Ql+PsfoStpdM
         YfuQ==
X-Gm-Message-State: AO0yUKW/RgApkG9cgmZgHLEIc07gmQVGepL+KPM+DdVUGuNENpCJXjPL
        S6eIPxHZkEi+Tfjeg1hq021KYjcVv1ObZw==
X-Google-Smtp-Source: AK7set/7O5cPOjWWT5NL1zQ86npGGa4Hwc1IonZHqxwpW6TemzAMGdwkBNz78HP+gQRRP2c2RcTiXA==
X-Received: by 2002:ad4:5caa:0:b0:56a:8d2a:8ef9 with SMTP id q10-20020ad45caa000000b0056a8d2a8ef9mr15311895qvh.35.1678710820761;
        Mon, 13 Mar 2023 05:33:40 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 198-20020a3707cf000000b007456efa7f73sm3310058qkh.85.2023.03.13.05.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:33:40 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5419d4c340aso53826987b3.11;
        Mon, 13 Mar 2023 05:33:40 -0700 (PDT)
X-Received: by 2002:a81:e30e:0:b0:541:7f69:aa9b with SMTP id
 q14-20020a81e30e000000b005417f69aa9bmr3803604ywl.4.1678710820086; Mon, 13 Mar
 2023 05:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230312132650.352796-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312132650.352796-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Mar 2023 13:33:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQsQZgU213+c3eJKZ2+p69AorUEhHck84NAN01QtxEBg@mail.gmail.com>
Message-ID: <CAMuHMdVQsQZgU213+c3eJKZ2+p69AorUEhHck84NAN01QtxEBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: renesas: mark OF related data as maybe unused
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your patch!

On Sun, Mar 12, 2023 at 2:26 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/soc/renesas/renesas-soc.c:272:34: error: ‘renesas_socs’ defined but not used [-Werror=unused-const-variable=]

Where do you see this issue?
This variable is used unconditionally, and the driver builds fine for
me for m68k/allmodconfig+CONFIG_OF=n?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -269,7 +269,7 @@ static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
>  };
>
>
> -static const struct of_device_id renesas_socs[] __initconst = {
> +static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
>  #ifdef CONFIG_ARCH_R7S72100
>         { .compatible = "renesas,r7s72100",     .data = &soc_rz_a1h },
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
