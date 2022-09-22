Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C95E6387
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiIVNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiIVNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00EED5F4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1765633E2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93862C43470;
        Thu, 22 Sep 2022 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663853150;
        bh=dzNyds4GT/pUOPUdrgeZ/5PR+45cCizJBsKcIdHDvgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX+hn2QN6R82tAOdEhP+bRamuCodQekl+DKlnqVCF+tKWutNqWfKGEutp8P7wdZrt
         lTMyJX0TGZ4L8qpqpfp9+O+TtWw9ZNhy3EtsIKkrQBZgz3KrJN6Gie4lHmPOixOIiy
         JGQy9TosqPRm9ktrlQcgQxuwuqOKUVsK9Z25NMELYeHkl9VwIOMcxzpZ0uwjZJwtUx
         NeBHC1aen5whFJ3ouo7Bys8K1AwMEfJF1uddITAUroHE39OO+g1pOkspXD32OyQ6uj
         j4+H464lMrdVjyRDKjpqHtPgqIFsxmC4eszyZ8djI+X9pN26BLuhnqFd50tGwhi95D
         cOPoyV0yCSwBg==
Date:   Thu, 22 Sep 2022 14:25:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Jonathan.Cameron@Huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v1 1/3] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Message-ID: <20220922132543.GA12095@willie-the-truck>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20220917121036.14864-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917121036.14864-2-xueshuai@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 08:10:34PM +0800, Shuai Xue wrote:
> Alibaba's T-Head Yitan 710 SoC is built on Synopsys' widely deployed and
> silicon-proven DesignWare Core PCIe controller which implements PMU for
> performance and functional debugging to facilitate system maintenance.
> Document it to provide guidance on how to use it.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 61 +++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst      |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> 
> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> new file mode 100644
> index 000000000000..fbcbf10b23b7
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> @@ -0,0 +1,61 @@
> +======================================================================
> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
> +======================================================================
> +
> +DesignWare Cores (DWC) PCIe PMU
> +===============================
> +
> +To facilitate collection of statistics, Synopsys DesignWare Cores PCIe
> +controller provides the following two features:
> +
> +- Time Based Analysis (RX/TX data throughput and time spent in each
> +  low-power LTSSM state)
> +- Lane Event counters (Error and Non-Error for lanes)
> +
> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
> +only register counters provided by each PCIe Root Port.
> +
> +Time Based Analysis
> +-------------------
> +
> +Using this feature you can obtain information regarding RX/TX data
> +throughput and time spent in each low-power LTSSM state by the controller.
> +
> +The counters are 64-bit width and measure data in two categories,
> +
> +- percentage of time does the controller stay in LTSSM state in a
> +  configurable duration. The measurement range of each Event in Group#0.
> +- amount of data processed (Units of 16 bytes). The measurement range of
> +  each Event in Group#1.
> +
> +Lane Event counters
> +-------------------
> +
> +Using this feature you can obtain Error and Non-Error information in
> +specific lane by the controller.
> +
> +The counters are 32-bit width and the measured event is select by:
> +
> +- Group i
> +- Event j within the Group i
> +- and Lank k
> +
> +Some of the event counters only exist for specific configurations.
> +
> +DesignWare Cores (DWC) PCIe PMU Driver
> +=======================================
> +
> +This driver add PMU devices for each PCIe Root Port. And the PMU device is
> +named based the BDF of Root Port. For example,
> +
> +    10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> +
> +the PMU device name for this Root Port is pcie_bdf_100000.
> +
> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> +
> +    $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/

Do you really need to expose a separate PMU instance to userspace for each
BDF? I think it would be much cleaner if you could follow the approach used
by hisilicon/hisi_pcie_pmu.c and hide these details in the driver, exposing
a `bdf=' selector to userspace instead.

Will
