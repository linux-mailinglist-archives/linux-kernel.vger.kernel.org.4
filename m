Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DD61F79C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiKGP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiKGP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:28:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03CEA1B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5F52CE16E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0E0C433C1;
        Mon,  7 Nov 2022 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667834896;
        bh=A6uwQhL+fjnIdp9jAg9GckWiE18J06ATVgZz3sYXlK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogoprlb/DCm9XG9EhNnNWeyeBGyo9GCGHyQtaDHUTtP/kSPHbTnxuc5RlmbYt+FSv
         uHX8YYh7lyc8ARZrkKiZ2dFtG1+sUHHoiBCq/HlY4bbuVQAFJ/xB4mscm8murPiJ6M
         o+ffQKvZrZayFOX2M34fPZoZaoA/0MEfrQ5JLUTWl9J6JyOiqQzJ1m+DzqqCyZkVAI
         eMYLCVepOnlGbHNEAcDuGaLwetx1/8vOM90H/ULtmhbEQSJZ/qZGk0c5p5VFp8CQbB
         mYAh1wh5ZgW2tJ+OgFYZH62tuDDXwfKvU2gZOTmiZSncx7cyci4p1oXQZcrqHIdBAM
         45nTWInF1Rr1g==
Date:   Mon, 7 Nov 2022 15:28:10 +0000
From:   Will Deacon <will@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Jonathan.Cameron@Huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v1 1/3] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Message-ID: <20221107152809.GE21002@willie-the-truck>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20220917121036.14864-2-xueshuai@linux.alibaba.com>
 <20220922132543.GA12095@willie-the-truck>
 <a01eae44-5daf-08bb-ea28-eeacd7006ab9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a01eae44-5daf-08bb-ea28-eeacd7006ab9@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:51:40PM +0800, Shuai Xue wrote:
> 
> 
> 在 2022/9/22 PM9:25, Will Deacon 写道:
> > On Sat, Sep 17, 2022 at 08:10:34PM +0800, Shuai Xue wrote:
> >> Alibaba's T-Head Yitan 710 SoC is built on Synopsys' widely deployed and
> >> silicon-proven DesignWare Core PCIe controller which implements PMU for
> >> performance and functional debugging to facilitate system maintenance.
> >> Document it to provide guidance on how to use it.
> >>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >> ---
> >>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 61 +++++++++++++++++++
> >>  Documentation/admin-guide/perf/index.rst      |  1 +
> >>  2 files changed, 62 insertions(+)
> >>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> >>
> >> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> >> new file mode 100644
> >> index 000000000000..fbcbf10b23b7
> >> --- /dev/null
> >> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> >> @@ -0,0 +1,61 @@
> >> +======================================================================
> >> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
> >> +======================================================================
> >> +
> >> +DesignWare Cores (DWC) PCIe PMU
> >> +===============================
> >> +
> >> +To facilitate collection of statistics, Synopsys DesignWare Cores PCIe
> >> +controller provides the following two features:
> >> +
> >> +- Time Based Analysis (RX/TX data throughput and time spent in each
> >> +  low-power LTSSM state)
> >> +- Lane Event counters (Error and Non-Error for lanes)
> >> +
> >> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
> >> +only register counters provided by each PCIe Root Port.
> >> +
> >> +Time Based Analysis
> >> +-------------------
> >> +
> >> +Using this feature you can obtain information regarding RX/TX data
> >> +throughput and time spent in each low-power LTSSM state by the controller.
> >> +
> >> +The counters are 64-bit width and measure data in two categories,
> >> +
> >> +- percentage of time does the controller stay in LTSSM state in a
> >> +  configurable duration. The measurement range of each Event in Group#0.
> >> +- amount of data processed (Units of 16 bytes). The measurement range of
> >> +  each Event in Group#1.
> >> +
> >> +Lane Event counters
> >> +-------------------
> >> +
> >> +Using this feature you can obtain Error and Non-Error information in
> >> +specific lane by the controller.
> >> +
> >> +The counters are 32-bit width and the measured event is select by:
> >> +
> >> +- Group i
> >> +- Event j within the Group i
> >> +- and Lank k
> >> +
> >> +Some of the event counters only exist for specific configurations.
> >> +
> >> +DesignWare Cores (DWC) PCIe PMU Driver
> >> +=======================================
> >> +
> >> +This driver add PMU devices for each PCIe Root Port. And the PMU device is
> >> +named based the BDF of Root Port. For example,
> >> +
> >> +    10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> >> +
> >> +the PMU device name for this Root Port is pcie_bdf_100000.
> >> +
> >> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> >> +
> >> +    $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> > 
> > Do you really need to expose a separate PMU instance to userspace for each
> > BDF? I think it would be much cleaner if you could follow the approach used
> > by hisilicon/hisi_pcie_pmu.c and hide these details in the driver, exposing
> > a `bdf=' selector to userspace instead.
> 
> Thank you for your valuable comments.
> 
> It's a good idea to encode bdf in bitmap and exposing a `bdf=' selector to userspace.
> The problem of bdf selector is that the user need to compute bdf from lanes, do you
> think it is user friendly? I'm worried about increasing the burden of users.

I don't see this as being an issue, particularly if you document how to do
it.

Will
