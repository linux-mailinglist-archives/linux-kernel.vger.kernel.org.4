Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E46BDC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCPXDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCPXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:02:58 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E1BE5CE;
        Thu, 16 Mar 2023 16:02:48 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id l9so1877670iln.1;
        Thu, 16 Mar 2023 16:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42N7QaDW74l84fk7KVVYAtLDt8AVVP8he/p12Jl7xSA=;
        b=PZRjw1C7xa5iwa/52bF8HE2hkqV3/Qiazc+skh6wHP8sJ942bx0QxbFc2fcH5RXO57
         mgwoTQ5XZSddFu4aCuRRbyb+O76OjCy5hqTZF97/zsRTQbKwZepgDnQxlb4SEvpSOBJ0
         D2oq6olyWB4upB45t9dm/Pe/0X9yrCwkUSCcrkCczuOmZQ2iV9BD5lUglM9Q+SsCwOcV
         b2R0rtwfPrhbib17oN5pL+3kuhi5D6jRWcPX5SMFzXXiAiBpbD4GW6E7cTNehhRoDvrt
         asC7ouls6Bb5EuWiVvSxt38K7fRp0n0ZbzBl2qUM74oVzRIAQYZtPKDlP9hT5JmlT5aq
         tmUA==
X-Gm-Message-State: AO0yUKWBjtXP9J0vObzr7UeWqW2isFACdixhr09PBG+uMdKeg9GU9bAq
        jx8opX3RSTcEdJw4E0Z0XkVhCTRndQ==
X-Google-Smtp-Source: AK7set8v1z8rweeLhSlrn8BXfCs9Xu5N6zIlRvf0won94cSzzp6gYiMsmmb4Swf+84CZTEbufgj+eA==
X-Received: by 2002:a05:6e02:1a8e:b0:323:338:cc50 with SMTP id k14-20020a056e021a8e00b003230338cc50mr9526557ilv.22.1679007767326;
        Thu, 16 Mar 2023 16:02:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 185-20020a021dc2000000b0038a06a14b37sm174163jaj.103.2023.03.16.16.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:02:46 -0700 (PDT)
Received: (nullmailer pid 4049144 invoked by uid 1000);
        Thu, 16 Mar 2023 23:02:44 -0000
Date:   Thu, 16 Mar 2023 18:02:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: remoteproc: qcom,adsp: bring back
 firmware-name
Message-ID: <167900776429.4049083.9689239612098099608.robh@kernel.org>
References: <20230309083548.47205-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309083548.47205-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Mar 2023 09:35:48 +0100, Krzysztof Kozlowski wrote:
> The firmware-name property was moved from common qcom,pas-common.yaml
> binding to each device-specific schema, but the qcom,adsp.yaml was not
> updated.
> 
> Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Use maxItems:1 (Rob)
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

