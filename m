Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE864D7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLOIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLOIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:31:22 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A02229C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:31:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so14582703lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKUhNhQH++1Xun++fQkRwkhy0b3MHO05OmMRhmu9zi8=;
        b=zL+QrLnzYv+Qac0DF9ntrmlsgAl/1xBeYvtBVGHaLe4geGB0HLzH+vUszM8t52eGUM
         RaVebbtKWxG57fl2FZQ/cveGIqHI759h3CrrWffn4y/iS0BiBLqZpQ0Vr8+Ivzd3sT1W
         AAuMMnfPWJ9RjZBAn5SA16FYXCniktz9yEAMAWZuCtoEnbjmONmk3NDeK+FiLdfWH5aN
         +RLtiiL2zBNkkGqr5zbuhXM/Ps4kf+bvLh5gZHsPPJ3hrEZaj8mNc7D4qZpqeSQU06KI
         cwaeXZTzxIurCdH6uT2kNPlShNJR0WFv+KYGOxboa7kxttitArBo4o1UgSpNG1doEKv/
         Hjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKUhNhQH++1Xun++fQkRwkhy0b3MHO05OmMRhmu9zi8=;
        b=lnU8CvxOxQcmhI1zOm+SNty3DOYEQAU0YJr0Qwjub6vwJa3peqpFpfBMb12ctkpPS1
         zEjJHiDZIlrdwQ84eY9CuWC6+brFWhqBQycuI2xp61I90TL47Lk5B5Etmiqf6hVYhYrs
         QGLrgm82sw88ph07jbQ6jgRw5Qd/792rlw/LhdwOvLEnH5tlUPk/5gY1afsJ4EM9Met8
         pRf/1PmsC94rOchQfcWoJiTPwG4bWGjpapFhL3W1jB1pcEbvIFN0mH5aIUMyYUPepKks
         SSg6wPv5HBVtQihfvPYvPynRZA0KwUXlV7NWPLgKRQjydfOj8l01ANMwSOBA1A6NfFvj
         iJew==
X-Gm-Message-State: ANoB5pmvggsgJOlkl9IBV+Z9bGZn87OH3AmWSP2rnx1iwcsN2iP+e6ZD
        S8Tlv3KAsWF1W0t70cpO00ecqA==
X-Google-Smtp-Source: AA0mqf6Hs7t4qi61Om1D5VAY2gh28XWZbr4n4AOXJ8z0MRKzpAaCAp4aeCiECNnhbcG63SdrWjsc7w==
X-Received: by 2002:a05:6512:29b:b0:4b5:6f7b:8cfe with SMTP id j27-20020a056512029b00b004b56f7b8cfemr8007443lfp.41.1671093079799;
        Thu, 15 Dec 2022 00:31:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512200400b00498f00420e9sm1090374lfb.194.2022.12.15.00.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:31:19 -0800 (PST)
Message-ID: <245b1554-5f61-3f1b-c04e-fd8326e62e8e@linaro.org>
Date:   Thu, 15 Dec 2022 09:31:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel_sprout
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214093342.153479-1-they@mint.lgbt>
 <ea20c58f-3a53-7cdd-8669-228c4acac49a@linaro.org>
 <5a511002-5cd2-b95b-a45a-faaf78e2f4a7@mint.lgbt>
 <cd025494-862b-70ec-a008-4be219f7f72f@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd025494-862b-70ec-a008-4be219f7f72f@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 18:45, Lux Aliaga wrote:
> Ok. I think that comment is incorrect. Changing the node name on 
> extcon_usb breaks the "extcon" property in &usb3_dwc3, even after 
> changing the reference.

You top-post and I have no clue what do you refer to. Don't top-post.

Best regards,
Krzysztof

