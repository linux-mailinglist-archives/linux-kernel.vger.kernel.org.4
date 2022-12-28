Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7896587D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiL1XLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiL1XK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:10:58 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BA65F1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:10:57 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D1053200C9;
        Thu, 29 Dec 2022 00:10:54 +0100 (CET)
Date:   Thu, 29 Dec 2022 00:10:53 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8150: Add DISPCC node
Message-ID: <20221228231053.46fclmazl5qrjbmo@SoMainline.org>
References: <20221212093315.11390-1-konrad.dybcio@linaro.org>
 <20221212093315.11390-2-konrad.dybcio@linaro.org>
 <20221228041658.hpmlspnhm2ssinai@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228041658.hpmlspnhm2ssinai@builder.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-27 22:16:58, Bjorn Andersson wrote:
> On Mon, Dec 12, 2022 at 10:33:13AM +0100, Konrad Dybcio wrote:
> > [..]
> > +			power-domains = <&rpmhpd SM8150_MMCX>;
> > +			/* TODO: Maybe rpmhpd_opp_min_svs could work as well? */
> 
> The power-domain being not disabled should be sufficient for us to
> access the dispcc. Beyond that votes would be needed for particular
> frequencies, and that goes in the client nodes/opp-tables.
> 
> So you should be able to drop this comment and the required-opps.
> 
> Regards,
> Bjorn
> 
> > +			required-opps = <&rpmhpd_opp_low_svs>;

Tested the removal of this on Xperia 5, no regressions.

- Marijn
