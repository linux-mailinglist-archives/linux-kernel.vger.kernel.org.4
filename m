Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58356DAA2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbjDGIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbjDGI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:29:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647AAF20
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:29:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-930129be52dso159793366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1680856192; x=1683448192;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvSp8cyUMKF1qGGbTf6r73kHmwUDhMZeDkSVRdnk+rE=;
        b=VrucHk7wS6BiVDQa+WFMoMuYB1xPFCpQGkLCRD8CwMigTZGjXRCWnumnH9kup9Dyt3
         lHBW+C2gPIbTq7cP8xw7igW+8VPR76Raswd6ju2wgLYoz+eB75cJTY0ZpKifMq5JnAOW
         4nUMJKUePLD6G07ymo6M98U9Ka9yNe/Qtg0Qj84CnG02npwWbIpS4IUGsdlWf7HDMQL4
         anVpCbg2HEUXWuNb0tInBFf8Q1fV9izkrZQCvdzv0VEzQTNjc6oiMzCH85QsuMf0IssI
         lz+RZAv4fHYACu109xSXkGREq2wuvTGwdd+FeFpowpzKZUynjxAwup4Z/6vJe3BedBdK
         YOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680856192; x=1683448192;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvSp8cyUMKF1qGGbTf6r73kHmwUDhMZeDkSVRdnk+rE=;
        b=kaUCho/BL78TGY7b0UQJwScGp2BwKRQ9RpXAwlPICAlhGIJ7PUTp1qVJlcKkN+nljB
         M5tnVmzZFG3I9OPBF45krRDhbqcAXE2ph4UZZCnC+3k6JTIQZGw72e9XyXv07P9xTzWP
         CdM2UI3/bUv8lPWHrLGUs2Sl7hDZFCFLm+cK6YvO4E9Oy6Tgcu2zlKMJP1GGuVSo9pd+
         77KTRVynW+cGONh4gmJW3t/y0g5DyZNuUuohYCbRFmT6mpS3firV0F/ZjDY1vwV6eyt5
         plqNEGW7vdtfCQaBFVRhcSuLqX/ssn7hNb6Ym1Odj6DXbKa+MC91bgOsSsCE908qK4+j
         Xiqw==
X-Gm-Message-State: AAQBX9fozDx7KyjyRmkPuGsqur4rglmsIfFU1/LYaKrDZBEie6JSymYb
        tAQ3vxl4R1KPdUIcRp7o4V5FKA==
X-Google-Smtp-Source: AKy350YbzKn/NC11aBG+Xn9E0morVBRWLIhxGyn63lK7zWZ+2D41nf5O5n31b+alJOBfm+dqxm6DzA==
X-Received: by 2002:aa7:d358:0:b0:4f9:f07d:a978 with SMTP id m24-20020aa7d358000000b004f9f07da978mr1931174edr.5.1680856192590;
        Fri, 07 Apr 2023 01:29:52 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a24-20020aa7cf18000000b005023aaf52desm1587496edy.95.2023.04.07.01.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 01:29:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 07 Apr 2023 10:29:52 +0200
Message-Id: <CRQDSIMFDNA6.28X06XB966UQA@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>
X-Mailer: aerc 0.14.0
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
 <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
In-Reply-To: <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Apr 7, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
> On 07/04/2023 09:45, Luca Weiss wrote:
> > Like other Qualcomm PMICs the PM7250B can be used on different addresse=
s
> > on the SPMI bus. Use similar defines like the PMK8350 to make this
> > possible.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dt=
s/qcom/pm7250b.dtsi
> > index daa6f1d30efa..eeb476edc79a 100644
> > --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > @@ -7,6 +7,15 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/spmi/spmi.h>
> > =20
> > +/* This PMIC can be configured to be at different SIDs */
> > +#ifndef PM7250B_SID
> > +	#define PM7250B_SID 2
>
> Drop indentation, although anyway I am against this. Please don't bring
> new patterns of this at least till we settle previous discussion.
>
> https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa683a9c7=
5@linaro.org/

Ok I'll wait for that to conclude then.

Let's only consider patch 1/2 from this series then for now.

Regards
Luca

>
>
> Best regards,
> Krzysztof

