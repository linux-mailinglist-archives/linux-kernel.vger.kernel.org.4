Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79973C281
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjFWVUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjFWVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:19:34 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9735B0;
        Fri, 23 Jun 2023 14:18:41 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-780cf728871so37907639f.0;
        Fri, 23 Jun 2023 14:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555069; x=1690147069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2d0xE7WeZx0J7vyX+ZnXckx5ALfCSXiGwPgMNPbbP/s=;
        b=SpLuoOSqoTdq6hZRDTuYjGiAaC+i54OPRIivosjaWbVl1+V/9hBkyo2OIzfgloFZRK
         90EvQNDZF5nbLYtDDM2+SQzs/Eoi0qm6RQROTBJxUqKFPXRU6iwksM1ofdEkF3BU6bSv
         R25x9smtyuK9qs051xAq3F2SfCgC32CYpwR2XDMLWMF9ik2jk1N+l3KGASKbcYZNau1U
         Vc7barntPFC5f4GJcrYBpugWZOBWqACQHeE7vMHc08zzo8hzVej8ARdtSFBSIhs6je13
         0UpAjhQA79KWgIh9eGWlv3OrIuowJym7RulNwgTAnfNw1k8KSuPtkHqETYHnkh3Z2o1m
         mluA==
X-Gm-Message-State: AC+VfDwZoeMaJzKsu87kNOVd75BaBxY+nZ1TJ4AwpdjCUIhu1qZ8jSiw
        5M27vWGdTiZIFdaFoWjBaw==
X-Google-Smtp-Source: ACHHUZ7x8bUxBiuFunsGd3zwd4WPP95Xgx0A+AYEC6nfAv2fiEQDI6WoYJQmBSMH22y/gbHjU45PDw==
X-Received: by 2002:a5e:dd46:0:b0:780:c536:d98a with SMTP id u6-20020a5edd46000000b00780c536d98amr7567776iop.9.1687555068951;
        Fri, 23 Jun 2023 14:17:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 15-20020a0566380a4f00b0041d89b79fdasm20860jap.20.2023.06.23.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:17:48 -0700 (PDT)
Received: (nullmailer pid 1185043 invoked by uid 1000);
        Fri, 23 Jun 2023 21:17:46 -0000
Date:   Fri, 23 Jun 2023 15:17:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] scsi: dt-bindings: ufs: qcom: Fix warning for sdm845
 by adding reg-names
Message-ID: <20230623211746.GA1128583-robh@kernel.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-6-abel.vesa@linaro.org>
 <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
 <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 02:38:04PM +0200, Luca Weiss wrote:
> On Fri Jun 23, 2023 at 2:31 PM CEST, Krzysztof Kozlowski wrote:
> > On 23/06/2023 13:30, Abel Vesa wrote:
> > > There is a warning on dtbs check for sdm845, amongst other platforms,
> > > about the reg-names being unevaluated. Fix that by adding reg-names to
> > > the clocks and reg properties check for such platforms.
> > > 
> > > Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > index 0209713d1f88..894b57117314 100644
> > > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > @@ -166,6 +166,10 @@ allOf:
> > >          reg:
> > >            minItems: 2
> > >            maxItems: 2
> > > +        reg-names:
> > > +          items:
> > > +            - const: std
> > > +            - const: ice
> >
> > reg-names looks like a new property, so it should be defined in
> > top-level and just constrained per-variant.
> >
> > Also there was similar approach:
> > https://lore.kernel.org/all/20221209-dt-binding-ufs-v2-2-dc7a04699579@fairphone.com/
> >
> > but I guess no resends and it can be superseded.
> 
> Right, the patches got reviews but was never applied... I really need to
> find a strategy to keep track of sent patches until they're applied with
> my work mailbox, it's not the first time that a patch has gotten
> forgotten.

There was an error reported on the above series. Why would it be 
applied?

That said, I'm not sure SCSI maintainers consistently apply DT only 
patch series.

> With my private mailbox I just have a different folder for patches that
> have been sent which I archive once they're applied, but with work GMail
> I don't see how I can easily replicate this since it's also not grouping
> threads properly.

Yeah, GMail sucks for that. I use 'lei' to get all my patches and 
replies to them (though its caching will miss replies). Then I delete 
them from the mbox when they are applied or otherwise finished. lei 
updates won't re-add them to the mbox.

Rob
