Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F92733791
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbjFPRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjFPRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:42:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C22D4C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:42:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9786fc23505so134784266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686937354; x=1689529354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzife/Ga92KPfU7PxiFcBGMF+Tc4zP+RIFWwh5m1s7c=;
        b=YG+LJ62WNuMOGkE6EoEI92oUfLgdHJgX/EjN8Ld80jfUl3qvIpuHcDgeWC6/XEhr3O
         h3HPKixTNv7Fz3j1bptLYcdX2mvA9RFci62+MiCmi+g1Xa1WKGCe1GPj3vBqEpVOnVwS
         LPdLApPxHldnVRsZdm3q+Cw0BFB3K7dyy64wWq54vzhUMHCh4my2/IjxLhi2xZ75KBhX
         nKKZet2AysRtYyOtEJZaBa6eOb50qF5TrB6qEUk8O37us/lOQiYOe/wwaXXdASn6z18O
         rwnx21Qzu1CFiVM+kItVQ3zKRnJu3Z9vpIFxR2KHSYxquDSzjp0lAz6T9lPT/9YhYhIM
         TMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686937354; x=1689529354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzife/Ga92KPfU7PxiFcBGMF+Tc4zP+RIFWwh5m1s7c=;
        b=f4FpvraAAYaAHWTHVDRdJPff6t+wpieTImg16g1GC7z8a/q756pl7TwB+VnlM1+xAx
         8kqJSgJgFutyZV/L+dtZ1Sjbwr9Mo4b2Dw84Dh4lbz+CduSIFJdh9TR2TY2RhFKqMtKR
         UadWWtupHRXgzyuQV6Pn0PgOWf38rBIaBxcE8B36g3zqyD7A/QMayQDgFdyLkwTFP//r
         hF5mdmM/u1yuYo1abirCRCJ3A6oBmJqGCSgP2eTB21dnCt9U0rNwS9jHz81EfrCEg7rx
         HkxPtrFiqoNBOzf6w9s8yefziHkcp7Ns6k2VduoGdLAF4dwRpt54+JtX7Qw9lSVx3lBa
         vR6g==
X-Gm-Message-State: AC+VfDyVrtT3he9a2XVqhpa32EyCL82ywF++rPhoqKGPHr86PWG6sI9G
        tWajpuLYemEtTv8DLW0aqLr+KA==
X-Google-Smtp-Source: ACHHUZ4Y3n61KROIK4ccOC0xSeZQmjKQhp+TTdrpdIlIthZMT4ClAAb9Rw2x5HyJ0MEYGpLLlXWi6A==
X-Received: by 2002:a17:906:a8f:b0:957:48c8:b081 with SMTP id y15-20020a1709060a8f00b0095748c8b081mr2181445ejf.24.1686937353847;
        Fri, 16 Jun 2023 10:42:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906684d00b009828dac8425sm3043094ejs.105.2023.06.16.10.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 10:42:33 -0700 (PDT)
Message-ID: <fbe7d37d-8a22-6d34-660b-70f177c001d9@linaro.org>
Date:   Fri, 16 Jun 2023 19:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 00/11] arm64: qcom: Enable Crypto Engine for a few
 Qualcomm SoCs
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        bhupesh.sharma@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, bhupesh.linux@gmail.com,
        devicetree@vger.kernel.org, djakov@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, rfoss@kernel.org, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, lkft-triage@lists.linaro.org,
        anders.roxell@linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230412115532.300516-1-naresh.kamboju@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412115532.300516-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:55, Naresh Kamboju wrote:
> 
>  > This patchset enables Crypto Engine support for Qualcomm SoCs like
>  > SM6115, SM8150, SM8250, SM8350 and SM8450.
>  > 
>  > Note that:
>  > - SM8250 crypto engine patch utilizes the work already done by myself and
>  >   Vladimir.
>  > - SM8350 crypto engine patch utilizes the work already done by Robert.
>  > - SM8450 crypto engine patch utilizes the work already done by Neil.
>  > 
>  > Also this patchset is rebased on linux-next/master.
> 
> These patches tested on top of Linux next-20230406.
> 
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


You provided the tags for entire patchset but it includes different
boards. On what boards did you test it?

Best regards,
Krzysztof

