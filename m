Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE79762B703
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKPJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiKPJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:56:20 -0500
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 01:55:28 PST
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093A1789E;
        Wed, 16 Nov 2022 01:55:28 -0800 (PST)
Received: from [10.88.19.158] (10.88.19.158) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 16 Nov 2022
 17:55:26 +0800
Message-ID: <7bb5e9ee-358b-ce6f-2cb5-a6b6b558c0a9@amlogic.com>
Date:   Wed, 16 Nov 2022 17:56:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 2/2] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.garry@huawei.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Chris Healy <cphealy@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amazon.com>
References: <20221116003133.1049346-1-jiucheng.xu@amlogic.com>
 <20221116003133.1049346-2-jiucheng.xu@amlogic.com>
 <Y3SwIPnDvEOlL+Mz@debian.me>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <Y3SwIPnDvEOlL+Mz@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.19.158]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my poor English. Your writing looks very elegant. I will apply 
your modification in next version.

Thanks,

Jiucheng

On 2022/11/16 17:40, Bagas Sanjaya wrote:
>
> The wordings are rather weird, so I need to improve the doc:
>
> ---- >8 ----
>
> diff --git a/Documentation/admin-guide/perf/meson-ddr-pmu.rst b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> index 15e93a751ced8a..4a1fdb5aba4b24 100644
> --- a/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> +++ b/Documentation/admin-guide/perf/meson-ddr-pmu.rst
> @@ -4,11 +4,12 @@
>   Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
>   ===========================================================
>   
> -There is a bandwidth monitor inside the DRAM controller. The monitor includes
> -4 channels which can count the read/write request of accessing DRAM individually.
> -It can be helpful to show if the performance bottleneck is on DDR bandwidth.
> +The Amlogic Meson G12 SoC contains a bandwidth monitor inside DRAM controller.
> +The monitor includes 4 channels which can count the read/write request of
> +individual DRAM. It can be helpful to show if the performance bottleneck is on
> +DDR bandwidth.
>   
> -Currently, this driver supports the following 5 Perf events:
> +Currently, this driver supports the following 5 perf events:
>   
>   + meson_ddr_bw/total_rw_bytes/
>   + meson_ddr_bw/chan_1_rw_bytes/
> @@ -16,55 +17,54 @@ Currently, this driver supports the following 5 Perf events:
>   + meson_ddr_bw/chan_3_rw_bytes/
>   + meson_ddr_bw/chan_4_rw_bytes/
>   
> -meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are the channel related events.
> -Each channel support using keywords as filter, which can let the channel
> -to monitor the individual IP module in SoC.
> +meson_ddr_bw/chan_{1,2,3,4}_rw_bytes/ events are channel-specific events.
> +Each channel support filtering, which can let the channel to monitor
> +individual IP module in SoC.
>   
> -The following keywords are the filter:
> +Below are DDR access request event filter keywords:
>   
> -+ arm             - DDR access request from CPU
> -+ vpu_read1       - DDR access request from OSD + VPP read
> -+ gpu             - DDR access request from 3D GPU
> -+ pcie            - DDR access request from PCIe controller
> -+ hdcp            - DDR access request from HDCP controller
> -+ hevc_front      - DDR access request from HEVC codec front end
> -+ usb3_0          - DDR access request from USB3.0 controller
> -+ hevc_back       - DDR access request from HEVC codec back end
> -+ h265enc         - DDR access request from HEVC encoder
> -+ vpu_read2       - DDR access request from DI read
> -+ vpu_write1      - DDR access request from VDIN write
> -+ vpu_write2      - DDR access request from di write
> -+ vdec            - DDR access request from legacy codec video decoder
> -+ hcodec          - DDR access request from H264 encoder
> -+ ge2d            - DDR access request from ge2d
> -+ spicc1          - DDR access request from SPI controller 1
> -+ usb0            - DDR access request from USB2.0 controller 0
> -+ dma             - DDR access request from system DMA controller 1
> -+ arb0            - DDR access request from arb0
> -+ sd_emmc_b       - DDR access request from SD eMMC b controller
> -+ usb1            - DDR access request from USB2.0 controller 1
> -+ audio           - DDR access request from Audio module
> -+ sd_emmc_c       - DDR access request from SD eMMC c controller
> -+ spicc2          - DDR access request from SPI controller 2
> -+ ethernet        - DDR access request from Ethernet controller
> ++ arm             - from CPU
> ++ vpu_read1       - from OSD + VPP read
> ++ gpu             - from 3D GPU
> ++ pcie            - from PCIe controller
> ++ hdcp            - from HDCP controller
> ++ hevc_front      - from HEVC codec front end
> ++ usb3_0          - from USB3.0 controller
> ++ hevc_back       - from HEVC codec back end
> ++ h265enc         - from HEVC encoder
> ++ vpu_read2       - from DI read
> ++ vpu_write1      - from VDIN write
> ++ vpu_write2      - from di write
> ++ vdec            - from legacy codec video decoder
> ++ hcodec          - from H264 encoder
> ++ ge2d            - from ge2d
> ++ spicc1          - from SPI controller 1
> ++ usb0            - from USB2.0 controller 0
> ++ dma             - from system DMA controller 1
> ++ arb0            - from arb0
> ++ sd_emmc_b       - from SD eMMC b controller
> ++ usb1            - from USB2.0 controller 1
> ++ audio           - from Audio module
> ++ sd_emmc_c       - from SD eMMC c controller
> ++ spicc2          - from SPI controller 2
> ++ ethernet        - from Ethernet controller
>   
>   
> -The following command is to show the total DDR bandwidth:
> +Examples:
>   
> -  .. code-block:: bash
> +  + Show the total DDR bandwidth per seconds:
>   
> -      perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
> +    .. code-block:: bash
>   
> -This command will print the total DDR bandwidth per second.
> +       perf stat -a -e meson_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
>   
> -The following commands are to show how to use filter parameters:
>   
> -  .. code-block:: bash
> +  + Show individual DDR bandwidth from CPU and GPU respectively, as well as
> +    sum of them:
>   
> -      perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 sleep 10
> -      perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=1/ -I 1000 sleep 10
> -      perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=1,gpu=1/ -I 1000 sleep 10
> +    .. code-block:: bash
> +
> +       perf stat -a -e meson_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 sleep 10
> +       perf stat -a -e meson_ddr_bw/chan_2_rw_bytes,gpu=1/ -I 1000 sleep 10
> +       perf stat -a -e meson_ddr_bw/chan_3_rw_bytes,arm=1,gpu=1/ -I 1000 sleep 10
>   
> -The 1st command show how to use channel 1 to monitor the DDR bandwidth from ARM.
> -The 2nd command show using channel 2 to get the DDR bandwidth of GPU.
> -The 3rd command show using channel 3 to monitor the sum of ARM and GPU.
>
> Thanks.
>
-- 
Thanks,
Jiucheng

