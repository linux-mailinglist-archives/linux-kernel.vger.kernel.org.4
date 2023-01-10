Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FD366500B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAJXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjAJXrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:47:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620161DF37
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:47:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bq39so20983675lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qqp4HHvF1xCYDUBm0QeC6QjpQDW7WeSW4baqDQqT6Vs=;
        b=oM0TLJikeZthJrnw2UBYYmiUMKwc87jlIoIC1tSZEtNEPfuN6VdCRgJfxjDKwM8PN3
         cIk++CCBVmaBs3x02X4dHRt3shlzP6LiyaFSKEZ/RoWdS5EeYbN/sUCdkJFZ8anhkJIf
         +yq8Kc1McZV+1oYjyamjHV52iLpzv7J4ZU5SWr+ZBkiPuXV4UMpsvib/0p1LHA9oMMkG
         EirExXRgdPr6NyadeQXFwyTd8wznYLn21UFkb/tCNGI1CSVEu7ihbo4bjupxCb5FDvgY
         SgHIL7UPNtbzGW1AsHFPhqLr15uEdBuixyP2hI3oKcj+JqW1DQNbNVmq5AW/Co48JKNj
         LBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqp4HHvF1xCYDUBm0QeC6QjpQDW7WeSW4baqDQqT6Vs=;
        b=VNJm+Y4/LQD5XlEfO+DzKcVfEVTBgbUnkA3opGF3psA2k1p777jCGS+QFHlpubDJMB
         7tAXMiBgF0yIYPnzSi5//4nVU8RLFENREVd/pTJDbYdI+TlGyHFWzk0judLggOWghQz6
         H81s8BRdFAjBkskq73gx+YUxD3RuIyD0LC8iJc5K0oj60SjPImvY/4N4Lbr+BVcsQ5tg
         AVa1g9XXeOCGDaizpAN/WNWJEolB0pgQD6FV9QTBxOII0zwxG9qQbacLy5+DvDSW6gHt
         5ZGFt9rH8BAkUwsalTyX3a9eda/+GKxqB7WaXILW2ZgDRUfJ5/ekKmSfhtHVQJDvg0da
         4c7Q==
X-Gm-Message-State: AFqh2kqQ1hBbNLETunNFxedG4SsSQnztgCXo/71qa2mlJG9rQb3PMeQx
        fn+P5plwFDxTd9u2h/Kztwq7cw==
X-Google-Smtp-Source: AMrXdXuTHr0dP8y2n0RzSwl/Yew/9kfqkmE7+NXj40uUsiHwr7acwQu8RyhbqSL+XZmJtCjLVkjzhg==
X-Received: by 2002:a05:6512:b92:b0:4cb:1645:7251 with SMTP id b18-20020a0565120b9200b004cb16457251mr17634574lfv.62.1673394433698;
        Tue, 10 Jan 2023 15:47:13 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id g2-20020a056512118200b004a27d2ea029sm2407254lfr.172.2023.01.10.15.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:47:13 -0800 (PST)
Message-ID: <22d4bd3b-1b36-8ad4-ca19-157597949a21@linaro.org>
Date:   Wed, 11 Jan 2023 00:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 02/10] interconnect: qcom: rpm: make QoS INVALID
 default, separate out driver data
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-3-konrad.dybcio@linaro.org>
 <d8a7e477-f612-19cb-8573-5cc0449df0fa@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d8a7e477-f612-19cb-8573-5cc0449df0fa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 00:13, Bryan O'Donoghue wrote:
> On 10/01/2023 13:21, Konrad Dybcio wrote:
>> +#define NOC_QOS_MODE_INVALID_VAL    -1
>> +#define NOC_QOS_MODE_FIXED_VAL        0x0
>> +#define NOC_QOS_MODE_BYPASS_VAL        0x2
> 
> The basic fix you are applying here makes sense to me.
> 
> But why bother with an additional _VAL defintion, you have your enum.
Thinking about it, I was probably confused by MODE_INVALID checks in
qcom_icc_set_bimc_qos and only now realized that it's not even called
with MODE_INVALID.. Will surely fix!

Konrad
> 
> +enum qos_mode {
> +    NOC_QOS_MODE_INVALID = 0,
> +    NOC_QOS_MODE_FIXED,
> +    NOC_QOS_MODE_BYPASS,
> +};
> 
> ---
> bod
