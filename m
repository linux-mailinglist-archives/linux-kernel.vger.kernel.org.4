Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BEB74284E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjF2O3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjF2O3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9B1BCC;
        Thu, 29 Jun 2023 07:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC3261567;
        Thu, 29 Jun 2023 14:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF314C433C8;
        Thu, 29 Jun 2023 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688048971;
        bh=8JR/CItlrlQ0WqXRlW0E1yvLOIt6OvzL+5y4jKGIuYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDOS2el9UoNYVZ350IIkDR2ADV9uSmaLE1hmlkn/+A4QGbJN+FI0dIKFXzI4WE9XN
         1mcNtZQRj32Kp+xgWEgkyKohlH/QjW6q4wyGeGwzhKNEpfZJisCf/SSSVLAjD8klTJ
         IiNqI4DyJjVf4ZVMQzckCJe3BfgIP5sSYOZuXiTPZWI7TyzFz4retExRl3m0UIXIj2
         4+/1s/q4L54senPb4mgQbI4rEDfOINpMoAWrVyLqeyAOlimVJUFw7+XREu62vDc00T
         wKsK0UPA/HSYGZF6o5tExCDd6AzQo9+5IGABLCM6LqwNpGka5qd51qAloAaQqfOoWR
         1jmYl2lyOVraw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEseM-0006qy-FB; Thu, 29 Jun 2023 16:29:35 +0200
Date:   Thu, 29 Jun 2023 16:29:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Patrick Wildt <patrick@blueri.se>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc
 interrupt parent
Message-ID: <ZJ2VTjm-JaGfskl5@hovoldconsulting.com>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
 <20230627132406.GA5490@thinkpad>
 <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
 <20230628052557.GB20477@thinkpad>
 <ZJvXZDBGBSQfeBdh@hovoldconsulting.com>
 <ZJvv_bcum7nhrgrO@mone.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJvv_bcum7nhrgrO@mone.fritz.box>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:31:57AM +0200, Patrick Wildt wrote:
> On Wed, Jun 28, 2023 at 08:47:00AM +0200, Johan Hovold wrote:

> > My point is that it's apparently not just Linux as most devicetrees work
> > this way at least for the root domain. And then it may be time to update
> > the spec in some way.
> 
> I'm not sure about the point you're trying to make.  In OpenBSD's
> implementation, which I think complies with the spec, for non-extended
> interrupts we check the node's (or all its parents') interrupt-parent
> property.

My point is that that is not compliant with the spec either which only
says that in case 'interrupt-parent' is missing in a node for an
interrupt-generating device, then the interrupt parent is assumed to be
the devicetree parent (which must then also be an interrupt controller
or nexus).

There is no provision for any recursive lookup in the spec currently.

> Technically the SPMI arbiter could define an interrupt-parent that
> points to itself, because it's using interrupts-extended anyway to
> point to the PDC.  But that would feel a bit stupid and not really
> correct.  Alternatively each child node could have interrupt-parent.

I agree that that would not really be correct (e.g. as 'interrupt' and
'interrupt-extended' are supposed to be mutually exclusive).

> That said, I understand the point that it might make sense to amend
> the spec so that if a parent node is an interrupt-controller, that's
> most probably interrupt parent,

This bit is already in the spec.

> unless an interrupt-parent property
> shows up before.

But this seems to suggest that you really meant to say "ancestor" in the
first clause?

> I would like to add that OpenBSD supports a number of SoCs for quite
> some years and this is the first time I've hit an issue with interrupts
> that were not designed in a way for the current spec to work.  That said
> we obviously support quite fewer SoCs/boards in total compared to Linux.

So OpenBSD apparently implements something similar to Linux (recursive
lookup of 'interrupt-parent' properties), but not the part about
stopping the recursion when hitting an interrupt controller.

Neither part appears to be spec compliant, but you only care about
updating DTs that do not comply to the latter bit. That seems reasonable
and should importantly not require adding tens of thousands of
'interrupt-parent' properties to the DTs in mainline.

Johan
