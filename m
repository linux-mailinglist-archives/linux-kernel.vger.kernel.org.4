Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935E5F38AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJCWOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJCWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:14:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3B32EF5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:14:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j7so14723541ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5FZVe4qgx0VvS22BuyLf2t6tSB6jCkuSkQ/O1CHtM3Q=;
        b=VcY4r82G7gHdeYUFFoYACviWj/qy2778vE5P5cUgPX5rJ4Am9rDQT1DSnJOt7jIgQD
         iILfYNH7faJ/NBW6BiX+bUp0RKKWXwFp6NXsQFLc2I0Z/adzj3zl0d3cjVa5xufWon4T
         syr8jsukj9it8KBoEafQMUdtTHl9hPVELSUMMhP+clMoi19xYwuozv+T+0qopdx+l0Wl
         dh9CWdHg7U6v3o6GjaNP5FGSMwBOT2qdP5HEsreksKBEy0wtZ62tslUg8nhx9lDqGRCZ
         D07cmU/uJ7auZo0aCHRIHpj6Wgm7DPVCUJKJ4NwRHkiXbaH9JPpNGai6SeMcNaJxH6n8
         EMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5FZVe4qgx0VvS22BuyLf2t6tSB6jCkuSkQ/O1CHtM3Q=;
        b=Ek3O3wVJLuFFixe5TGfEvOYhotgvfy3Rs8V4a2efNct9IkVoytT/6SzVyvLg966dFY
         c9Vp0jaTW4V0+uJeNgfdJOs+iVLsyaHUgmT2INYdZMrBCO7TeVSyIFGVNP6/f5BWCjLa
         5pJywEPYGpSdfEMFQte2hWkXBzDdeXC/9eSLDRlGVPYzGjokLCKM3nkc9xCp7GAo3TmV
         VkN/HxrGOLMqF69ZVOkdZHjYKJeh0oWD2n9DJXwYkRg0/pXCwMvez9kLgxGSKAGjPm6s
         n4F5DYl6lSVfOC9yshOktIFXvKeayUPEJGFCClKopNJfKIdp8RtC+mBKPXY7ClNTB0dj
         l8Dw==
X-Gm-Message-State: ACrzQf1M7xnBuw12m7191062P0hlFI7f1OnbTPxzUjl1jUR2NuzHxiwV
        7CTof4izdVlRB0GRjmsKKwWH2f7rWeym4Fb0fJaDsQ==
X-Google-Smtp-Source: AMsMyM50iuzbg50mfv02VLKAqIUzPFceoAfv9Ta62zYqvc7Msa9SH+aEBaFaPaaRG9C/g9GCEVWNCEr29yIgQu/mqrA=
X-Received: by 2002:a5b:c:0:b0:6bd:f84c:b63e with SMTP id a12-20020a5b000c000000b006bdf84cb63emr3690764ybp.275.1664835251547;
 Mon, 03 Oct 2022 15:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com> <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
 <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
In-Reply-To: <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 01:14:00 +0300
Message-ID: <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
>
> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
> > On 01/10/2022 05:06, Melody Olvera wrote:
> >> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
> >>
> >> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >> ---
> >>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >> index c5b76c9f7ad0..b47a5dda3c3e 100644
> >> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >> @@ -51,6 +51,8 @@ properties:
> >>            - qcom,scm-sm8250
> >>            - qcom,scm-sm8350
> >>            - qcom,scm-sm8450
> >> +          - qcom,scm-qdu1000
> >> +          - qcom,scm-qru1000

I think after seeing all the patchsets it's time to ask the following
question. Do we really need a duplicate compatibility families:
qdu1000 vs qru1000? I'd suggest using a single set of compatibile
strings in most of the cases.
Settle down onto a single name (qdu,qru, qdru, whatever) and define
distinct compat strings only when there is an actual difference?

E.g .we don't have separate compatible strings for all the sda660,
apq8096, etc. unless this is required by the corresponding hardware
block not being compatible with corresponding sdm or msm counterpart.

> > Items should be ordered alphabetically.
> Will fix.
> >
> >>            - qcom,scm-qcs404
> >>        - const: qcom,scm
> > Patch is incomplete. Missing changes for allOf.
> Will add.
> >
> >>
> > Best regards,
> > Krzysztof
>
> Thanks,
>
> Melody
>


-- 
With best wishes
Dmitry
