Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5560B19D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiJXQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiJXQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A002A732;
        Mon, 24 Oct 2022 08:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 033E96142E;
        Mon, 24 Oct 2022 14:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142BC433C1;
        Mon, 24 Oct 2022 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666623290;
        bh=BXul8fAuWOv9kKt/CiQlJsCKSFcWw5Z9yPRMme+vveQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifVdRfpEJ/JnccfplLbEB5DlkAdKqpAerJp5NW7EfjFhLmUzEs7BIqBi4Uf7cT/TR
         3uL5Cb2ZrMumBdoMOqFUg54ZJciQFTF8j7H9rceJsNo8DByxCAGxKpRp6B3HxeYjEh
         D3dYCV15Fy+PNN7OwgyTqlFrJ/0JO5DPe2hckIjHnpi5+Rj38I/+Iyo3mky+HEJnqx
         bO6ml5H7XGPBycrgFmzvRkIuwjbH0DXqOEAA5gms/2BhHJhjYFbIljnsYCvqFLbO8Y
         W6mHr56NS4+oWaUMTpL2Ix/0/T/pPWpEPgQnhvGC2lAgg/h/3CGr1RmLPaHBfSuV2m
         rPg4iZLxhkazQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1omyqY-0003Gg-9l; Mon, 24 Oct 2022 16:54:34 +0200
Date:   Mon, 24 Oct 2022 16:54:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: add TCSR node
Message-ID: <Y1anKh24QaXcsS74@hovoldconsulting.com>
References: <20221024125843.25261-1-johan+linaro@kernel.org>
 <94e05a63-e7f3-a78f-d0a6-8efcae619726@linaro.org>
 <Y1aWPhP7/ft8s+bh@hovoldconsulting.com>
 <826176ba-d7c6-a64f-e15e-d2694571cb72@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826176ba-d7c6-a64f-e15e-d2694571cb72@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:09:51AM -0400, Krzysztof Kozlowski wrote:
> On 24/10/2022 09:42, Johan Hovold wrote:
> > On Mon, Oct 24, 2022 at 09:34:22AM -0400, Krzysztof Kozlowski wrote:
> >> On 24/10/2022 08:58, Johan Hovold wrote:
> >>> Add the TCSR node which is needed for PCIe configuration.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
> >>
> >> Please send the patches together with the binding. There is no need to
> >> have this split and it causes additional effort during review - lookup
> >> of the binding.
> > 
> > I was under the impression that the dts changes should be submitted
> > separately from the binding as they go through different trees. (And
> > last time I posted them together the subsystem maintainer ended up
> > taking also the dts changes by mistake).
> 
> Yes, that's also true. :)
> 
> > The binding has been picked up by Lee now so I posted the dts change.
> > Could have added a lore link though.
> 
> This also would work and help a lot.
> 
> It depends in general on the maintainer - for example Greg does not want
> to deal with individual patches, especially if DTS is just one patch and
> USB would be 10 of them. Our toolset is not good for picking up 10 out
> of 11. For all such cases - please provide link to lore.
> 
> If however there are just two patches - one DTS and one for maintainer -
> then having them in one patchset should not cause additional effort for
> the maintainer.

I'm pretty sure I saw Lee complaining about Bjorn taking also the
binding update through the qcom tree recently when someone did just
that. Apparently it was TCSR related too:

	https://lore.kernel.org/all/Yzbk%2F6SQdpNQTahV@google.com/

Heh. That was you. :)
 
> As you can see on the list, majority of patchsets consist of
> bindings+DTS. Pretty often entire piece - bindings+driver+DTS.

Yeah, and whatever alternative you go with, someone will get it wrong or
complain it seems.

Johan
