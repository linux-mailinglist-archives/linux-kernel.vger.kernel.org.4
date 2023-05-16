Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1152704C11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjEPLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjEPLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:13:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373D2133
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:12:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so21569305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235483; x=1686827483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWIwuTFrYBYgl8P2n9Ov43OkTF/62v0t+dON2/Bzrrc=;
        b=jXCDlmmt3UfTwRCSv7A0Yyh1YWKFDPjG1R7nd9qpj+XhdnjyJxUKSRbFDL+jlFcUAl
         50tnR0oM/VucMGelsIrZKV6Mzg8MDRTbin/nQhntEWwKaaCWWC21dYvym4E06EPc71YS
         x/IGHZXJIk4heoqoELsOG/R6c1rS1benVoWfjZPHzQ9N0rnssQDQIWXceQaiQII0JyTz
         0GphAWRSmASgH+Tvs1VGT2Y6glnwOKlvGpxETFbVwv/1hMUQj/IwVqUF8cRSKTrdvJNs
         URxKuLcPq0duRB7aan0Yl4DiFIZ4axh5TF3Yn3G1PA1xHEJqVNjJk96xvjs1ngvnlCym
         G1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235483; x=1686827483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWIwuTFrYBYgl8P2n9Ov43OkTF/62v0t+dON2/Bzrrc=;
        b=g8v0Ag9d3PDVUV01JvgKdlRC2uSQt9S9F7v1PaX35iP4FPDH9TjSplXHbYJgVx+qM+
         EsXofW6Y5kWz/9trpWkP4OmqDqCmgWPo3QPUinrZBiKyN9ThyzuznidnefQKBhekNa0s
         u6gFcoEMT3qpI3pAaww80HZnW9BKXOVWXLCxD34bb0Lr+lPL/E4seGGpBXntVxqjNF7Z
         qxUPf70KcXSaBAZj2iAagPgApQafSAOkli5OccIZ6BjmkKhz3+0DQcW4zA7v/ldY/gs6
         wpdz+z1efdMjC2FJltdmG5edWbhYLW8EwF7ythdUpq9/fW3PUxxJJ0ysH2dBfEaQBChH
         QRWw==
X-Gm-Message-State: AC+VfDwdAtSp/pGhHug9M6bmiqlqZs+FEgF6TyrMmWMBiDzuAAM9jxeJ
        YvJ8ehZYjZgzPX68RyAKNJuAkg==
X-Google-Smtp-Source: ACHHUZ423C6CBeHJcTpAQ3lxQIdBbdC0s3xVfCnNetTKsBsI+lCROE++9lZVbQlQadozPu+TFI9wzw==
X-Received: by 2002:adf:eb4f:0:b0:307:d04a:60d8 with SMTP id u15-20020adfeb4f000000b00307d04a60d8mr11156020wrn.0.1684235482709;
        Tue, 16 May 2023 04:11:22 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003f4f8cc4285sm1961277wmj.17.2023.05.16.04.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:11:21 -0700 (PDT)
Message-ID: <3e4961ec-8a31-b756-9361-ff853b264856@monstr.eu>
Date:   Tue, 16 May 2023 13:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/23] arm64: zynqmp: Misc zynqmp changes
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> Hi,
> 
> the series is syncing the latest dt changes based on board status and the
> latest DT schema.
> The patches are based on
> https://lore.kernel.org/all/20230321070619.29440-1-parth.gajjar@amd.com/
> 
> Thanks,
> Michal
> 
> 
> Amit Kumar Mahapatra (2):
>    arm64: zynqmp: Set qspi tx-buswidth to 4
>    arm64: zynqmp: Add mtd partition for secure OS storage area
> 
> Ashok Reddy Soma (1):
>    arm64: zynqmp: Fix usb node drive strength and slew rate
> 
> Michal Simek (15):
>    arm64: zynqmp: Describe TI phy as ethernet-phy-id
>    arm64: zynqmp: Fix usb reset over bootmode pins on zcu100
>    arm64: zynqmp: Sync node name address with reg (mailbox)
>    arm64: zynqmp: Add dmas, dp, rtc, watchdogs and opp nodes for SOM
>    arm64: zynqmp: Use assigned-clock-rates for setting up SD clock in SOM
>    arm64: zynqmp: Used fixed-partitions for QSPI in k26
>    arm64: zynqmp: Add gpio labels for modepin gpio
>    arm64: zynqmp: Add pinctrl emmc description to SM-K26
>    arm64: zynqmp: Switch to ethernet-phy-id in kv260
>    arm64: zynqmp: Setup clock for DP and DPDMA
>    arm64: zynqmp: Enable DP driver for SOMs
>    arm64: zynqmp: Rename ams_ps/pl node names
>    arm64: zynqmp: Enable AMS on SOM and other zcu10x boards
>    arm64: zynqmp: Describe bus-width for SD card on KV260
>    arm64: zynqmp: Add phase tags marking
> 
> Piyush Mehta (1):
>    arm64: zynqmp: Disable USB3.0 for zc1751-xm016-dc2
> 
> Radhey Shyam Pandey (2):
>    arm64: zynqmp: Add L2 cache nodes
>    arm64: zynqmp: Add pmu interrupt-affinity
> 
> Sai Krishna Potthuri (1):
>    arm64: zynqmp: Add resets property to sdhci nodes
> 
> Srinivas Neeli (1):
>    arm64: zynqmp: Add linux,code for gpio button
> 
>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  15 +-
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso |  20 +-
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  20 +-
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 321 +++++++++++++-----
>   .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |   2 +-
>   .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |   2 +-
>   .../boot/dts/xilinx/zynqmp-zc1275-revA.dts    |   2 +-
>   .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  10 +-
>   .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  10 +-
>   .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   2 +-
>   .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  32 +-
>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  42 ++-
>   .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    |  25 +-
>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  42 ++-
>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  42 ++-
>   .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  29 +-
>   .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  29 +-
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  33 +-
>   18 files changed, 513 insertions(+), 165 deletions(-)
> 

I have applied the most of these patches. The rest will be update and sent as v2.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
