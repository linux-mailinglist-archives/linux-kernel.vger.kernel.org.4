Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49177622611
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKIJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKIJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:01:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C41AF3B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:01:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m22so7688047eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wsdyl9eQolwHQu2400xEuupzASBq5K0VfYORRvnPoT0=;
        b=CLqmvEVcSBs8jh+I++OezYrLnpWMKuvFa+ctyobLa+R/SXb5T1ivx8uoWtMmyApIYz
         ounc/hnZ3Mxr0h5Vm6kBQtwByb4CnlEFrKodY6saOlys+arRwAkb50zZ3F7UV96HkYWQ
         ysQHZ15zI6f3z/rUExt6guzTBLmt1fC2xMOlUaYbV/aI/6KD8cJtH0FArn9SR2WGZpfM
         cU2zO0PJpaEnguqK6wnWBqSe+npUf80EXunYaL5CxndQeX43xUyfInQJcI6kMiGtqY2Y
         cuSLc6G+XwTwkKYvRMLFKwUEInTwQmVOVl7qAy8kp1bCGgcUGOBgMNMoe/wpPPI9MJo+
         SEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wsdyl9eQolwHQu2400xEuupzASBq5K0VfYORRvnPoT0=;
        b=2w4wqSupcvt5iDCnEQ3fZ7Y1wnDN3O7zn0NpsNHhPJe33gCn3Is0b+TFXIe99jPbyN
         CS7Sn8rDyOz70RfYR6CKOIuCvFRZLuH152EraCmSEctp1aFN9uym/bdKFFuTRt80W2Dx
         3IajFsU49j932zLDJNsLS+e3Y13+G6YtcbZmZE482FUq9fpEMRpQ+Be7FnsBvTIEyEm0
         mm3eZzJYbJFIMPz7Ob2wq+D4bKdp7lmZMMeYuyPHx/YPNWyqMs1E7UWubKUVEroG+kY5
         nLpN2lMfMZkLZ3VMo0RzIR9AVHxFUE2hVquyc8VCO1hsdChG+vqOvZwqXLimTm3SsWVK
         vd7g==
X-Gm-Message-State: ACrzQf3mM7aUcCGNHijWmwOURIxzU+g8nD0fV26snO+Dy4crdl1LwB3O
        7Z8eHk0h2b/XtlkBF+bEFjmSIpEUvmMmu4XaIC67HA==
X-Google-Smtp-Source: AMsMyM6OeCTpErxM3BzIkOS9g1uNoOpQf66z+lCIcXSiJlVfhCJ3tq22oVyyKtPYOfrVMAaAAMklQfTrVq7EBkq23cM=
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id
 d11-20020a1709064c4b00b007ada197b58emr57350750ejw.203.1667984461798; Wed, 09
 Nov 2022 01:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20221108140909.51422-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108140909.51422-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 10:00:50 +0100
Message-ID: <CACRpkdZa-h9Wwzf195EtMz7pewEMrzy8g5B=WkmH=DB9TXfe2A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,msm8976: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Tue, Nov 8, 2022 at 3:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Convert Qualcomm MSM8976 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
>
> Changes during conversion: update the list of non-mux pins (like sdc1)
> to match Linux driver.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

As usual with these Qcom bindings I simply expect to get it in
a big pull request from you later on :)

Yours,
Linus Walleij
