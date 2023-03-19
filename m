Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA96C017D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCSMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCSMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:17:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161DE1024C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:17:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so36895016edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3W3QZYcSIyfrXX4gOmz0cOwbXa3Zt/8qSGmb7XOLRE=;
        b=CF8/1uGn6MBl0UnasIEAl3sOywvA1z+LUB1rhmNciYHMzoM3JyLIJNfU1fXMH6u3Dx
         PdTbZ4GSFsHFYaBaJDAEN10PN+nsTn+2WpiOo117lJO/B/F42RTRD4w7hUoJlTvOOKhl
         b0EXQo4fk+AFDJE/N4GbAOtiba3kB7DEwmH50IFDFSUy6xuXeXpRnYvJhEM0O5ZAqDvr
         yz3GCgER0lf3cHDDpfN0yt5STfhRpBLnCkxHVdRgWiWu5TxYgWa1MfhzCk8ltUnBI2JF
         csusmSYnz/KSEYhPpk2yYN4WqrsrXN0UCjH9/vXKdrToFaix8O7a/MB82CdOEh9Tz+FM
         9OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3W3QZYcSIyfrXX4gOmz0cOwbXa3Zt/8qSGmb7XOLRE=;
        b=XhgqNivB/OZDEYcuOvrW4ddp8JolNp11EUGv/zqMaWZpd0sIMLg/RxUaoKnLsdvgIL
         hPkyq/W4x0Tj1HcOoVP1yUVtlvUAniXJ2VY9kSSqF6kT/hJyN2BUkAprnyzoZrfYK1Hk
         HtneULjLVMew+vk+yylY6gPik5gYmLqz6cmwDlviFI4z3dXEk2gRofca0aeUhdhSrNgW
         BTkLAPgzk9FnjwBXIBKFkTD1tKeIygCdtipDE9jITDyW7px2zMs1/DU1Y5XXSglhDAVs
         s9N5mWZUUSvOBdmSqUekH0CY9Q8qCejn9Hoq2BeBTumO43YgnekE4/xx926cgr8TwdUA
         3/EQ==
X-Gm-Message-State: AO0yUKVfHkokQ10trl1YJNBoSWAu85/FG3FVeN5CUgyJlKiU3qK6gldi
        NqQGO0Gj1o7O3/xUwr7Y1Z93DOlWSofxBPQ7zII=
X-Google-Smtp-Source: AK7set/SF4qxDnDiV9swe50UtHOt9t4X3MtKNwvA+meSt/nONKnzz9TOqt5ja+qUVPYRqCtzWzC/bA==
X-Received: by 2002:a17:906:c359:b0:933:4c93:69ee with SMTP id ci25-20020a170906c35900b009334c9369eemr2811353ejb.45.1679228236600;
        Sun, 19 Mar 2023 05:17:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id kj2-20020a170907764200b009324717b9f3sm2667147ejc.71.2023.03.19.05.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:17:15 -0700 (PDT)
Message-ID: <b31fdeec-59bc-f24c-ab1f-7b3e33c0b52b@linaro.org>
Date:   Sun, 19 Mar 2023 13:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/2] dt-bindings: optee driver interrupt can be a
 per-cpu interrupt
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20230317172859.989650-1-etienne.carriere@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317172859.989650-1-etienne.carriere@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 18:28, Etienne Carriere wrote:
> Explicit in optee firmware device tree bindings that the interrupt
> used by optee driver for async notification can be a peripheral
> interrupt or a per-cpu interrupt.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v4


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

