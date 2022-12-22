Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AB6540A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiLVMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbiLVMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:02:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E33836D40
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:54:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x11so2444591lfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpAVb3+cVXQa1lG9/26ZmhtnuZCNmgaIflq0pQhJ+MI=;
        b=WMfKHcAIqLmzoW3u9ksF8dcVFMxOlA4FFCTklAZueBNiqdfZJxFULrasW0YNolRL+g
         l9jJDrVgFXPItkMc+8qNlt8q/YPFS5++54Bm0/0OI8of/bwkqlSkmzsmzKt7OsjaNydB
         SaqvlyDt9nOVrNT6g540uS3yNsE3He0u5hog7cxv1Yoq/o8dNjEvdiwyScVUi8v0kVus
         wZjM0eUwGZaLYbXorLZ2538sie1yaa2L0cKFZ16svZSc/0fVVc4sc/dZzbOdEE2EpdT8
         A65vkWXlxfO7u1FaBJpolVnrLNVZPrxCkG95fXXxiOxUU7N4vmu9A3fE+w6WQybg1H1v
         kryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpAVb3+cVXQa1lG9/26ZmhtnuZCNmgaIflq0pQhJ+MI=;
        b=zK3NmumJAVuQhhrk9NuguqkvOVVNoyCTpwuXbi9icEWvVNXoAzP5sH711qD3Q5CONc
         78/kujPbog8kD8vFutH4LWOfMPiDZyqqMhtBLTJk5cgBFfPxG0Aoa5/txP57JoYmiseJ
         EptNcrkyVJEPHCFYUeNeTmwD4pG01tGsIzIUVEo0fvXK1RJgYF0wxBq3HblaoH8pgoKv
         Z9LhL8n3FOKjaGUbUQattorCZ3/K0Bcosp0b87CWFxYpwcYpPPuW+OGvDFn36Y6uA1jo
         GuO2/Nb+QkSEcZeH6aE5NuQoeFMbAL0AiyNJBxDPRlnboiCoiL+r1deOr1YwevhCrciJ
         YI+w==
X-Gm-Message-State: AFqh2kqdfOYAlQyrOQI7IuIol9yp+itdkfWoYGJ4mqm2mW+MzXVXjS8/
        mKGam9eBQv0AeCwOZ6jfAA3aEw==
X-Google-Smtp-Source: AMrXdXtON0Zmt7ZIsbCnFjMaae522gN6PEYbg49HK+urLOAHDo4Cg/TkyZaKta1OtYFRq6DDHDoIaA==
X-Received: by 2002:ac2:5318:0:b0:4b5:7720:5fe4 with SMTP id c24-20020ac25318000000b004b577205fe4mr1728513lfh.67.1671710094036;
        Thu, 22 Dec 2022 03:54:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b004b55f60c65asm44401lfs.284.2022.12.22.03.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:54:53 -0800 (PST)
Message-ID: <dbf60b16-9331-64ae-93eb-0a67576adf1f@linaro.org>
Date:   Thu, 22 Dec 2022 12:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 08/21] dt-bindings: msm: dsi-controller-main: Add vdd*
 descriptions back in
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
 <20221220123634.382970-9-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220123634.382970-9-bryan.odonoghue@linaro.org>
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
> When converting from .txt to .yaml we didn't include descriptions for the
> existing regulator supplies.
> 
> - vdd
> - vdda
> - vddio
> 
> Add those descriptions into the yaml now as they were prior to the
> conversion. In the .txt description we marked these regulators as required,
> however, that requirement appears to have been in error.
> 
> Taking the example of sc7180-trogdor-wormdingler.dtsi. The avdd and avee
> come from GPIO controlled external regulators, not the SoC and in this case
> there's no need for vddio to power an I/O bus. Similarly the regulators for
> the LCD are controlled by the panel driver not by the dsi-ctrl driver.
> 
> It would be possible to connect a different type of panel to the DSI bus
> here in which case we may or may not want to make use of vdd, vdda or
> vddio.
> 
> This is also the case for older chipsets like apq8064, msm8916 etc the vdd*
> regulators in the dsi-ctrl block are helpers not dependencies.
> 
> Add the description of vdd, vdda and vddio back in for the existing
> upstream dts where vdd, vdda or vddio are already declared but, don't
> declare those regulators required - they are not SoC requirements.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

You got here ack, didn't you?

Best regards,
Krzysztof

