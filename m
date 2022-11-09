Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8E6221DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKICRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiKICRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:17:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FC54B36;
        Tue,  8 Nov 2022 18:17:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d3so23767607ljl.1;
        Tue, 08 Nov 2022 18:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XpP+//w19I82QVMgBBw3grNzgACxsqDv57GGmoQMP9M=;
        b=BXtcKlfmMQwNn3M2yfxc50TfM7MhWZ83PJ+rxKReoQ2mz+BINIQUWvhSoQ3AGi3tm+
         RuVEm4sy+3hX2m9v+neyp/pf+Xa9ZmbWdjUw4d4FLQT3oNH1no6yyYY5Sg+2/iCYGBw/
         mNOnfF3ntiIg9Oi/Xdzn+vXUr+HmcTJhIrEjk8jmdTPLbpXgAk5RBanTrGKLHfnXgSnP
         iVbpub1Pb46h+BYGXn6b6LTZfCBY3sGKM9w8rfF6bfkzg9YoQfQBey9s4WuUeApn9stz
         KTlAeZQNRyLLDjrSWvGdQ9aW9J8ZW8SmHXs0SR28u2cyRaoXCkUUeU3fNsMXZycKpJ7R
         wGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpP+//w19I82QVMgBBw3grNzgACxsqDv57GGmoQMP9M=;
        b=6C9jiOK3fJoIP4nHzlUs+sKVwOFzfZ/aj7a2bdr6vpgHSZ3MuzvMblXsIDVHaoiq8w
         Ejva5mtsb8AWnmq2LiZulgUQ0oPfe5GeS/MpF6oe+0Q0degGNwqbxITa5KGS4Ku2NJqN
         TKXP1RnlBwxqyEXdkgTXRwSLrIRAfwPcQM9+7f/3LC68HLX0zarPwSc2+QvRebwhlNYG
         SnOffewHJ01sLLgjGeu3vWE4Rp1sc+sDyJqeeyNxA9eq9RS7kXQlH7stbWJlQmJOyvOc
         7hq3pVoZK6NMIVHH0xlRmr2eYfIv8hK2qkHJWAZjSemjhzIjlYJU7Fyd2ZiUkEl4wsmn
         FCbw==
X-Gm-Message-State: ACrzQf3Mydo6NtO5CJP0jgUCPxnhF38juuEbXRJhJYrHzJnnUofEtBzT
        F9Q0+mUAl0adGLZUiYggKORZY8dRePPtMWZMqAg=
X-Google-Smtp-Source: AMsMyM59PxKl5WTaImkmYE9uscX168LbQ9y6Fm4x/hj9xGZ+83bs+k7P9VWn1Yaq9urmsgSkrujADB8fQmnr84kVkdo=
X-Received: by 2002:a2e:950e:0:b0:26f:a6db:67b8 with SMTP id
 f14-20020a2e950e000000b0026fa6db67b8mr20036757ljh.74.1667960268768; Tue, 08
 Nov 2022 18:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20221109015818.194927-1-jiucheng.xu@amlogic.com> <20221109015818.194927-2-jiucheng.xu@amlogic.com>
In-Reply-To: <20221109015818.194927-2-jiucheng.xu@amlogic.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 8 Nov 2022 18:17:37 -0800
Message-ID: <CAFXsbZqn7KrUvasp5wWvNRo4aEM-Ohmd4nEt8Es95Z44vMUBiQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>
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

Reviewed-by: Chris Healy <healych@amazon.com>

