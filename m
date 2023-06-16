Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A573366A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjFPQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFPQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:47:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE2E4B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:47:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-985fd30ef48so140332166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686934064; x=1689526064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR/ewEVzheud766IYogIIFYLKZVXzHUKJUCXE3IEQwQ=;
        b=rGUeIYi4IdshDA7+hbcoGOkqgoSQkakptbeirMO/8Pk0Za0pIfm8rxTJj39EzbQHa9
         oAxUiGDMPB8XlE32Z6TLSN7pzeip6NtD9myAXFvWYopaMZX007baNDS4OODvRzkJ4XK/
         BxT8Rx9QFfGIbB8NB04fh8VJkOqJQ+BlZxbN9n6PId+6016eXBD4kntYpuAx4otDAzfT
         CrCPghrWZnww2ftgna3xiIXFjZtgh1C81mcKiNzSA08ZxnKF/J+qVKOWXqKjeisD/9hg
         NEoH6NInD6b40jJvTQPXHzHVujCE8CXL3fJ3Hd9yGdgiwaqPYnbb4ClZ4PQCbyooY9od
         mRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934064; x=1689526064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR/ewEVzheud766IYogIIFYLKZVXzHUKJUCXE3IEQwQ=;
        b=E2pVh/oypoJsxVFY3Upx2x6C0SbNFrJaEGpbB5SpYn0n6X8J5DfMdC7LZT5GSC4/fb
         1ezUIixNyWoNsSKQ8DxSUaNtxq2tDkkbNwE9EO/Vd0FgslxrWRcyujmb5Kd/R7uz58DB
         5u7t8JNCxMsXKuXFJ11mD3tdNwQkRCWOK+nwFQn6QaYElD0+0sTFrGYTbJkcbyN1Wp2F
         8Xl6RaAhXOCzJuZnQPThXI6yZtcKiCaHig8iAO902c2WE7Y/3rauwGf3GpOtqk1hQrxD
         daTEIuM7FPgEnwF4E3R2TvuVIODiAZEcSBW6fLHHznU3kS8bnvAd0iEUZkCJ33534znv
         F/Wg==
X-Gm-Message-State: AC+VfDxYFuSHktre+fv1BhTPuwc4ytS2O2qbbBVgUeUgbpwiP7nK6GSD
        Ipmq4tDqLGT+jwVfDw5W3JaE8g==
X-Google-Smtp-Source: ACHHUZ63zAUCicktB84FmVBiqmjP2B+fOb0miIHGkGuCBDLQfBbTBvT9sZYVXErc12e8NZ4CiYo1YA==
X-Received: by 2002:a17:906:2b50:b0:970:e010:3bb2 with SMTP id b16-20020a1709062b5000b00970e0103bb2mr2174696ejg.35.1686934064188;
        Fri, 16 Jun 2023 09:47:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906265900b00977ca5de275sm11171386ejc.13.2023.06.16.09.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:47:43 -0700 (PDT)
Message-ID: <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org>
Date:   Fri, 16 Jun 2023 18:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
 <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 18:23, Jassi Brar wrote:
> On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
>>> From: Jassi Brar <jaswinder.singh@linaro.org>
>>>
>>> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
>>> Specify bindings for the platform and boards based on that.
>>
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>>
> I can remove it, but I see many mentions like "Fix bindings for"  "Add
> binding for" etc in the subject line.

Can we fix them as well?


> 
>>
>> Binding without it's user is usually useless. Where is the user?
>>
> It is required for SystemReady-2.0 certification.

For what? If there is no user, it is not required for SR. We don't
document compatibles for something which does not exist in the projects.


Best regards,
Krzysztof

