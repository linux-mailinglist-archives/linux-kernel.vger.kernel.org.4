Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776F56D92BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjDFJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjDFJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:31:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE76EAF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:31:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so147843386edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680773473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RIfpuoVaNfnxeve7MYPNghsS5GMXgpW/gynvfrtPRQ=;
        b=Z6K9oBTG3TkcviaKOTj+7E+7gJgTDrMRJym9EfJWN39HGEewSP4RY6G7BATJ2N4jRg
         IadjNVgCfU5oP6DsfsvdN1o5QcGL8cMk0u/BHy1ENWQYuL+6N1PBVwRr+bGd+G8m/gst
         +LcsiDSq99hplkS6GPFkEOhwb7pYntOyPoeTtpa8FnY12dyJE5m0E9io24mBYg8NWszj
         xy6QFmtSBEbxaGMVfsdLedo5UASjZDvi3A0ySv+Z8Xs4smaUguvekzumWA6YXItnKuQA
         wC6OdXo0OSZ/X6GXKwvgHz2qflFNgbe/amKt8aTLlrIRCKgRsJIfHN4VM4zQxDhGR1At
         6FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RIfpuoVaNfnxeve7MYPNghsS5GMXgpW/gynvfrtPRQ=;
        b=0zdLxI+Kip1Ql/k4lrmUr08ViwRDvEpwOWYL7RBqGf/nlzn9FFQLo6J0kNCfiYudxT
         MlKRD8sZnMwXBdHdBlx+2KD1Ckodgkm/4VHpZPeFGwZ19uWqY+TJlNXOqpGKvcUa15N4
         9lENGYoS//4iEWH1t6qxQmoOR0sumevRnwouECuKPJ5+cZ30/qD/xD3myRaJ9rAJnCa/
         hNkP/9CFLkPpKdzTeAoyGbboNUXwy3iUYoCBtJm3z+V1wx917dOR6tpaSieHw7AgAKRo
         tHO7P5NR8I5bw2tlKqHC9O61jQ8nORuiRt7bS09csqt0VYndHlszj4fQbVX8R8RQ+zrM
         il+g==
X-Gm-Message-State: AAQBX9dmlEsPbe6YUAWopKPnvOez2neC5Y6sHcXmJgsXFNGsAQ3m/8T1
        ZNsYQQ4YJdnTZzt40vWzdR1ERg==
X-Google-Smtp-Source: AKy350Yyy9UiZia+JA070uxpRw7X2DpW+5gxQSCln7rvz8jC2z3gIEAclRA+XxTXfeJmWApTbvYxwg==
X-Received: by 2002:a17:907:c709:b0:930:1178:2220 with SMTP id ty9-20020a170907c70900b0093011782220mr5510101ejc.40.1680773473299;
        Thu, 06 Apr 2023 02:31:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id jx17-20020a170907761100b009332bb8b1f7sm571254ejc.66.2023.04.06.02.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:31:12 -0700 (PDT)
Message-ID: <731caa8b-1a4c-d1c3-9398-ef3fff75aa76@linaro.org>
Date:   Thu, 6 Apr 2023 11:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: dlg,da9063: document voltage
 monitoring
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
 <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 19:14, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Document that the da9063 only provides under- *and* over-voltage
> monitoring in one, and therefore requires both to be configured with the
> same severity and value. Add an example for clarification.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 17 +++++++++++++++--


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

