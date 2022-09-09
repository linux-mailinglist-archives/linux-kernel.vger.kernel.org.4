Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6C5B319F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiIIIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiIIIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:25:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D47AC06
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:25:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m15so1434192lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FdkeN45+bpzn92GuTJsvAHffS0/CIgbdMCx/tHdOYZc=;
        b=jaQcvdJRg763YYgdwLo8KSl1ulYiKmO6nCev7fjRJSfsDBd/4r5N5791QcL3at27EK
         a62cQDjK5HiUYjDxqcoVF+iPFiLO0uoZ4Iur3BUyYnVU1YXWTfoU4aDAwkr5cHCebiuc
         DKKqgubknUvBciYoh0PY4+J+jffAZ/DiOFHFMfHWilrj3/5IZJJmA0GLRMH7ogtOh3XI
         2ZR3BYVtMTzj2sS9sBXOY6tnAgsyAnOnfgzBn9V4myili1RXukmd61bRzzL1xKzrWqI4
         rtGJUBOTYiAu4tCDJgycXBan998pVXshYtbeQURg07f6TLC9NoIdZwakMMeYn6+2nXDv
         eQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FdkeN45+bpzn92GuTJsvAHffS0/CIgbdMCx/tHdOYZc=;
        b=lDDChC1l8ilebZCv7fyTHf1Ga0jZncdo2AL+XpHKsVQw3RGBi9CDbtmQH/evYKaWaJ
         8hh3sQseOLJfmGCJwwrgtNiHNm8G/4Taf2Uirlu+B3pKItW4No5Uel4Q88txt1eqPp51
         1qL4mt+4Za5JTxiGhYtMN1CJbHTLEjrjwxyhVj5frmWsUVA37X0q7KZVEMb5FwlGAkoD
         +E9z7nsxmmWG3QDuy562ZJWRvDZOrJ2GdlEQo4ojDeO++mU7w/LBBk6oUIXMiBWufQOH
         vfV3vrRsN9y2hEcwR9A6/YhoFeh8D4l4xfhGroS1xkM1zwUbfGKbGKCXXa2W+eALfbw/
         oNyQ==
X-Gm-Message-State: ACgBeo1Z/aM0bPAHyKpgDzr198tOSu/hEHjz8l8wdFIQmwu1fjZL1fw6
        BtLnWUrBcks8Y8Cx7HsGecc0Og==
X-Google-Smtp-Source: AA6agR6sXGaQC/MGJzYgm5A/kkMiHKD4dqdS7hGBSaJrUpLAeb1q6i/CUX1vmLcbcRKk4rCOrB8OiA==
X-Received: by 2002:a05:6512:159a:b0:492:d0c8:aec1 with SMTP id bp26-20020a056512159a00b00492d0c8aec1mr4300245lfb.275.1662711940468;
        Fri, 09 Sep 2022 01:25:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f11-20020a056512360b00b004946c99e78asm170519lfs.277.2022.09.09.01.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:25:40 -0700 (PDT)
Message-ID: <fdfbe7a3-73c5-01b1-1d71-3ba3c1f6f143@linaro.org>
Date:   Fri, 9 Sep 2022 10:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: split beryllium dts into common
 dtsi and tianma dts
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
 <20220909035447.36674-2-joelselvaraj.oss@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909035447.36674-2-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 05:54, Joel Selvaraj wrote:
> There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
> The previous beryllium dts supported the Tianma variant. In order to
> add support for EBBG variant, the common nodes from beryllium dts are
> moved to a new common dtsi and to make the variants distinguishable,
> sdm845-xiaomi-beryllium.dts is now named as
> sdm845-xiaomi-beryllium-tianma.dts. The model property is updated to
> distinguish between the variants. The compatibility property is
> moved to the tianma variant, but it is not updated to avoid any
> further conflict with other projects/users that might depend on it.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
