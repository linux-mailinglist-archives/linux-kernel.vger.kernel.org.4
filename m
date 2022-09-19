Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9EC5BD639
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiISVSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiISVSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FCE2B62F;
        Mon, 19 Sep 2022 14:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822D3618CA;
        Mon, 19 Sep 2022 21:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91A6C433C1;
        Mon, 19 Sep 2022 21:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663622315;
        bh=zyKwpB+TZU0POEehx6BHCVgBibbVZtVjpx2DjzNk6fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NeKrC1aMNRDeZ8TX0sQIYnI3jRBY2AmbpSrAEqqpTnrm0POsTUBO95bXhxkr0k4sQ
         9FnvmU+FbXIPtS92p05VBEF/2KkGn3Wy2pGfaNXzqElVoTbnKwn+EzA1c+cEZ7gxZ3
         K83CLaoZcnbMn7DGbuzYC7DgT3bPgUDe/BZe6utD8+xB7mvgjpMdwXCI3j/giNRpFb
         ox59Fu5TFuUgyvP4HJ8CF8mmAG77RTzyhdkVJ3BnradIr2GfTK5Ipk9K26le2/ARBp
         UtZ4c3Gt+V5Y8piAFwQ1Lx30k96Vc1cFIf+ey9cqkuIs6b1afA5SU65az10f9dfEvs
         AzvHhpOB6NVUA==
Date:   Mon, 19 Sep 2022 16:18:32 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Message-ID: <20220919211832.6b3buqxrnfp6yjjg@builder.lan>
References: <20220916200028.25009-1-quic_bjorande@quicinc.com>
 <20220916200028.25009-2-quic_bjorande@quicinc.com>
 <1641e41c-08c7-859b-644a-28d966fb00f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641e41c-08c7-859b-644a-28d966fb00f3@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 06:03:27PM +0100, Krzysztof Kozlowski wrote:
> On 16/09/2022 21:00, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
> > Qualcomm SDM845 and SC8280XP platforms.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> No need for quicinc SoB (unless you also take ownership).
> 

It's my understanding that both needs to be there. Bjorn @ Linaro
authored the patch and the author must certify its origin, but as the
submitter I must certify its origin.

I'm not entirely sure what you mean about taking ownership, I am going
to pursue getting these patches landed. But it wouldn't be correct for
new me to claim I authored them.

Regards,
Bjorn

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>\
> 
> 
> Best regards,
> Krzysztof
