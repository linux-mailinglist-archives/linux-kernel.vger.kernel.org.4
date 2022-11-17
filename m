Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0BE62DA21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiKQMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiKQMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:01:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 184555B846;
        Thu, 17 Nov 2022 04:01:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3748813D5;
        Thu, 17 Nov 2022 04:01:56 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D32B53F663;
        Thu, 17 Nov 2022 04:01:47 -0800 (PST)
Date:   Thu, 17 Nov 2022 12:01:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117120145.ou2pg7obxnwlsc36@bogus>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
 <20221117112403.haffuclwooudvgwz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117112403.haffuclwooudvgwz@vireshk-i7>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:54:03PM +0530, Viresh Kumar wrote:
> On 17-11-22, 10:19, Sudeep Holla wrote:
> > Why do you need the above 3 changes if the below(4/4) will ensure
> > cpufreq_get(cpu) returns the clock frequency. I was expecting to drop the
> > whole "confusing" clock bindings and the unnecessary clock provider.
> > 
> > Can't we just use cpufreq_get(cpu) ?
> 
> https://lore.kernel.org/lkml/cover.1657695140.git.viresh.kumar@linaro.org/
> 
> The basic idea (need) here was to fix the DT and let the CPU nodes have clock
> related properties, which are missing currently.
> 
> The context can be seen in the above thread.

Thanks for the link. Sorry I still don't get the complete picture. Who are
the consumers of these clock nodes if not cpufreq itself.

I am going to guess, so other device(like inter-connect) with phandle into
CPU device perhaps ? Also I assume it will have phandle to non-CPU device
and hence we need generic device clock solution. Sorry for the noise, but
I still find having both clocks and qcom,freq-domain property is quite
confusing but I am fine as I understand it bit better now.

-- 
Regards,
Sudeep
