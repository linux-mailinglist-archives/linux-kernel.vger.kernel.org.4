Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC09C6C43E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCVHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVHNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F48974E;
        Wed, 22 Mar 2023 00:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B2B61F8E;
        Wed, 22 Mar 2023 07:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC85FC433EF;
        Wed, 22 Mar 2023 07:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679469188;
        bh=aNUV68ID9HeuVLNkjfLlfLCc8QamVARcxLvEQ1PZIDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tf1qkvoTjNuq3FPokBSs5onX7nbhpPXfWXeeaByUFyDjPXe3kCQkX/nI/tk6yEyYc
         Ym1w4pwjEaIaHq0VIhE3dGsv6r1FCVIF7vz3YFnvt/HkshArSxM0yWMyLlZducN2LA
         9sZQlqkc85SprvpuYZPR3Evz95TEqoyY9KKheYH39OXlFogm1PLJuOzVLdwz73wS3F
         7gNBTPo9Yz9iz1DO7CAX00HtHgKhGNZQlAYs2EhFko9gyzG+tDjn2CasvTqkJ4a0xp
         ot/nEErRNQZ6ok88mZgySo6yT+aJnWTQFcEzatyzusoHflqyJj7rkZT2RYQoE0I3hx
         BIpMgp9vBx/6Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pesg6-0002H7-1V; Wed, 22 Mar 2023 08:14:34 +0100
Date:   Wed, 22 Mar 2023 08:14:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
Message-ID: <ZBqq2sIcjLenI/Az@hovoldconsulting.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
 <167940239018.531701.12929244936825953214.robh@kernel.org>
 <CAL_JsqKvAxvYsuUtkPerp0aVuEQ7xUrCH2twAm42DLcpvjEKqA@mail.gmail.com>
 <ZBmzZBYUFXlTX08i@hovoldconsulting.com>
 <CAL_JsqKOSQJBVAaDVrAze6VZe9XHaY7AMs_pM=f3Pgto6UDDqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKOSQJBVAaDVrAze6VZe9XHaY7AMs_pM=f3Pgto6UDDqA@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:27:55AM -0500, Rob Herring wrote:
> On Tue, Mar 21, 2023 at 8:37 AM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Mar 21, 2023 at 08:20:55AM -0500, Rob Herring wrote:
> > > On Tue, Mar 21, 2023 at 8:17 AM Rob Herring <robh@kernel.org> wrote:
> > > > On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> > > > > Add an 'nvram' pattern property and a reference to the corresponding
> > > > > SDAM DT schema.
> > > > >
> > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > >
> > > > Running 'make dtbs_check' with the schema in this patch gives the
> > > > following warnings. Consider if they are expected or the schema is
> > > > incorrect. These may not be new warnings.
> > > >
> > > > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > > > This will change in the future.
> > > >
> > > > Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230320135710.1989-4-johan+linaro@kernel.org
> > > >
> > >
> > > This is a long list of warnings. Can you all fix some of them before
> > > adding on to this binding.
> >
> > Note that this patch is only making the list of warnings shorter so I
> > don't think addressing the remaining issues should block this one.
> 
> How can you tell sorting thru the 100s of warnings? It sounded like a
> new feature to me, not a fix for something missing. Anyways, I've
> gotten 2 patches today for this binding and I don't see patches for
> fixes. Which is a bit surprising because you all generally are fixing
> warnings on the QCom stuff.

Indeed, it was not obvious and that's why I mentioned it.

The SDAM binding has been there since 2020 and 9664a6b54c57
("dt-bindings: nvmem: add binding for QTI SPMI SDAM") but updating the
"parent" pmic binding was apparently overlooked.

I'm generally not cleaning up DT checker warnings, but I want to avoid
adding new ones as I unknowingly did in this case when enabling the RTC
on the X13s.

> I didn't really mean to block this one, but I don't really want to see more.

Understood.

Johan
