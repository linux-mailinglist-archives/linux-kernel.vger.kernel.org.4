Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4626F6218B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiKHPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiKHPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:45:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9053B57B72;
        Tue,  8 Nov 2022 07:45:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8009A1FB;
        Tue,  8 Nov 2022 07:45:42 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B083F73D;
        Tue,  8 Nov 2022 07:45:34 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:45:32 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221108154532.dvo3drvvkagkssab@bogus>
References: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:38:15PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds clock provider support to the Qcom CPUFreq driver for
> supplying the clocks to the CPU cores in Qcom SoCs.
> 
> The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> clocks to the CPU cores. But this is not represented clearly in devicetree.
> There is no clock coming out of the CPUFreq HW node to the CPU. This created
> an issue [1] with the OPP core when a recent enhancement series was submitted.
> Eventhough the issue got fixed in the OPP framework in the meantime, that's
> not a proper solution and this series aims to fix it properly.
> 
> There was also an attempt made by Viresh [2] to fix the issue by moving the
> clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> since those clocks belong to the CPUFreq HW node only.
> 
> The proposal here is to add clock provider support to the Qcom CPUFreq HW
> driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> This correctly reflects the hardware implementation.
>

Just curious as who will be the consumer of this CPU clock information ?
Traditionally it was cpufreq that needed this information. But now with
this series, it is bit convoluted IMO as the clocks is depending on the
CPUFreq information indirectly and not used by cpufreq.

Whoever is the consumer of this clock, why can't they use cpufreq information ?

I did a quick check and couldn't find the info I am requesting here, sorry if
it is already answered/discussed. Please just point me the url.

-- 
Regards,
Sudeep
