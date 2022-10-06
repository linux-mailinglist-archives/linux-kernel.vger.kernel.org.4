Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98C5F6FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiJFUzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiJFUz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:55:29 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250665A2FD;
        Thu,  6 Oct 2022 13:55:28 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id m81so3435455oia.1;
        Thu, 06 Oct 2022 13:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87EsXsPO3i29vRZ8NZXoBCisaDJZa8eRu9AijNvsIQ4=;
        b=H+ppr7PfYC3xZdh+bIzh/xlE31ksGTNEgJXZEfCKohMoHctX2wu4+5nwvDLkhnDDA/
         Ugt9EuYjTneOes758r8vEflqt6+PTLYLmpuqn+FIqcVy0IqQg9XdL07yJoYyKZEl8o7r
         NloSKMt0RT2+1kmvFW7cEMtAZv3ocLeaIFe1BASpGmJPDY7W++G9yXoNGaSMRDXWD7Wo
         NpHHXp0WUdgVSrV9YkWmz5As6Qyb2UJdd5j3xNWkDsWnv4IdZOhw8kq7D92ngg/v9WuR
         vNuzn3mZAreL1AKXX37/pXHCUQ63DGGM4Pc+hGWINSn+xZR5E2RAkEp6fbK6dMESD5PK
         oXZQ==
X-Gm-Message-State: ACrzQf2kmXvA/igxHJujRBrzPjx8zihdFUSaEgSaHWl/nUJlfIw3B37B
        f4VdOBQXJK6WNLQdf+fOog==
X-Google-Smtp-Source: AMsMyM6I8daphx2LbYRtfkfVn1FrxA9Uouc3358E1SlooJgU8Y2aeIhyV21Kn7xA7YRa8yxAcaweIQ==
X-Received: by 2002:a05:6808:11c7:b0:347:cab3:9e5d with SMTP id p7-20020a05680811c700b00347cab39e5dmr5792922oiv.217.1665089727418;
        Thu, 06 Oct 2022 13:55:27 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id a25-20020a056870a19900b0012c52bd4369sm372435oaf.19.2022.10.06.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:55:27 -0700 (PDT)
Received: (nullmailer pid 131758 invoked by uid 1000);
        Thu, 06 Oct 2022 20:55:21 -0000
Date:   Thu, 6 Oct 2022 15:55:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sm8150: convert to
 dtschema
Message-ID: <166508972028.131709.427904989393799429.robh@kernel.org>
References: <20221006144518.256956-1-krzysztof.kozlowski@linaro.org>
 <20221006144518.256956-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006144518.256956-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:45:18 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm SM8150 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8150-pinctrl.txt  | 190 ------------------
>  .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml | 178 ++++++++++++++++
>  2 files changed, 178 insertions(+), 190 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
