Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8670A67C898
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjAZKbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjAZKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:31:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138234016
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:31:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2965154wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5KI1HfwZehVRZCGq9eIEmT6FtE92VCThGr2hKIL1AU=;
        b=RpcROijhZnixVsRVbtQU7mzqkw6dLIHWg8jcS2pTsxhoIM/nM3CaAheXllwTzvmgLa
         YV3+iZ8GgBj5rnsJvC4dL0ZaZi+mcipvxWVHj4v3N2nT0/vQrXWwVf4g50EcPPdku6gt
         JFxr/oXyOb2YFyjenshWTrvIhUIjLQ83h3c5td/ptSdB4l9fvdHoStWGQxohjf25tzVf
         km9DUcvSzZKxovAsrH2S7UTn8Loto1GxAamJpBtoOmp8B8n/r+EbWWFuHNBU8cinb6gH
         N4wQDVkdQqE6GUKD2UcMGog4fsF8ZjO+Z0+PLfe10DxqFgnh/Qi0MLr5QVWeUQifsa3T
         kT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5KI1HfwZehVRZCGq9eIEmT6FtE92VCThGr2hKIL1AU=;
        b=5JOJ2vRKdJuXcrLeob3U9JomcgvbcCY43cRV16CIzMLx2c7Q48/mYBcNg8XS6cjbXl
         YLbzBfxuGLTFcR/xsN04RgKt/O7ZEHXuYwzYemexXEE8I+mRUDzzfqA0g7WU8fJaQ/yr
         dGcaS/75kUjyYVuOhlwLiaByMbg7mxAwy0PxevMYV4RqcwZUKoR1Ztht3WmWTW+uHO2t
         Tjcsd8ukQtPqOyADL+kB2X+USZHNR/BCeWVxohNxpJrQtpaForHSd2m8ComsXqBo/amp
         QQSAQ4h3n+FA4SKclP/KqKEPOQj5U/ALJ5w/3c4vKuWRpnCn4sZIc7H0CgLHZGczhyDP
         B+iQ==
X-Gm-Message-State: AFqh2kq6nVA45592zvphkpGdZQX9+L6cNbPD1wFSyj/r3W3+XbJfmhRf
        PUCfGTDhZAjUl3lQmK8Yf+lS7Q==
X-Google-Smtp-Source: AMrXdXtg5Jkxnnjlzoz4W7gv8azVosHtM4Vq45Cb7Q+R/cBkuLpo8hAksiaeq5bunaf/ycP/7TddiQ==
X-Received: by 2002:a05:600c:4a27:b0:3da:fae5:7e2f with SMTP id c39-20020a05600c4a2700b003dafae57e2fmr34777603wmp.3.1674729091567;
        Thu, 26 Jan 2023 02:31:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i21-20020a1c5415000000b003dc23574bf4sm1088415wmb.7.2023.01.26.02.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:31:31 -0800 (PST)
Message-ID: <98938065-2678-bf0e-26fd-3ac8302431b4@linaro.org>
Date:   Thu, 26 Jan 2023 11:31:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [GIT PULL] pinctrl: dt-bindings: qcom: bindings for v6.3
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20230120174631.353345-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120174631.353345-1-krzysztof.kozlowski@linaro.org>
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

On 20/01/2023 18:46, Krzysztof Kozlowski wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.3
> 
> for you to fetch changes up to 5b8c304c94d79f44aea8ee273ce70ca380804156:
> 
>   dt-bindings: pinctrl: qcom,pmic-mpp: Rename "mpp" child node names to "-pins$" (2023-01-20 18:43:06 +0100)
> 
> ----------------------------------------------------------------
> Qualcomm pinctrl Devicetree bindings changes for v6.3
> 
> Set of cleanups and fixes for Qualcomm pin controller bindings, to match
> existing DTS and correct the schema.

Hi Linus,

Just reminding about this pull so it won't get lost.

Best regards,
Krzysztof

