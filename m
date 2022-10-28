Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB5610A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJ1GNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1GN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014031B7F03;
        Thu, 27 Oct 2022 23:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9077162672;
        Fri, 28 Oct 2022 06:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82E3C433D7;
        Fri, 28 Oct 2022 06:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666937606;
        bh=4CqAhmzska+zzYLW4aongWkFXFBMvigrTx+gYITPknc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6eCy8hir0S58TiK/kcwLHlj+03InJp83Lz6JQZe8LjzvTbuC9THnZoyAnuXOnFMU
         OGNByaMKlMlFwswkRReYkxJfB5JUkGQo5UtiPzXeV64wXT7wthwbyBOr6QyqrQq4JF
         hPmVB6TugYmwTExukSPq+QLbdXlJ+dWE9wFtUlAWlaXGRD6C4qxqpLMxD73rYLiB3b
         /feBI0g+bgjZyZRTu1hA8f6Zv0FDb2UzIUYoAZcsKy9HX0/HHiQEXXQ+6MvH3RwIqx
         RYWmQ0E/Z9gbDIAv65wU1UsYzI+LKfAN50GAnGLJKkVDs7F6LHURL8cyB2rTAeJcjF
         gfZSrQFpxdvhQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ooIcC-0005Sw-8T; Fri, 28 Oct 2022 08:13:12 +0200
Date:   Fri, 28 Oct 2022 08:13:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] dt-bindings: phy: qcom,qmp-usb: fix sc8280xp
 binding
Message-ID: <Y1ty+E2qyxlniIsV@hovoldconsulting.com>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
 <20221024100632.20549-12-johan+linaro@kernel.org>
 <c9940701-8486-5a0c-4c7d-9c85b9460a7f@linaro.org>
 <Y1tyBw2iQvV89+UB@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1tyBw2iQvV89+UB@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:09:11AM +0200, Johan Hovold wrote:
> On Thu, Oct 27, 2022 at 10:15:45PM -0400, Krzysztof Kozlowski wrote:
> > On 24/10/2022 06:06, Johan Hovold wrote:
> > > The current QMP USB PHY bindings are based on the original MSM8996 PCIe
> > > PHY binding which provided multiple PHYs per IP block and these in turn
> > > were described by child nodes.
> > > 
> > > The QMP USB PHY block only provide a single PHY and the remnant child
> > > node does not really reflect the hardware.
> > > 
> > > The original MSM8996 binding also ended up describing the individual
> > > register blocks as belonging to either the wrapper node or the PHY child
> > > nodes.
> > > 
> > 
> > (...)
> > 
> > >      then:
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml
> > > new file mode 100644
> > > index 000000000000..95ee81d782f9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml
> > 
> > Filename based on compatible, so in this case
> > "qcom,sc8280xp-qmp-usb3-uni-phy.yaml", unless it's like the PCI case?
> 
> Yes, you're right. Thanks for catching that. This should be the only
> sc8280xp USB PHY compatible so the file name should be updates as you
> suggested.

Looks like I missed the '3' in 'usb3' in the previous patch as well.

Johan
