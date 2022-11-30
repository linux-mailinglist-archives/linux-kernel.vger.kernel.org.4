Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7463E11D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiK3UHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3UHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:07:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C81F2D9;
        Wed, 30 Nov 2022 12:07:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66F06B81CD4;
        Wed, 30 Nov 2022 20:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56FBC433D6;
        Wed, 30 Nov 2022 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669838863;
        bh=7+AZ/AGCKZtG91XadBL5ljZgYXCyQsHOIz9tdN8lLaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHpsvWzNvGaGEwLZ3ChSHJX0ewNB+1hY8j1sBe19XSoOePTwc/IoyhsI/t2DHIq8O
         QCfQ8dnlWPVZHRwnhIJooNM651FAf4zsn7+nwJ1gjLJVXgSrGq6wcUqIMnQf5NrVhs
         L2a0LzrRj3U+5AoDPB4EU8VgLd8U0zd5/34q68X1zLYkRiX//tb7tLeYaPnRbFEdgr
         CYMe/GGb+Lxxu8VqALf38KaGu1suBI+c96mMMwPM6ow/ONQBPEWP1klVP0sn3COjPL
         RREeOfejrGMMsP6KfnLvr5CFiV4COKEau0LhkSN8eiK0lnwSx7Cth8PkMRv+xeEtPS
         WVzkisNbj20+A==
Date:   Wed, 30 Nov 2022 14:07:39 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] arm64: dts: qcom: sc8280xp: Define some of the
 display blocks
Message-ID: <20221130200739.ube7hvobythkbhuy@builder.lan>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
 <20221026032624.30871-11-quic_bjorande@quicinc.com>
 <528e0921-73d7-655e-c3dc-ac3ebb3a5979@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528e0921-73d7-655e-c3dc-ac3ebb3a5979@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 03:15:25PM -0800, Kuogee Hsieh wrote:
> 
> On 10/25/2022 8:26 PM, Bjorn Andersson wrote:
[..]
> > +		mdss0: display-subsystem@ae00000 {
[..]
> > +
> just curious, where are mdss0_dp0 and mdss0_dp1?. Are two dp/usb combo phys
> not going used?

They are, but at the time of posting this, the QMP nodes was still being
reworked to support expressing the DP-part of things.

Now that the rework is in place I will include them as I respin this
series.

Regards,
Bjorn
