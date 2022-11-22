Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682266336BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiKVILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiKVIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:11:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC43B22504;
        Tue, 22 Nov 2022 00:11:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E83696157D;
        Tue, 22 Nov 2022 08:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34386C433D7;
        Tue, 22 Nov 2022 08:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669104685;
        bh=EPQQOwK7ri32REuTW/k8a/b1T3JLvCaSgiYITbKyPfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gg+GYSG/xWG6ymJX3J6bsCAexrMP0ko0dZ017PEuZ/2xXqqWCkrutCaX9qd7kR612
         nFF7dXrkTUrDau1huCUyF+btCNRkvpdSCyejzBVpIgzVoTExQI1moRQcT+JA0+ztzB
         O4MJe+A3N4lqogCefnk5gCxlO156adbYK0P0yi14r+UJnASmFLfoYso5ovpVoRg4+u
         nuGMqpkqe24NDJ2xXcirfUkXbK+W8WuVkZstlXod6fVK8q0dmH66iJI7c3o+efMQBA
         P95ZnTWgvkOf7pUb5VFEiO1Py7/BEOmkZQp/6G6+J3cBzXerjV3GFuCTIe8DRuys6W
         aSC12Ip5/CELg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oxOMp-0005jB-0M; Tue, 22 Nov 2022 09:10:55 +0100
Date:   Tue, 22 Nov 2022 09:10:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add sm6350
 compatible
Message-ID: <Y3yED5jXn7/AwTS5@hovoldconsulting.com>
References: <20221121075358.76582-1-luca.weiss@fairphone.com>
 <Y3sxqUu0dnaQfdFY@hovoldconsulting.com>
 <COINW4PF8OS8.2QJZZKVL58FJG@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <COINW4PF8OS8.2QJZZKVL58FJG@otso>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:55:31AM +0100, Luca Weiss wrote:
> Hi Johan,
> 
> On Mon Nov 21, 2022 at 9:07 AM CET, Johan Hovold wrote:
> > On Mon, Nov 21, 2022 at 08:53:55AM +0100, Luca Weiss wrote:
> > > Add the compatible describing the combo phy found on SM6350.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> > > index 97a7ecafbf85..68aecb638870 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >        - qcom,sc8180x-qmp-usb3-dp-phy
> > >        - qcom,sc8280xp-qmp-usb43dp-phy
> > >        - qcom,sdm845-qmp-usb3-dp-phy
> > > +      - qcom,sm6350-qmp-usb3-dp-phy
> > >        - qcom,sm8250-qmp-usb3-dp-phy
> > >    reg:
> > >      items:
> >
> > The current USB3-DP bindings are broken and we should no be adding
> > further compatibles here. Please consider rebasing on:
> >
> > 	https://lore.kernel.org/all/20221115144005.2478-1-johan+linaro@kernel.org/
> 
> I'm not quite clear what you want me to do. Just rebase this change on
> top of your patchset and resend or something else?

Yes, you should rebase this series on top of the above, add
qcom,sm6350-qmp-usb3-dp-phy to the new (sc8280xp) schema, add a
register offset table for QMP v3 to the PHY driver, and update the dts.

Note that the USB/DP configuration structures have been merged (and some
config fields have already been removed in linux-next).

Johan
