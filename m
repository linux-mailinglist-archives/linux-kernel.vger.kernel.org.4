Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5460428D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJSLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiJSLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC51A20D;
        Wed, 19 Oct 2022 03:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7643961800;
        Wed, 19 Oct 2022 09:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98CDC433D7;
        Wed, 19 Oct 2022 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666172044;
        bh=+XJ4KA8dllr0ByMjgUh1Y3S/fQ8SIHjq3TDCIyLLrNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7Uch+ZhgMxzh633BHSOdQxgxOqQowc35/YWFAWeeU2s0E+SioG0sAWiRyAQRnsGN
         0mXBcQtpiF2kOYrwuWgc4SJnQZsDBoFGsW8JvtPwpY6O8uiibCtq3L726zsubk+UWG
         8j9rsryp/cG7gZydanqhizZLgUtQQ5H0t7mYjnPlKn62L/KB5r3+p3esvvbTejHnNz
         8oH+xKXDWfh0w5qUuu+S9D7Z7ggNqLH+rGfZpwZXQjZ03Ssa2uO/EhPzBD2hPHkSF2
         uX0uoTZbcVItVSQjtyPhNnndaLD6L9gEP95UYVf3GiCDPHFzNRKGwjsnOw0aNaVVXs
         pYOkC+u9eiivA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ol5SS-0005JG-2I; Wed, 19 Oct 2022 11:33:52 +0200
Date:   Wed, 19 Oct 2022 11:33:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
Message-ID: <Y0/EgN78YdQ9Mg23@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
 <Y05+E90tmlq2tNFa@hovoldconsulting.com>
 <CAA8EJprwhEvUfUr-zDir4zFh_NAyr0qPbrHi6Hf8=2HC1dAhaw@mail.gmail.com>
 <b0c1bdfb-4a31-9deb-1f0a-0ed813707464@linaro.org>
 <Y07OfmfQgQWFzHZY@hovoldconsulting.com>
 <e334e265-fde0-29df-d905-c3ec4941f152@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e334e265-fde0-29df-d905-c3ec4941f152@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:44:22PM -0400, Krzysztof Kozlowski wrote:
> On 18/10/2022 12:04, Johan Hovold wrote:

> > The question is whether to convert also the current bindings and DTS to
> > the new (sc8280xp) scheme (e.g. drop the child nodes and register
> > subregions).
> > 
> > The driver can support both binding schemes using the same compatible
> > strings for a transition period (or in theory forever) by checking for
> > the existence of a child node.
> > 
> > Converting the DTS to use the new bindings would obviously prevent using
> > them with an old kernel (i.e. 2 above), but I don't think that's a
> > problem (unlike backward compatibility during at least a transition
> > period).
> 
> It is still not nice towards any other users of DTS, because this will
> break all of them. I agree this won't be ABI type of break. It is
> discouraged though, unless there are clear benefits from this or one
> totally does not care about other DTS users...
> 
> As I said it is up to platform maintainer.

Yeah. When time I spoke to Bjorn about this, we agreed to draw the line
at SC8280XP.

But if it turns out converting older platforms is needed to fix bugs or
add features (e.g. due to the incomplete register descriptions), we may
later have to reconsider this.

> > My concern was how to describe the deprecation in DT schema if we were
> > convert them. By instead just keeping the old bindings as-is in a
> > separate file and continuing to support them in the driver we can have a
> > nice and clean description of the new bindings (sc8280xp) without the
> > legacy cruft.
> 
> You cannot have one compatible in two schemas, so for old bindings (and
> DTS):
> 1. Don't convert them,
> 2. Convert with keeping old properties - as you pointed this might be
> full of conditionals/allOf, so difficult to maintain and read,
> 3. Convert dropping old stuff.
> 
> For the option 3. for sure Rob will ask why. :)

Thanks for confirming.

So I guess we start with keeping the old bindings as they are (1) and if
later needed (or desired) we should simply drop the old bindings (3)
from the schema (we can still have the driver support the old bindings
during a transition period).

> > If we were to start introducing conditionals on existence of child
> > nodes, and marking the old bindings as deprecated in one large schema,
> > then that sounds like it would be very messy and hard to read and
> > maintain. But perhaps there is some way to do this without such
> > downsides that I'm not aware of.

Johan
