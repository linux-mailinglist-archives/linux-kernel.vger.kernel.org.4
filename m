Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9113363C1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiK2ODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiK2ODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:03:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD9140CB;
        Tue, 29 Nov 2022 06:02:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C72761752;
        Tue, 29 Nov 2022 14:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E28C433D7;
        Tue, 29 Nov 2022 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669730577;
        bh=rO7yqgdWyNq3EM/Oqp68vfyfQaLdzq20dcvot8x/GeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S6mFhxcoZLEdjKmV1WrgU2HV039yJTJzw9l6X4o6Si0KSGt+jLRzK2Tt9yaq9knHo
         c5h6COBslmC+6FRv3Vupa4s3hJSycD8jLOzsUQbskmTAwtMy0HDRSLkddlea8s6MXq
         IP7JfMh7OJfLtRZpVD2K8L1g1xbzZs7w5OWGuoueJBBO13GVUI4DKrdV2H4nr+JCXa
         puQfx0NtuPhgC40ca/U1Z12mg4w9EKuR68Y2TTQtqKAXoeSgjgvBF7tGSKeOeoJ1Nl
         lrB0Cf3X6jin0aXPn25h+lh98J1+JgzEtXaRz6blkf0FxWA0kt+rfF68D2vwJWTXy9
         4NyEL+4P0/dpg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p01CJ-009Mgz-8B;
        Tue, 29 Nov 2022 14:02:55 +0000
MIME-Version: 1.0
Date:   Tue, 29 Nov 2022 14:02:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
In-Reply-To: <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <44c746aee96ebf13bd701d78f1c2b9c0@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ulf.hansson@linaro.org, marcan@marcan.st, rafael@kernel.org, viresh.kumar@linaro.org, matthias.bgg@gmail.com, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org, mark.kettenis@xs4all.nl, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-29 11:36, Ulf Hansson wrote:
> On Mon, 28 Nov 2022 at 15:29, Hector Martin <marcan@marcan.st> wrote:
>> 
>> +examples:
>> +  - |
>> +    // This example shows a single CPU per domain and 2 domains,
>> +    // with two p-states per domain.
>> +    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
>> +    cpus {
>> +      #address-cells = <2>;
>> +      #size-cells = <0>;
>> +
>> +      cpu@0 {
>> +        compatible = "apple,icestorm";
>> +        device_type = "cpu";
>> +        reg = <0x0 0x0>;
>> +        operating-points-v2 = <&ecluster_opp>;
> 
> To me, it looks like the operating-points-v2 phandle better belongs in
> the performance-domains provider node. I mean, isn't the OPPs really a
> description of the performance-domain provider?
> 
> That said, I suggest we try to extend the generic performance-domain
> binding [1] with an "operating-points-v2". In that way, we should
> instead be able to reference it from this binding.
> 
> In fact, that would be very similar to what already exists for the
> generic power-domain binding [2]. I think it would be rather nice to
> follow a similar pattern for the performance-domain binding.

I'm not going to rabbit-hole into whether this is a good
or a bad binding. As far as I'm concerned, and as a user
of the HW it describes, it does the job in a satisfactory
manner.

What I'm concerned about is that this constant, last minute
bikeshedding that actively prevents upstreaming of support
for HW that people are actively using.

If anything, this is only causing people to stop trying to
contribute to the upstream kernel because of this constant
DT bikeshed. Honestly, writing code to support this HW is
a lot less effort than trying to get 3 different people to
agree on a binding.

It also affects other OSs that rely on the the same bindings,
and will eventually only result in developers not submitting
bindings anymore. After all, nothing says that bindings and
device trees have to exist in the Linux kernel tree.

         M.
-- 
Jazz is not dead. It just smells funny...
