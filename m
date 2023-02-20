Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72DF69C8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBTKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBTKff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:35:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1773018B22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:35:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eq27so7423015edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4HZjaEfXhxPqqJJhqyI7tvXB4DOG6uqP5FwvH6q4eU=;
        b=Zs+dadc7Co8wjuK9wb8wBh+RJxOdxm2VM1QAdx8dk2R4i5UwJPfksduHDhHv5ItFZ1
         aLptINgWArsWRUNJcmTGTY6ithb8Lzh9k+gEqoKz5MnHQ1YokbWVgxffQJNFW2qZeUiz
         8RAbkrEgpXdRwSfCDXbn2wDCQ/7QARclpSGTRWV523vDeqr5iPyHVVcKRHuoRJrGnL8W
         wb/cSzvLYHY7+RNa2S83DpaiZrAhR4GBM41+CY9urz+VwQXifXCz49exQfV9B1UADNeH
         RKbc76FbmRsGOQI3LsRyRSTAdIime1dOUIu8n6f1Z6HGMU/ww+fbHFrNY81Xly64MYAJ
         0r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4HZjaEfXhxPqqJJhqyI7tvXB4DOG6uqP5FwvH6q4eU=;
        b=iLROQ3W3gueb3wy02GYczBVekLSXqT4VFo5WnOkItVbbe0/FolXXkOwzzDpN++oWlU
         d3QG3x4AX61aDwUkySQOoiHek3vd1VsGsFAlm1F2WUlUego6P7rryfwfXtjbxMP4B5+l
         9Xo6/w5/6vhgGLrKifqVijdo5/wJxiJNgqJJZAU/+r4gvTEgr5w5Yn50MhS56f1grP96
         g2RmriIXUTedkOd/hKj63GDcd7VQnGeIBpSgXRh62QWaDWwbA8KWGprSDqOP94LOpikL
         FEhECRRiDgQ3TPBRPcJ+f4EQUIQGyvsOMW+O4o318wIieaxTVXo0o7Hbgq6s5wwhqLke
         fpgQ==
X-Gm-Message-State: AO0yUKXNYP0RxUu+vt+X5n7AbvmX/7jP6fq4vLbuPV8ANSuW9tmq/jYU
        0rQmVmLd6lJQ+1TvGKZ+7ET2Sw==
X-Google-Smtp-Source: AK7set9SOK81yO3nimO9NuGkdvcul+tD3RZ2vpuiPwLroUindDRTeJPJ+nruZibhYU2AZJydG+C29w==
X-Received: by 2002:a17:906:c407:b0:8af:5154:ff8e with SMTP id u7-20020a170906c40700b008af5154ff8emr8474579ejz.15.1676889332553;
        Mon, 20 Feb 2023 02:35:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y21-20020a056402359500b004ab33d52d03sm1446406edc.22.2023.02.20.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:35:32 -0800 (PST)
Message-ID: <abec828b-9b34-fc5a-cd36-8be6f20dfd25@linaro.org>
Date:   Mon, 20 Feb 2023 11:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
 <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 10:56, Ryan Chen wrote:
>>
>>> And also have separate i2c master and slave register set for control.
>>
>> Since several of my questions remained unanswered and quite frankly it's
>> fruitless... so let me read the commit msg directly - it's the same device, just
>> with different register layout. Having new compatible makes sense, but this
>> should be part of old binding.
>>
> Sorry, I am confused, Do you mean I should base on original Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> Add new compatible? Not add another aspeed,i2cv2.yaml.

Yes. New compatible and new syscon phandle (constrained to specific
compatibles in allOf:if:then:) to the old binding.

Best regards,
Krzysztof

