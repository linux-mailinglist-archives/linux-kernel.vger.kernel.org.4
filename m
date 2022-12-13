Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1A64B99D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiLMQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiLMQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:26:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0818B236;
        Tue, 13 Dec 2022 08:26:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A81BAB81260;
        Tue, 13 Dec 2022 16:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61393C433EF;
        Tue, 13 Dec 2022 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670948770;
        bh=NkxDPuLY7Zyb3KNbQ2lo6DdobBvEk1ck2GXb4Yzjh1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXuoP9G941WQ5H778c1k+WBpRS0EI10F6D4Uvuf0wcMz0tXCHBB/WAK8HCq5NG0jh
         ZOtOAd6LyWTZPFdX03soWBTweC7dFblKrBbBcuLpds634TEMyF5GrJnQw4L4pqJKSD
         3Arihx7ASAzJLghNk6VlEa2Zs981Ddv58J7TzjoZ3zD2Oo/SP9nCFbsbfSDAsZSJzQ
         j502/OsTxh7P4rtt0Q1DbJ6pqeT5bguLMcC/FvTelgxdyjr6lxeviNEXhIFudTnqId
         AyEWY8B7gqOg8xDpZCe/H84DHm4N8vWdRLkodOPZCasaje3f3JyXvKtrRv19lkculb
         mxL5sVVRFczOg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p5872-0005vC-Dy; Tue, 13 Dec 2022 17:26:36 +0100
Date:   Tue, 13 Dec 2022 17:26:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/12] arm64: dts: qcom: sc8280xp-crd: Enable EDP
Message-ID: <Y5invNFKLBKy30v1@hovoldconsulting.com>
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
 <20221207220012.16529-12-quic_bjorande@quicinc.com>
 <Y5MPa9l4btcDG9GP@hovoldconsulting.com>
 <20221213151012.GB16520@core-thresher1.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213151012.GB16520@core-thresher1.qualcomm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 07:10:14AM -0800, Bjorn Andersson wrote:
> On Fri, Dec 09, 2022 at 11:35:23AM +0100, Johan Hovold wrote:
 
> > > +	edp_reg_en: edp-reg-en-state {
> > > +		pins = "gpio25";
> > > +		function = "gpio";
> > > +		output-enable;
> > 
> > 'output-enable' is not valid for tlmm and causes the settings to be
> > rejected:
> > 
> > 	sc8280xp-tlmm f100000.pinctrl: pin_config_group_set op failed for group 25
> > 	reg-fixed-voltage regulator-edp-3p3: Error applying setting, reverse things back
> > 
> 
> Thanks for spotting that, it doesn't seem to be needed for the gpio-regulator
> driver anyways...

I noticed that the firmware on both CRD and X13s sets the drive strength
to 16 here. Should we specify that too (and disable the pull up)
instead of relying on the firmware configuration?

Johan
