Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBEE5B52E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiILDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiILDhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:37:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625E27CED;
        Sun, 11 Sep 2022 20:33:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q9so7048902pgq.6;
        Sun, 11 Sep 2022 20:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=zxyLCxBxrIb0KArqw1MDtuzNgDbw/ERwBIuGCbQ8zJ4=;
        b=QbFPIYlD4o3Dx0IrN+OHZvDORHVlX/RyM1SHlcQsxnGFrU5DImTHLxICoIZY2luq0U
         4a4zYadMXXyO1Z/K9CIBb3emFYWWzLOx/8X5pO+hnVhPYYaTrgcr6Z1fdFWLL9z9ZQuu
         XzEGRPs9r/+I1GVlDsc6Bvzb3zTx/GYIrdDt/zBSyOVkqR4VixzAqg9/48CZRGV/y+1I
         UZOI0w+JWFvrOXRs/ESTr6v5ZSL6sYsWQOgdf7DAQvolCF6tbhJK4QFkB8P4e3/990w2
         1LHZvQk4TjZ0yKGIJ6aJxBFLJSEPAZQNJPm67FqD2/k/mrpZbgmb8iLH/otsRGuj/Jq2
         iU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=zxyLCxBxrIb0KArqw1MDtuzNgDbw/ERwBIuGCbQ8zJ4=;
        b=gPBYBP9LvZfT94yOQ0ewiRzVdR/J//L7KMEo2lyWL78pGYHzEEIZ9i42exXnW9DHFt
         n6OSsZHqd1g6mYUZZ8liyY72wGn99YNJF3mi/voI29+KBnQQxY2lyBf6bJttN3ghqHG1
         h4lbwmffT15+fDs3RURSTBiNSmR7YOy/R+J643xrCNShFjYlf9BuqVEPA6MtYhb32i+B
         wAomTKOeyVzjaNXJqnL9GDpAAsaVCQw0eyF2KmSj6obIK7ZGD/vbCv+NIh8fTHKoZXoG
         kfCzrSw/X/PW1GPnP62QihfY33Je9oC5X/udQX8eUUDBFebopb6slD81RN4GAM3SJ085
         zlNw==
X-Gm-Message-State: ACgBeo3+/BESUkaD99jA2rQnDlk+C5kRlsLg9wGsdpuCPCcOJKoLIWR1
        DfbcWIKKD7nanEohrGu+CsY=
X-Google-Smtp-Source: AA6agR47MBF/ehK9ibey9/j8xSLT6QN/Czg0NTYIjQIf8VbCDI32gM/+1qj8KX4TXryGZ7QeBat+CA==
X-Received: by 2002:a65:6a05:0:b0:42c:87a0:ea77 with SMTP id m5-20020a656a05000000b0042c87a0ea77mr21853209pgu.75.1662953638856;
        Sun, 11 Sep 2022 20:33:58 -0700 (PDT)
Received: from localhost ([49.207.206.91])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709027e4c00b00172c7a2c662sm4671566pln.48.2022.09.11.20.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 20:33:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Sep 2022 09:03:53 +0530
Message-Id: <CMU3V4NK164X.1D3TDJPALGIDD@skynet-linux>
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Cc:     <bjorn.andersson@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: remoteproc: qcom: wcnss: Add
 qcom,pronto compatible
X-Mailer: aerc 0.11.0
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-4-sireeshkodali1@gmail.com>
 <ad201ee7-d83c-9ebc-3619-64632f1f266e@linaro.org>
In-Reply-To: <ad201ee7-d83c-9ebc-3619-64632f1f266e@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 9, 2022 at 1:30 PM IST, Krzysztof Kozlowski wrote:
> On 08/09/2022 20:49, Sireesh Kodali wrote:
> > The qcom,pronto compatible is used in the wcn36xx driver to determine
> > which register to access. However, this compatible was not documented.
> > This patch documents the existing compatible as is, since it isn't
> > immediately clear why the wcn36xx driver uses this extra compatible,
> > rather than relying directly on the regular compatible string.
>
> The patch does much more - messes entirely all compatibles...

Is there another preferred way to handle this?
>
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pi=
l.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > index bc18139fdb91..5e4a97e9d330 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > @@ -15,10 +15,18 @@ description:
> > =20
> >  properties:
> >    compatible:
> > -    enum:
> > -      - qcom,riva-pil
> > -      - qcom,pronto-v1-pil
> > -      - qcom,pronto-v2-pil
> > +    description:
> > +      Append "qcom,pronto" if the device is actually pronto, and not r=
iva
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,pronto-v1-pil
> > +              - qcom,pronto-v2-pil
> > +          - enum:
> > +              - qcom,pronto
>
> It's const, not enum.
>
> > +      - items:
>
> No items.

Both these things will be fixed in v3
>
> > +          - enum:
> > +              - qcom,riva-pil
>
>
> Best regards,
> Krzysztof

