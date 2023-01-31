Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F9682158
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjAaBUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAaBUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:20:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861AE10ABA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:20:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u5so8816218pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WlKnm9SlBY6a95G31ugIPx75GFY5lk/gBJScYr6B/MA=;
        b=D9rmez0+kSKL3ccFg9a8F7AC1nKa00vADDYdszu9EH8DheWWLli6rK5KQG+m5BDTun
         lBN3WiydFkh0tenV2406XKnQtMRh6xc6n2fE0ebr1WQaK0U9SEeflAszPpkaoEczXCPa
         XnJ1zqvgyNwoi6VrgYqpbxCLOgDdxcvws0ZfwlT70OkOSwwYd8pazHEn/kuiJtYM22J7
         kOf9lJua0c/fv0pyYlG9F4HJa3jGoahD9mRdj1+isxbekM65F/g6qDG8KyLMcWDQWG6+
         R8T2lbX2UzZVK83BTDKWSVk4xIjaABA2PMQlvA9tQVzbLSueVsWJKDQjFrANX9n7Nu8n
         auYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlKnm9SlBY6a95G31ugIPx75GFY5lk/gBJScYr6B/MA=;
        b=mYQlWEhmBm5aPXkkQKSGxe6Uh4IfzjhCZ4Euj8qar/OSy1nRI8QV1Rv+J4IZrnHw6c
         sASQUZ5OT8e+E9f4Gxd24pX8TTdlomJWYQIdcGK+YzvWKubzcv8/leRV6HpK2pVYaYkW
         V4bW3I92quHRAwOgMvYLopHbCnYDlp+5jJK849iXVecJ68MeounW9Rztfxbx5wZ0NZJx
         3K5OZT3+dY2ysyecMceAFkmDgvnrR5TEmc0K3vx3Lgwrg7Lo8QIdeP15SRwfdH+xaz57
         3KOOpCAg+eNYJrhT9t9+5YE2utd+naoIsPAsDbmKw3zR1ktVkwWeZo7zOjbSBP9svWNB
         kAXA==
X-Gm-Message-State: AO0yUKWZJUvwtZxOijMja1VyLOonR7HLyZg33SDc71NKXYt33bNvx982
        CbciNDigEGmJapZvcYw030OudK8X1GfbDfGc/Djc6Q==
X-Google-Smtp-Source: AK7set/OnrysWGmShNaN4ttMAIR9UncJ4m1eUuwNep1bR9GutY4sRTfWIiOaEY4ReHbIYjKOu7DJxRnva6K27yrlZqg=
X-Received: by 2002:aa7:91d3:0:b0:592:61cc:5aeb with SMTP id
 z19-20020aa791d3000000b0059261cc5aebmr2113642pfa.59.1675128041704; Mon, 30
 Jan 2023 17:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130114839.379f08bd@xps-13>
 <CALHCpMimX63NC2P=mYdqOv339P06B4iAd10L2NpC5ALy_207vA@mail.gmail.com>
In-Reply-To: <CALHCpMimX63NC2P=mYdqOv339P06B4iAd10L2NpC5ALy_207vA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 30 Jan 2023 17:20:05 -0800
Message-ID: <CAGETcx8FpmbaRm2CCwqt3BRBpgbogwP5gNB+iA5OEtuxWVTNLA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 4:09 AM Maxim Kiselev <bigunclemax@gmail.com> wrote:
>
> Hi Saravana & Miquel.
>
> Sorry for the long response. I finally got access to my test device
> and tried this patch series.
>
> And unfortunately it didn't solve my issue. I'm still getting a
> hanging f1070000.ethernet dependency
> from the nvmem-cell mac@6 subnode.

Thanks for testing the series.

Btw, don't top post. It's frowned upon. Top post means your reply is
on the top before the email you are replying to. See how my first line
of reply in inline with your email I'm replying to?

