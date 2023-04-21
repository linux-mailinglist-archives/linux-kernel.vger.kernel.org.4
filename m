Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093176EA514
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDUHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDUHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:40:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F3593C0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:40:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so2367118a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682062838; x=1684654838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRmjG1qsadAKHj3HgH/yDwDDGHpwkpdZ5tpDMXAixaw=;
        b=JzPTB4QLGGUvieQQjLh87+VKC8mlHNGX3dWOAFpM8GAkWaBGyogkiPkG2dz5MtgzGd
         FuaciGIX90+KjpwDs9aE7hI5NH1ZXvuLeT3iHnBxekYkylEsnn5fO/S+puRsNBm8ZlTi
         agtlrsySn7+Wr+Lfx38pYsz2oCqhNMyNSkxguIjiy9xhfqsfaZrk31Ve0/KrWA9dmu8y
         zr0TnSfV3ohk56Zhhm6HIC8f8fdGrdjZIyhfJK0USU2rLJOFPeZXIQr4U91CfS046aFK
         R+preI1MkL1hlYwHJk9MRK/dDUKNJvwgLNwI2oTE5148Hm4WppHMEVXvmbQLoleFhGZm
         VbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062838; x=1684654838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRmjG1qsadAKHj3HgH/yDwDDGHpwkpdZ5tpDMXAixaw=;
        b=aq65SZFZt0xPDGYZSTQ0HXbg3Uw0nG32qrxwnAK+ErTblKpy9KWSPvfZJaBveHxfsz
         xES3kOvaeafIv3KQIdoLn0ZJt4PUlOuI2kHua3XEGd0zlRLb1yG+hFuogtdfkk8JstnF
         DhlmmHSjsNgqD9Aja5xVh1/zAEHyw/dhF4igSHtNOwKqeqVaPXmBIt7JU9NoAUx5yVbG
         gKA0JT8buwenc7mxKm2HMByZHAtDfbeT4kGItHuiCR4SBXn0JqFYq3Vpok90lbo1N7u/
         pI4LzA8LuAeHWe44ibNPgB/IFUWnRqY+uuw86pj33I0p1YtcSaFWUTWE4UBoLn0sBE9z
         Vvkg==
X-Gm-Message-State: AAQBX9czoBNPhY6gJBjLRFU7lMzs6aYD/as2V3pJkvee8ZF14RBd+h/f
        Giy5cKGVeU3qc/UUgOwKKA5BKw==
X-Google-Smtp-Source: AKy350YMb2QpC7UaVaVJT/Vi5m2rfTyFGJKZC//wlbCdeoyZG+x/yBwFJeH95NKOcVmjbhTQmDDl+g==
X-Received: by 2002:aa7:d491:0:b0:506:a663:5c1b with SMTP id b17-20020aa7d491000000b00506a6635c1bmr3353450edr.18.1682062838624;
        Fri, 21 Apr 2023 00:40:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id i17-20020a056402055100b0050685927971sm1570810edx.30.2023.04.21.00.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:40:38 -0700 (PDT)
Message-ID: <320cafe5-d90d-6987-77a1-16cdfa0dcfe8@linaro.org>
Date:   Fri, 21 Apr 2023 09:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add
 versal watchdog
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, git@xilinx.com, neelisrinivas18@gmail.com
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
 <20230420104231.2243079-3-srinivas.neeli@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230420104231.2243079-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 12:42, Srinivas Neeli wrote:
> Versal watchdog IP uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and
> a period that is not too late.
> 
> Add devicetree bindings for versal window watchdog device.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V4:
> - Updated commit subject(removed redundant "bindings").
> - Updated commit descriptioni(removed "this patch").
> - Updated watchdog.yaml reference to local.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

