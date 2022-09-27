Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8A5EC4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiI0Nqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiI0Nqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:46:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E75EC57A;
        Tue, 27 Sep 2022 06:46:42 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y15so5115228ilq.4;
        Tue, 27 Sep 2022 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JYhubVsYX6ouoh07xHct6JKDa2u34ATcTX+f9kydsg0=;
        b=SFNBETuy+YwSF+Q5f3FRDqDN/eaViyqw5he3UZgTk4MtyJF6NRCFNYIKYJPmlsEAMt
         DeyMJfFPjEHThTWRJp3rwRQNYq+ZP2jaZRHsnPQUIIDoSjEnb2J9Ee7Ql7vsi1f3j6o/
         jljy4aCW1hQFLl0pqMecxtsOTvbgdYBKABSzUnLo1vpbsoWJhvmEPoLD5bs7HSEIMWBU
         wuvLfswFLjp0hC6zhxiQcY5dIDIbYgEDKhQ9j0i+rprfbNfGwV1WpoNmxVOp4RQ0vso/
         Md84BYiwvupF5tMaidkzgxgcpXnhMJk0px5c/qoGPkjlQ7myoI/dmvljGCU6pWvZLAl2
         eVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JYhubVsYX6ouoh07xHct6JKDa2u34ATcTX+f9kydsg0=;
        b=OsUwitFeFBUkqbBjvwldvn2fv9Ob6UFkSwbTA5Q26rQopwrULRCD5wjpbfeKzW+mDo
         62XpRWspSR92mjjQohN+MLt9zY9e3Mw6qLwjFgsktX7it8xg55Ru0oKL5SCrxXYscVL3
         f39/w2HxnzIy0u2F+JlrMi6J1Am0ctOPzBvCXktJEm+TOnd0179J4amtWaV0oCbhdXmN
         gJ3KjC+/jCHG8f6nb1VE4M9fs4/NTyjMfoJKsFvO77z3dK0dLXLgjIOF7BKhTd4Uihrv
         15ex3YWjzCV0Ee8x6K25h0fSmUK/YGC0wcWmnrAqr7EVktgqO4ppPTA+KzGY1135ZPmW
         u1Dw==
X-Gm-Message-State: ACrzQf0KwBTPUHc+XlEiqVRoew1w4hxklC/0OSJl+CcRSNWSWeoRjxLW
        bVcc5vziwX462YBq/FfniSc3Mt3M2Q4xfJVy8xk=
X-Google-Smtp-Source: AMsMyM74SUeo8HFBuN8kt3k2EUdmy5YSQU9ffddju6d2f4+EfiQh0gzO1dPkP75z7a8X/jcoAFX7j9B59EvRj65nyGI=
X-Received: by 2002:a92:360c:0:b0:2f6:33ed:e2a2 with SMTP id
 d12-20020a92360c000000b002f633ede2a2mr13076960ila.29.1664286401415; Tue, 27
 Sep 2022 06:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926061420.1248-1-linux.amoon@gmail.com> <20220926180102.37614-1-amadeus@jmu.edu.cn>
In-Reply-To: <20220926180102.37614-1-amadeus@jmu.edu.cn>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 27 Sep 2022 19:16:25 +0530
Message-ID: <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe
 controller on rock3a
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        michael.riesch@wolfvision.net, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chukun,

On Mon, 26 Sept 2022 at 23:31, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi,
>
> On 26-09-22, 06:14, Anand Moon wrote:
>
> > +     pcie30_3v3: gpio-regulator {
> > +             compatible = "regulator-gpio";
> > +             regulator-name = "pcie30_3v3";
> > +             regulator-min-microvolt = <100000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> > +             gpios-states = <0x1>;
> > +             states = <100000 0x0>, <3300000 0x1>;
> > +     };
>
> This is actually no different from vcc3v3-pcie regulator?
>
> > +&pcie30phy {
> > +     data-lanes = <0 1 2 3>;
> > +     phy-supply = <&vcc3v3_pi6c_03>;
> > +     status = "okay";
> > +};
>
> It seems that there is no need to define additional data-lanes when
> the pcie3x1 node is not enabled, and phy-supply seems unnecessary on
> this board.
>
As per the schematic below pice support with 2 regulators

VCC3V3_PCIE        (SCT2250FPA)
VCC3V3_PI6C_03  (PI6C557-03 is a spread spectrum clock generator
supporting PCI Express and Ethernet requirements)

[0] https://dl.radxa.com/rock3/docs/hw/3a/rock3a_v1.3_sch.pdf

> Excuse me, can you try the patches I posted? Lspci can recognize
> pcie3x2 normally, but I don't have a spare nvme hard drive right
> now to test if it works.
>

No, it did not work on my board, see bool logs.
[0] https://pastebin.com/Lk93VFxg

[ 0.725985] phy phy-fe8c0000.phy.4: lane number 0, val 1
[ 0.726975] phy phy-fe8c0000.phy.4: rockchip_p3phy_rk3568_init: lock
failed 0x6890000, check input refclk and power supply
[ 0.728172] phy phy-fe8c0000.phy.4: phy init failed --> -110
[ 0.728704] rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -110
[ 0.745193] ALSA device list:

Thanks
-Anand

> Thanks, Chukun
>
> ---
> Chukun Pan (3):
>   arm64: dts: rockchip: Add regulator suffix to ROCK3 Model A
>   arm64: dts: rockchip: Rename pinctrl label of pcie2x1 on rock-3a
>   arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a
>
>  .../boot/dts/rockchip/rk3568-rock-3a.dts      | 36 ++++++++++++++-----
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> --
> 2.25.1
>
