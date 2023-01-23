Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678B677707
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjAWJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjAWJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:06:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8601CF52
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:06:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so8424635wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qT8VDBW8UHV1yeROoYytlmMrV/nocyFgzQx6EY9sPnY=;
        b=jjzItVrmtYSP2PpXag6KstA4FOPzDGtz6YMFxZsr4Gijz59RpZhR78fbxGVOau4cYn
         jsUmxAdrdOzn6rxVs8KDRW0vT02V2XKhgfUTvZLYbwyWp/0tliNgGQ8MReoFn5O8b3SB
         YfQF5wztIxmuzYtN/RZvXlDPE04pZO6TmKJ0m3jxrjyCohKrZeC7K5Z1yWjPKNZRVej0
         uC2Y0OPY1EgZfOpv7S2iHe/ErtuKOP/OcX2ar+sBtPdqY7Aj90zi7EmKnXQV+SrFRkdf
         TAQjSqn9pUeO9R1oz1p230DiI6YuLSVdYjJb7oj6inpAgzWsDrDU/VEu2aY/gzVJFlfN
         WlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qT8VDBW8UHV1yeROoYytlmMrV/nocyFgzQx6EY9sPnY=;
        b=Zk9S/7wYiEimxubp5b6JpVJW5o1Vs83kGc7zAj5+7vxSoMU0tiMKcotihVal6t39GP
         IKETennKIPK86V3TocX3fzAdyn2+tc7jIQ2xKH/uIacKS710rA86sWkh8aMQK/CUi96q
         GmqDfgNmLYVEyE+hN6iv8HTk8bq0yd/6/Eno0ELZA3HCQ4MucbCR6Xpw1g9O2TMH9sdR
         V4M14TOge2Ce/h1cb4G21YKJ0wt3aNAIH1Sd3hNR+z5wnUT2knJNggWKaXfjFccjpHgM
         e4CQ34e5UhSXUCIfYP/XrkkX5tmvb9uF0FAwekxBGBPq1STfBtbR/M5KnpjXfdzeIy6+
         twiQ==
X-Gm-Message-State: AFqh2kqsCkei7K8zcfKauPmpk8agaHAtw0tleMEzUePfA5GxXW53/8QF
        lfNDe7I8PFg2lUNenkghi5INqA==
X-Google-Smtp-Source: AMrXdXunP3IY8eNNyaGERglsQ226d+VylGRf7gSuCDniB/ieNQkaZEMQ10E8CUjEXXeeTxz3iR3+Ow==
X-Received: by 2002:a05:600c:4395:b0:3da:2829:2935 with SMTP id e21-20020a05600c439500b003da28292935mr23145718wmn.11.1674464779681;
        Mon, 23 Jan 2023 01:06:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003c71358a42dsm13964289wms.18.2023.01.23.01.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:06:19 -0800 (PST)
Message-ID: <c00e3e15-1d42-8851-a17b-0c488d245ca1@linaro.org>
Date:   Mon, 23 Jan 2023 10:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: msm8939: Move msm8939 to a
 distinct yaml file
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-2-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123023127.1186619-2-bryan.odonoghue@linaro.org>
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

On 23/01/2023 03:31, Bryan O'Donoghue wrote:
> The MSM8939 has two DSI controllers as opposed to the MSM8916 which has
> one. As a consequence we need to document some additional clocks provided
> by the MSM8939 GCC which are not provided by MSM8916.
> 
> Move the declaration of the MSM8939 super-set of clocks to an MSM8939
> specific yaml file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

