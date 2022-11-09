Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C26229A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKILIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKILIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:08:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0E4063B6;
        Wed,  9 Nov 2022 03:08:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B55EE1FB;
        Wed,  9 Nov 2022 03:08:41 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80AF3F534;
        Wed,  9 Nov 2022 03:08:33 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:08:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221109110831.lngwmwyjqp4qj73r@bogus>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
 <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
 <20221108155717.srlnabls5ze2resx@bogus>
 <20221109074908.GC4651@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109074908.GC4651@thinkpad>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:19:08PM +0530, Manivannan Sadhasivam wrote:

[...]

> qcom_cpufreq_hw_get() returns the frequency that got programmed by the cpufreq
> core. But that frequency is not necessarily the one that gets delivered to the
> CPU cores because the EPSS/OSM hardware block may vary the frequency after the
> DCVS operation.
> 
> So this frequency is the final one that gets delivered to the CPU cores.
> 

OK, thanks for the info. Just wondering if there is any issue making
qcom_cpufreq_hw_get() return this value instead of all these complexity.
I think the DT binding is too confusing as cpufreq-dt uses that to manage
DVFS which this one uses it.

If possible we should just make cpufreq_get(cpu) return the value you need
and use the same where ever you need. Sorry if I am missing something obvious
but I am struggling to see that.

-- 
Regards,
Sudeep
