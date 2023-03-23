Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C336C6B20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCWOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:35:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19F269F;
        Thu, 23 Mar 2023 07:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A8EB82142;
        Thu, 23 Mar 2023 14:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D58C433EF;
        Thu, 23 Mar 2023 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679582103;
        bh=XAJilagdFHAbyDVNopysdHU+xHd7bXMhpJwcbv1bR/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK5N2wJS7Ucyla2zQSLVgPiIR/FhN37JCun+95PHKCELxsixTmFqYSF7WGdYJl6lO
         AKyzJRY6pfUxOUKxsefZNCVKh3QJiCzZb89onDOJ+GXF+5mcTmeqEN8/yYrquDFi+U
         FSk8PlVusxToRj1tU0CaOSiQS04q+Md4debja8HpHA4itGp5VSdr6Dqlyh/BOu2aus
         QZOCSZLWKXA5G0orfx0Ap5ZC5/5iw+VrnpR7fp8C4156KWH0ENaYU42RP1uFhfyGgE
         amq7/vDWPRyy1tC0m5HWcM5ElERp8gka8tzhLVsam1KfepwHHE//YP3+qqHxAifBGe
         Tg7ah7zT7H8KA==
Date:   Thu, 23 Mar 2023 07:38:14 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] arm64: dts: qcom: sm8450: add dp controller
Message-ID: <20230323143814.cdfbgzlnlbnocx5z@ripper>
References: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v6-5-d78313cbc41d@linaro.org>
 <b1e6ca00-348b-4d61-6e90-30bef756732c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e6ca00-348b-4d61-6e90-30bef756732c@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:51:34PM +0100, Konrad Dybcio wrote:
> On 17.03.2023 16:06, Neil Armstrong wrote:
> > @@ -2783,6 +2790,78 @@ opp-500000000 {
> >  				};
> >  			};
> >  
> > +			mdss_dp0: displayport-controller@ae90000 {
> > +				compatible = "qcom,sm8450-dp", "qcom,sm8350-dp";
> > +				reg = <0 0xae90000 0 0x200>,
> > +				      <0 0xae90200 0 0x200>,
> > +				      <0 0xae90400 0 0xc00>,
> > +				      <0 0xae91000 0 0x400>,
> > +				      <0 0xae91400 0 0x400>;
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <12>;
> > +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> > +				clock-names = "core_iface",
> > +					      "core_aux",
> > +					      "ctrl_link",
> > +			                      "ctrl_link_iface",
> I applied this locally and noticed line has 2x 8 spaces.. Bjorn, could
> you please take care of that when applying?
> 

Thanks for pointing it out. I did correct it, and I had to do the same
in sm8350.dtsi.

@Neil, please run checkpatch --strict, it will highlight these errors.

Thanks,
Bjorn
