Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297273B78B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFWMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjFWMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:38:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9A2135
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:38:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-987341238aeso62511166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1687523885; x=1690115885;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYc9Y8Fk+9JanmEhEnHaiaBpMkiE5E4zckC1jKCp3JI=;
        b=jTgYOyaAjpoo8Mcnnx0WQTeFsoAmeb/wJWjvW/uLF3NxAr5hORXlIS5clrheKakDCQ
         QUDYNxTqJyaRvkFKYCQH6DaIFcHre9Bn/4M1WDmI3Tz9RZWY+ZNSAdsTGuWCiXWmfnjs
         kfBp7EuhmbcjR0E2nMIiOvM3i1mdQhV5x9EBqLOJJZiYIfqyhvLtd0biBO77K6Gn0/7Z
         +8eBxWacql+/teWnCb6Px268OENyc3W8t4WNUX1ww+tTX7X2C9fMvgnxwm2XKn/0Idwj
         Trmz92DVC1nGoNj1Sf/RQJrw7pv4EygiSJVOz3KgNj0Iac94MFFTF6lmLblZa2ZYN0i8
         vFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523885; x=1690115885;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pYc9Y8Fk+9JanmEhEnHaiaBpMkiE5E4zckC1jKCp3JI=;
        b=k0uAAgKlyF7Y3TJ3ZAFyA8LO6KUrBz6iGER05OACsbaT+k7/79AKrCvfYDBhGd/n9+
         xjXqDNidiXqelsD7Ji3VqGHBIklyhEiaQ7g4OHBGMGrjfw2vGFIrpiaJWS4ACVTwVwWX
         ENDXWJBcvTscxDmYOzuXjYH5u2bFNqrnBBOSPTY+m/ld3MNvTPHDLrq+Ewz8DZj/n2Ky
         2tQKNxfRjxxAtcSkTzIB+eN3QJrB8K6YLJN+lJRtKLvGwgPa5vk9csTbLbgagGQSD+Qv
         rSllBivXKNxQcGYCfTRyiJO2sy28cuPoWg1/MPZg6X3bPbkFHEMPG7RW6iDSErY6kA+u
         QPjg==
X-Gm-Message-State: AC+VfDwr+GuuCrTxqpvCjWmxecmoUJLKjMIIi7Nuu5ftBB9DEPCsSy1H
        /4HpVUmRkYgdW/iEFscI4o5veg==
X-Google-Smtp-Source: ACHHUZ6/T6ZvEX84bh2OjD7TKv4ueJqlqSL0QOFwrlvlM/U3oeVXKQGNI/jpfhtNnyAHk0yddxh/CA==
X-Received: by 2002:a17:907:6095:b0:989:1cc5:24a with SMTP id ht21-20020a170907609500b009891cc5024amr10643271ejc.13.1687523884866;
        Fri, 23 Jun 2023 05:38:04 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906141000b0096f937b0d3esm5930041ejc.3.2023.06.23.05.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:38:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 23 Jun 2023 14:38:04 +0200
Message-Id: <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] scsi: dt-bindings: ufs: qcom: Fix warning for
 sdm845 by adding reg-names
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Abel Vesa" <abel.vesa@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Bart Van Assche" <bvanassche@acm.org>
X-Mailer: aerc 0.15.1
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-6-abel.vesa@linaro.org>
 <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
In-Reply-To: <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 23, 2023 at 2:31 PM CEST, Krzysztof Kozlowski wrote:
> On 23/06/2023 13:30, Abel Vesa wrote:
> > There is a warning on dtbs check for sdm845, amongst other platforms,
> > about the reg-names being unevaluated. Fix that by adding reg-names to
> > the clocks and reg properties check for such platforms.
> >=20
> > Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Docu=
mentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > index 0209713d1f88..894b57117314 100644
> > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > @@ -166,6 +166,10 @@ allOf:
> >          reg:
> >            minItems: 2
> >            maxItems: 2
> > +        reg-names:
> > +          items:
> > +            - const: std
> > +            - const: ice
>
> reg-names looks like a new property, so it should be defined in
> top-level and just constrained per-variant.
>
> Also there was similar approach:
> https://lore.kernel.org/all/20221209-dt-binding-ufs-v2-2-dc7a04699579@fai=
rphone.com/
>
> but I guess no resends and it can be superseded.

Right, the patches got reviews but was never applied... I really need to
find a strategy to keep track of sent patches until they're applied with
my work mailbox, it's not the first time that a patch has gotten
forgotten.

With my private mailbox I just have a different folder for patches that
have been sent which I archive once they're applied, but with work GMail
I don't see how I can easily replicate this since it's also not grouping
threads properly.

Also patch 4/5 in this series has an equivalent from me:
https://lore.kernel.org/all/20221209-dt-binding-ufs-v2-3-dc7a04699579@fairp=
hone.com/
^ this might also be preferable since I guess it doesn't break
dt_binding_check?

Regards
Luca

>
> Best regards,
> Krzysztof

