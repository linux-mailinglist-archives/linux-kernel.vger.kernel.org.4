Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF880617A22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKCJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKCJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:41:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19B29E0F7;
        Thu,  3 Nov 2022 02:41:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7031FB;
        Thu,  3 Nov 2022 02:41:41 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398673F5A1;
        Thu,  3 Nov 2022 02:41:33 -0700 (PDT)
Date:   Thu, 3 Nov 2022 09:41:21 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, sudeep.holla@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        quic_avajid@quicinc.com, souvik.chakravarty@arm.com
Subject: Re: [RFC 0/2] Add support for SCMI QTI Memlat Vendor Protocol
Message-ID: <Y2OMpiMXcaEiiA/2@e120937-lin>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:28:30AM +0530, Sibi Sankar wrote:
> The patch series documents the bindings and adds support for the
> SCMI QTI memlat (memory latency) vendor protocol. The protocol takes
> in several tuneables including the IPM ratio (Instructions Per Miss),
> bus bandwidth requirements and PMU maps to enable frequency scaling
> of various buses (L3/LLCC/DDR). The scaling is performed by the HW
> memory latency governor running on the CPUSS Control Processor.
> 
> Depends on CPUCP mailbox driver:
> https://patchwork.kernel.org/project/linux-arm-msm/cover/1663135386-26270-1-git-send-email-quic_sibis@quicinc.com/
> 

[+ CC: souvik.chakravarty@arm.com ]

Hi Sibi,

Nice to see vendor protocols starting to make their way into upstream !

I only glanced through the series as of now, and I'd have a few
questions before going on with the review:

 - why this protocol is dependent on a specific transport ?
   Is it to compile it only on platform supoprting it without adding
   a per-protocol Kconfig ?

Protocols are anyway enumerated at SCMI stack probe time so even if it
is not there it just won't be activated...I maybe missing something.

Thanks,
Cristian

