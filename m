Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B1696140
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBNKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjBNKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:45:45 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD126866;
        Tue, 14 Feb 2023 02:45:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AE5BC3FB17;
        Tue, 14 Feb 2023 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1676371452; bh=+3HwTc9ECCiYjn5bB7Ckhk2en8do+vQ2etYA80kGnc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=K123Gas5KDqjqIqfg5w1nZuAe/HmooRGNhtmN8V/U+mQYp8NICfNSfZ0s0Wh4bpQ8
         XW33aBK0RMCM9mhtYWCCD/NqGFafdWaSeV+NrqtLoMZnP6ypdvxuTWM5K/g67emTMg
         /HiDf6IU+IvfWgGRSAuHUnvxbH/H4XRDcWmuVSnhsz9I56y2k7S2MAKts28IGHdH6Y
         /d8TWEkVVStdNAJSz+7ioXnkRKUltev84u6rYzNFi8CEdEjzwrcdiUMvXyJncTAS7R
         oRcaUyhC1/tkbX3nxGv8qOpSiQ5NqROohjBsbi/kLp6syLJt9ZTBeYdH4vWlYAbgPT
         WfCQg3aapQDzA==
Message-ID: <6009e594-ec2e-cf02-842c-91e993d66d36@marcan.st>
Date:   Tue, 14 Feb 2023 19:44:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] Apple M2 PMU support
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 19.38, Janne Grunau wrote:
> This small series adds support for the PMU in Apple M2 cores. The PMU
> itself appears to work in the same way as om M1. We still want to add
> CPU type specific compatible strings so that we can distinguish counters
> in the case they count (slightly) different things on different CPU
> uarchs.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (2):
>       dt-bindings: arm-pmu: Add PMU compatible strings for Apple M2 cores
>       drivers/perf: apple_m1: Add Apple M2 support
> 
>  Documentation/devicetree/bindings/arm/pmu.yaml |  2 ++
>  drivers/perf/apple_m1_cpu_pmu.c                | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230214-apple_m2_pmu-175b75c74d4e

For the series,

Reviewed-by: Hector Martin <marcan@marcan.st>

- Hector
