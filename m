Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6219D5E5AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIVFtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVFs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:48:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026AB40FB;
        Wed, 21 Sep 2022 22:48:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v186so306676pfv.11;
        Wed, 21 Sep 2022 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=XGFyLted51/RT9xbeKBS8viSPSWXeRp6XswM//QSaRc=;
        b=IGQTZU0ZI7mEQl/MTnVsVah5Uj55ITzawnylZ6ObJQ+gfEPLAfcIK8QZNGfiCV2/3X
         xgjTQovvqlNhlzaXKlmVn73q8iRdLmK+Og7UHE2gj/1wb2EHl25tolWmsv2vOBvQ8YEh
         rt1Id4k+Gv9wg1AEodH4wgXxVvIeK8qUvpXfFu0tMx6/5CNmPqnDZXI5kikDHkTF6qBB
         MGmZzhTOWRoDsJh99uLXTy9yeHK0I/8hsfpvXIhwM/CZpjAOsXwMClcABkWi6ROxWFVU
         Rk9FKR9XeTT41Ef1Gf3xOTzSboznutiHmXodrx1QkVKIE60Y44vJcsf3qyBfeSrKQ2E3
         zpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=XGFyLted51/RT9xbeKBS8viSPSWXeRp6XswM//QSaRc=;
        b=4jjZ/j68RJznXV91NkFGzI3sVcbFX1sHNm/UZ4BIbX0Pqx71FOQkjGZE8a/cEPgXpm
         VfIgQH0CMZfBMAp1Spfozw5CZwPATVVkoN7VeROn8e0z5RvTiyWAg6GQ5ne2OP79Dxs2
         PmXzQFXH3UPUjZOnv4B9zcAGdP0wR/o9iHJlQjYOampVIISBbQlYb+GFy2jIi9NICYLc
         ttuV0/ZkxKYYUk1NaaQ5LeOdJT6tTrFHvCirWgBMcA+DxxOnzIRiPlIW7jEK1od7sZQu
         N0B4CmdGKnyJfFupapN5nJdwoq/8C79Zabk9ukG+h43xg464CzxKrsO96e/b78Wfec5d
         bh+A==
X-Gm-Message-State: ACrzQf03g8/07U1j1H8jE51nnsAgIMbs/QCXfBS7jZV3rYBtqE/54NBF
        wm2V1c9wtlw8vaXNWn+cXLYJKAvs1yi1Wg==
X-Google-Smtp-Source: AMsMyM4WAOaEjjQxOqO8ijc7wC0a/CpadcLAG7ZRy2O2HSg+IXmrzYGIB4zINGB+RlNQtXs7D+h71g==
X-Received: by 2002:a63:5915:0:b0:438:d560:c4d3 with SMTP id n21-20020a635915000000b00438d560c4d3mr1603320pgb.240.1663825738416;
        Wed, 21 Sep 2022 22:48:58 -0700 (PDT)
Received: from localhost ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b001769206a766sm3000029plk.307.2022.09.21.22.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 22:48:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 22 Sep 2022 11:18:49 +0530
Message-Id: <CN2OZW7ML4AC.35WIWKCPJQ512@skynet-linux>
Cc:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: remoteproc: qcom: Convert wcnss
 documentation to YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.12.0
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
 <20220921043648.2152725-3-sireeshkodali1@gmail.com>
 <c241920b-c94d-83d8-d195-2cf3cc044038@linaro.org>
In-Reply-To: <c241920b-c94d-83d8-d195-2cf3cc044038@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 22, 2022 at 12:46 AM IST, Krzysztof Kozlowski wrote:
> On 21/09/2022 06:36, Sireesh Kodali wrote:
> > This is a direct conversion of the existing txt documentation to YAML.
> > It is in preparation for the addition of pronto-v3 to the docs. This
> > patch doesn't document any of the existing subnodes/properties that are
> > not documented in the existing txt file. That is done in a separate
> > patch.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
>
> Thank you for your patch. There is something to discuss/improve.
> (...)
Thank you for the review
>
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +    description: reserved-memory for the WCNSS core
> > +
> > +  smd-edge:
> > +    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
> > +    description:
> > +      Qualcomm Shared Memory subnode which represents communication ed=
ge,
> > +      channels and devices related to the ADSP.
> > +
> > +  iris:
> > +    type: object
> > +    description:
> > +      The iris subnode of the WCNSS PIL is used to describe the attach=
ed RF module
> > +      and its resource dependencies.
>
> On this level of indentation (for iris):
> additionalProperties: false
Will be added in v5
>
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - qcom,wcn3620
> > +          - qcom,wcn3660
> > +          - qcom,wcn3660b
> > +          - qcom,wcn3680
> > +
> > +      clocks:
> > +        minItems: 1
> > +        items:
> > +          - description: XO clock
> > +          - description: RF clock
> > +
> > +      clock-names:
> > +        minItems: 1
> > +        items:
> > +          - const: xo
> > +          - const: rf
> > +
> > +      vddxo-supply:
> > +        description:
> > +          Reference to the regulator to be held on behalf of the booti=
ng WCNSS
> > +          core
> > +
> > +      vddrfa-supply:
> > +        description:
> > +          Reference to the regulator to be held on behalf of the booti=
ng WCNSS
> > +          core
> > +
> > +      vddpa-supply:
> > +        description:
> > +          Reference to the regulator to be held on behalf of the booti=
ng WCNSS
> > +          core
> > +
> > +      vdddig-supply:
> > +        description:
> > +          Reference to the regulator to be held on behalf of the booti=
ng WCNSS
> > +          core
> > +
> > +    required:
> > +      - compatible
> > +      - clocks
> > +      - clock-names
> > +      - vddxo-supply
> > +      - vddrfa-supply
> > +      - vddpa-supply
> > +      - vdddig-supply
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts-extended
>
> You require only interrupts and interrupts-extended satisfy it, unless
> this is a result of bug in dtschema?

It should be `interrupts`, will be fixed in v5
>
> > +  - interrupt-names
> > +  - iris
> > +  - vddpx-supply
> > +  - memory-region
> > +  - smd-edge
> > +
> > +additionalProperties: false
>
> Best regards,
> Krzysztof