On Tue, Nov 8, 2022 at 5:58 PM Jiucheng Xu <jiucheng.xu@amlogic.com> wrote:
>
> Add a user guide to show how to use DDR PMU to
> monitor DDR bandwidth on Amlogic G12 SoC
>
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v8 -> v9:
>   - No change
>
> Changes v7 -> v8:
>   - No change
>
> Changes v6 -> v7:
>   - Drop the Reported-by tag
>   - Fix spelling error
>
> Changes v5 -> v6:
>   - No change
>
> Changes v4 -> v5:
>   - Fix building warning
>
> Changes v3 -> v4:
>   - No change
>
> Changes v2 -> v3:
>   - Rename doc name from aml-ddr-pmu.rst to meson-ddr-pmu.rst
>
> Changes v1 -> v2:
>   - Nothing was changed
> ---
>  Documentation/admin-guide/perf/index.rst      |  1 +
>  .../admin-guide/perf/meson-ddr-pmu.rst        | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 72 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/meson-ddr-pmu.rst
>
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 69b23f087c05..997a28e156c1 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -17,3 +17,4 @@ Performance monitor support
>     xgene-pmu
>     arm_dsu_pmu
>     thunderx2-pmu
> +   meson-ddr-pmu
> diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> new file mode 100644
> index 000000000000..15e93a751ced
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================================
> +Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
> +===========================================================
> +
> +There is a bandwidth monitor inside the DRAM controller. The monitor includes
> +4 channels which can count the read/write request of accessing DRAM individually.
> +It can be helpful to show if the performance bottleneck is on DDR bandwidth.
> +
> +Currently, this driver supports the following 5 Perf events:
> +
> ++ meson_ddr_bw/total_rw_bytes/
> ++ meson_ddr_bw/chan_1_rw_bytes/
> ++ meson_ddr_bw/chan_2_rw_bytes/
> ++ meson_ddr_bw/chan_3_rw_bytes/
> ++ meson_ddr_bw/chan_4_rw_bytes/
> +
> +meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are the channel related events.
> +Each channel support using keywords as filter, which can let the channel
> +to monitor the individual IP module in SoC.
> +
> +The following keywords are the filter:
> +
> ++ arm             - DDR access request from CPU
> ++ vpu_read1       - DDR access request from OSD + VPP read
> ++ gpu             - DDR access request from 3D GPU
> ++ pcie            - DDR access request from PCIe controller
> ++ hdcp            - DDR access request from HDCP controller
> ++ hevc_front      - DDR access request from HEVC codec front end
> ++ usb3_0          - DDR access request from USB3.0 controller
> ++ hevc_back       - DDR access request from HEVC codec back end
> ++ h265enc         - DDR access request from HEVC encoder
> ++ vpu_read2       - DDR access request from DI read
> ++ vpu_write1      - DDR access request from VDIN write
> ++ vpu_write2      - DDR access request from di write
> ++ vdec            - DDR access request from legacy codec video decoder
> ++ hcodec          - DDR access request from H264 encoder
> ++ ge2d            - DDR access request from ge2d
> ++ spicc1          - DDR access request from SPI controller 1
> ++ usb0            - DDR access request from USB2.0 controller 0
> ++ dma             - DDR access request from system DMA controller 1
> ++ arb0            - DDR access request from arb0
> ++ sd_emmc_b       - DDR access request from SD eMMC b controller
> ++ usb1            - DDR access request from USB2.0 controller 1
> ++ audio           - DDR access request from Audio module
> ++ sd_emmc_c       - DDR access request from SD eMMC c controller
> ++ spicc2          - DDR access request from SPI controller 2
> ++ ethernet        - DDR access request from Ethernet controller
> +
> +
> +The following command is to show the total DDR bandwidth:
> +
> +  .. code-block:: bash
> +
> +      perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
> +
> +This command will print the total DDR bandwidth per second.
> +
> +The following commands are to show how to use filter parameters:
> +
> +  .. code-block:: bash
> +
> +      perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 sleep 10
> +      perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=1/ -I 1000 sleep 10
> +      perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=1,gpu=1/ -I 1000 sleep 10
> +
> +The 1st command show how to use channel 1 to monitor the DDR bandwidth from ARM.
> +The 2nd command show using channel 2 to get the DDR bandwidth of GPU.
> +The 3rd command show using channel 3 to monitor the sum of ARM and GPU.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb63b9cbc149..5ed563368a48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1055,6 +1055,7 @@ M:        Jiucheng Xu <jiucheng.xu@amlogic.com>
>  L:     linux-amlogic@lists.infradead.org
>  S:     Supported
>  W:     http://www.amlogic.com
> +F:     Documentation/admin-guide/perf/meson-ddr-pmu.rst
>  F:     drivers/perf/amlogic/
>  F:     include/soc/amlogic/
>
> --
> 2.25.1
>
