Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27705F6BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiJFQ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiJFQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:26:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0627AB4883;
        Thu,  6 Oct 2022 09:26:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pq16so2190015pjb.2;
        Thu, 06 Oct 2022 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hbfYGNHUkbmVg6N1hzYd69NmOtZCOiVnEh8wTB8DMg=;
        b=JjzxOMhV7V2SgpMy8q792kZr9G7r7J3adWjJGYYmRSiSFvbW08bB1UgaE7fwo1sIQI
         iQ8HG3TuMDbxJaRyslyiS3KT7kmWWvcarDncNPocMUcR9PzQsbEC7BmJ/ijB3kzb+8WC
         MF0E71SeMUCHx9MPEHcpQT+xLHkKfl9PuTUH/P464HusQKg0FIjBzXWA4ZQnbuzZKlml
         qXCQoiWcBiqzx2VBpjXSi4tyDMoTZ65+8bpRGgsPT/78ct+FY+D15l/2r0tSLcqkwHUe
         z0st7mOBR1eCc33EQ84SGPOjVLhE3e/9kxJOHgvc3BU3Vp/dQZWocl03Ec9ldxqeDspg
         SwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/hbfYGNHUkbmVg6N1hzYd69NmOtZCOiVnEh8wTB8DMg=;
        b=zKYjk1TdKarvj4B5pLc+jOBIxpDy88SS/HyJL13ih/3ponBMLQwsNtx52o+bEjDuKg
         Hzbv9SPrHxZ5kGH8bhj+y8uN+Kq1iDJ/o0+5QczJl63F/gB1OrtY/k5g2g/LUWWNIons
         0ZzIdHh17A9hfLRoYeWCjQTEF8EHmB2G2Gz5NePuoWWSlllhW6jbgkmwBEDRoY/exstL
         rp2mrA1XLKVeXsAhPINdblYdwUhxOxwmGioAZFNhgxebQeryGQ4Z0mq+AlkXKWlOL0cV
         h5TK7HEsXqqNAXG3rLQO+XToecufjjtU3+bpKZGTo49DXFDjWj63wqeYQJZrmSivp3Yb
         0QcA==
X-Gm-Message-State: ACrzQf2Y6EafSuy1ol1gTb3v2VgR9PWoyKohcNkpR8gkdl13IjbzMIEq
        q8vYn9MwV5TTPGYKn1wQj2Mo2Cpx8vpdgw==
X-Google-Smtp-Source: AMsMyM5F6u1RXpZU1tZnO4TqKmN/xrY68kBym4WjqB8nJ5GrAT4yc25/Qc/whLqCZsnKUkQHSIPNCQ==
X-Received: by 2002:a17:90a:f190:b0:20a:a8b1:b199 with SMTP id bv16-20020a17090af19000b0020aa8b1b199mr11525129pjb.83.1665073568325;
        Thu, 06 Oct 2022 09:26:08 -0700 (PDT)
Received: from localhost ([2406:7400:61:5d7c:350b:1ad7:ecfb:8fec])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b00562a0c8a195sm544942pfc.69.2022.10.06.09.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:26:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 06 Oct 2022 21:56:00 +0530
Message-Id: <CNEZBDQ6ZMHN.220HJ00NJ8J68@skynet-linux>
Subject: Re: [PATCH v2 2/2] dt-bindings: remoteproc: qcom: adsp: Add ADSP on
 MSM8953
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>
Cc:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>
X-Mailer: aerc 0.12.0
References: <20221006044745.286264-1-sireeshkodali1@gmail.com>
 <20221006044745.286264-3-sireeshkodali1@gmail.com>
 <14aca742-4a27-c1d9-3015-eade31a4a3ca@linaro.org>
In-Reply-To: <14aca742-4a27-c1d9-3015-eade31a4a3ca@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 6, 2022 at 12:42 PM IST, Krzysztof Kozlowski wrote:
> On 06/10/2022 06:47, Sireesh Kodali wrote:
> > Add support for booting the Audio DSP on the MSM8953 platform. This is
> > used by SoCs like SDM450, SDM625, SDM626, APQ8053, etc. Since the
> > configuration is the same on all SoCs, a single compatible string is
> > used.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yam=
l b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > index 3072af5f9d79..c9d69f6160a1 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > @@ -18,6 +18,7 @@ properties:
> >      enum:
> >        - qcom,msm8226-adsp-pil
> >        - qcom,msm8974-adsp-pil
> > +      - qcom,msm8953-adsp-pil
>
> Alphanumeric order.

Ok, will be fixed in v3

Regards,
Sireesh Kodali
>
> Same in other places.
>
> Best regards,
> Krzysztof

