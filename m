Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650F5B54B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiILGud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiILGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:50:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C318393
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:50:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh9so17879440ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=xZBOwNESCEJeEq+vLfcgL2fVk6vfsvOgXDG6N/bBa6c=;
        b=aCnY/rISi56RQ4sPzM0j9ja3twfV0iGOd9cV/JuLqIummpMz4IEIARe/FDf6qXzmN3
         CdVzUiENGT5wqRSyGJ0M26+ILsRG6vRnq4JD+hI8p8uSa/KCefW+1nb5qkbPLVqdCojC
         PHsvUPwW9R2B8aBXprG+bfV2UmqgyqeOH2BQw4XAnqmIgAK7MWZXodrKksGTx8M13g7Y
         hFJTaFFX8wB6O86V02Lti3xfygV96CZqQm1NMlQJh3AV1+gqzHWCLMufuRplAHgEWk44
         LV0YpeGE/AOz/GSq686GotC+XGfn1TGtk62thgIe6Sqtr4bDY6v8NivbUscfxTN7Gci0
         yLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=xZBOwNESCEJeEq+vLfcgL2fVk6vfsvOgXDG6N/bBa6c=;
        b=TUGSuX7UWyTosdD/qcvYRIWeQJAaRjK7dMA4c46lCRz19T41jndNmdqb0HMli0lAlO
         Qu/7CRP3Q/OVbFwAHFi/kw57eJwheOvWUDnhsW9/w6+6WasoZy+rYiWqdpkaUbu9DXJH
         Jg1RwNLIaMG2/h2udip589RvibYMMxVAtMFu+a4lCeMkPIEYbUCQhWzl1zRX0BdGBOUo
         UpS5Yc0OJl0U3sI/fsZ3mGEg7zZr0RvaOYmYukU/2zrb02615gkHXIrEElLALvEepHdf
         G+wNjtzICbYdt8q1LfnHe1WuUcLk5jvNgaMQ3HUGm6qy3uovTuo9nUVp7YjlP77FCkT3
         1JCQ==
X-Gm-Message-State: ACgBeo3oRNwdMHqIBC8fh2Ah8B2UxANxjAxs+CA1MKe1Smq7pqZIlhpq
        1Iu/t1QR3MlXiuXJ2nkU0UmQGw97PJJtag==
X-Google-Smtp-Source: AA6agR5N3rC7lPJBRa2z0wfQhvNsQktDqbdv2Xr/KHg5grU1X4tND818Jy3MzYr9U1yU0pi+RAlq+A==
X-Received: by 2002:a17:907:868f:b0:730:bc1f:a8d8 with SMTP id qa15-20020a170907868f00b00730bc1fa8d8mr18280757ejc.106.1662965422709;
        Sun, 11 Sep 2022 23:50:22 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709064b0900b0073d218af237sm3920973eju.216.2022.09.11.23.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:50:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Sep 2022 08:50:21 +0200
Message-Id: <CMU81K51YF5E.4KH2T53ZEIKW@otso>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: qcom,pdc: convert to YAML
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.11.0
References: <20220103074348.6039-1-luca.weiss@fairphone.com>
 <20220909143950.GA992904-robh@kernel.org>
In-Reply-To: <20220909143950.GA992904-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri Sep 9, 2022 at 4:39 PM CEST, Rob Herring wrote:
> On Mon, Jan 03, 2022 at 08:43:48AM +0100, Luca Weiss wrote:
> > Convert the PDC interrupt controller bindings to YAML.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since v1:
> > * Adjust description of second reg-name as suggested by Maulik Shah
> >=20
> > @Rob Herring: Hope it's ok to keep your R-b given the above changes
> >=20
> > This patch depends on the following patch, which fixed sm8250 & sm8350
> > compatibles and adds sm6350.
> > https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.weiss=
@fairphone.com/
> >=20
> >  .../interrupt-controller/qcom,pdc.txt         | 77 -----------------
> >  .../interrupt-controller/qcom,pdc.yaml        | 86 +++++++++++++++++++
> >  2 files changed, 86 insertions(+), 77 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/qcom,pdc.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/qcom,pdc.yaml
>
> In checking top compatibles without schemas[1][2], I found this. Now=20
> applied with sm8150 compatible which was the only change since this.

Thanks for digging this out, I have totally forgotten about it!

Regards
Luca

>
> Rob
>
> [1] https://gitlab.com/robherring/linux-dt/-/jobs/3005191129
> [2] https://gitlab.com/robherring/linux-dt/-/jobs/3005191129/artifacts/fi=
le/all-compatible-warnings.log

