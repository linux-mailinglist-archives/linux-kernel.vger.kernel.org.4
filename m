Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A56C330C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCUNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCUNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:37:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4F42BC7;
        Tue, 21 Mar 2023 06:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F422B8169B;
        Tue, 21 Mar 2023 13:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA50C433D2;
        Tue, 21 Mar 2023 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679405840;
        bh=WcieU/vH4wQINZPtitpWJtdYbGV3aMX2fQpPt6uBVP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1L12ZuFlpbOhqNnlY48o70oH2jSNnqaT1nyzsb77yG/J5FKGr/vaazvq0Ph9ry7R
         Ez8ri+9WBT9RCD/AdLFDkKppM79beXdyyQghJGrT+HLsTdQIHggf2+trzp0zG/95aO
         NFL5dFbNSbjdMMGj1/Ty7ubXww6XcIGen73ccmOJe5rqJJciEeIjOkktnRfICkcGGa
         Z9i3DE0m3WuMlZaM9M7zsJN073vdVAV6pfBrWAVeYV1Gfdqf2Eearf9VuwzdbNUA+M
         74InmJJ+ollVzSXig8zr1Yo40IUVS7bj4xc9ehg8tpOdmCLGlJqTPgZz3h1XUHtlzm
         C9ix5ItcDIVBw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pecCK-0006Qr-W6; Tue, 21 Mar 2023 14:38:45 +0100
Date:   Tue, 21 Mar 2023 14:38:44 +0100
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
Message-ID: <ZBmzZBYUFXlTX08i@hovoldconsulting.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
 <167940239018.531701.12929244936825953214.robh@kernel.org>
 <CAL_JsqKvAxvYsuUtkPerp0aVuEQ7xUrCH2twAm42DLcpvjEKqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKvAxvYsuUtkPerp0aVuEQ7xUrCH2twAm42DLcpvjEKqA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:20:55AM -0500, Rob Herring wrote:
> On Tue, Mar 21, 2023 at 8:17 AM Rob Herring <robh@kernel.org> wrote:
> >
> >
> > On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> > > Add an 'nvram' pattern property and a reference to the corresponding
> > > SDAM DT schema.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230320135710.1989-4-johan+linaro@kernel.org
> >
> 
> This is a long list of warnings. Can you all fix some of them before
> adding on to this binding.

Note that this patch is only making the list of warnings shorter so I
don't think addressing the remaining issues should block this one.

Johan
