Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D957A7433A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF3Ej0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 00:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3EjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:39:25 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B4A1FC0;
        Thu, 29 Jun 2023 21:39:20 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c13280dfb09so1372044276.2;
        Thu, 29 Jun 2023 21:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688099959; x=1690691959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCTjff0Lm/tkc2wvW+DXTAD5VUVHNKURb19DniWHXAc=;
        b=HMRxRdGlfVDURrt1iQr2yiUxysd4BSefhCVfYklrRBHEoApgVmcDs8ZbE45QWFgOgj
         cCYTvAbqAkrSBbELlgBW/SDvUspy0iHgDZecC0LJe+FXaSrjBVOELz0f/uWe/9votjlw
         xK78+ynzPj/POmJc6AIpEPD84TNJzVsuEQMbi0xWG+HIOAehLyNauhvvJGbO0+uC5ARZ
         FZZYILm2pNMEH2GculWSAxYC4FaLUaxDOEpDGwjKSAlwk8lHu9KtBaErudlrSNuwmTgJ
         Lzum96BhcdvHcyUnYU2sAYyvxnE22NnmBbRPAnKzm3Elx9BNFD/DG/XxZe2wDyPnV6A7
         fEog==
X-Gm-Message-State: ABy/qLYnLQLNOiWfO71sCHyNf+pzwZpKXTCM+GrutxCxI436zZspkf7o
        sjmE/DW3AVJORK1PNJhVILZzgWUxzIcb1xbR
X-Google-Smtp-Source: APBJJlHcnlhQVr/XiJSoKdbWwRGozSxDZLax3KI9epzczZ23m1Ah0w3PM0mIwiWaTTnHK3hnf39i/w==
X-Received: by 2002:a25:6884:0:b0:c39:8036:e3f9 with SMTP id d126-20020a256884000000b00c398036e3f9mr1837158ybc.26.1688099959254;
        Thu, 29 Jun 2023 21:39:19 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id w143-20020a25df95000000b00bcae3682a51sm2861298ybg.47.2023.06.29.21.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 21:39:18 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5700401acbeso14956587b3.0;
        Thu, 29 Jun 2023 21:39:18 -0700 (PDT)
X-Received: by 2002:a81:5bd6:0:b0:56d:2e22:8b31 with SMTP id
 p205-20020a815bd6000000b0056d2e228b31mr1434020ywb.41.1688099958565; Thu, 29
 Jun 2023 21:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy> <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
 <20230627-unsure-uniformly-079cad2c26e6@wendy> <061bb829-fb75-d154-0c15-9f0f982fec41@amlogic.com>
 <CAJX_Q+0Kf3zFyUtkCEkm7K8zXwaovxQmo1DWFwy8y25GQ2wqXg@mail.gmail.com> <0b4b67aa-e8f5-2bd9-223b-0f26add687fe@amlogic.com>
In-Reply-To: <0b4b67aa-e8f5-2bd9-223b-0f26add687fe@amlogic.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Fri, 30 Jun 2023 05:39:07 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3jDsFwmx-voMxCiKadJSobV00BuwLjpzc72UK5681ibQ@mail.gmail.com>
Message-ID: <CAJX_Q+3jDsFwmx-voMxCiKadJSobV00BuwLjpzc72UK5681ibQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
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

On Fri, Jun 30, 2023 at 3:22 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
>
>
> On 2023/6/30 00:33, Lucas Tanure wrote:
> > [ EXTERNAL EMAIL ]
> >
> > On Tue, Jun 27, 2023 at 8:52 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> >>
> >>
> >> On 2023/6/27 15:23, Conor Dooley wrote:
> >>
> >>
> >>   > [ EXTERNAL EMAIL ]
> >>   >
> >>   > On Tue, Jun 27, 2023 at 02:13:34PM +0800, Xianwei Zhao wrote:
> >>   >> Hi Conor,
> >>   >>      Thanks for you reply.
> >>   >> On 2023/6/26 18:02, Conor Dooley wrote:
> >>   >>
> >>   >>
> >>   >>> [ EXTERNAL EMAIL ]
> >>   >>>
> >>   >>> Hey,
> >>   >>>
> >>   >>> On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
> >>   >>>> T7 is an advanced application processor designed for smart display.
> >>   >>>>
> >>   >>>> Add the new T7 SoC/board device tree bindings.
> >>   >>>>
> >>   >>>> Add basic support for the T7 based Amlogic AN400 board, which
> >>   >>>> describesthe following components: CPU, GIC, IRQ, Timer, UART. It's
> >>   >>>> capable of booting up into the serial console.
> >>   >>>
> >>   >>> Lucas has already sent patches for the T7 SoC & is at v5:
> >>   >>> https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-
> >>   >>> tanure@linux.com/
> >>   >>> There's been a bit of discussion there, and there serial stuff in
> >>   >>> particular is different in his series (it doesn't use always-on for
> >>   >>> examples).
> >>   >>> Could you please go and take a look at his series?
> >>   >>>
> >>   >>> Cheers,
> >>   >>> Conor.
> >>   >>>
> >>   >> AN400 is the reference board designed by Amlogic, which is different
> >>   >> from Khadas VIM4.
> >>   >
> >>   > Yet you share the same dtsi, which he has got through several
> >>   > iterations of before you arrived.
> >>   >
> >> Hi Lucas,
> >> Are you going to continue with the dtsi part?
> >>
> >>   >> And T7 serial is the same as S4, so I follow S4 serial.
> >>   >
> >>   > Yeah, no. SoC specific compatible please.
> >>   >
> >>   >
> >>   > _______________________________________________
> >>   > linux-amlogic mailing list
> >>   > linux-amlogic@lists.infradead.org
> >>   > http://lists.infradead.org/mailman/listinfo/linux-amlogic
> >
> > Hi Xianwei,
> >
> > I am doing the basics for Amlogic T7 A311D2, but the next step ( sd
> > card or emmc, something to boot on) would be more difficult for me
> > than you.
> > After the first series for Vim4 gets merged, I will start to work on
> > how to get sd cards working.
> > But if you already have that working for the AN400 board, please send
> > it. And I will look at that work and use it for Vim4.
> >
> > Or, if you don't have it ready and want to share it with me, we can
> > work together on these A311D2 patches.
> > You test on AN400, and I test on Vim4.
> >
> > Thanks
> > Lucas
>
> We are preparing this part. However it depends on clock. So the clock
> must ready first.

Will you send clock for T7?
