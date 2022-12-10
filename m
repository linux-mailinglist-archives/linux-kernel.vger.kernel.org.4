Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E03648E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLJJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLJJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:52:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795E17E0F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:52:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d14so6286913edj.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaRs0tVajL2z3Q0psiY2Z2F8Ucs58++aiBC4DspdQDM=;
        b=DEzaRxUAHbbA46UvVfDNfajqLaEZaqFdp5lsBixgN3/5DVhiOd81lhGxAQGShvjUYK
         f3pgZP4mm4j/KtLnO9bzum1QBhxbKSMlqdaxrz7iW5oDB3mdrzqp83QKVnBzsc4ugboz
         8uUxotygqCFQmvyPbIyloQAcuDGGwkRVo7grNN0hrvblzbsaG6Dgnpb4erVOjZ/GlZEL
         R1auhmXRtW9IMpsyJl+TYOkcXqZmTWVbnTtYZY1a7V501YN+NKX9AU8Zsa6u+bO8+3MO
         8vLEZs4PinHcfxck1BSO4vbmGj/fHMUaT9qhaGBscbsdm68sEkG9oB9qc2/EQobIQ7Kg
         LDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaRs0tVajL2z3Q0psiY2Z2F8Ucs58++aiBC4DspdQDM=;
        b=zGeJyq+R+mZFM9u+acu3P+r6wbyRvujGpQem05E/DYw6uAfLaUSJd3kKSIg4ePSFP7
         XrQ+u/gqV9kC+fD2BO+GEbPzcbS2MIWUuQY2Vy6blrSJwA9n0ZlpMSKAeg2mOXVem1nF
         +7e6aCdfiLqDAKr9fsQvommN52BVrGvrDWELkYbVEi+2Kly1HABBpOLsEOy884rUigpW
         McUZmUlyX+ITpTT21mg339ynVQYLSpB28lOvIO7bNH7HXlLUQXoC1eMTcFGAmLExCgE5
         vRcs+VFv4FMQDl9D08YXzKdhUpX5AywF8arT9sFI2oDPtci8/1szHCfgl4yvwwTu6OtG
         MWag==
X-Gm-Message-State: ANoB5pnUOgKvaXT30crhCKq9U1ura0sCAqp5NhS3x+umR4yIXsTf6UeE
        1YNPFmnS4/wOFfAcwuj4RE+IbD1d004cTraHwuI=
X-Google-Smtp-Source: AA0mqf4X/QEMiXTPdkc3DYtcsktlzTHpu68kxl+OpQXW9KZ0gikWWQwcBpbm3ywe/YiitCpURxr0v7Hc/7o882OJYiw=
X-Received: by 2002:aa7:c055:0:b0:45a:1af2:ed6d with SMTP id
 k21-20020aa7c055000000b0045a1af2ed6dmr68890171edo.364.1670665944669; Sat, 10
 Dec 2022 01:52:24 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
In-Reply-To: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 10 Dec 2022 12:52:12 +0300
Message-ID: <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
Subject: Fwd: nvmem-cells regression after adding 'call of_platform_populate()
 for MTD partitions'
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Maksim Kiselev <bigunclemax@gmail.com>
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

Hi, friends.

After applying this commit 'mtd: call of_platform_populate() for MTD
partitions' (bcdf0315),
I faced with a problem that my ethernet device can't be probed because it
wait when 'nvmem-cells' device will be probed first.

But there is no such driver which is compatible with 'nvmem-cells' because
'nvmem-cells' is just a mark used by the 'mtd_nvmem_add' function.

So this leads to appeating of unresolved dependency for the ethernet device.
And that's why the ethernet device can't be added and probed.

Here is a part of kernel log when spi flash probe start:

> device: 'spi0': device_add
> device: 'spi0.0': device_add
> spi-nor spi0.0: mx66l51235f (65536 Kbytes)
> 7 fixed-partitions partitions found on MTD device spi0.0

After 'm25p80' probe 'f1070000.ethernet' linked to 'partition@1' :

> device: 'f1010600.spi:m25p80@0:
partitions:partition@1': device_add
> device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--platform:f1070000.ethernet': device_add
> devices_kset: Moving f1070000.ethernet to end of list
> platform f1070000.ethernet: Linked as a consumer to f1010600.spi:m25p80@0:partitions:partition@1
> ethernet@70000 Dropping the fwnode link to partition@1

And as a result I got `-EPROBE_DEFER` for `f1070000.ethernet`

> platform f1070000.ethernet: error -EPROBE_DEFER: supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready

Here is a part of my device tree:

    enet1: ethernet@70000 {
        status = "okay";
        nvmem-cells = <&macaddr>;
        nvmem-cell-names = "mac-address";
        phy-mode = "rgmii";
        phy = <&phy0>;
    };

    spi@10600 {
        status = "okay";

        m25p80@0 {
            compatible = "mx66l51235l";
            reg = <0>;
            #address-cells = <1>;
            #size-cells = <1>;

            partitions {
                compatible = "fixed-partitions";
                #address-cells = <1>;
                #size-cells = <1>;

                partition@0 {
                    reg = <0x00000000 0x000080000>;
                    label = "SPI.U_BOOT";
                };

                partition@1 {
                    compatible = "nvmem-cells";
                    reg = <0x000A0000 0x00020000>;
                    label = "SPI.INV_INFO";
                    #address-cells = <1>;
                    #size-cells = <1>;
                    ranges = <0 0x000A0000 0x00020000>;

                    macaddr: mac@6 {
                        reg = <0x6 0x6>;
                    };
                };

            };
        };
    };

In the example above 'ethernet@70000' requires 'macaddr: mac@6' which is
located inside mtd 'partition@1' of 'm25p80@0' spi flash.
