Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44366BCEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCPLyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCPLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:54:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904ECB79E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:54:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j42-20020a05600c1c2a00b003ed363619ddso1841457wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678967642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uFoBC91q5VOOAd9taKsYCtd+FrLnQsGWtXFX+JEaiE=;
        b=jjMDXSIXZzfRTYSnbX9Mr/KdIc0QFnzYdAQ9S8ArgGTUCs1WFd5qLtP9xIQIJcnfRl
         +kCWYNMbCSGF2Q3Yn04z3qB3Kh1acy0QsQVzpRjxA7uSyWhHrzd2GjknX2UoKf7Jp+Xv
         vtncFNEY1Kd7l69F25oh5mmfjRdjDEVuvofIOt1izRtW/mMfhbGR80tyegJQWyyv/zmY
         MmZ/odykKrmClKh9um570beMx6Qp9AgXYik4ASWBadNI17upijzCNLfYokdZbMhO7/Un
         VSzTHbzGBVRZmOVISJqhGeC1vvaFdJmJxqpGH5p2DcjGOO3ArEe1rQqapmkw1bISeyEO
         Kiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uFoBC91q5VOOAd9taKsYCtd+FrLnQsGWtXFX+JEaiE=;
        b=ul5zLRF9kh2t+QI7l6GpDGDt7tYyu4hE2verSTN21+vpflUP+dew0alFJwJYwY4jMC
         LR51YMt9HAEpGBsORM5G9S90ANdYbbqmE34FRelU8zjoYLLY5nl7rSAoW8jTwTO3uwXW
         ScLszzChRp4jiM2lZJW1bdgZxKnV//DEL9qaCb6TPnHROmreMeEAVMhmW+Bri4rjFhg2
         JrfDaehLQLg7AlCmDc1r27eqtSLOzf6/EEZKwEaqNtcjanqHm997M8GUpLKS/70RREK0
         woKP21WpNsDlMmg7Onxhccnp5eoOEzwwA894/qBCsaq5GSnd+b46UY+ABnW/1Tfh9mbu
         VxHQ==
X-Gm-Message-State: AO0yUKXyt8JdMy+jremwAoY+bV+JONmPZRc58VxSBqjuKR3vH/Hnl9No
        LDktYwNJCkZyIUEacBjjHUJNSQ==
X-Google-Smtp-Source: AK7set9Hrt5RyoRlxpHSmE6khdeump8dTgY0/+kD7fmRmozJMoSKNdoEVqtZwQHDJhcw0jetX5Hx8A==
X-Received: by 2002:a1c:c907:0:b0:3ed:4f7d:f6ee with SMTP id f7-20020a1cc907000000b003ed4f7df6eemr1979671wmb.14.1678967642038;
        Thu, 16 Mar 2023 04:54:02 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q22-20020a056000137600b002c71d206329sm7006900wrz.55.2023.03.16.04.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 04:54:00 -0700 (PDT)
Message-ID: <e3805411-170a-759b-3608-7f53464641e8@linaro.org>
Date:   Thu, 16 Mar 2023 11:53:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
Content-Language: en-US
To:     quic_vboma@quicinc.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
References: <20230202064712.5804-2-quic_vboma@quicinc.com>
 <20230316081509.12201-1-quic_vboma@quicinc.com>
 <20230316081509.12201-2-quic_vboma@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230316081509.12201-2-quic_vboma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 08:15, quic_vboma@quicinc.com wrote:
> +	if (IS_V4(core))

Hi Viswanath,

Could you please take in the change to base on on IRIS version and 
rebase your patch on _that_ much at least, not necessarily all of the 
changes in the series below. Dikshita should be able help.

https://lore.kernel.org/linux-arm-msm/c9c324aa-6192-f878-9189-635626e76b13@quicinc.com/

IRIS version is more granular/accurate than V4/V6 etc.

---
bod
