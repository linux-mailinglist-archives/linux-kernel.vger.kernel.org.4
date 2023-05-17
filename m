Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98BF706091
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEQHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEQHAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:00:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50438E49
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:00:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso6614097a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684306852; x=1686898852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAjF1NXEM4zGYNUukISUAOQ2ax8auRzyW2rSkhWnq7Q=;
        b=hdRkNFTlt7MrqcSUjSKPfU+olaNsYieuYS0HQkLfFKT5mhZcveQN8ic4Jt2GSaG6oJ
         PF5liBhs0A1D97/MnvEFJLvkmaVF0rL4AvEU7NiBtKDVhto2H8jpZRlb1Vmg+cAddNm8
         KESA/O5auVtRs3Yt0+aNA/zUT7NzWf3Zw4JhO+PBDpbFCmdqwWf0VQ4mGI/OkNz5vfYd
         lk2s1bYCEZJXGh1/OYzNvQPzTgOwJFQi8V9qk3i2i3fQeOICBa/O5vve1bjy+eyj7qUr
         t4XtJirJHyajJiOvfDzNrSmx9/3vcvmbhbOyWtVPBptzAOMFHXxlwTuJlwugdDt0Zucx
         pykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306852; x=1686898852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAjF1NXEM4zGYNUukISUAOQ2ax8auRzyW2rSkhWnq7Q=;
        b=X0vMmpGVNV3pbuwlypct4/cGDEoPTQT0lTZ1wWbiIkw8J28JJ59cYSFkXnUo9zmqGy
         MxfTA2RuQQWIqS7QoPGx65QAyOwycew6bbOd/wxGn/WvQCxSZZ3y1vXppUjfO/fn+peN
         +TGYg7ubVys2J5nBedbDpRyAc1BvX4MVkSCFPd6BTXsjVgUFvIslqlcmRutxDyEXKP/z
         0UowEzeZnPfNkYDS/yXSDIMachwwg2hBwjEQBmMwRGdj9GUX7P7nQFqs572JwAXMx7IB
         OluJ1gvnQ8PTlpcTxAUWjJ2uvIPJsnosaVthVlxE/mFsLO1LtW1es3IP3LrIEtidEte2
         fNBw==
X-Gm-Message-State: AC+VfDxn9rPdaO0cEIHrIR1H1xreJ+JBvFHqS+17jdq+gsFJ7VjcuxRT
        Q0sUzST1piz5VXJXIBOQ1qcrNw==
X-Google-Smtp-Source: ACHHUZ6BjmcvhdPU38ZrpUfAaHbkeuBu2xxSZvXzuVAHV3S1jyt12w+dX7YUyco99giSrFC0CW/q6A==
X-Received: by 2002:a17:907:3f0e:b0:96a:316f:8aaa with SMTP id hq14-20020a1709073f0e00b0096a316f8aaamr920201ejc.37.1684306851695;
        Wed, 17 May 2023 00:00:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00960005e09a3sm11866796ejb.61.2023.05.17.00.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:00:51 -0700 (PDT)
Message-ID: <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
Date:   Wed, 17 May 2023 09:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517055726.GA3165@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 07:57, Varadarajan Narayanan wrote:
> Part-1 is adding the 'const' entries at the beginning i.e.
> 
> 	+      - const: qcom,tsens-v0_1
> 	+      - const: qcom,tsens-v1
> 	+      - const: qcom,tsens-v2
> 	+      - const: qcom,ipq8074-tsens
> 
> Part-2 is changing from one valid syntax to another i.e.
> 
> 	+        items:
> 	+          - enum:
> 	+              - qcom,ipq9574-tsens
> 	+          - const: qcom,ipq8074-tsens
> 
> Without both of the above changes, either or both of dtbs_check
> & dt_binding_check fails. So, it is not possible to just add the
> "valid hunk" (part-2) alone.

Of course it is. All schema files work like that...
> 
> If having both part-1 and part-2 in the same patch is not
> acceptable, shall I split them into two patches? Please let me know.

No, hunk one is not justified.

Best regards,
Krzysztof

