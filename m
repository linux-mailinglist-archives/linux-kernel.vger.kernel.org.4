Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D754E5B52ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiILDif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiILDiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:38:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488691D0D2;
        Sun, 11 Sep 2022 20:37:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v1so7341670plo.9;
        Sun, 11 Sep 2022 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=WaXIZ5JwVsOhXBftrVsmp7zYZvH72+xMf1APyVxWgac=;
        b=BvBKHaXw647oP9whkO74o4CzpP4P0/nUEZi1CHqGBs6t+xL0thcbuhYD7lgmQwUl0o
         ZpPPX74a4aVDI3l0bC88XCzZP9MREdsxXGtSnXMLfp8yJky9wKYPZzRjv4lropHPJ0XL
         +hERQAJkHrfbMVMZaURFlo2ROu6wlmXa8dG+ArOzvcwk+YPU4WdpIsOhkgP7eySPpwdf
         W537ielDapcbfB+Gzou5YVX3mETbb/H7R/11w6/3dXYLB7ZNQbEkrnNJCiK+/IEgD4eL
         hVCRcoSwRFsCV2FjaQahsqBZI55qsjCu0jTeVBIbKRyKas6nPMjmswhhXIuBDHQkMPht
         FkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=WaXIZ5JwVsOhXBftrVsmp7zYZvH72+xMf1APyVxWgac=;
        b=nOPLIpLVYsWWHxQv59aoxO7ACzDElcBxpqJ8tOi+MgAtaTUfMXuv/3s+9DsKJM4/2u
         LHTKXttP8bnYZnQCB0F/tIkia3QQ4P8x2Oax4Ka7gxKyKi8nNzTxoHxx9FEy8SBY/EgF
         Hc3HlPEoII7feKhdNGWJZmyhpuvttArx/DWgNJR0tx9poJCVHE3v3v/MRPvQuJW1x15P
         fzPgnmlT1kevbrwXr6QnEJlEG+gHyCmCtHo0bM8Ex6cdCAMSwzYBC3Usn1ar1hWwOL3a
         BXH7WlNIAmd2xZOL+L+z/uZGf5rbiruKP3YUSBQR7VJHlyJy1HEBxuDGhbGIZ+UgrSjU
         8lOw==
X-Gm-Message-State: ACgBeo0uZ0mFaDfdohqFP0MLZPIU2BUrWj6DY+QeRZOwIwouy20u+XFL
        w/CqJUoMmRUv8c8dQvOCdho=
X-Google-Smtp-Source: AA6agR7WZjKQIj4wNSJkCIx88LLNCKl079Nd0UrTPInvVpyfh3D9Q3WpEzX1koiAd5Wet3k9KSWFRg==
X-Received: by 2002:a17:903:1205:b0:171:4f8d:22a7 with SMTP id l5-20020a170903120500b001714f8d22a7mr24673515plh.164.1662953849690;
        Sun, 11 Sep 2022 20:37:29 -0700 (PDT)
Received: from localhost ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7952c000000b0052e987c64efsm4187352pfp.174.2022.09.11.20.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 20:37:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Sep 2022 09:07:22 +0530
Message-Id: <CMU3XSTKA8DK.3V3N5T54PCYIQ@skynet-linux>
Cc:     <bjorn.andersson@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: qcom: Convert wcnss
 documentation to YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
X-Mailer: aerc 0.12.0
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-3-sireeshkodali1@gmail.com>
 <932d68ce-0c14-3fda-8247-f5fe34b2f8b0@linaro.org>
In-Reply-To: <932d68ce-0c14-3fda-8247-f5fe34b2f8b0@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 9, 2022 at 1:29 PM IST, Krzysztof Kozlowski wrote:
> On 08/09/2022 20:49, Sireesh Kodali wrote:
> > This is a direct conversion of the existing txt documentation to YAML.
> > It is in preparation for the addition of pronto-v3 to the docs. This
> > patch doesn't document any of the existing subnodes/properties that are
> > not documented in the existing txt file. That is done in a separate
> > patch.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 263 ++++++++++++++++++
> >  1 file changed, 263 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,w=
cnss-pil.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pi=
l.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > new file mode 100644
> > index 000000000000..bc18139fdb91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > @@ -0,0 +1,263 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/remoteproc/qcom,wcnss-pil.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm WCNSS Peripheral Image Loader
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Use email from maintainers entry.

I didn't notice the entry had changed from since v1, will be fixed in v3
>
> > +
> > +description:
> > +  This document defines the binding for a component that loads and boo=
ts
> > +  firmware on the Qualcomm WCNSS core.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,riva-pil
> > +      - qcom,pronto-v1-pil
> > +      - qcom,pronto-v2-pil
> > +
> > +  reg:
> > +    maxItems: 3
> > +    description:
> > +      The base address and size of the CCU, DXE and PMU register block=
s
> > +
> > +  reg-names:
> > +    items:
> > +      - const: ccu
> > +      - const: dxe
> > +      - const: pmu
> > +
> > +  interrupts:
> > +    minItems: 2
> > +    maxItems: 5
> > +
> > +  interrupt-names:
> > +    minItems: 2
> > +    items:
> > +      - const: wdog
> > +      - const: fatal
> > +      - const: ready
> > +      - const: handover
> > +      - const: stop-ack
> > +
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Relative firmware image path for the WCNSS core. Defaults to
> > +      "wcnss.mdt".
> > +
> > +  vddpx-supply:
> > +    description:
> > +      PX regulator to be held on behalf of the booting of the WCNSS co=
re
> > +
> > +  vddmx-supply:
> > +    description:
> > +      MX regulator to be held on behalf of the booting of the WCNSS co=
re.
> > +
> > +  vddcx-supply:
> > +    description:
> > +      CX regulator to be held on behalf of the booting of the WCNSS co=
re.
> > +
> > +  power-domains:
> > +    maxItems: 2
> > +
> > +  power-domain-names:
> > +    items:
> > +      - const: cx
> > +      - const: mx
> > +
> > +  qcom,smem-states:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      States used by the AP to signal the WCNSS core that it should sh=
utdown
> > +    items:
> > +      - description: Stop the modem
> > +
> > +  qcom,smem-state-names:
> > +    description: The names of the state bits used for SMP2P output
> > +    items:
> > +      - const: stop
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
> > +
> additionalProperties false on this level.

Will be added in v3

Regards,
Sireesh
>
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
>
> Best regards,
> Krzysztof

