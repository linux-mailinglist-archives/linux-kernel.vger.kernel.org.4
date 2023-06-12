Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43EB72BE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjFLKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjFLKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:11:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A64228
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:51:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9788faaca2dso701537966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563482; x=1689155482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p73p8iBF8aXDQgFdOMI5kr8I00UMbWdp8nhLok7wZbE=;
        b=kaBQyxEJjsN1+xKoTCuWznHkrGfi24IjYupmx3KNL49JI8TcnKOm3gzqPs4xKKSZ8P
         LxuWnwpAGq37k88T1nK0WwLd4azQNkH1m8eSVpl5akD8ywZx96Qr00DZCjpKdF/ngw4X
         TsrDjF9h/M/5bGxwZFuPGTYfdFF6lkf65E/bTYT8wfa+tnxOEkXhf6XdJdN0+Na0Nrvp
         WNWXuIb6b4L/HhvuUCX/8uqrTTjfgzMuyFrT8HI9elIGIH5J3bYSYxVQNgS6kYskGiaL
         bCzihQyJ879LMowmgq0Y7n8D63YUqmaSrvIoT/Ra7A93VD6Aeeud3m11zOGL8VL6SHuU
         jpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563482; x=1689155482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p73p8iBF8aXDQgFdOMI5kr8I00UMbWdp8nhLok7wZbE=;
        b=BoBDSjbHHp+IQXwkUuOV/oGlvetBv/6oP/BGv/ELYEcL9EDccx3mlOtxBe58263zZp
         iDqB1uhCfPFcX5dO2/fMl6PyVBOvr/7Qxu3+9uwdZFOlv/ZtT1FTdKpgqo874IN39W7f
         2X2GHRyA97Lld+1WBw1hmRvK2hP5XodGyTDWzWp5Yqq+ti4nd2jJXZhbE9QtcDfwylx0
         bap2twRW4sS6pGrXJbxBZQuwWss9WhQ13u8izOfEpoKfsBFvuEiept4i8cUgJ/ji/Lw2
         MhjKnrsc3hvNcfjnFYOH/ZIStk6pOnyeEBAz1rO21Ud/myvJ7xoGwajMHz+QBQaJptZA
         fCtA==
X-Gm-Message-State: AC+VfDzbTrg2snlIP57+AHS2VU4Q9cA9WqAJ4kwa5Chs9mPGrBTPQSyy
        MAyjdc2hJ4sRbJEdqp/kXahniA==
X-Google-Smtp-Source: ACHHUZ4rvqW+RXF5ZByOUxAp90+FZQtXk5GA+J2fVeqLdy9oIQxUyIWww+3XSb16dju+/3m1aea4bg==
X-Received: by 2002:a17:906:6a1c:b0:978:ab6b:afe9 with SMTP id qw28-20020a1709066a1c00b00978ab6bafe9mr8699754ejc.66.1686563482008;
        Mon, 12 Jun 2023 02:51:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kf10-20020a17090776ca00b00965f6ad266bsm4850797ejc.119.2023.06.12.02.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:51:21 -0700 (PDT)
Message-ID: <3ac37e54-0633-37d2-2ba7-f06abcb9a5a7@linaro.org>
Date:   Mon, 12 Jun 2023 11:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable HSR by default
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230612094340.13865-1-r-gunasekaran@ti.com>
 <ab8dfd0f-fa49-6493-d79d-c35f632373f3@linaro.org>
 <e3e409c5-56b5-570d-e962-a7c0a1c05fa3@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e3e409c5-56b5-570d-e962-a7c0a1c05fa3@ti.com>
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

On 12/06/2023 11:49, Ravi Gunasekaran wrote:
> 
> 
> On 6/12/23 3:14 PM, Krzysztof Kozlowski wrote:
>> On 12/06/2023 11:43, Ravi Gunasekaran wrote:
>>> Enable HSR feature in kernel build.
>>
>> Why? Commit msg should answer to this question.
> 
> I apologize for incomplete description. I will send out a v2.
> 
> HSR protocol is implemented by the network stack at /net/hsr/*
> In order to create HSR interface, HSR module needs to be loaded.

You described what HSR is, but I want to know why do we need it in our
development arm64 kernel. You might want to enable anything and explain
what is this "anything" but this does not solve any of the concerns.

Best regards,
Krzysztof

