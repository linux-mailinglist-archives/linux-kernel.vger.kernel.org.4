Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F188E729B38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbjFINOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbjFINOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BA2E43;
        Fri,  9 Jun 2023 06:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA238614D1;
        Fri,  9 Jun 2023 13:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501EDC433D2;
        Fri,  9 Jun 2023 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686316455;
        bh=qgIw3ZmXGorDQYkQ1E+r3SCp4BCBY6HOYRFQ0E9qhj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eM1TpsLXyvb5hqFPZtL+HvhboO5hsh4NRQd8mHIEvZS1Zx81GPjJD0ltvcq+PSQSi
         BD4etuaw0grWBkCR1tF6WWWTVOH9xLg88NcJiIEEO9OuH241BGKd4KSUHXXU/nXGHj
         qeundAAb/1uEOt4TCddwRZukAd89nT+GLDhvbvLkkQqFUn0P7MBZBNXAXFKJKODWKL
         sM62G66SI2TPgxbnLrAonM1Y4+TzVxPyagrsP836dcAd7J1RB+qiLwsqLRr5Qbcm7S
         aJaw6k4+FpGnzfzh/ysVyXt+y4vK9OMZNAQG7+hI138uZc+L/ZYW81YMA8GRGe/div
         xeRTIJwNIOwUg==
Message-ID: <9ae34dcc-0022-8097-7c86-8b11811ac2e1@kernel.org>
Date:   Fri, 9 Jun 2023 15:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
Content-Language: en-US
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_mkshah@quicinc.com, devicetree@vger.kernel.org
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230608085544.16211-2-quic_tnimkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 10:55, Tushar Nimkar wrote:
> This change adds idle-state-disabled property using which certain or all

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> idle-states can be kept disabled during boot-up. Once boot-up is completed
> same can be enabled using below command.
> 

I don't understand and you did not explain here, why this is useful and
why this is needed.

> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable


> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> ---
>  Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> index b8cc826c9501..f999bc666bbd 100644
> --- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
> +++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> @@ -358,6 +358,13 @@ patternProperties:
>            systems entry-latency-us + exit-latency-us will exceed
>            wakeup-latency-us by this duration.
>  
> +      idle-state-disabled:
> +        description: |
> +          If present the idle state stays disabled. It can be enabled back from
> +          shell using below command.
> +          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable

This is Linux specific command, so does not fit the bindings.

Best regards,
Krzysztof

