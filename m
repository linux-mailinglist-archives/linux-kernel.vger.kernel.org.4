Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35FB60BEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJXXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXXq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:46:57 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B4315513;
        Mon, 24 Oct 2022 15:04:30 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id l127so8882320iof.12;
        Mon, 24 Oct 2022 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6Hj4N+4veeusei3+LeKJBihL82EbHjlptidnA5pQRg=;
        b=bVW3OkqoFa8qpC3Mtn6GcpLUhrZsle2ubiisRjQliF99pT94NXJ5aZ//4KNmQbErSk
         uoPNweia+hHp27++v6sKwV41fVmN7gkRJYw4OrGUnZ0hYhB+ksFe8XZrrv6e5XZw2fES
         GBBPInef9Rf6zOrcfp8cPapeXGwbNV7aqeVWo9A+s1DVx+AVkwWRzFpGomEp8kVvYQrT
         g9mB5Nxbsa4bYnjCCTwUQzYYSSrYKYUxZPfHX2V0QsWJ7moyLtl7YCucomuie1RFIZ/S
         6b62B5fkYcL85Z2Rb3RXQcGg53z5ebgWTG+ede71M9/UZVNpY6itat0p2LSSdFALrX4s
         0/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6Hj4N+4veeusei3+LeKJBihL82EbHjlptidnA5pQRg=;
        b=fhibO+Ks2KyhCxBVvCMZ6ZX0XZHsAeDVqaaCPHBtDogyx0jz/cTXa3Tl2civB+d+Qf
         5pTl/OlF5VX5smH/laU6BHvWxbvorp+SV5LH/xGhC0q681sXvCefqzAzBNWWYoFEMiu6
         cP9heQkHDBYedkOmDUoJOkPY2wwRotjDvNSEvyacsuM0NESWJLHSlVd+plt7WPo4W3sR
         tuodx+AgNsZ9sdG7BiEQpYMLD3ft0u0FA7wjvYrDhwaWLTT5Cc65IPzeXw9LI/LirwVs
         RP65pM1kGCm5aDUPI08MheuCKGDSJlulYUqDL2SwMnThSvk+6gqf54ag8tGZBwltB87v
         /kgQ==
X-Gm-Message-State: ACrzQf2ykUFx9dfgtz1FH6P282Sc6eD72gUL6KPEhAdXKsaSb4oXKMtL
        RZZ0Z+dX7AjW3feQRaoD9yLhWJQGILs=
X-Google-Smtp-Source: AMsMyM5VomLJ0q+WWb7FeIRDgK7wmAIEigxDpprDZ2CZWH3YZa3CrzreLrhAHRtzKWvgFnsddFbPyg==
X-Received: by 2002:a05:6638:2045:b0:365:c463:de2a with SMTP id t5-20020a056638204500b00365c463de2amr23457457jaj.122.1666649067717;
        Mon, 24 Oct 2022 15:04:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b8cc:2162:7a0f:fd4b? ([2600:1700:2442:6db0:b8cc:2162:7a0f:fd4b])
        by smtp.gmail.com with ESMTPSA id z17-20020a05660217d100b006a11760aebbsm368047iox.36.2022.10.24.15.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 15:04:27 -0700 (PDT)
Message-ID: <51477b80-478f-d2cb-d98d-477431057fd4@gmail.com>
Date:   Mon, 24 Oct 2022 17:04:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/7] Rename DTB overlay source files
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221024173434.32518-1-afd@ti.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221024173434.32518-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 10/24/22 12:34, Andrew Davis wrote:
> Hello all,
> 
> This is a series based on my patch here[0]. As suggested by Rob
> I've resurrected Frank's patch and appended it to mine as a series.
> 
> First patch here is my original patch, 3rd is Frank's patch but with
> the unittest changes pulled out into the 2nd patch. That was re-worked
> moving the source building macro into scripts/Makefile.lib.
> 
> Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> overlays. Split out by platform so they could be taken by platform
> maintainers or if easier ACK'd here and taken all together.
> 
> This should cover all the DTB overlays so we can remove the old .dts
> rule for overlays and make .dtso the only supported way, let me know
> if we want that this cycle and I can post that too.

