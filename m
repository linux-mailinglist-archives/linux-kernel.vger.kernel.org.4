Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B715E8E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiIXQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiIXQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:51:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F052DD1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:51:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j16so4791731lfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gNYZXt17DV/TexDp3xUIxIPFrk7l1dxnMeGcWYpvKqc=;
        b=JNWiIDzI1b8sukTpns+Lk7aRagy1FgJ9qdsApmFw7kCKjKULcSd3II2b4295RHm+fs
         u4jVIsiUnYO7BMciotcDLM9bjeh4pMMuTY14i5VFQNV0mWLk8wgaenqMGdgKo/iWBXDJ
         Hi1yEHtdLkN8PzxCfQU8ijPetRANQN5VTRAUYmOyTeLMrlH5fp4J1YBI5ZoclLf/RioV
         PtamN7Pj19znhKOOy5yDx4n5SXaBR0OZ7C/Xu9z0XMbmoNdnNN0YNj6aUZYqOJHky9n0
         b+T48tKY+S0Ebz6B5Oq/hJn9G3groJf2uyJwxBzeQp7h2RUvp3qkP7Mr5F7SgxLycvlF
         VDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gNYZXt17DV/TexDp3xUIxIPFrk7l1dxnMeGcWYpvKqc=;
        b=duH+IAD3adkoW+UvMbmfL8U7+KBkN8DR8qtzGQCdZQ7trhSKP6l8cg6KvoZueH3fFS
         4MhxoDnAZ2MVdefSshpj1lMk9e4f6j+wlSTuUV9igioREVf9nhttOfFA3tz2j8/Og1TV
         fCEOWXuHV1/LH9ehLAKD3CvX18qjF21PKaPyyfbyJz+14VSPlXHSYgSIvZSF5ZURr1XN
         JziOq9SwQ/OHlCLOrcNRg7dxWZHmws35MKFxf2YKALzMgv5q/J5/D9mB/Ti4CCRVQj6O
         VOmDNwKRhM3eL+6Iiji7Q9nCfAT3ekhJzalvgGyGDMwsR1AXACnfMfxglAlxYtZPMOd8
         SHaw==
X-Gm-Message-State: ACrzQf0cVXQZLtIy5hHowsh7A9/FHkskOUmvNY+K6i82Jiw5sf5voD32
        t8cYOaeYIDUE0m+F86MH0lxvMA==
X-Google-Smtp-Source: AMsMyM5CHH/ZsNiW9lJ5OD7gJPm901E5o8Bx2ECC2tyQ1epDZOqy2PL/sJufViaObBxO3YpcKjiQ3g==
X-Received: by 2002:a05:6512:22ce:b0:497:499e:c966 with SMTP id g14-20020a05651222ce00b00497499ec966mr5231439lfu.402.1664038300021;
        Sat, 24 Sep 2022 09:51:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s13-20020a05651c048d00b00262fae1ffe6sm1822913ljc.110.2022.09.24.09.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 09:51:39 -0700 (PDT)
Message-ID: <a14ed141-4839-cf91-10fc-f4e03f969e0e@linaro.org>
Date:   Sat, 24 Sep 2022 18:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] ARM: dts: qcom: fix node name for rpm-msg-ram
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220924145126.24978-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924145126.24978-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 16:51, Luca Weiss wrote:
> Adjust the name to match the bindings and fix the following validation
> error:
> 
> <snip>/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dtb: memory@fc428000: $nodename:0: 'memory@fc428000' does not match '^sram(@.*)?'
>         From schema: <snip>/Documentation/devicetree/bindings/sram/sram.yaml


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

