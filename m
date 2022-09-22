Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D85E699C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIVR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiIVR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:26:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C0B02AE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:26:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x29so11849846ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NNU0iak8ifcJbLJaqeSlylthUL+6NyYhyDMHO2Uy9To=;
        b=KQ0jyGs+2KecOqLYzn93kiETHKZ4CzUzrcwjQSv6EcP1yYIJ4iCn+gb+NgClC9Jp0f
         X+XMHXLZCGTM86i9+9v6Kgm8SvzU6fjdT/7lYkmlPh250Wv9PzfEsuWrVnWQIcmJhii9
         Lx2NQQWNNUQqPchsphsqORTv+ehOwrMasTz7WTUSJvIoFSr6OGcXRfwEKMDiNWGkF67H
         u3WBucI6qpRlwO0xXQ7fVY8y1wgekeObjz6WmGOs/hu7o5nn2P7e/lpSNt1PlK0uamMr
         H5Oktw9eKQ44Gn4rCoXlYYM/sZKi9IMXMWuWne/ndHmDLl9dQ6+vV6DihM2TZr+oDPx6
         YkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NNU0iak8ifcJbLJaqeSlylthUL+6NyYhyDMHO2Uy9To=;
        b=8CEAx36DBLZ6yZBi6XFgCO4vxBNyTcOjU4g7Vukc4s4RBvpyaEjboXud5doFMfwDsR
         VW7499yZdTWPz0jJcYNaM0KFzlp0oaV0KEbgECoegXXzX0pY6QLGjkeWYn1/xLLmdG+q
         nJCT5buUDpwByBiAHYM9eVp6OFtWbBxZfTzDy4CFcIFkSV9oYXItMMPaMRz6AjLoVF5o
         a1Axtl2EiHlJxfRaP2Lo+f/MM9ky+fxDt4VPV0MSRHVKaozt1od/dhgxMg4iXTJXOkip
         KM3Sp8vNpcYHgW/bXO70lXx6U+BBKSWmPVOWiRGba8BQ5cGgV1cKioLACQ0zZrLcmGFW
         7Bww==
X-Gm-Message-State: ACrzQf07nMEyVJS3l1C9HtuB7CVbF757gVNIBUvXjHqmyXdwb0VTLDNZ
        vlpCgOLybubHopXGlQWSCx4haA==
X-Google-Smtp-Source: AMsMyM7KEWWPebb5wahwM0sTczlYzznz+dDsA8GGo5vdceIOBRj48oim0VWv+N3DrH91VgT3QO+GVg==
X-Received: by 2002:a2e:894e:0:b0:26c:5434:e62b with SMTP id b14-20020a2e894e000000b0026c5434e62bmr1472822ljk.180.1663867596929;
        Thu, 22 Sep 2022 10:26:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a3-20020a2eb543000000b0026bda31c10fsm974042ljn.61.2022.09.22.10.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:26:35 -0700 (PDT)
Message-ID: <2b7c1b90-c484-74e2-5664-f2bdd08d2849@linaro.org>
Date:   Thu, 22 Sep 2022 19:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] dt-bindings: virtio: Convert virtio,pci-iommu to DT
 schema
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220922161644.372181-1-jean-philippe@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922161644.372181-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 18:16, Jean-Philippe Brucker wrote:
> -
> -[1] Documentation/devicetree/bindings/pci/pci.txt
> -[2] Documentation/devicetree/bindings/iommu/iommu.txt
> diff --git a/Documentation/devicetree/bindings/virtio/iommu.yaml b/Documentation/devicetree/bindings/virtio/iommu.yaml
> new file mode 100644
> index 000000000000..ae8b670928d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/iommu.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/iommu.yaml#

I noticed it now - filename and ID do not match compatible, so this
should be "pci-iommu.yaml"

Best regards,
Krzysztof

