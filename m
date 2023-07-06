Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14974999F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGFKn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:43:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F1171A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:43:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9939fbb7191so102712266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688640232; x=1691232232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlDMTzsKNMidmUdvGl8KWau1B0O61dJBW9y0FhLiN4c=;
        b=CntR0Z4AQaH70ULKuK4ws5fg8VwI6RkXvH/jM/35U1758RZQOBz+3Kj2dJumsRIIZq
         /n/z4sW9I+ya/u39JaJgdfMEJqKWc7OCC8ooMwwtu/ucwdQuMGXL0dNGPCevGWrIzmgY
         v+ijlbpPBxIzFnH9l96i7ph4AFFRwAYZM1oyVRPnhqiFAvSyDMwk6qSVvw5mnqnwfizv
         4AgHNEaelytnFYwKpJH35pRLjuKDRGSqIsg5lhrLdhmbQsI9vVepSJEr5SK2b6DqbgtC
         56joC4SU4gKbmuIPUDk99o8/oVl0WLk+INUffmsJtyJXnhqDA20IiGlvOodjxo+9Aj0q
         oEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688640232; x=1691232232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlDMTzsKNMidmUdvGl8KWau1B0O61dJBW9y0FhLiN4c=;
        b=SPfcC/6sFSQHSO+FrYt5BM1uzTpyPKL7TIxKsPcGoNt1FGeUKr8HjYMXFvlxTUX1mR
         sLMP3Gv2IOaFifAMwQp8INAjNWYHRL/npoMrAw/iTmxtt0ofa3twznUqZGfQZqFccRKI
         v2cRXEyXclFQ68jzp7ddB/PncKmy+TPEbHCMysgbGdhnMO6KRkK27vl2RHKT3wjtHWn1
         xJ9whzFHYwatNdnpvzwE7eWY8K4L4E+dFJ2jjGaBBVB7RoGCDdyzENnL4+Tx+zq49L5d
         txLA/VP1XpBS+fwGuGRKjluMj96MVJ6vQ3WGVArD36qGAqSvwzHqlAHYXk0AFX/2UZGJ
         9ajg==
X-Gm-Message-State: ABy/qLY84RyjAlUEI5GMNjnUvkuryB0/3cC/0Oh4pmEZGEOCd9/98YWq
        6WXio71n2x9mKmjF/8H3KcmIwg==
X-Google-Smtp-Source: APBJJlGj3/9m6yl/nRf0ABw8E5K1spIchFLi90TK/GD98lFspv/f0NtTveCxXYHXGF3dtw3kBg2V3Q==
X-Received: by 2002:a17:906:6a1b:b0:98f:450e:fc20 with SMTP id qw27-20020a1709066a1b00b0098f450efc20mr4598238ejc.17.1688640231840;
        Thu, 06 Jul 2023 03:43:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id pv11-20020a170907208b00b0098e2969ed44sm633935ejb.45.2023.07.06.03.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 03:43:51 -0700 (PDT)
Message-ID: <97f2bcd7-cf78-d4e6-7c5f-672ec8d4d2c5@linaro.org>
Date:   Thu, 6 Jul 2023 12:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Update PD Macros
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <1688635428-25127-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688635428-25127-1-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 11:23, Rohit Agarwal wrote:
> Hi,
> 
> This series updates the PD macros for the Qualcomm chipsets
> in the devicetree files based on [1].
> 
> [1] https://lore.kernel.org/all/1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com/

You need to clearly mark dependencies also in other patchset, otherwise
this is unmerge'able. Specifically, the header changes should go with
DTS branch, so you need to give proper hint to Bjorn about that.

Best regards,
Krzysztof

