Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716426F39AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEAVWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEAVWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:22:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411B173C;
        Mon,  1 May 2023 14:22:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24dfaff8794so1582080a91.3;
        Mon, 01 May 2023 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682976170; x=1685568170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0u9gt6o3EPT+URBm1bfsKeQp8moBBgJYkfWedTIxGU=;
        b=M/HxJ79lXyiTBAEVfMtbDe0tD8JpdFGNP/Rk3ZPD1+uNJSK/bpycIqM8wzxBOX1Xbs
         jvokajw8EeIM48suA5nmOmxHxdeHcHSWqL9JxJ+D26pYN8z1WKgG88akUGnbOlXNN/Lx
         vB0OHVtWSJggkkbX4TbK6lWlWCbLx+0hv+1e2P9X0l7AS6kwZoTr+6bQs3fcuxY4g8wE
         wxJ5Sj4aqJT+ysEAzQbtuDyQjSf8flhvddGTkzFq14nvvO/FaE7pnPxTZxRLlsWsbgRY
         iQHI68Nm0USwPsxzhDkR2GonMMdC8M66NhSdVZOcBev5bT4AEQIzj/pAhVm/kG2VLI4Z
         oxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682976170; x=1685568170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0u9gt6o3EPT+URBm1bfsKeQp8moBBgJYkfWedTIxGU=;
        b=MLzTh5FCU2Ya9dnf3PRP53rfDazqxc2KFa/MHCQL/JrUc2KL2gKTVjIdYJHrCttcrb
         vxAG19a1P2FYJ3NHcPZZBoRxAscBXOGGcj4HENn3HBbNGbHj8+3v30+j/DGXgtYaAod0
         4jrNIAzRfWr+wKXAXGG/poIXoLloAfUqbVrKtGCasVYVAkxu1v97yN4EU0KL6hjbof5s
         cXvxvxGzKvK4bBbbyrtotWUvvbQ1CBRGG5bGssLlciv1RQqdXOoB/T22+/Lk0OHsnQ9/
         p3vULXV37yCNl/5+n7hWqQPyRVscDfLyfhHps8J2TGp0qEXVgd0oYhSZIWpdvrRgtecg
         oLfA==
X-Gm-Message-State: AC+VfDzD8mwAbCr1sPtmKHVBKqg+VwZfHgyjX4W2sIAe2PgP9/rhtAUg
        UI7KiNJXiwvSsIeAEBwp3GoqyPVdKm//KgcoqL0=
X-Google-Smtp-Source: ACHHUZ4VZPUBs1wO6n/3I38y+KofvEbYP1WUShkHBw6p3mFkXrV/MgzPZYzB2SAG6/dOSa4YWd+iFXXfItaG+6sICrM=
X-Received: by 2002:a17:90b:180f:b0:24e:1f06:4d32 with SMTP id
 lw15-20020a17090b180f00b0024e1f064d32mr1046702pjb.2.1682976170146; Mon, 01
 May 2023 14:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230429193336.600629-1-robimarko@gmail.com> <8feae59c-b762-8cc8-7aa9-237ce4af5b1e@linaro.org>
In-Reply-To: <8feae59c-b762-8cc8-7aa9-237ce4af5b1e@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 1 May 2023 23:22:39 +0200
Message-ID: <CAOX2RU6wwvMLgScAgtqpOuSLeaULUAet4TtjQZkWK_uwwkr2Zw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018 family
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2023 at 14:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 29.04.2023 21:33, Robert Marko wrote:
> > Add SOC IDs for the IPQ5018 family.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  include/dt-bindings/arm/qcom,ids.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> > index 802495b20276..c1283bad81e1 100644
> > --- a/include/dt-bindings/arm/qcom,ids.h
> > +++ b/include/dt-bindings/arm/qcom,ids.h
> > @@ -216,6 +216,9 @@
> >  #define QCOM_ID_SM8350                       439
> >  #define QCOM_ID_QCM2290                      441
> >  #define QCOM_ID_SM6115                       444
> > +#define QCOM_ID_IPQ5010                      446
> > +#define QCOM_ID_IPQ5018                      447
> > +#define QCOM_ID_IPQ5028                      448
> >  #define QCOM_ID_SC8280XP             449
> >  #define QCOM_ID_IPQ6005                      453
> >  #define QCOM_ID_QRB5165                      455
> > @@ -229,6 +232,9 @@
> >  #define QCOM_ID_SM8450_3             482
> >  #define QCOM_ID_SC7280                       487
> >  #define QCOM_ID_SC7180P                      495
> > +#define QCOM_ID_IPQ5000                      503
>
> > +#define QCOM_ID_IPQ0509                      504
> > +#define QCOM_ID_IPQ0518                      505
> Are you sure these names are in tact?

Hi,
They should be correct, I am seeing them being used downstream
and in end products as well, IPQ0509 being one of those weird ones
that integrate 256MB of RAM on the die as well.

Regards,
Robert

>
> Konrad
> >  #define QCOM_ID_SM6375                       507
> >  #define QCOM_ID_IPQ9514                      510
> >  #define QCOM_ID_IPQ9550                      511
> > @@ -236,6 +242,7 @@
> >  #define QCOM_ID_IPQ9570                      513
> >  #define QCOM_ID_IPQ9574                      514
> >  #define QCOM_ID_SM8550                       519
> > +#define QCOM_ID_IPQ5016                      520
> >  #define QCOM_ID_IPQ9510                      521
> >  #define QCOM_ID_QRB4210                      523
> >  #define QCOM_ID_QRB2210                      524
> > @@ -243,6 +250,7 @@
> >  #define QCOM_ID_QRU1000                      539
> >  #define QCOM_ID_QDU1000                      545
> >  #define QCOM_ID_QDU1010                      587
> > +#define QCOM_ID_IPQ5019                      569
> >  #define QCOM_ID_QRU1032                      588
> >  #define QCOM_ID_QRU1052                      589
> >  #define QCOM_ID_QRU1062                      590
