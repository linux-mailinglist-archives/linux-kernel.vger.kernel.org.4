Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30496778FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjAWKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjAWKTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:19:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A737A113CC;
        Mon, 23 Jan 2023 02:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F652B80CBC;
        Mon, 23 Jan 2023 10:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0650CC433D2;
        Mon, 23 Jan 2023 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674469181;
        bh=R8TEHMiMrqLAL4VER9QYwXpcKwfMt+LaxjwixzRorjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFlknf7bHk9HiHeO2bHfa1wcP91KT8Wf+/vJ55+DGGz1fVU5ccAny+01ENx4vhoam
         9zjclV80G90b5WAbI+JB1QfnKQQLnuAWIsCW/3MlTiSYEW3OUTJpI3NhtZboEhJPBX
         2hiA+UNILsBqnO4Q+nV7NblTd7CiPQhj7dPpb6uvH8Gkf3LNs+Ff9L7pt4dMXWPJ/C
         gCq/CV4JA3Xcq8wM409qzW3/8ppWenjhhvw5N8lyxFH1kwqOw+TTR5rbDW56oRvLjH
         xZB6rrE2ODKMQPOcVnk6Mz3HNy8tXqHPVHfLgBhczuqPOvKKYjUOU1C81V1mY4z55n
         BL6o+MvSmZsIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJtvO-0000fP-Ag; Mon, 23 Jan 2023 11:19:38 +0100
Date:   Mon, 23 Jan 2023 11:19:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 04/10] dt-bindings: phy: qcom,qmp-usb: Document SM8550
 compatible
Message-ID: <Y85fOgfjEUBMnWar@hovoldconsulting.com>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-5-abel.vesa@linaro.org>
 <Y3TpzgQ1JaFs5sNk@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TpzgQ1JaFs5sNk@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:46:54PM +0100, Johan Hovold wrote:
> On Wed, Nov 16, 2022 at 02:01:51PM +0200, Abel Vesa wrote:
> > Add the SM8550 compatible to the list.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml       | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > index 0c6b3ba7346b..cba2a252baf8 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> > @@ -37,6 +37,7 @@ properties:
> >        - qcom,sm8350-qmp-usb3-phy
> >        - qcom,sm8350-qmp-usb3-uni-phy
> >        - qcom,sm8450-qmp-usb3-phy
> > +      - qcom,sm8550-qmp-usb3-phy
> 
> This one too should be based on sc8280xp rather than the legacy binding
> scheme.

I can't seem to find a v2 of this one adding a new-style binding for
sm8550.

Note that the corresponding dts changes have already been merged:

	https://lore.kernel.org/all/20230119004533.1869870-2-abel.vesa@linaro.org/

Johan
