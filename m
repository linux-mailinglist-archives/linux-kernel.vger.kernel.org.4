Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3486C7848
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXGw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCXGwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA76124C80;
        Thu, 23 Mar 2023 23:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 753F9B822AD;
        Fri, 24 Mar 2023 06:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CBDC433EF;
        Fri, 24 Mar 2023 06:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679640770;
        bh=eAgzktUw36k84XyIpPeAFS22zFe2LwUnrI5YTkK3tLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uy30E47500cQwy4yveoh3p8sqXsEoe+5WtY81PxbQuING23HmwERsmB7HB8++fsRL
         6tf9dyoa+9lOSJDTyt8wAonTHUJ0J2SrrJaC/GykO8O2X81R5HlxhLGQiOswPNt15v
         LBKYrhQ/4EyL5pWH9aYSkZf0utMxXoAMTpLO+bozn4KB0AlAclLd69fkP65H8p14bB
         dQ4qZmtsnGVZ6bOEqV+QlcvaokRXCD0k2xn1sCYyZj8BvIQfmiZGbrrSS4IhJH2lFf
         AeuQ51n2upKFnkTasj7teSd/zFmIgybVLp+nXod5NVPr4G+lsLl+ScgH1UzpcAA9Nh
         FeR0MtGg+uDTg==
Date:   Thu, 23 Mar 2023 23:52:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sm8450: remove invalid reg-names
 from ufs node
Message-ID: <20230324065247.GA9598@sol.localdomain>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-7-3ead1e418fe4@linaro.org>
 <9614782e-0d78-e8f2-a438-452cfa86f80b@linaro.org>
 <316d7d7d-b370-36e1-648a-400447d2dd47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316d7d7d-b370-36e1-648a-400447d2dd47@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 23, 2023 at 02:10:44PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 23/03/2023 11:49, Krzysztof Kozlowski wrote:
> > On 23/03/2023 11:25, Neil Armstrong wrote:
> > > Fixes the following DT bindings check error:
> > > ufshc@1d84000: Unevaluated properties are not allowed ('reg-names' was unexpected)
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > index ef9bae2e6acc..8ecc48c7c5ef 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > @@ -3996,7 +3996,6 @@ ufs_mem_hc: ufshc@1d84000 {
> > >   				     "jedec,ufs-2.0";
> > >   			reg = <0 0x01d84000 0 0x3000>,
> > >   			      <0 0x01d88000 0 0x8000>;
> > > -			reg-names = "std", "ice";
> > 
> > This is also part of:
> > https://lore.kernel.org/linux-arm-msm/20230308155838.1094920-8-abel.vesa@linaro.org/#Z31arch:arm64:boot:dts:qcom:sm8450.dtsi
> > but I actually wonder whether you just missed some binding patch?
> 
> I'm aware of Abel's RFC patchset to support shared ICE, but this is a cleanup of the current DT,
> and the current bindings schema doesn't document reg-names.
> 

The ufs-qcom driver accesses the "ice" registers by name, so the reg-names can't
be removed from the device tree.  A few months ago there was a patch to fix the
device tree schema for qcom,ufs to include the reg-names.  It looks like that
patch got missed, though:
https://lore.kernel.org/r/20221209-dt-binding-ufs-v2-2-dc7a04699579@fairphone.com

- Eric
