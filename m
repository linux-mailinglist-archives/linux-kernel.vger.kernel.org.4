Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31A6D0781
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjC3OBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjC3OBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF584213;
        Thu, 30 Mar 2023 07:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73EB76206F;
        Thu, 30 Mar 2023 14:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88148C433EF;
        Thu, 30 Mar 2023 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680184864;
        bh=0q2pRY+1UL9yACnDYDVnBIsKGPp5b+d4pytxVh3cDFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6OaMygEnv8joiNXbk/Z5Q1BruDmxi5yUFR0T/c8PA4X6EYzp4Kmqn2tDgruy8HMU
         mjoAbVkMY6JWR3IRC2vn2RnD21DKTbmvpdRYyzKFU+xlXdu1BEMr4MaAo/rVjbZwFC
         aaKaGoFCyGs0N6dsRuSbEncXEsZalI658lEmrJjrhSVym5D51+waURVDtm1alnOVnI
         c5AH03NZGg6vrc+TH0lic/JLYPFOK2WJMJnJaISgLG7t63sbu+SD+rKh1Mf8j2I+Hb
         J8TJKtYHCA1MJdbYTzaSGIjHhKpgGWJIdhip2O9abRBqBvteMtZXbkLdijFdN27u4b
         XN1GtdCTbjnVQ==
Date:   Thu, 30 Mar 2023 15:00:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/18] dt-bindings: mfd: qcom,spmi-pmic: add
 compatible for pmm8654au
Message-ID: <20230330140059.GA489249@google.com>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-7-brgl@bgdev.pl>
 <20230330131324.GQ434339@google.com>
 <CAMRc=MfNNsiqzgCSF3xcuJf6LND+_cer9_vq3BZq3vvsb_+D-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfNNsiqzgCSF3xcuJf6LND+_cer9_vq3BZq3vvsb_+D-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, Bartosz Golaszewski wrote:

> On Thu, Mar 30, 2023 at 3:13 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 27 Mar 2023, Bartosz Golaszewski wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > PMM8654au is the SPMI PMIC variant used on sa8775p-ride. Add a compatible
> > > for it.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Cc: Lee Jones <lee@kernel.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> >
> > Change-log?
> >
> > >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > index 975c30aad23c..0f7dd7ac9630 100644
> > > --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > @@ -79,6 +79,7 @@ properties:
> > >            - qcom,pmk8350
> > >            - qcom,pmk8550
> > >            - qcom,pmm8155au
> > > +          - qcom,pmm8654au
> > >            - qcom,pmp8074
> > >            - qcom,pmr735a
> > >            - qcom,pmr735b
> >
> > I believe this is already applied, right?
> >
> > Not sure why I have 3 copies of seemingly the same patch in my inbox.
> >
>
> I've sent out three iterations of the series containing it. This one
> didn't change. As the rest of 18 patches don't concern your subsystem,
> I decided to only Cc you on this one. Let me know if you prefer to
> receive the entire series even if only a single patch needs your
> attention. The reaction to such dumps varies from maintainer to
> maintainer so I chose the safe approach. :)

There is no simple answer to that question.

Not Cc:ing me on this whole set appears to be the correct decision.

--
Lee Jones [李琼斯]
