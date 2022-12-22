Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48A6540B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiLVMGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiLVMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:05:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DAC44941
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:57:31 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o6so2392047lfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ybQ4Whpa3SpP761yeHUxG3tM4xYXNTJUdHflhRn7YU=;
        b=zQUQj35lOnAY8gpRut1fU2rTLaWFGfMggPAUapYo/N2I7D13sgT5R5wKR7FDaB/dpj
         kJt3nTSsGyZMPA0F0JgJlNhQcs3hdqqPr2QEVWCd41qX5fsyaeqRrXrtpSlzllfcelgi
         mHYr2Li7g4Y/+ccNMqAhlotkMT4IHXqIH0nOepEP3cqnDnpBZ2757w2A+rw9BxH7XuR0
         a6J825pLQyp7Vxg6DJeeB8s6UZjnk5gLv5Xz06QZsGjAfxV4BdidmbWVeTOsKQRt+to1
         NGHvpUc0oyL8r+/6DmMqwnml3MfQW63FsVNKPuaTlBOLPDbx/QwV1K42ASroe5IihxF2
         Nx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ybQ4Whpa3SpP761yeHUxG3tM4xYXNTJUdHflhRn7YU=;
        b=KfinTj2ydn1e8GXAIv2tzVJtL0KcWzt1vgGXgdZeodgep4SiRbTpY1y5THIGydNcdh
         hD89lv1lNMRmCdfvlGm2+8/fL1plHqTWNAm9hDxcEY0nVdpqddQ5OuYst3IUbQkV10k/
         zRfCI8tTdG2yRL+WTbhG2fDG6niAm52CdOe8d1LAFF0VcdxW8iCK1rdx11dWLlt6i/cY
         vIGhBXuz4q7dhCj/0g8oZ43reVEoV+/HefgwwsshnHIzxSwxlaFBl34v7u5eIpJRclO+
         acvDERZQx0+ND8Kepc9Zrw9RWVPblj6Fs4NZ9fKvypoBIKtF43SkkP71Dk9miiBMH0gS
         kFwA==
X-Gm-Message-State: AFqh2kofFYqDgfdLLHMO52PeLvlevv3NUHA2SRbeWXTpH1uba/nzhKq0
        dqWAiUmPxhsk+2t8oAxmxRTunw==
X-Google-Smtp-Source: AMrXdXtXval6G4cxnlj44j4xDxigyTVVNLo6CuavcrR8WiAMsxtzmsn7MTcmxS5ivayE002kYlqRVg==
X-Received: by 2002:a19:490f:0:b0:4b6:2bba:923 with SMTP id w15-20020a19490f000000b004b62bba0923mr1412758lfa.11.1671710234800;
        Thu, 22 Dec 2022 03:57:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b004a45edc1de2sm45382lfs.239.2022.12.22.03.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:57:14 -0800 (PST)
Message-ID: <af21dcff-9bfa-8a12-a307-ff9adbd59f2b@linaro.org>
Date:   Thu, 22 Dec 2022 12:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 09/21] dt-bindings: display/msm: Add list of
 mdss-dsi-ctrl compats
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-10-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220123634.382970-10-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 13:36, Bryan O'Donoghue wrote:
> Add the list of current compats absent the deprecated qcm2290 to the list
> of dsi compats listed here.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/display/msm/qcom,mdss.yaml          | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Is your patchset bisectable? That's second place where it looks like not.

Best regards,
Krzysztof

