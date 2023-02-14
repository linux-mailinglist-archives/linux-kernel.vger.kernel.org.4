Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C8695CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBNIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjBNIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:22:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E747212B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:22:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso13094764wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rZYNk/+SGPInJMtgZ1K6jQiSHv5cED0P/DIveONKHE=;
        b=b3lgCkM3PbWTCNRWh5Bf/k2/hpE7laCJLD5srPOBh4vskNvXGLVsydy5mjnSV0tRbj
         ADc8FA8wOnub6Yrcjx0c4AHDB733qO8LrYskiCsubK6PQMNw/LIQ1inzJc9vz4+Joyi9
         1n5ThnhS8Uq2VcGD7CUzAM3l8YRaXHLLpadILNk/isd6VHtv9k7no1eyByq9YZ0qUa6i
         0RrHYuz6s+vVsAIlR3mHvk+Nn6bOsB0a1fJpc5rSvrGDGUdSdv3xRdovk/i1W/506PSm
         KBrsfNogXSRyOxqnLyvEFr8WUf7vGTTsqdE0lvzjYStg7ETuv+s+G4xrrkF6zmKhVqNB
         GEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rZYNk/+SGPInJMtgZ1K6jQiSHv5cED0P/DIveONKHE=;
        b=aTnpuxkC1EEf28JuG0nC0PokZ1eaaolOzW3Y06JEgGdP8w8nxLMC2H1fCYFCOnlGFl
         xk+rkaIpn4dTmglqk/lLvEzrF2toj2ocyUZkcuTes9AT23Ey1MgY8tkS4LXqJu69X6yv
         nVsndwP0k6L4fjqbffSOBHwjku4lGalarPtplAlePf/Os3xdGWdK4GIj8pje+IxcywIN
         2Y/ivhLuUxR6vF7xsdzKsqrucQkSFABzH9ZXN+nNs36QDTXCaSD6tEXNCSj6pBVMWJv+
         tMnxbe5Y8V3qBHy/wjWM/HnhxsZrwJGgtpeMorAGknFcWzM7kxkSCT32w0uluRUOyMoa
         ucHQ==
X-Gm-Message-State: AO0yUKXeW5vE060XMXcj77vwjTFn5TJc7ZG9rj4ebLjr/IUmSIBnJuxq
        kqis1vnK7rYfda4GaK+qC6GiQg==
X-Google-Smtp-Source: AK7set+Eb1ptTujhKIkoR8EnzxrayL+3WjJO5CiG0mbYdQv9ZVJ1BjiMvzwz6g06O0qsbAI5AEaHFA==
X-Received: by 2002:a05:600c:1652:b0:3dc:16d4:a99f with SMTP id o18-20020a05600c165200b003dc16d4a99fmr1205182wmn.8.1676362941215;
        Tue, 14 Feb 2023 00:22:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003db12112fcfsm18040828wmo.4.2023.02.14.00.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:22:20 -0800 (PST)
Message-ID: <294ec301-2792-4bbd-4184-494dc62faf22@linaro.org>
Date:   Tue, 14 Feb 2023 09:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/9] dt-bindings: firmware: qcom,scm: Update
 QDU1000/QRU1000 compatible
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213185218.166520-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 19:52, Melody Olvera wrote:
> Update compatible for QDU1000 and QRU1000 to include the interconnect
> these devices have.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

