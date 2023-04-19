Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C96E8110
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjDSSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjDSSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:14:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6CA26F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:14:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy21so433027ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681928047; x=1684520047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xg3K3M8j59tMsqtihbLK8heSWq7f1ie0foKRcCv+H/w=;
        b=fnNwTRGi9HUBN2zEvwQ89hYmX+LWWW+J9Mp12/44/oBqIHMuqwdCS2HyfeiTqh5VH+
         qjpjGIetaBELAI3SHuQ+ojgsm1a4SIP5XMylYmr/XRzVs4pYauH7FG3NlCajoHEVbv0U
         a1u0Lt2jjFwrzaZ0Wdzo+Vy9EehOdS4EU2JFVaDqy8vFLr0qAJDBNsV9rKJ4G/3IBR2K
         3TZX088sudpRL8KiaRO4QDOld6A1JOcp0vIcUvJDLbVGbvpO6b5J1lao0+8KDG9MNMN3
         HIwVy6cN+TFw8oSgBVe4gTPszFeSYxXwt6TosTUcsKbBzEtWys5A7ezEF6x9ozCF0RbM
         2euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681928047; x=1684520047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg3K3M8j59tMsqtihbLK8heSWq7f1ie0foKRcCv+H/w=;
        b=OK6OwetbY6ve/uRZjUW6Jn6ANgaAJ8CyyaBOX61wLZYiEfl8W+b37YBuHavHQA5PH/
         L9IDejzYxr51sm1wp/s8nCqLaWI6RQ9D+5ZM8lb69gGPsEY/er4Dm5rCgvEb4Dd5om5n
         pde0JdHC+lgyAAuYjU/z3/3Mos+XvHXkvtPdWAxwJnfPWvRdGCLpzfKK8Mv3LXxprInK
         hcaGCza4eqBD819VCh8qh6IJutXdxWQuTu5JwavRgFUflWmiMHXrW/vWGK/PFwaExGQz
         /7PrGvi1fBLHOHlh/UA8G9e5IqPHOg2rh1IHFZqDr5IdE0BZJxGFmVMO5jJjuwFKUSjG
         uVIg==
X-Gm-Message-State: AAQBX9fa82XWwZIfFHHadmQnjJAQ5tFv2FfyHGphM+mYP+hIIkGRYtn5
        xx2XnHcck6YnSYHG0h8tv/+v3w==
X-Google-Smtp-Source: AKy350br1hRHPBQPh7/yhSG6kX2cW268D8yfyrjD0fO5T5B5egerpgp7UimoCyx83w1tZFm4KXxfMg==
X-Received: by 2002:a17:906:a1c7:b0:94a:97dd:aed9 with SMTP id bx7-20020a170906a1c700b0094a97ddaed9mr17222396ejb.70.1681928047045;
        Wed, 19 Apr 2023 11:14:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906ef0400b0094f969e877bsm3847134ejs.43.2023.04.19.11.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:14:06 -0700 (PDT)
Message-ID: <9070d030-088c-f917-93bb-bc3bffceaaab@linaro.org>
Date:   Wed, 19 Apr 2023 20:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v13 2/4] dt-bindings: i2c: Add Maxim MAX735x/MAX736x
 variants
Content-Language: en-US
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418103430.966278-1-patrick.rudolph@9elements.com>
 <20230418103430.966278-3-patrick.rudolph@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418103430.966278-3-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 12:34, Patrick Rudolph wrote:
> Update the pca954x bindings to add support for the Maxim MAX735x/MAX736x
> chips. The functionality will be provided by the existing pca954x driver.
> 
> For chips that are powered off by default add a regulator called vdd-supply.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