Thanks for picking this up and moving it forward.  I've reviewed patches
1 - 3, and took a quick look at 4 - 7 (which also look fine at a glance).

-Frank

> 
> Thanks,
> Andrew
> 
> Changes from v1[1]:
>  - Added patch to rename pi433 overlay.
>  - Cleaned wording on patch 4-6.
>  - Collected some ACKs
> 
> [0] https://www.spinics.net/lists/kernel/msg4548509.html
> [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
> 
> Andrew Davis (6):
>   kbuild: Allow DTB overlays to built from .dtso named source files
>   kbuild: Allow DTB overlays to built into .dtso.S files
>   arm64: dts: freescale: Rename DTB overlay source files from .dts to
>     .dtso
>   arm64: dts: renesas: Rename DTB overlay source files from .dts to
>     .dtso
>   arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
>   staging: pi433: overlay: Rename overlay source file from .dts to .dtso
> 
> Frank Rowand (1):
>   of: overlay: rename overlay source files from .dts to .dtso
> 
>  ...qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso} |  0
>  ...qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso} |  0
>  ...qds-7777.dts => fsl-ls1028a-qds-7777.dtso} |  0
>  ...qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso} |  0
>  ...qds-899b.dts => fsl-ls1028a-qds-899b.dtso} |  0
>  ...qds-9999.dts => fsl-ls1028a-qds-9999.dtso} |  0
>  ...ts => imx8mm-venice-gw72xx-0x-imx219.dtso} |  0
>  ...=> imx8mm-venice-gw72xx-0x-rs232-rts.dtso} |  0
>  ...dts => imx8mm-venice-gw72xx-0x-rs422.dtso} |  0
>  ...dts => imx8mm-venice-gw72xx-0x-rs485.dtso} |  0
>  ...ts => imx8mm-venice-gw73xx-0x-imx219.dtso} |  0
>  ...=> imx8mm-venice-gw73xx-0x-rs232-rts.dtso} |  0
>  ...dts => imx8mm-venice-gw73xx-0x-rs422.dtso} |  0
>  ...dts => imx8mm-venice-gw73xx-0x-rs485.dtso} |  0
>  ...2.dts => draak-ebisu-panel-aa104xd12.dtso} |  0
>  ...xd12.dts => salvator-panel-aa104xd12.dtso} |  0
>  ...v-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} |  0
>  ...v-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} |  0
>  drivers/of/unittest-data/Makefile             | 66 +++++++++----------
>  .../{overlay.dts => overlay.dtso}             |  0
>  .../{overlay_0.dts => overlay_0.dtso}         |  0
>  .../{overlay_1.dts => overlay_1.dtso}         |  0
>  .../{overlay_10.dts => overlay_10.dtso}       |  0
>  .../{overlay_11.dts => overlay_11.dtso}       |  0
>  .../{overlay_12.dts => overlay_12.dtso}       |  0
>  .../{overlay_13.dts => overlay_13.dtso}       |  0
>  .../{overlay_15.dts => overlay_15.dtso}       |  0
>  .../{overlay_16.dts => overlay_16.dtso}       |  0
>  .../{overlay_17.dts => overlay_17.dtso}       |  0
>  .../{overlay_18.dts => overlay_18.dtso}       |  0
>  .../{overlay_19.dts => overlay_19.dtso}       |  0
>  .../{overlay_2.dts => overlay_2.dtso}         |  0
>  .../{overlay_20.dts => overlay_20.dtso}       |  0
>  .../{overlay_3.dts => overlay_3.dtso}         |  0
>  .../{overlay_4.dts => overlay_4.dtso}         |  0
>  .../{overlay_5.dts => overlay_5.dtso}         |  0
>  .../{overlay_6.dts => overlay_6.dtso}         |  0
>  .../{overlay_7.dts => overlay_7.dtso}         |  0
>  .../{overlay_8.dts => overlay_8.dtso}         |  0
>  .../{overlay_9.dts => overlay_9.dtso}         |  0
>  ...node.dts => overlay_bad_add_dup_node.dtso} |  0
>  ...prop.dts => overlay_bad_add_dup_prop.dtso} |  0
>  ...d_phandle.dts => overlay_bad_phandle.dtso} |  0
>  ...bad_symbol.dts => overlay_bad_symbol.dtso} |  0
>  .../{overlay_base.dts => overlay_base.dtso}   |  0
>  ...erlay_gpio_01.dts => overlay_gpio_01.dtso} |  0
>  ...lay_gpio_02a.dts => overlay_gpio_02a.dtso} |  0
>  ...lay_gpio_02b.dts => overlay_gpio_02b.dtso} |  0
>  ...erlay_gpio_03.dts => overlay_gpio_03.dtso} |  0
>  ...lay_gpio_04a.dts => overlay_gpio_04a.dtso} |  0
>  ...lay_gpio_04b.dts => overlay_gpio_04b.dtso} |  0
>  .../{testcases.dts => testcases.dtso}         |  0
>  drivers/of/unittest.c                         | 48 +++++++-------
>  .../{pi433-overlay.dts => pi433-overlay.dtso} |  0
>  .../pi433/Documentation/devicetree/pi433.txt  |  6 +-
>  scripts/Makefile.lib                          | 23 ++++++-
>  56 files changed, 82 insertions(+), 61 deletions(-)
>  rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-7777.dts => fsl-ls1028a-qds-7777.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-899b.dts => fsl-ls1028a-qds-899b.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-9999.dts => fsl-ls1028a-qds-9999.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-imx219.dts => imx8mm-venice-gw72xx-0x-imx219.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs232-rts.dts => imx8mm-venice-gw72xx-0x-rs232-rts.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs422.dts => imx8mm-venice-gw72xx-0x-rs422.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs485.dts => imx8mm-venice-gw72xx-0x-rs485.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-imx219.dts => imx8mm-venice-gw73xx-0x-imx219.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs232-rts.dts => imx8mm-venice-gw73xx-0x-rs232-rts.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs422.dts => imx8mm-venice-gw73xx-0x-rs422.dtso} (100%)
>  rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs485.dts => imx8mm-venice-gw73xx-0x-rs485.dtso} (100%)
>  rename arch/arm64/boot/dts/renesas/{draak-ebisu-panel-aa104xd12.dts => draak-ebisu-panel-aa104xd12.dtso} (100%)
>  rename arch/arm64/boot/dts/renesas/{salvator-panel-aa104xd12.dts => salvator-panel-aa104xd12.dtso} (100%)
>  rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
>  rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay.dts => overlay.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_0.dts => overlay_0.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_1.dts => overlay_1.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_10.dts => overlay_10.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_11.dts => overlay_11.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_12.dts => overlay_12.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_13.dts => overlay_13.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_15.dts => overlay_15.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_16.dts => overlay_16.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_17.dts => overlay_17.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_18.dts => overlay_18.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_19.dts => overlay_19.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_2.dts => overlay_2.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_20.dts => overlay_20.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_3.dts => overlay_3.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_4.dts => overlay_4.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_5.dts => overlay_5.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_6.dts => overlay_6.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_7.dts => overlay_7.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_8.dts => overlay_8.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_9.dts => overlay_9.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_bad_add_dup_node.dts => overlay_bad_add_dup_node.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_bad_add_dup_prop.dts => overlay_bad_add_dup_prop.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_bad_phandle.dts => overlay_bad_phandle.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_bad_symbol.dts => overlay_bad_symbol.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_base.dts => overlay_base.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_gpio_01.dts => overlay_gpio_01.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_gpio_02a.dts => overlay_gpio_02a.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_gpio_02b.dts => overlay_gpio_02b.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_gpio_03.dts => overlay_gpio_03.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_gpio_04a.dts => overlay_gpio_04a.dtso} (100%)
>  rename drivers/of/unittest-data/{overlay_gpio_04b.dts => overlay_gpio_04b.dtso} (100%)
>  rename drivers/of/unittest-data/{testcases.dts => testcases.dtso} (100%)
>  rename drivers/staging/pi433/Documentation/devicetree/{pi433-overlay.dts => pi433-overlay.dtso} (100%)
> 

