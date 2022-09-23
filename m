Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98B5E774B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiIWJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiIWJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:35:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48618C009
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:34:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x29so14009994ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GWmHghJUdd8nlM9IdLaudhwp+t/jqWHBWVH9O9dLOKE=;
        b=C2WjIgHYXxv18OFIKPy3lVch4PIjcXQlbxyW1jWOTtQe13IyFAS/RHH0RjM1kn6MP0
         Rf/ZQSX+9ImZTq3Eh3f1yOynjCuxS1zzV1S7qicSB748mgnNXduvYuz5GZ153G8LeKWa
         OoOHsoldHhDiaAf2DD1qJKTOdCIUkM5rvTX6KNCDuexlbXga0C1xFK6/nsJXYG++1Adh
         f1qQ//toknSjifTsK5zVcOdpMy2aOwgBKgdbpIUc0R8GFcB8u5+AYdF8Qjif57UI00aE
         wWMt0yCOqzBv0zv1t4itiERrOr1PyVxUd02/0523pvJcYh/uPm0r/b5q9YHvtZ2/mfgu
         FItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GWmHghJUdd8nlM9IdLaudhwp+t/jqWHBWVH9O9dLOKE=;
        b=mEKZQorS31T2Akc/u/w4Bo8w8sETkW3gx9Q02O1EDkdRI0n/Lw3mQMJHpEjgO6X9lv
         4AtLBfU2Cv/wqVYmV8GxTMRy7Gd45O8sFNcsLkXOLh28Ij8JlJN2anJ/vsdYAWwtOUEN
         7Huk0Zff2NSykOFyEYSCThKaQ8Krwo4KiB4VTKjwmy5IKb9nAp3zUUrLhbj/1APVsaqH
         N7PbQ7AOzBqj5UxRrYv25RbiNsq1FZkvNGVGIyaGdOTue6HrV4/LI7fw9R4vOp811CyW
         iOAlnQS0IsnNuN83IeVsLZptX0Itak/vvg5PwFSy07HcQXInhRNmwvJEb1qAydmDsAoR
         G2uQ==
X-Gm-Message-State: ACrzQf018r3SaaYj/AwNjlMtbu3uprmfaniCJzB0AtCYHskpK/AooZBL
        MSE76c0gBZVflF4VRPWdcSa/xg==
X-Google-Smtp-Source: AMsMyM5lblJDJzn8tEfG+3848XjLbn/5TtxVBk4EfcFkRPwhzpbqD58iQ5BLW/wbN0JgLCcqWdn/6A==
X-Received: by 2002:a2e:a594:0:b0:26c:53e1:a609 with SMTP id m20-20020a2ea594000000b0026c53e1a609mr2389562ljp.302.1663925693958;
        Fri, 23 Sep 2022 02:34:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t2-20020a05651c204200b00261e8e4e381sm1304329ljo.2.2022.09.23.02.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:34:53 -0700 (PDT)
Message-ID: <054773bb-8e5a-d8b9-16e3-50ccbbbc0a5e@linaro.org>
Date:   Fri, 23 Sep 2022 11:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Separete LTE/WIFI SKU for
 sc7280-evoker
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220923061756.2557403-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220923141624.v2.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923141624.v2.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 08:17, Sheng-Liang Pan wrote:
> evoker will have WIFI/LTE SKU, separete it for each different setting.

Typos in commit and here ("separate").

> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
> 
> Changes in v2:
> - change Cover-letter tittle

cover letter is not related to this patch, so this should be "none".

> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Best regards,
Krzysztof

