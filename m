Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2A5BB2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIPTLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIPTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44BB69E8;
        Fri, 16 Sep 2022 12:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB2D62D55;
        Fri, 16 Sep 2022 19:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E63BC433C1;
        Fri, 16 Sep 2022 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663355504;
        bh=ON/pptyKFVUg7D83LSDO5V0oG+BOKV5rguUzzH7k8sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCZiTwkMTDz3m3INuO75+/69RIGcrxGVmCFk/P9sqTo01hWOQQMJFRMz2/f3Lik8H
         lQmbR1e0bx+C11/aRv0+GH+xT0y56GzGob2N1Ppn7h0GLGYKdqM6ZWKTF2DlVYQYfS
         TK9i+1pXu4B6yAlln14AHOmwwtx5OYtaIJq8Aty5BfK47R3Q/ocu9hzK2sLhJz5goc
         KWcVTqYhPhk5ECadSkeDTtiZ1ecp9OHqcsaqWo2VCvONDAoiTKEeC6RtHe1M/is8dh
         hr98kPDdJJWmeO7/okrgQsuK69uka3OkMc5RyhhuIbgVV9QSaGevyXR1Zfu53V8ohE
         99A3b7E+hGsQw==
Date:   Fri, 16 Sep 2022 14:11:41 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G
Message-ID: <20220916191141.xf2pdioeleyjbmg5@builder.lan>
References: <20220916121204.3880182-1-vkoul@kernel.org>
 <20220916121204.3880182-7-vkoul@kernel.org>
 <CAA8EJprcqrmHQCtYbOT=DWp-0iEWWVC0=-KZRz1DZqK6gE94qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprcqrmHQCtYbOT=DWp-0iEWWVC0=-KZRz1DZqK6gE94qA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:26:59PM +0300, Dmitry Baryshkov wrote:
> On Fri, 16 Sept 2022 at 15:13, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Introduce support for the Lenovo Flex 5G laptop, built on the Qualcomm
> > SC8180X platform. Supported peripherals includes keyboard, touchpad,
> > UFS storage, external USB and WiFi.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 590 ++++++++++++++++++
> >  2 files changed, 591 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> >
> 
> [skipped]
> 
> > +&gpu {
> > +       status = "okay";
> > +
> > +       zap-shader {
> > +               memory-region = <&gpu_mem>;
> > +               firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
> 
> Is the firmware signed with the test key or with the proper vendor
> key? If the latter is true, the firmware should go to the subdir
> inside the SoC (I'd suggest following the example and using
> sc8180x/LENOVO/dmi_id/)
> 

Correct, this and the remoteprocs should be pointed to
qcom/sc8180x/LENOVO/82AK/

Regards,
Bjorn

> > +       };
> > +};
> > +
> 
> -- 
> With best wishes
> Dmitry
