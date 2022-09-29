Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469AC5EF03A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiI2IUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiI2IUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:20:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD288DEF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:20:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v28so953872wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=R+SUCLs4kkbpBBxoV6+75r7Hz8DhI37YXfiFFqEYe2U=;
        b=joV1plGkZvwTOaLRJwZ/0QJcD8rALm+MIEEQMqJqn/WEq79+jWq85xpI4D8trai/Y7
         GXDfZY5xrsE3DZM6420cd9Bi4dAPI1R6iIIBWUK1G+iCoTsxR3WQioiad4/7BMYgRsXn
         We52b9q/8DP3xHufHAOfOaUJ9owZ/vk/+peDbsYS3z1v6kg7IhUO3BzaB5Nwk+93sIMF
         tk1VhJ1nkHjMCEZOGWeAeJsk1K/rjxScp2nbKbEKL8olqSqxqeaichxymgiemN2yg7ye
         /hQYIG+L9ZP0ucGYrBnGKK6xUHACnfNCIa8iPgXxD7HhPbYH1PkrVO5GZXllABaVW9Fa
         cOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=R+SUCLs4kkbpBBxoV6+75r7Hz8DhI37YXfiFFqEYe2U=;
        b=KBeUXOoWJCAgxdFMnzJZnqi72/pBU2GfUs5GPTashiZteGo3rM/nJuA1PnSYmqicos
         MnNhMuirgHG6GFO8xv5FcNwy8hIAgyUtFpVsl5XaTvLGjONOul0a1IJ9Q5dQOPTxNAo5
         Gx67DnlVUYmXVzILbQBSBa/7XxGJ+EZBKlipvzHgW0rkfhA4BvCbt+E3WVLm9oEeBZGC
         0A+w5JxFH4ZCGwCe1RPYsLGsmkH3dceAyKeqHCkyFDfb6kBkMa0dXRkFd6rOdkNBot3T
         R5kZYHVayKIH47h2tjtk9Y7SqLa0DbewO869LnGqt3eJsli9uuVt4mHhQxDI/UBE8/Jy
         X+EQ==
X-Gm-Message-State: ACrzQf37PIvnd/T/5LTqIbxGpEdFNiWu0NOgWiaLKjMBqserygTKvrMu
        nP/OYpbOaAz4eZjjnOSorTpM/g==
X-Google-Smtp-Source: AMsMyM48Xl3XmF55EfHMrLcGMFAlJHJczNwrO9zuYwS3EBI3phyAvOpY1xPuU+fQCR1X6Tv6u6cRwg==
X-Received: by 2002:adf:edc6:0:b0:22c:ca29:6c31 with SMTP id v6-20020adfedc6000000b0022cca296c31mr1279998wro.351.1664439609406;
        Thu, 29 Sep 2022 01:20:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003b5054c6cd2sm4858053wms.36.2022.09.29.01.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:20:08 -0700 (PDT)
Message-ID: <873cb152-4021-5aa3-d9d5-661127349fa7@linaro.org>
Date:   Thu, 29 Sep 2022 10:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/7] dt-bindings: arm: qcom: document the
 swir,mangoh-green-wp8548 board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-1-b6e63a7df1e8@linaro.org>
 <a58a4022-ab21-6833-d13d-c3f35fc7caec@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <a58a4022-ab21-6833-d13d-c3f35fc7caec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 19:53, Krzysztof Kozlowski wrote:
> On 28/09/2022 11:14, Neil Armstrong wrote:
>> The qcom.yaml was lacking documentation of this board, fix this.
> 
> It is documented in:
> Documentation/devicetree/bindings/arm/swir.txt
> 
> so remove that other file and instead describe it like a conversion.

Ack

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Best regards,
> Krzysztof
> 

