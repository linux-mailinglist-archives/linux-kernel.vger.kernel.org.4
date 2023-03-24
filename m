Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEE6C863C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCXTyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCXTyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8126B1BDA;
        Fri, 24 Mar 2023 12:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD87862AD3;
        Fri, 24 Mar 2023 19:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E957AC433EF;
        Fri, 24 Mar 2023 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679687645;
        bh=+l1Tmr6waa7ZpwQpJUq3NH4jxVo6IGOnRiecZJHvp9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWzQ90dJJ4XktycTJ1Js2unTbW1g9b6OhlV89FkuxIvs73yLlwFwCBXsq0ZbiAbsS
         hUGqmmaUfZjTMduY+dubRO2akcckszFzZ77LePRCyX8svr/Yu/TBLQVqkhX/p7Zz6l
         4VKjzBoRyqiIKX4T6+snATZWYkFz5oPE1VjOIdc9sWzNOuON6ENM2LCxgLP2LqoLod
         b9zE00ZSaLIexQRBvRUopfoLuNKqojucT/zxFtZ5KGnK5Lu2O2GJa5Crql1ame8LY0
         W8x04UfKdANOorVNd4dBKjxyAUZ5W7Fs6n5B/pTnPz+vb2J293qsRWtgfic6oZCJl4
         4aBEwyo44z2UA==
Date:   Fri, 24 Mar 2023 12:57:13 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8450: remove invalid
 properties in cluster-sleep nodes
Message-ID: <20230324195713.5blwpv7xjijlrtt5@ripper>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-2-0ca1bea1a843@linaro.org>
 <20230324174518.2arvdglqqixmxqcp@ripper>
 <fdd51d3d-a1fd-c3a9-c578-59a11c5213de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd51d3d-a1fd-c3a9-c578-59a11c5213de@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:27:12PM +0100, Krzysztof Kozlowski wrote:
> On 24/03/2023 18:45, Bjorn Andersson wrote:
> > On Fri, Mar 24, 2023 at 10:28:47AM +0100, Neil Armstrong wrote:
> >> Fixes the following DT bindings check error:
> > 
> > Is that because idle-state-name and local-timer-stop should not be
> > defined for domain-idle-states or are you just clearing out the
> > dtbs_check warning?
> > 
> > According to cpu-capacity.txt local-timer-stop seems to have been a
> > property relevant for clusters in the past, was this a mistake in the
> > binding or did something change when this was moved to
> > domain-idle-states?
> 
> I cannot find anything about local-timer-stop in cpu-capacity.txt. Where
> do you see it?
> 

Ohh, you're right it's only mentioned in the example.

But idle-states.yaml documents the property for both cpus and clusters,
and it's used throughout the examples.

Our cluster states are defined in domanin-idle-states instead of
idle-state, does this imply that the flag is no longer applicable
per cluster in this mode of operation?

Regards,
Bjorn
