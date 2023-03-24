Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3E6C837E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCXRmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CCBC64C;
        Fri, 24 Mar 2023 10:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35DF62C1A;
        Fri, 24 Mar 2023 17:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B9C433EF;
        Fri, 24 Mar 2023 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679679730;
        bh=sk7R+qaRnvRoyWIxFll8DPdn5wqX+Pp6np8xpvBRcZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxj9WV/IaFFX4jIdJ3milBTT3JlHExArc/Z4f+1/UtC229TqKbL1rMNHcYqoOtdNl
         pa853S/83SrYck1OLSCcvRigaFXNcSTyV+46DNrUChjEwGCYgtZkj8oA8Q8aBjZg7S
         dWuLlazxLkjXjVeQehHkjpkT5uG2gHlBNL95QLA2Gt2FeHcq5GdGrhg85tUrdKFdJy
         kFO/71V+xeVB4euOy6/Y73GROGYcDgzxLD1zdkvvmKO4tXQ0xjmcsTMI2UFWnucy4W
         fZUqdBh8GDsSfKUc7HA0wQnh0nmz6VSgjMxbzYAbvPgr/15QoktLoe4iDUCV/oSSRQ
         hBocaR0TrMPJA==
Date:   Fri, 24 Mar 2023 10:45:18 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8450: remove invalid
 properties in cluster-sleep nodes
Message-ID: <20230324174518.2arvdglqqixmxqcp@ripper>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-2-0ca1bea1a843@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-2-0ca1bea1a843@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:28:47AM +0100, Neil Armstrong wrote:
> Fixes the following DT bindings check error:

Is that because idle-state-name and local-timer-stop should not be
defined for domain-idle-states or are you just clearing out the
dtbs_check warning?

According to cpu-capacity.txt local-timer-stop seems to have been a
property relevant for clusters in the past, was this a mistake in the
binding or did something change when this was moved to
domain-idle-states?

Regards,
Bjorn

> domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> domain-idle-states: cluster-sleep-1: 'idle-state-name', 'local-timer-stop' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 78fb65bd15cc..ff55fcfdd676 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -255,22 +255,18 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>  		domain-idle-states {
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
>  				compatible = "domain-idle-state";
> -				idle-state-name = "cluster-l3-off";
>  				arm,psci-suspend-param = <0x41000044>;
>  				entry-latency-us = <1050>;
>  				exit-latency-us = <2500>;
>  				min-residency-us = <5309>;
> -				local-timer-stop;
>  			};
>  
>  			CLUSTER_SLEEP_1: cluster-sleep-1 {
>  				compatible = "domain-idle-state";
> -				idle-state-name = "cluster-power-collapse";
>  				arm,psci-suspend-param = <0x4100c344>;
>  				entry-latency-us = <2700>;
>  				exit-latency-us = <3500>;
>  				min-residency-us = <13959>;
> -				local-timer-stop;
>  			};
>  		};
>  	};
> 
> -- 
> 2.34.1
> 
