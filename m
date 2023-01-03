Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CA65CA8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjACXtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjACXtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:49:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F5813F26
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:49:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso22017046wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzuSR66Slw5b05LQRX+L6Dh2f0E0qoPcnQ6jREbJakU=;
        b=agQyEtUFxmGDkoWjDyOI0o/0JqJACgRXWCKdkS/Q0xy3nHi3tzh6xENmQfiW6E07Ow
         0dGc5o+2Dcd3L8A33jsUDtQBQmDz/8LJfsxK+3h5bicVrnDXxg4gLDNfHVvOzl9rw+1s
         OFR573pi7R+8Me6Bv0/mS26YHdsOfPZ/MsDnZfbIppabS1DsMKXHTJDQpG9pu6ZRv27O
         fDXN6g+fBtD9+icYb27T2Jm0uzVXU9uZrKlNgxRvGG8CGE8uJ+BobF08F/KjcFPM1mAZ
         ueA3q8UFFjaL0LE6NmM2VfGmZW30KaXjlcoHcOmQ65PBTnH7BnzMw+35yDlC8NWkZij1
         biXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzuSR66Slw5b05LQRX+L6Dh2f0E0qoPcnQ6jREbJakU=;
        b=Fu0IXTXEUbKFti8WRFIORqqGmZLf6pQ3JMHqOfZZJ1craOMZowl0oH4WrH+bwmu39a
         LMry8ipplzxlFUgb1/KfRLtltC/Fi0hFgMoWawe5FkvJY+il4fCzCobuqvxMvOUpHDXU
         xlsUPjK4DtmHRXDaLpgHfx6syYh7msr/H0Lml1WlwIvOnctBzcckiAvWNh0fSDVTyNs1
         rl53RqM5JXq5iWPjlr3PmaK8QnqhYGeHo9EeGfE+eUbkBL9882hTj+I7zTJd6alHNbYR
         Z72a2sUuc4bBeRLulO+gUTXPa/1tHxjxQMOKrWDY2k+k9RZw8wfyHItPSxI3AQZ3KPDT
         5Iyw==
X-Gm-Message-State: AFqh2koy8ZQYMbW2ppVkX3ZZpYRpiK46KJYMK9nTu0HBudFTAIH5g3wt
        3+lSLipQl0nJ5aSnVzAYmn35sA==
X-Google-Smtp-Source: AMrXdXtK+qKI4wPxZ+4Hzl1jsGs9t3tiExxTJkvyc3L0CgmqC4vFQIO2kTCgUti8j7DGFEgLKnNdkQ==
X-Received: by 2002:a7b:cbd4:0:b0:3d3:3d51:7d44 with SMTP id n20-20020a7bcbd4000000b003d33d517d44mr32813918wmi.33.1672789739088;
        Tue, 03 Jan 2023 15:48:59 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k39-20020a05600c1ca700b003a84375d0d1sm54410904wms.44.2023.01.03.15.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 15:48:58 -0800 (PST)
Message-ID: <ca7bcae0-2427-fe65-92c2-9ca1f1526ef0@linaro.org>
Date:   Tue, 3 Jan 2023 23:48:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/4] interconnect: qcom: rpm: Set QoS parameters
 regardless of RPM bw setting
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
 <20230103173059.265856-2-konrad.dybcio@linaro.org>
 <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
In-Reply-To: <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 23:43, Bryan O'Donoghue wrote:
> On 03/01/2023 17:30, Konrad Dybcio wrote:
> I agree your code does what it says on the tin but, whats the overall 
> justification to depart from the downstream logic ?
> 
> ---
> bod

and can we prove with a meaningful test a behaviour change ? Better 
throughput ? Lower thermals ?

---
bod