>
> Here are related parts of my kernel log and device tree:
>
>
>     [    2.713302] device: 'mtd-0': device_add
>     [    2.719528] device: 'spi0': device_add
>     [    2.724180] device: 'spi0.0': device_add
>     [    2.728957] spi-nor spi0.0: mx66l51235f (65536 Kbytes)
>     [    2.735338] 7 fixed-partitions partitions found on MTD device spi0.0
>     [    2.741978] device:
> 'f1010600.spi:m25p80@0:partitions:partition@1': device_add
>     [    2.749636] Creating 7 MTD partitions on "spi0.0":
>     [    2.754564] 0x000000000000-0x000000080000 : "SPI.U_BOOT"
>     [    2.759981] device: 'mtd0': device_add
>     [    2.764323] device: 'mtd0': device_add
>     [    2.768280] device: 'mtd0ro': device_add
>     [    2.772624] 0x0000000a0000-0x0000000c0000 : "SPI.INV_INFO"
>     [    2.778218] device: 'mtd1': device_add
>     [    2.782549] device: 'mtd1': device_add
>     [    2.786582] device: 'mtd1ro': device_add
>     ...
>     [    5.426625] mvneta_bm f10c0000.bm: Buffer Manager for network
> controller enabled
>     [    5.492867] platform f1070000.ethernet: error -EPROBE_DEFER:
> wait for supplier mac@6
>     [    5.528636] device: 'Fixed MDIO bus.0': device_add
>     [    5.533726] device: 'fixed-0': device_add
>     [    5.547564] device: 'f1072004.mdio-eth-mii': device_add
>     [    5.616368] device: 'f1072004.mdio-eth-mii:00': device_add
>     [    5.645127] device: 'f1072004.mdio-eth-mii:1e': device_add
>     [    5.651530] devices_kset: Moving f1070000.ethernet to end of list
>     [    5.657948] platform f1070000.ethernet: error -EPROBE_DEFER:
> wait for supplier mac@6
>
>     spi@10600 {
>         m25p80@0 {
>             compatible = "mx66l51235l";
>
>             partitions {
>                 compatible = "fixed-partitions";
>
>                 partition@0 {
>                     label = "SPI.U_BOOT";
>                 };
>                 partition@1 {
>                     compatible = "nvmem-cells";
>                     label = "SPI.INV_INFO";
>                     macaddr: mac@6 {
>                         reg = <0x6 0x6>;
>                     };
>                 };
>                 ...
>             };
>         };
>     };
>
>     enet1: ethernet@70000 {
>         nvmem-cells = <&macaddr>;
>         nvmem-cell-names = "mac-address";
>         phy-mode = "rgmii";
>         phy = <&phy0>;
>     };
>
>
> Maybe I should provide some additional debug info?

I took a look at it and I think I know the issue. But it'll be good if
you can point me to the dts (not dtsi) file that corresponds to the
board you are seeing this issue on so I can double check my guess by
looking at the exact code/drivers.

The main problem/mistake is the nvmem framework is using a "struct
bus" instead of a "struct class" to keep a list of the nvmem devices.
And we can't change it now because it'd affect the sysfs paths
significantly and might break userspace ABI.

Can you try the patch at the end of this email under these
configurations and tell me which ones fail vs pass? I don't need logs
for any pass/failures.
1. On top of this series
2. Without this series
3. On top of the series but with the call to fwnode_dev_initialized() deleted?
4. Without this series, but with the call to fwnode_dev_initialized() deleted?

-Saravana

Sorry about tabs to spaces conversion. Email client issue.

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..23d94c0ecccf 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -752,6 +752,7 @@ static int nvmem_add_cells_from_of(struct
nvmem_device *nvmem)
 struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 {
        struct nvmem_device *nvmem;
+       struct fwnode_handle *fwnode;
        int rval;

        if (!config->dev)
@@ -804,9 +805,18 @@ struct nvmem_device *nvmem_register(const struct
nvmem_config *config)
        nvmem->keepout = config->keepout;
        nvmem->nkeepout = config->nkeepout;
        if (config->of_node)
-               nvmem->dev.of_node = config->of_node;
+               fwnode = of_fwnode_handle(config->of_node);
        else if (!config->no_of_node)
-               nvmem->dev.of_node = config->dev->of_node;
+               fwnode = of_fwnode_handle(config->dev->of_node);
+       device_set_node(&nvmem->dev, fwnode);
+
+       /*
+        * If the fwnode doesn't have another device associated with it, mark
+        * the fwnode as initialized since no driver is going to bind to the
+        * nvmem.
+        */
+       if (fwnode && !fwnode->dev)
+               fwnode_dev_initialized(fwnode, true);

        switch (config->id) {
        case NVMEM_DEVID_NONE:
