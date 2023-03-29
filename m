Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B256CD502
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjC2Iok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2Ioh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:44:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26CF170F;
        Wed, 29 Mar 2023 01:44:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso15430397pjb.3;
        Wed, 29 Mar 2023 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680079476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYEpcK9HQA90h87FcKJb7lj4OLHxZGh1sA7YFQ0W1d0=;
        b=PpMlDvDbCHBvEr7RIq8DRBYjSQc0DapVxTGUdNgkdjpez7Q9ryqDlSQV2i+PTrcYJL
         R0p6iJ2JiHjHF5kodcu8d26bDQSmRYnCSVldNarOAyb5Yjrqad0P0tJO26kSXNNdUIIB
         rAwSu85HSR8ThjnBs8MQwf0EhoD1Ok70XmAz2swZ7E+K3ADQW5BPTtL81AVnkqYggeZg
         kRBoFIjM4KFt2JvCguzv0XsKZsGSU27+liIMHYvDduZgsqERVX+3SiLxOxdkFxzSt21a
         u3VIDUMwxVuHiSFJ4UJUihSc2FnI8m7Ryye4AnX7xYWzJATPFs7VznqvlFmB8+u9vSXy
         HOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYEpcK9HQA90h87FcKJb7lj4OLHxZGh1sA7YFQ0W1d0=;
        b=4P134gysYjncZBm2vv8Jzo1Ykkq0rxf3kaTclqTEAXSLip1dB2vqHcgE6JgECX36TH
         VPL1ywfi7/2qPe46YZ8zL8/magUo6iqpv5pipm9PmF1ngbUbm5DAqKtz9VaQ15HQK6ER
         k4xSj5+WyZ7RIM4sABEIbPw5PNvH1v6ZpOr/bwuZ0dpfliUq/XjVVrKEJqgyVZfrCKNt
         0LMDzlpEXUKwxhvorrK/3/QXi25nXF10ap+N85/tmYRbwKfi8Wat5wHukpkAadd2CVqi
         y6JsWy+dpO75227la90pGZo6QaU1M4tEKio7Ypdh2Wj2MbmZbQZ0Pat7vYpMvLT+uQiW
         ZegA==
X-Gm-Message-State: AAQBX9e0KOhyntIZ62N8MIqcrnV96QCok41aGH/BftFO6ElHUQk4Hcqd
        W4dc5E3/ycFFEpfbn4EPngs=
X-Google-Smtp-Source: AKy350bAhAlegQKfwu/2+LY1ZHjWKyceXNFPIVYTvQkZT9D6R2AWO8cDGFFIrG8UkaF17gk0SQFxOw==
X-Received: by 2002:a17:90b:4c45:b0:23d:35d9:d065 with SMTP id np5-20020a17090b4c4500b0023d35d9d065mr17712376pjb.48.1680079476257;
        Wed, 29 Mar 2023 01:44:36 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a0fc500b0023493354f37sm922823pjz.26.2023.03.29.01.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:44:36 -0700 (PDT)
Message-ID: <7b5e42bc-0788-5208-e97e-10502da1c238@gmail.com>
Date:   Wed, 29 Mar 2023 16:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
 <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


Thanks for your review.


On 2023/3/29 下午 04:20, Krzysztof Kozlowski wrote:
> On 28/03/2023 04:19, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 uart driver bindings.
>>
> This depends on clock patches, so it must be taken together.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

OK, I will combine this patch with the clock patch.


Best regards,
Jacky Huang
