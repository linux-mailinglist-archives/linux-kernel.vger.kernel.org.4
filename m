Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF55EACF6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIZQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIZQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:46:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFC8E0F8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:36:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d42so11571399lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NdD3ysadw1mQdYPOU4EwS3yTmvQUO98WTNXkaJ5Je4A=;
        b=c6ewr/mFasF3rWZKnZcQ6r5Wj1beFg430Y29bpXQLlUVzZmwo/mCCb6xzvhPGpKhNX
         rlxIsIHnxXLhucskcWJfiPFrI6msIqn3q2EhcU87WUf+joLGBjIL8ORqM9H+nQKERrCk
         QEWY8ca89GkyLWUBog+h1053UjtWqHdijjx3cInf0kLzLO/+j0HzH8IsZiyyCK9QbTqM
         2/1iywv415/Scs3Gni2K09TtMyRNNO6ivc1u7f5KV0WSCxPIVoGkT5igNSUw0c+0uYBd
         45QOn6wGIMKiJkY5JkiPVegrf16OQdSXn2o7u499YffGfzH3i9d+020vRGeZziI34Ro+
         iDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NdD3ysadw1mQdYPOU4EwS3yTmvQUO98WTNXkaJ5Je4A=;
        b=1wD8xl5EKlXU7K839NoshKmAAJYGzzXGL1VnN1paaFkxBROe2CVInByBpxio+czY+G
         0rsXCbfdTpFE1bcQ8pWcadoi1R/J4cyaGCkMt/qvHjGT1fN5ORK3OkIH9zkrYF1D7Cdx
         9jI39DRMHAn337PlJhuGeYkaFih/V/Hd23sYgHk1jhbJhAQJAsxHKUs9XPPruhRw8N3F
         UvqgNvQeqEonnz6QpBHL9nJqgKKIFqxMAo+4wLOfknhkIB170D98kOYezBkKppQ5nqNL
         ODo1VlgoX9EkRgKHk+eLz+sBcavSH30YDgqP4+5+gLwqYQPDhj2HmM/FLPPI95CxLAcp
         98zw==
X-Gm-Message-State: ACrzQf3BmK/EkBazmSkXe4EnlXaZFFxWR+RqVIIwvuN/r8PmIZF7iUYw
        0QsHiqHh0vmk+pz7EmiP41nnVA==
X-Google-Smtp-Source: AMsMyM7MjonJ6cIFHspxIEl28Vcd7kw6kwThRCncxLU3jHqMpzHJDsiwIViy/i3AEWg0xCW4sRJ5lA==
X-Received: by 2002:a05:6512:3159:b0:492:d660:4dd7 with SMTP id s25-20020a056512315900b00492d6604dd7mr8317604lfi.204.1664206601036;
        Mon, 26 Sep 2022 08:36:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004a0526b11ffsm1425030lfs.133.2022.09.26.08.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:35:18 -0700 (PDT)
Message-ID: <f4d29a38-c195-43f7-4837-43a6176a0a58@linaro.org>
Date:   Mon, 26 Sep 2022 17:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv3 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220926140932.820050-1-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926140932.820050-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 16:09, Dinh Nguyen wrote:
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              - altr,socfpga-dw-mshc
> +    then:
> +      required:
> +        - altr,sysmgr-syscon

else:
  properties:
    altr,sysmgr-syscon: false
and then you will probably see the warnings leading to error in syntax
(const is not an array)...

Best regards,
Krzysztof

