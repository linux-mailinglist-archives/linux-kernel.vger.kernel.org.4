Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14F5BF967
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIUIgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiIUIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:36:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4F83069
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:36:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q17so6049741lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=WSl6x1ZY7OekVx3cUrQbIpVJZrenOR7l9ismPCaJv4k=;
        b=ZiqyYPLVGzRRb+fUK7ioj7ZrTpjDn2Cg2VlWNwKVKEt0r4ESpG99kDnzOhQommV7SS
         9zGV4P6H8FoumksAC7G44oNwZLfY2gFk98F5xXdCRyo3pBZ0nEfj8XF3D6NtUp7UK4ih
         A2dHG/H7Wp0PQUOnpBmc/hhx2FmHOCDJS/oHd3KyS2qpZpck0JTb+17WoyHwlr5LI3If
         n1BAHC/+hUqKo4m7iR9vkGLaeR8YTP5xAP5xB+g2TkWERwZkAC19jQlQ4uCpPThY0BUk
         IV1uxc9BGV7bMy5bwvHsaMk2lH2XP/nmDnClQzGBkpHzkc12+4BbX47ZHw7f0MLOc24I
         EHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WSl6x1ZY7OekVx3cUrQbIpVJZrenOR7l9ismPCaJv4k=;
        b=wyTcoycOoIyHOXWlv1wd19vQsTcaEt1hxeubYtwdydLKl0V20zZch6oWF58WHdAEti
         YSae7WSjyD18UGsnM6pyYWLIdYmMwAA/4tasqJ4i/mTgDm5BFQ0WuWRe2LdcHvK79J3k
         h7bmmrzGsNiL2EYY8QaMPgMaYFIt97viSdKfl1Ry2zf9sIlBdxcXbNLgv1OsG5TuI1WJ
         ldJQ1G1HBSWqyW1ej+6sQnl/reRRjhbS2MmLU7uKJ5xqQkwufQ3CntLsNOlG+khV7sQJ
         7qZh/YRixZAT5qt/3YhtBI7G+sjTdzEqDAv0cBxe+7XK+dYQy7r86xdYJfHg3oL0nEUi
         5Aig==
X-Gm-Message-State: ACrzQf3GYxCGVl+9BWWyKTOnVqEn3B321a4/4ZnE7TZ6H+ajHtGITGaF
        Ha9oaQwrLU6iE1YAjzuyd7zZvQ==
X-Google-Smtp-Source: AMsMyM7UvmGqcBtZrGL1DwF/jeH5+auaegOGwAymQjnCMBtFqaDiuMM7HVIB/4Zqfb40PkQwIAC+lw==
X-Received: by 2002:a05:651c:1504:b0:26c:6331:3463 with SMTP id e4-20020a05651c150400b0026c63313463mr1387627ljf.30.1663749374006;
        Wed, 21 Sep 2022 01:36:14 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651c119000b0026c18aa8587sm338514ljo.75.2022.09.21.01.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:36:13 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:36:11 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 3/4] dt-bindings: remoteproc: qcom: wcnss: Add
 qcom,pronto compatible
Message-ID: <20220921083611.stqvrwt2gfm3izlk@krzk-bin>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
 <20220921043648.2152725-4-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921043648.2152725-4-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 10:06:47 +0530, Sireesh Kodali wrote:
> This is not a fallback compatible, it must be present in addition to
> "qcom,pronto-v*". It is also not documented in qcom,wcnss-pil.txt.  This
> is the reason for documenting it in a separate commit.
> 
> This compatible is used in the wcn36xx driver to determine which
> register must be accessed. However it isn't immediately clear why the
> wcn36xx driver relies on this extra compatible string rather than just
> looking for "qcom,pronto-v*".
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,wcnss-pil.yaml       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


remoteproc@fb21b000: 'power-domain-names' is a required property
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb

remoteproc@fb21b000: 'power-domains' is a required property
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
