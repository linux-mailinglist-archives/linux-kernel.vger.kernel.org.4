Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A156A73474C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFRRka convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:40:26 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD0F1B5;
        Sun, 18 Jun 2023 10:40:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5702116762fso32614927b3.3;
        Sun, 18 Jun 2023 10:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687110024; x=1689702024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amJGUKjp5oGz/tKayl+1XivBm6hIlBGrgnz6eQlEOCU=;
        b=l+TCmmkO4J+03JZl2w0pAPYlP5a7UCZpW6mFdIeA3RWukkS1zPlVM2n9gRbuNVl2cS
         dF8hStAkaKMzBoj4AGOYaowx7I3ge6Anz7bHAtb9DRVgImkpXtdK+LujK9+sAMqrad48
         aXvh+APIEZlVJehx21CnpTnWqWzb7Iz4H01cNi/iokn6B7rYQgWbi15Oes8VYD4cgjkp
         jYB/G6ugEPZHrw4w5Ct6pzWTZemHPQ3GFqmfuc1e0jR6yJLz4cQIzzy/IeX8oIGrpPMN
         aXlNXeVkuSQwu7BW0gcaaUsCDTHkxC2tBUkUztMpU7uGBiLeYL3ON3dTWAt5t/Gvg0YC
         aKbA==
X-Gm-Message-State: AC+VfDwbfa/9NYFC0M67e/EbHHaM+Np3kFAiJXaU/8b/wOyh1+7zSzkM
        ezmDtRDP+R7Mv9pJUiaqg1uLaZ6x/GzDJdBa
X-Google-Smtp-Source: ACHHUZ598kbbjt87uA1MinglZTifgxGcg6Y6xUG753LFYg8O+lfD/47p0MI5jc8BPXp8TDCEzdsw3A==
X-Received: by 2002:a0d:c845:0:b0:570:a6b:fefc with SMTP id k66-20020a0dc845000000b005700a6bfefcmr8016744ywd.21.1687110024575;
        Sun, 18 Jun 2023 10:40:24 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b0057042405e2csm1816724ywe.71.2023.06.18.10.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 10:40:23 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5701e8f2b79so32807367b3.0;
        Sun, 18 Jun 2023 10:40:23 -0700 (PDT)
X-Received: by 2002:a81:bf46:0:b0:56f:f890:3149 with SMTP id
 s6-20020a81bf46000000b0056ff8903149mr9364206ywk.16.1687110023119; Sun, 18 Jun
 2023 10:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230615182938.18487-1-tanure@linux.com> <20230615182938.18487-6-tanure@linux.com>
 <ZIufK7uK0ZrsVTZ3@ofant>
In-Reply-To: <ZIufK7uK0ZrsVTZ3@ofant>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 18 Jun 2023 18:40:12 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3_UME4xigEU+_dXrdLi+YkL0+TC-Y552LBcuTii4=V5w@mail.gmail.com>
Message-ID: <CAJX_Q+3_UME4xigEU+_dXrdLi+YkL0+TC-Y552LBcuTii4=V5w@mail.gmail.com>
Subject: Re: [PATCH 5/6] tty: serial: meson: Added T7 SOC compatibility
To:     Yixun Lan <dlan@gentoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:31 AM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Lucas:
>
> On 19:29 Thu 15 Jun     , Lucas Tanure wrote:
> > Make UART driver compatible with T7 SOC UART.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  drivers/tty/serial/meson_uart.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index 2501db5a7aaf..0208f9a6ba7e 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -796,6 +796,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
> >               .compatible = "amlogic,meson-s4-uart",
> >               .data = (void *)&meson_g12a_uart_data,
> >       },
> > +     {
> > +             .compatible = "amlogic,meson-t7-uart",
> > +             .data = (void *)&meson_g12a_uart_data,
> I think you are trying to follow previous s4 scheme - to introduce a new
> compatible string, while I think it's not necessary or even wrong, this will just
> make the dt_match_list longer but without obvious benefits..
>
> as Conor already raised this question in previous dt-binding patch[4/6],
> how about just using 'amlogic,meson-g12a-uart' which is the first compatible
> introduced.
>
> if people agree, we could also drop 'amlogic,meson-s4-uart' since it use same
> compatible data as gl12a, anyway it should be separated into another patch..
>
> > +     },
> >       { /* sentinel */ },
>
>
> >  };
> >  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
> > --
> > 2.41.0
> >
> >
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
>
> --
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

Yes, I am dropping this patch and using s4 and g12a compatible lines.
