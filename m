Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E57645305
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLGE3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLGE3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:29:52 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A231DEC;
        Tue,  6 Dec 2022 20:29:51 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id bi15so7742954vkb.11;
        Tue, 06 Dec 2022 20:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A1h+jqILdMXB6P8ZcOCajUAqUjvUVylvDrJFO02co2I=;
        b=W1AgjHgpnm7gFpIuv5EhYP7O46Domez33ShWFR9Gv6H3TLJI8xyQMgzGi1MYGDnUyI
         hPXGQiCvSNqgs+Qrt1yqZH67sJllU3wSIcQAFVK/7cxkDDyu5yoVDoSrvMl9GYc0ZU7u
         Pe8GnDiJS910msXbs34X5nNlg9Td23m2bochEoYcYvX6yNetQt9OHK0UeNsU8pmYVzDE
         t8/uVb5bSwhsONA/0rO+vGqbjAeIgx/Hs4S/L4jM1bVgQIu7MUNYERmzL93v9rElG3lx
         f4yzKykP7dcuFBVNHn9/bxdSh851C8BQbbaIBexslHJ/6KFKpnW8BIJSaupHXQrxn+Zx
         4N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1h+jqILdMXB6P8ZcOCajUAqUjvUVylvDrJFO02co2I=;
        b=PnGsQIHEDoX4PVu5Pt6Sf2HXBqGCpzem/AG2weiGJHup73cTCUw8l2pYGvip60/yVo
         Lw3kwjo8wwSOphoi/frUvHuenhYy63tn3beuGD1W84cK/e4nHDDtM724YyQWfdtXgfLQ
         Gy7SQb8wnXEKBr0RQiDt11deT9+4X/qSGCEGzXaPfPWjcglKH9K0a2DvyIGMSLQ9Tp7t
         DEZiZ2OUX6/4RETtpBvSyYO395F9F6dKm3fH4AFBFFEzi3WRBUdmADKnF9YuUZlXsCHT
         7PClf8XpO4sMrU6r5ZEDmcw9otK4sed0wfytONv8DboiWDx1iC6ZFWtx2n2yqAuMlAt2
         7F6g==
X-Gm-Message-State: ANoB5pmgQTosJ4XYM5tgWfDM+cfjiWF1SqZUnotDeXtWi0yZzrAWa9+9
        bHiI5/akRDZa+xRXDaLvNeJFudZMIl6PpFyOrkg=
X-Google-Smtp-Source: AA0mqf46k4Azl7/ZeLVOE38VFrgzWeBnwaXKlXGr3CrFZ4fB15UdPH8zDxCEBbdy/8YD10n2nlH8M3/PNTBwwM70cBs=
X-Received: by 2002:ac5:c915:0:b0:3b8:7fbd:9554 with SMTP id
 t21-20020ac5c915000000b003b87fbd9554mr40412873vkl.27.1670387390201; Tue, 06
 Dec 2022 20:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-7-linux.amoon@gmail.com>
 <0f0c87d9-cff5-3bc8-07e2-7022a190cc86@wolfvision.net>
In-Reply-To: <0f0c87d9-cff5-3bc8-07e2-7022a190cc86@wolfvision.net>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 7 Dec 2022 09:59:34 +0530
Message-ID: <CANAwSgTLL3nJ5pUuaFpKe8tc6oVREo_WOJ+_Q3kO3OmgPTa0Bw@mail.gmail.com>
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Michael

On Tue, 22 Nov 2022 at 22:16, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Anand,
>
> On 11/16/22 21:01, Anand Moon wrote:
> > Add MDIO description with ethernet-phy-id compatible string
> > which enable calling reset of the phy. The PHY will then be probed,
> > independent of if it can be found on the bus or not,
> > and that probing will enable the GPIO.
> >
> > ethernet-phy-id is read from ethenet register dump reg2 and reg3.
> >
> > Fix following warning.
> > [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
> > [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
>
> Without this patch, the phy on my ROCK3A is properly detected:
>
> [    1.494963] rk_gmac-dwmac fe010000.ethernet eth0: PHY [stmmac-0:00]
> driver [RTL8211F Gigabit Ethernet)
>
> but with the patch applied, only a generic phy is recognized:
>
> [    1.398674] rk_gmac-dwmac fe010000.ethernet eth0: PHY [stmmac-0:00]
> driver [Generic PHY] (irq=POLL)
>
> This does not seem right at all. NACK to this patch!
>

Yep you are correct I found way to read the ethernet id

# there is kernel module witch help read the ethernet-id using netlink socket.
$ git clone https://github.com/wkz/mdio-tools

$ sudo mdio
fixed-0
stmmac-0
$ sudo mdio stmmac-0
 DEV      PHY-ID  LINK
0x00  0x001cc916  up
0x01  0x001cc916  up

with the above ethernet id I update the compatible string
compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";

I could get the ethernet registered correctly.

[    9.865059] rk_gmac-dwmac fe010000.ethernet end0: Register
MEM_TYPE_PAGE_POOL RxQ-0
[   10.061904] rk_gmac-dwmac fe010000.ethernet end0: PHY [stmmac-0:00]
driver [RTL8211F Gigabit Ethernet] (irq=POLL)

Thanks
-Anand
