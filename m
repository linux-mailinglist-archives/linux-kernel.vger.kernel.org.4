Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A06DAEA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjDGOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjDGOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:14:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C56E95
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:14:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z8so379514lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680876885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LitglThuTVOTiVOaOmHnsqwO/XYwRjfJqpIXvqvwqNw=;
        b=cAJLA9st/am2ROtRBIB70zu0nglMvAOV3tEd1HC7g3HQTdqzeVP6KEr48jA56VgUXa
         KkJI7AZfrd5ROqX9VFNupGEpR10zXacKOp5mMY9f7a9R3GsOJaD4AmAgvw0bauwySmIj
         Ds/tKOGM5BzZOnDKSg+JU9vEbCnTLAaLtKhlcmJxrk1+MGVZciLb5GCJcqngWOG2Xe2j
         hyBvQft9VXg+87mF6/xYLDeC6AzeE8oAqPkWloaluS73LMS+5T8p0brCWML14lbdQ/v1
         vkqzR7Vn5HoZSrtgml9w6Dm8e44P7dktx/lHy0A1qrgzeNB6ddJI8U5w+im7sjZTuO0l
         7xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680876885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LitglThuTVOTiVOaOmHnsqwO/XYwRjfJqpIXvqvwqNw=;
        b=Q7WqE6kF+Feex7Gxt0TwGQN3TEjEeZoANINi/1C20fV7MYPZUP2PjD4/2c5cYpP5bd
         w8tvwfJYDh02mv0sWa/6Tzi9XZ60/yUl9OiHMRHZd61XYTzecojX4TVyjCJ5y6Bc/qON
         AkvkI4SQKpMB2iLP9Bp+vjSlbtt7WQhR2u3TN1ophEiYQyTCa3nSU4CuBwX/yHEFluQ3
         l8aHmOvCE14oE/MOtf/0/ysu6rqD52YOWRY14EzLehJf3IYrRazcwjVB/24OVu5lha5p
         b2emzvQWIaqHe9Z81hl1B2qN1wqBgrBcey1uVlSi64Sv6VW8BMK6txO1eaDUpnTWh2qo
         X3YQ==
X-Gm-Message-State: AAQBX9ef5pgWxi2u+aid0EUQgkX3wnuFz9uSB0mAKXpCgbuiLKEySItI
        kE4XGuVkzuBZZ5tyJB5FYYtG7A==
X-Google-Smtp-Source: AKy350acqruf2IioEOZZ0qADTAJUPgXe5AxpKHhOF2m+bdEf90YFET55+2fUJcuLINdva0c6Z0S0zA==
X-Received: by 2002:a05:6512:49c:b0:4e9:5f8e:315a with SMTP id v28-20020a056512049c00b004e95f8e315amr568818lfq.65.1680876885096;
        Fri, 07 Apr 2023 07:14:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2485b000000b004db0d97b053sm719656lfy.137.2023.04.07.07.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 07:14:44 -0700 (PDT)
Message-ID: <d9a641ca-9db4-f566-0abf-9cfd7b6f4cfc@linaro.org>
Date:   Fri, 7 Apr 2023 17:14:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: qcom,qmp-usb: Drop legacy
 bindings and move to newer one (SM6115 & QCM2290)
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
 <20230407061122.2036838-2-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230407061122.2036838-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 09:11, Bhupesh Sharma wrote:
> 'qcom,msm8996-qmp-usb3-phy.yaml' defines bindings for several PHYs
> which predate USB -> USB+DP migration. Since SM6115 and QCM2290
> nodes for USB QMP phy are being added to dtsi files by followup patches,
> move these bindings instead to the newer style
> 'qcom,sc8280xp-qmp-usb3-uni-phy.yaml' file.
> 
> Since no device trees use these bindings presently, so we have no ABI breakages
> with this patch.

NAK. Please follow, what is the difference between the old and new 
bindings. I would not have asked you to move yaml from the old to the 
new bindings file.

-- 
With best wishes
Dmitry

