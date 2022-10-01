Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40135F1A8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJAHO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJAHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:14:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A605F13D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:14:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o123so7714247yba.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PgzZ0PoJnAJz0dQXkSQKaL7dHuT1cZSXRrd9261Dnqk=;
        b=mlQfF7N1lrHCE7kzVtI6RSbT96oqYXRvPkt9eX6xq+qfm4PQfTjJVQlxNDnrIqSiK7
         fYF0Md3sB5LhiyQOzellOrJf+UQq0Usqk7TkNrf3IEMewO5PdRPyuNMDKMOMoqpm/YdL
         U76rKfnEfbppYSWsDQENGMquaxWiWBPv8nXQnH8I5RP+s+IkOaMuiYfqg01Cfsc3aGfI
         PJLIQnsuxZAuyMfxGnywGcU0cWYVhzR1J7o61gpcW518YfAIrTs330qNfLWP6fX9oiEY
         7xSObKxr6BQM5qFim7Ez/TfVjduQ0VT4rjTXCutA4b+am1i6GQSiu5mipBtOS7rfyAc6
         FF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PgzZ0PoJnAJz0dQXkSQKaL7dHuT1cZSXRrd9261Dnqk=;
        b=i9kjWUpP7l7jRgCKLlkMok7Ta1zUUBFdKBuiObjRkE4ZEGzjc7PTVnML3WTSR/Zg5T
         ExWbpFMcR5yYFsFa8Vlkjv9H53A4pRjbjYaPbvNMa7FD2zk23SRMdOZpxIHiBurwVo0e
         VIIT8mOY3Gfht9nEIH8APUu5oH4IwtCwYpaCUuFB/quyf1DeuA/hA2YUl2cWGDeQcuzT
         wemqWNFC0xo2tiJEH0f5+UodcZx04Vmv5Kfn1oo3tbRtRsfzcsM/SDMA1oM4m9VlUDhf
         Nq9eiFkYCRkZ8JNELNZe8D28wKOqAD9EoNSOQvagO2nEJCTfpR237VNspKzKJ1W737vs
         IPbw==
X-Gm-Message-State: ACrzQf12Gpy2MeOyDjbTseJpgNNHWLmggEw9/FJTECj++17xIXVvjCW+
        +g7Il1J33T+WboD90VEz/MGN2Pqb3L4++BumqSrF5Q==
X-Google-Smtp-Source: AMsMyM6u9BV0jp1phJUaaaJ8xA763ZxFTU2uofLHSHfSHU9LH6ozAYvYoscycfEMeh5n7Po4WdRQDl22O+CU0dKPQTY=
X-Received: by 2002:a05:6902:102f:b0:6b4:7cba:b77a with SMTP id
 x15-20020a056902102f00b006b47cbab77amr11680432ybt.516.1664608465947; Sat, 01
 Oct 2022 00:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030627.29147-1-quic_molvera@quicinc.com> <20221001030627.29147-3-quic_molvera@quicinc.com>
In-Reply-To: <20221001030627.29147-3-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:14:15 +0300
Message-ID: <CAA8EJppLd6dti=gbR0hbEAQyj5PHA7xWR3w+DESx1qcKcyf3YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: qcom: gpi: Add compatible for QDU1000 and QRU1000
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
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

On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add compatible fields for the Qualcomm QDU1000 and QRU1000 SoCs.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/dma/qcom/gpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 8f0c9c4e2efd..94f92317979c 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2292,6 +2292,8 @@ static const struct of_device_id gpi_of_match[] = {
>         { .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>         { .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
>         { .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
> +       { .compatible = "qcom,qdu1000-gpi-dma", .data = (void *)0x10000 },
> +       { .compatible = "qcom,qru1000-gpi-dma", .data = (void *)0x10000 },

As usual

>         { },
>  };
>  MODULE_DEVICE_TABLE(of, gpi_of_match);
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
