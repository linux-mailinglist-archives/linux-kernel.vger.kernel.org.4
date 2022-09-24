Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD605E8A21
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiIXIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiIXIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:22:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227FEA6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:21:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q17so2308370lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nTxsfs2zXjNjdXC7XVmLXrkQUhLVp82wU25VhknIpH4=;
        b=ynNb8KlX2ritczYckVbPo4eOPezJri68TZc/oUPtq/rwBes51UjQhgsQ8reD0tvAqN
         YBrPW/KWDfLkRdb7RKjKPN2aOnkWBwSeykUfe4jWkryU360jbsafuglDEjgm7QD7S4Uv
         2Fl/Isu2VnpH/ZfUkTYhqK0dF7BDUzXNtH+GbBKwDandbMolSiy7kIlOP/pk4os4U2j6
         GUry62CYGAFmJ+wctaXWcc4ENrV26MdDUPovPICZ7rO81yjlOKELqQ2+kGze25HhwwGn
         pUyS6IYLUuMRs1YCWk6qwhXK+zyK6NGzZ0qXwYo5Xo+Soqdo2akkVbvqp4Uyqz0hTGYt
         FuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nTxsfs2zXjNjdXC7XVmLXrkQUhLVp82wU25VhknIpH4=;
        b=XbbBPwqqfHItSeZ7WiqY+m2yQirlGjv8w9HDJrBscQ2WOlI8cS4nFFE11ar59BQMfh
         tbzAMmqkJgSIHq1tf+kbfymzXc4lfzj0t38al+rEHZmiD08OIMG91itdsRb5FmhvyjwD
         607MRUpmocDCtkL4JsddZdKDnLnGuSxy3HHil0nOmgymAWfwWGTVHTp2Ppplewq5apYv
         /9NLLrNHtvWFOXRndMg5A4IGf2dyft8Q5TV1B72p/Ua6GJBkVuWjSdJnRTyCxrSkc2Hq
         GsNBCMGJs4t0pn2HyM6xm7MYI28vFeBznU66IdK58eMfe/JRod4XitIwMfJLjtRZVio3
         XtiQ==
X-Gm-Message-State: ACrzQf2rf5UFTlmH74AjY255bL9K4MEC3GER/SayG76gHEWFeAVsnV/a
        wkj67qTcQdnsS9WaJeCg9YYmyQ==
X-Google-Smtp-Source: AMsMyM78g/pGqRaUod7u8K2nn2DBlqXMJ91Nw15TnPerkAemk9J8gGtMYf5UQu/I/jU++W+/Gsz0DQ==
X-Received: by 2002:a05:651c:a04:b0:26c:50df:75ad with SMTP id k4-20020a05651c0a0400b0026c50df75admr4100970ljq.416.1664007680598;
        Sat, 24 Sep 2022 01:21:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e3-20020a05651236c300b004976809d6a7sm1810430lfs.283.2022.09.24.01.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 01:21:20 -0700 (PDT)
Message-ID: <dc0ef30b-0c99-7086-7b49-755f51fe9668@linaro.org>
Date:   Sat, 24 Sep 2022 10:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] bindings: Update maintainer's email address
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 02:36, Guru Das Srinagesh wrote:
> Update Guru Das Srinagesh's email address.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-

Use subject prefixes matching the subsystem (git log --oneline -- ...).
Here it should be "dt-bindings". Also describe who's address you are
updating:
dt-bindings: Update Guru Das Srinagesh's email address

With the subject fixed:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

