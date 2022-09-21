Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D14E5E53B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIUTSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiIUTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:18:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6E9E697
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:18:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a8so10796423lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4K6JbV5ZwU/7mQCZXcGP3t4pUNp3SX7Jex1JLDsoBRU=;
        b=zDhkW4sUuaJHrN8n9JuLa/iVLeeW2yQFpz47ihw9miQv+EzlXs2Hy9WbDHfn8GqZ2K
         I3OEB/LrDi/G4QBcx9DvUM/wicO+9RCOErO0VmA+BuHEEBU3IjG5fSip0PwypoHXpBz2
         MLhf4DY1zLerO3YCYBiBGI26FzJaObxi50rJXx86W4lB7sBGiECgdHArhwSHzFM1rKHB
         oNmNCT/09cRKbwtzbMME57sZWEyxt2w91i/3MzaoyjIgdo8jOmnO6uMbieMOqvrsbDoi
         S1SOJGfE8mhH5tUM5wdAWAHt6ZygSLpmXX8/a120Juvch+pjwkXR+w1NnAFwneupappT
         1A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4K6JbV5ZwU/7mQCZXcGP3t4pUNp3SX7Jex1JLDsoBRU=;
        b=z5een2sEfXA50ygOHs4nC2GXa6wtVL2YjsSbk1jkLAiMhwuXO5O+Jy4ci6uyt1GV0U
         vFmW1J5sFhcVTg1waMI01FdsfRECdqNnlEFVQx3oKUFr5sxhjZdXnf1Jr2nVyOg0FUp6
         7nGahAnkHsLude1fc+QpW5YOQ5oHMbTwOEgM7KsxUb7LfhVuCOiOIIys0CQtUR0l9YDM
         Zx/l4T2Hy1jFn40RYFZXsg29mRvssfPUkE4UPU6J5jKkLjhUyIqNTuQBBPjnyebUoJB5
         bM/HqygWOjWLgkT2VQ9FoH6kk9fWHr5c+KZuTfMN/qMfz/F5PAf8iZgoiR+3QUoGmoEj
         ZTCQ==
X-Gm-Message-State: ACrzQf1rxLsngVJLi7XQKnjWdMlcVv6rKVkhoPLYS210vtCskY1bTZb+
        XnjoBphGe99UrHK5PtPL4hd9Cw==
X-Google-Smtp-Source: AMsMyM5Za7gbwIymx5nD8zXUtkkscdjID6g8aEvDflEe+xhj6/0NmEK4gdMsA2vZ4vV3wht4IwIehw==
X-Received: by 2002:a05:6512:308e:b0:49b:9015:e76e with SMTP id z14-20020a056512308e00b0049b9015e76emr11626400lfd.393.1663787929329;
        Wed, 21 Sep 2022 12:18:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i1-20020a2e2201000000b0026c0158b87csm561903lji.29.2022.09.21.12.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 12:18:48 -0700 (PDT)
Message-ID: <39dd7679-3f60-ee65-a6aa-cd426cd78fed@linaro.org>
Date:   Wed, 21 Sep 2022 21:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 0/3] ARM/hwlock: qcom: switch TCSR mutex to MMIO
 (msm8974)
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
 <4768567.31r3eYUQgx@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4768567.31r3eYUQgx@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 21:09, Luca Weiss wrote:
> Hi Krzysztof,
> 
> On Dienstag, 20. September 2022 17:04:11 CEST Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Remaining patches from v3:
>> https://lore.kernel.org/all/20220909092035.223915-1-krzysztof.kozlowski@lina
>> ro.org/
>>
>> Not tested on hardware. Please kindly provide tests.
> 
> With these patches on top of 5.19.9 everything incl. modem still seems to work 
> fine on msm8974pro-fairphone-fp2:
> 
> (2/3 & 3/3 from this series)
> ARM: dts: qcom: msm8974: add missing TCSR syscon compatible
> ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
> 
> (picked from linux-next)
> hwspinlock: qcom: Add support for mmio usage to sfpb-mutex
> hwspinlock: qcom: correct MMIO max register for newer SoCs
> hwspinlock: qcom: add support for MMIO on older SoCs
> 
> Tested-by: Luca Weiss <luca@z3ntu.xyz> # fairphone-fp2
> 

Thanks!

Best regards,
Krzysztof

