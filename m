Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD40D707055
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEQSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEQSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:01:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022502D5D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:01:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso1538241a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684346469; x=1686938469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPjH+AyIlGHtcYsMCoD8SjkZqBgLcEDJmRre38IR4fs=;
        b=m45d4S0F3TH37O+Gj63MF73tYqlxMelat9CME2f4e/lla5QOkzkmD+fq8tvAnDj1/f
         5fIMbxuuygLE5OscAlgwVZbh7O8cWmg3d1j+40whh7jeEsLyPjX+X8E8gHc4EGczfnVk
         3MLQmxr5+6nmnuEdbmgFu262RZcoGA1iaOtWpebAtB+0NakFNNCGw0IqGrHETxpAkRQm
         gqgom7gHtbjw6TmjEmbWw+4cMR3SOrKD1c++tSZYivqmteixmS7LmevAFoP4HV9AZW6z
         lb7+cOT+qV/+mbqDliGaKgo84Mh7lvja/WxWddTKcn2GVtp7B8DmazUjNQ8Z7cHRja+O
         zAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346469; x=1686938469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPjH+AyIlGHtcYsMCoD8SjkZqBgLcEDJmRre38IR4fs=;
        b=YOtkQuvy3u7UpYoI7N/zjjWjKiO6InoPtw0Dti/OGIwYuSbBUFQSYP4TBEQjHVEzeM
         dR1UVuDOwJC6RwJrUqKXKa1cRPeX4BwG4nM923YdwLbjgpGn5KyL1+dEUOuJyNV/zRyx
         6bFaFMNuCrYqjh9rp8+1gVgogKGoUiEge81oiYlNFBvbYlebyax3EbJD768VZafhaWpZ
         hC8UbgAlHt9K5TRsVIrcr5M6xapxAHUkWj/xcDVhTbSH8Jwbaz9X4voP2Oyy/6AYH7n3
         qk2WQsCFVdUjvm9GP/hzXw5ob/Xtb628r57YAy+d8M1jpUhqLS0i4/8qDO8MIvliZSVF
         RRxw==
X-Gm-Message-State: AC+VfDwtevnR+xW/ouayh3sh70RPjE2/Zx0rAu0A2N5THMyB2egoBk1r
        RgWeIi5Hv2JeBZseieB12pjX7Q==
X-Google-Smtp-Source: ACHHUZ4g2WtZ5hlvOmXPEF17atv8bVoLgjz7HOHZ3CGenXQf5HRVcvc35O4CYw6HgWqI7/aDgDBmYQ==
X-Received: by 2002:a17:907:2da9:b0:94f:247d:44d2 with SMTP id gt41-20020a1709072da900b0094f247d44d2mr38652805ejc.5.1684346469404;
        Wed, 17 May 2023 11:01:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00965fdb90801sm12672206ejz.153.2023.05.17.11.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:01:08 -0700 (PDT)
Message-ID: <904b0fad-16ec-6633-fee9-60c24e9daf14@linaro.org>
Date:   Wed, 17 May 2023 20:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 1/4] dt-bindings: phy: qcom,qmp-usb: Drop legacy
 bindings and move to newer one (SM6115 & QCM2290)
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
References: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
 <20230516150511.2346357-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516150511.2346357-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 17:05, Bhupesh Sharma wrote:
> 'qcom,msm8996-qmp-usb3-phy.yaml' defines bindings for several PHYs
> which predate USB -> USB+DP migration. Since SM6115 and QCM2290
> nodes for USB QMP phy are being added to dtsi files by followup patches,
> move these bindings instead to the newer style
> 'qcom,sc8280xp-qmp-usb3-uni-phy.yaml' file.
> 
> Since no device trees use these bindings presently, so we have no ABI breakages
> with this patch.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

