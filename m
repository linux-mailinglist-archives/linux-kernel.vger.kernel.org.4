Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0C6DDDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDKOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDKOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:23:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8ED10FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:23:00 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54c17fa9ae8so260025447b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681222979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YfaEeNuJ+Hdp1nHSVtR8YcRxyh5te0e8PseTVlzu67k=;
        b=ovm4+NgZ+Ec4ZjIgJf/sOKoaRV3p0V8E1syXJvvmN7tSDnoHRfDV7X+TM/TuJJb98k
         V/zWcS1oqVkkB/Ccede5GHn7AATYAMDz5q/j3HxM/7/rUH3P4zamX2P+ZO6xwIlmPYFl
         vf2NJBm9RLfBZ84LmTcitMTQgIdhBxMUZx/7/GQMfUxAT1l+cQ18O0zzWRW+i6YQD+xJ
         vWqSACuOk5Mq4HwpVsg89Zq5ScenA1NUtQgmNBwbg0qHO8J1jrXplwxR1lKuo7qhch9O
         zCVkvUg2NWx+OYuPsDxmbTc52BqlEOtfwM8INvs570K/ZJjaAOR6QYWVdH90JBhpPbZF
         rgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfaEeNuJ+Hdp1nHSVtR8YcRxyh5te0e8PseTVlzu67k=;
        b=ulZIFG8MBAy/G62ms4QZMDrVYNeTXHI0cc+CGE41wDzqtgCVKcXNeFWHN/E3Beru/R
         XHpeIMhxxgte9qw8Rsj19J8VZyLWqbHKs4nILC44OuxDIqFtNBVNpgs01PMOdBy4HrFx
         nS+oGadut1uR9VqoAo2pzeq2vH8aUgQWIM3sCT2q76YyyLSw+/GaFtBWsSbDAnzwGVLC
         A5F/mptMoxkIJpvPrULgd70mKoP9i6mtQKj0OAh0s0BqDS8HCfNUMe6UQ0aqH6mhP0hQ
         XckiNUHqIEioElptUjjXoRPtEs4dO5aQFNTQL1Ej78retJwc5b8DR7YlOuOVDNswxtXe
         XzyQ==
X-Gm-Message-State: AAQBX9ejGUOmp3Kke+LhIJwlz4enmQsYVkBnHYrya+qdNqwoaSMSqARg
        FgvZ6PW+HaRIF7A7qQAw6EBZqaoathxeMU0pg3rJzQ==
X-Google-Smtp-Source: AKy350b19zupv5UWGi6PzMtlcoyVqeyNRUYz0VDgkCWSi6ZkEx0abL/8b9KOQQdtuLoLndmVPQJJ0YjEaKzB5J3gCXc=
X-Received: by 2002:a81:b149:0:b0:549:18b4:e94d with SMTP id
 p70-20020a81b149000000b0054918b4e94dmr7819496ywh.7.1681222979591; Tue, 11 Apr
 2023 07:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230406194703.495836-1-brgl@bgdev.pl> <20230406194703.495836-3-brgl@bgdev.pl>
 <20230411131740.GA2913234-robh@kernel.org>
In-Reply-To: <20230411131740.GA2913234-robh@kernel.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 11 Apr 2023 16:22:48 +0200
Message-ID: <CACMJSevSygrwzKdYNGKCgtdjuAQcVyqL3LvKonyat=EHCaNPzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: qmp-ufs: describe the UFS PHY
 for sa8775p
To:     Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 15:17, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Apr 06, 2023 at 09:47:00PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a new compatible for the QMP UFS PHY found on sa8775p platforms and
> > update the clocks property to accommodate three clocks.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        | 26 ++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > index cd0fbbd3593d..5bc93acccbad 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> > @@ -16,6 +16,7 @@ description:
> >  properties:
> >    compatible:
> >      enum:
> > +      - qcom,sa8775p-qmp-ufs-phy
> >        - qcom,sc8280xp-qmp-ufs-phy
> >        - qcom,sm6125-qmp-ufs-phy
> >        - qcom,sm7150-qmp-ufs-phy
> > @@ -25,12 +26,15 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > -    maxItems: 2
> > +    minItems: 2
> > +    maxItems: 3
> >
> >    clock-names:
> > +    minItems: 2
> >      items:
> >        - const: ref
> >        - const: ref_aux
> > +      - const: qref
> >
> >    power-domains:
> >      maxItems: 1
> > @@ -52,6 +56,26 @@ properties:
> >    "#phy-cells":
> >      const: 0
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sa8775p-qmp-ufs-phy
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          maxItems: 3
>
> The max is already 3. Did you mean 'minItems: 3' or 2 or 3 clocks are
> valid?
>

For this compatible only 3 clocks are valid so it should have been
minItems indeed.

Bartosz

> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 2
> > +        clock-names:
> > +          maxItems: 2
> > +
> >  required:
> >    - compatible
> >    - reg
> > --
> > 2.37.2
> >
