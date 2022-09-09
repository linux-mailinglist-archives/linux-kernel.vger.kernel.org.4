Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0845B3C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIIPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiIIPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:42:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A24C6D56E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:42:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq23so3359270lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YImkMqsDB4QBZFr3qfoaJFMGDrNj1JUk+BlTGRuyEpo=;
        b=bzAkpKroytpR3qI7sQ0rrB7ib4rQrvIZ2BFv0GFivIKdSOskbu/J6N/pDT8C6/VrSO
         +tjRCci7OYX32xQj/gRBcpqHzZwZIhkI94IbVO+xndI8Pa4AJ3fTVQrBXHv6QAWk3fzy
         MRbQ3NTxpwAS7EoXOJn4HYbKNVqse41sKSmfcqMXpf+UwUE+0OQYz/+yH+ZmtpSttROq
         Dd9YjF2Ejhv8aSAmc+hDhOu9ARlWrDlP2b6xfT+LjdeDd5cYZGDqypvErUw/lrGTG5/l
         +5uaQM5mevmfdImcCUFEkx9fj4sD5y+PQDKwqrPa+XTStK2xugTQPxl/XW3YN5YXKX2F
         LJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YImkMqsDB4QBZFr3qfoaJFMGDrNj1JUk+BlTGRuyEpo=;
        b=1sHcS8rVHthIwLyjnTl/Y1KktUfAx55m0b4kaDTLtmGY4oqJ9rW3O7ESqo4Q4rmZg5
         LcyOyX0dVnNt5IyIY5fHnFQoj+0CofX9kjbz6UlRCoMKMqZcrKZkfRdW7ZwJkqHAmG8T
         kHk3L/EAsAjgcI7fhS4hJtzTIsO7HqYDKLI5RSky78VpZ+Bx+DaNpG+mOdgebwrkIZ21
         JAdeAgkweZL1KNSZSPqvm5cQCEXiGVW6kfMNi+K7amf2gFmY3X/3V6q7H4fJkE3Jm5zw
         GO7G9CmUCXyZWz65dZdJqmhd3YNJoTeUwThxYAsyucnffLHriGVNfpnOIO5CQB36DIHF
         4Krg==
X-Gm-Message-State: ACgBeo0vwx/kXIflnIZzB0HdbCifcn1PpsorEFYb+RfaaVuRDiz3XYXP
        /E9gYVS3p2FqG2fhBomwYE7maw==
X-Google-Smtp-Source: AA6agR7ted8a2yjv2Kq3DTMDlx6TQoYmH5W4UmDVYcGZ11H5Q0T2OzMmKPbE9iubCyO1Y7JWs1IxWA==
X-Received: by 2002:a05:6512:1115:b0:497:cd1:463 with SMTP id l21-20020a056512111500b004970cd10463mr4442277lfg.24.1662738125688;
        Fri, 09 Sep 2022 08:42:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a4-20020ac25044000000b004946a38be45sm130063lfm.50.2022.09.09.08.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:42:05 -0700 (PDT)
Message-ID: <84cb315f-dd55-53fc-3e3f-1e18f7916c99@linaro.org>
Date:   Fri, 9 Sep 2022 17:42:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND][PATCH V8 1/2] dt-bindings: mfd: sprd: Add bindings for
 ums512 global registers
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220909152421.278662-1-gengcixi@gmail.com>
 <20220909152421.278662-2-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909152421.278662-2-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 17:24, Cixi Geng wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
