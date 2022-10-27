Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31160F99A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiJ0NsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJ0Nry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:47:54 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273E183E11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:47:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i12so1308296qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jwbx4aeCYU3Ry3LO3u7wdTMADpr9Sq4Lt9n5HgpGCOc=;
        b=d12GULx274SfPQBlBEIpgHqeY3IFb0QKGemxX30c2RDM4cKE0VYQ4bmGcFzT7aegYi
         ffUna0evS16D8vJdWC1fbi0h3j5ywL3cuKKyzTSvQQpZ2qjRuZC5bKLlLk86UG8LDAqN
         rkj5uRZ1vDv56qJvJIaBTcxOVXRcVQUMYt0MU8Yd68N2t/Ccaydyr2ZTGKoBFbcAp1Ua
         S32Awj3z/1W21vQFGG9pqDGDSmXbi5qFNwO1nR3iaDvOYSpxs4zDVnDEuCJ0g8hVKLWD
         uOAQ726aqlarPJSgqVVB9mRnohl1gME7Ak+g8oRwdagkCejj6N8O7/vkLIwzFr5RErdQ
         PODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwbx4aeCYU3Ry3LO3u7wdTMADpr9Sq4Lt9n5HgpGCOc=;
        b=gak1ZijWdr7gGIzhSdyjHOUYZvoI1234mNQRd8S/F5V0UZxNovee9PH0ZPA0LSdUGk
         TXGD8K8WdSsrcPk13TYgHm2W48DxwEQvKwxnZE/Pmvl3SycfCpAsTWYDKhkWUqZWf9Tc
         X5leglMNl8JGMweWa+PeZCv5Buii3n7YeuYHDNH0FFeqDR6+BrW6u6mmftF0hek4Qesj
         PSLiX1ErxNK8MZtGFwrNgonbGNzKvz/aTXuTzKp3EBq2XO2bdWVar2W/E0i9dmCOkLER
         FDqgcYEkYugKzT8AzdfHKmdmqjeklJYOrSwGBsZ43HAgzvdxp40eXrNe60ZiB51Eip3p
         lvjw==
X-Gm-Message-State: ACrzQf0vuoLCg48ZLaJ12RTSNHiJUrrYh/Xn2XKfOIC0HcT5UlhGOAsl
        pIgRfWbPznimb83JvplmgYchGg==
X-Google-Smtp-Source: AMsMyM6pNSZMVGoS3Nz9zGVQZgm1gGYB5sZCQYcJmpLCBhO/akfLPCf7o+jIA7s6sKTRFgYFFENXtA==
X-Received: by 2002:a0c:a711:0:b0:4b1:8816:4168 with SMTP id u17-20020a0ca711000000b004b188164168mr41347746qva.46.1666878472657;
        Thu, 27 Oct 2022 06:47:52 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bl24-20020a05620a1a9800b006ed61f18651sm1015002qkb.16.2022.10.27.06.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:47:51 -0700 (PDT)
Message-ID: <0decb01c-b651-59cc-c5a0-0c9dc173766c@linaro.org>
Date:   Thu, 27 Oct 2022 09:47:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 02/11] arm64: dts: qcom: sc8280xp-pmics: Add temp alarm
 for PM8280_{1/2} PMICs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-3-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027063006.9056-3-manivannan.sadhasivam@linaro.org>
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

On 27/10/2022 02:29, Manivannan Sadhasivam wrote:
> Add support for temperature alarm feature in the PM8280_{1/2} PMICs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

