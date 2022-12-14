Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0F64C80B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiLNLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiLNLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:32:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38A263EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:32:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x28so9925096lfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZH3XT6lTlLRNGTJ73ZDjLUEvijxVcPXVJpLiElakDk=;
        b=YGtHyBCnTJ8gs4i/HEWe9cgKVAFFzQdfLygGe0mPGvT0yIAX+RgwFAO78MQS/oa/h3
         RPXKTKm3ictGbJdL3xllATRJIyVJpUuqH1h1b4DVjgo0Tuxm2ZNpOmma6kwd2inAKaIr
         FjXMWs5HoSmseuBE6Z5e2WjvXKUEGmRBgLeVCzvRjxU/Y/jlUH4xsR9zq6R0420KAJPw
         EX8l/1nxKKtvGB1Wi/fsaXTvGsdQZ68AgfbVvJZN1yRTXlxT/VymBxmVkq4LovssUqtB
         J3YJVDZyXzZRySU3rKHzhuTps89Xuf1fmzEU6qNMZmi0LO/a94EgRdnadDBZE3XVmCrV
         ntbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZH3XT6lTlLRNGTJ73ZDjLUEvijxVcPXVJpLiElakDk=;
        b=KcXWMLX6jalR9PAewnCmexiyrGDvfapjXSdDREXAYRyh0zgQbfsW2tIEG6evruh+9V
         x5Oh3UTYRFclP6wZgRkng8wz2e2rvgUjCOPuY/BRqQfEdqYtogNmu7Mo/q1CSQHx7Lvo
         Vj+uP+n6KnRh0h90/SZHprSL2BqlHakfqOZuQPVux7ih23C1kwsH+3P4VqQPoezlZiuD
         fYogj3DplX+dve/WnMHOZTNXMb+hAjQDDNMFdeuu/81WXCFh3LDZAMNbEWYmRBS1vAmJ
         UujoEXPpPXk8NQahf1EJrZ/cl/f3zVKxzMKb/5xClsEFxJQoCP6FTHLCuW1skyvziSYZ
         bCzw==
X-Gm-Message-State: ANoB5pkLzPO6/yh6z0EQPjrLkTZE1SevWzhq4FB/ftq3NuJTCho74v8W
        IfMVRwZuOuoijV7OiWLuGPy9oQ==
X-Google-Smtp-Source: AA0mqf5jw5C31aaaMe11ESCzNTaeNGoE8ERX053NGxmAW3INXjCgPRcNip5wnRUM3AQuZPy3DJEZ1A==
X-Received: by 2002:a05:6512:3a8:b0:4b5:964d:499b with SMTP id v8-20020a05651203a800b004b5964d499bmr6418347lfp.34.1671017538398;
        Wed, 14 Dec 2022 03:32:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651234cc00b00485caa0f5dfsm780956lfr.44.2022.12.14.03.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:32:17 -0800 (PST)
Message-ID: <aabff507-ad37-1cd3-b1b6-ce8e6dd9269a@linaro.org>
Date:   Wed, 14 Dec 2022 12:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] dt-bindings: display/panel: Add the Focaltech gpt3
Content-Language: en-US
To:     Christophe Branchereau <cbranchereau@gmail.com>,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214110037.149387-1-cbranchereau@gmail.com>
 <20221214110037.149387-3-cbranchereau@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214110037.149387-3-cbranchereau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 12:00, Christophe Branchereau wrote:
> Add bindings for the Forcaltech gpt3, which is a 640x480 3.0" 4:3
> IPS LCD Panel found in the YLM/Anbernic RG300X handheld.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

