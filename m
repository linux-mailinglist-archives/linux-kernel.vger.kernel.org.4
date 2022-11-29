Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EAF63C19D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiK2OAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiK2OAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:00:50 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689A532B88;
        Tue, 29 Nov 2022 06:00:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 33E213FB17;
        Tue, 29 Nov 2022 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669730446; bh=adS46JVWH1WlaPbDZblMEFJYiqhfkyXnDs8IpAPLC2w=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=IWzbqBPmY10XvuyP3B89YIfdQPitUUc8VmOhJdYYoFvGO6o3rEW+9bPt3rhVg6WYw
         Io36r7PLmxsCpw+cSXJPEMJabwGTe+KLxK+R1UGR6mTj3wLIgKrOc0+uP2do0C5Kc4
         JpeYbXAxFezVdpDv7Lo2DsBIzYapRii4GyUd/zDt9HXVPgw7nfSMNDHiG4jwsD7IgX
         0f3nV4yp1tx0RHSlBf1wK9zh4OhDOhEuShnm8Y7Kdh8WY4jnL+171EqVQRHNS5Yxjz
         ESIDwC0CxOL39402m8cm6gFBkbIEG4vgtZT0BdOPx2p5/eR3l/8qEZYwoT6LC7nLQA
         65PJAxTtnhSyQ==
Message-ID: <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
Date:   Tue, 29 Nov 2022 23:00:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
In-Reply-To: <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 20.36, Ulf Hansson wrote:
> On Mon, 28 Nov 2022 at 15:29, Hector Martin <marcan@marcan.st> wrote:
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

While I agree with the technical rationale and the proposed approach
being better in principle...

We're at v5 of bikeshedding this trivial driver's DT binding, and the
comment could've been made at v3. To quote IRC just now:

> this way the machines will be obsolete before things are fully upstreamed

I think it's long overdue for the kernel community to take a deep look
at itself and its development and review process, because it is quite
honestly insane how pathologically inefficient it is compared to,
basically, every other large and healthy open source project of similar
or even greater impact and scope.

Cc Linus, because this is for your Mac and I assume you care. We're at
v5 here for this silly driver. Meanwhile, rmk recently threw the towel
on upstreaming macsmc for us. We're trying, and I'll keep trying because
I actually get paid (by very generous donors) to do this, but if I
weren't I'd have given up a long time ago. And while I won't give up, I
can't deny this situation affects my morale and willingness to keep
pushing on upstreaming on a regular basis.

Meanwhile, OpenBSD has been *shipping* full M1 support for a while now
in official release images (and since Linux is the source of truth for
DT bindings, every time we re-bikeshed it we break their users because
they, quite reasonably, aren't interested in waiting for us Linux
slowpokes to figure it out first).

Please, let's introspect about this for a moment. Something is deeply
broken if people with 25+ years being an arch maintainer can't get a
700-line mfd driver upstreamed before giving up. I don't know how we
expect to ever get a Rust GPU driver merged if it takes 6+ versions to
upstream the world's easiest cpufreq hardware.

- Hector
