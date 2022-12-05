Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE5164352F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiLEUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiLEUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:02:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08CB10CB;
        Mon,  5 Dec 2022 12:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56B7AB80E6F;
        Mon,  5 Dec 2022 20:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4354C433D6;
        Mon,  5 Dec 2022 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670270560;
        bh=Nr9qAFkOjKJXxGf3nfHjroa81FlJK3z/0Sp6VRgIWw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7dsTvcw6XxQIkuPJEHkC3DudoJfY5i/o15Y0mWAslMqBR/i3j0mL8KRA6r1hrwnT
         MIrbyWsJBtNaQ+ePnVBeJ6eGZIfCrueUqkTjQVuJESrD+MZknd+PmdXq2bPY2EX0cE
         aGITTerd65L+p9kX7i7BNngq5197vQ+YnhitP3jj0LlPE4ocq4q6uqWmEcbxfE5a3x
         fzp5bSWGDFZH4LdVX8DuS1+YX/1/VKL+cYE6IVtz44mDdcvYyH4oLjX5smA37NzYpo
         X7NkbPRSI4l6gIBK+juFlcQWpXmnJXxqUVfGoCuHjcFkrzowbOLBgI+rRDaxTd6ISO
         1tSSveccz0RGw==
Date:   Mon, 5 Dec 2022 14:02:36 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/13] arm64: dts: qcom: sa8295-adp: Enable DP
 instances
Message-ID: <20221205200236.2t25pv5abrgkrt5k@builder.lan>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
 <20221205174433.16847-14-quic_bjorande@quicinc.com>
 <b58f6935-b6ac-128b-2fec-a06dccc3210f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58f6935-b6ac-128b-2fec-a06dccc3210f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 07:09:45PM +0100, Konrad Dybcio wrote:
> On 05/12/2022 18:44, Bjorn Andersson wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
[..]
> > +&mdss0_dp2 {
> > +	status = "okay";
> status should go last.
> 

Thanks for pointing that out. Would be nice if the computer told me
that...somehow...

> > +
> > +	data-lanes = <0 1 2 3>;
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> > +			mdss0_dp2_phy_out: endpoint {
> That's quite a lot of indentation.. couldn't these endpoints be defined in
> the SoC DT?
> 

The alternative would be to have the description of each DP controller
split over multiple nodes and rely on the reader to stitch together the
view of the node based on the label.
Based on the naming of these labels they would at least be adjacent, so
it wouldn't be that bad.

But I feel that there is enough DP-controller nodes in this board
already; I've yet to describe the two USB Type-C controllers or the two
DSI-DP bridges.
So I don't know if it's worth optimizing indentation-level within each
node like this.


And we will end up mixing this optimization between DP controllers, USB
Type-C nodes, QMP nodes, DSI-DP bridges.

Regards,
Bjorn
