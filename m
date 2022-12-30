Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E582D6530FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiLUMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiLUMmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:42:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7822BF2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:42:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h7so14794749wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjBNgPtelhx9bIjQtxlWNxvzSpMpPYqIg+5JJozsdV8=;
        b=xj2INPX1mZEFp2y3khc6K/3upKuD2J2dTuPmkrcX7HH68g1x2a2eBI5qJbEbEj87kZ
         hFmt//6YjeOGAtGVPZ50zpOCdOOaox/DqgF9cKTTu0FZI62uWqWGhPINs9kdlR3baPwR
         +rTcEcOQmsZat+mW8Fbrqh7wmlsUiEZHNfJo7ndm48rEleG8Cnd82df4TNx0RxJoQz32
         BE9Bf7EQ9MzXAfGkgEO4nXZnEfVtnWVHtP5AmvHXhRD2CAnz4ZUmzXXYqjZHz7WKJvg+
         L0FHBMQ//fGNVvWLG8CK0ZlOF/42H/a1BOwCLCoQGUVJozuiHTuuUiGve/X6UcYCic3T
         h+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjBNgPtelhx9bIjQtxlWNxvzSpMpPYqIg+5JJozsdV8=;
        b=wstNMD0eXnMWf/rAZ5IVZjfU81mXttMdKD+8dhusdwovHzuupl4Ty5euniMFlNu6ud
         NNU/nmAiPgJEkgAy+U2FXCWapPCVrrGP4bf4w8I3Vh9txzBGuuAhawO39yAcsYH+/crV
         c2+wVmFEX+aCsthxwcWyG2aGTcfvw086/kUuKz2Z6yf6ErCS+CmQT3O3WcKsypJQ/5Cw
         UvvZucSf13Xtla+OZqMhYCGgEpUyQKaM3qONjewG2QOU4mzt3s56J6ZRcm+GMMlFWUFv
         H2gYN2lthlDok2j70clixeS7tr60noeMP1zfXtYby0IGL171WU2Dlb7TyH7oOTPjhqVq
         fv8A==
X-Gm-Message-State: AFqh2kqY36etauqMvV29PGhz/XgcUDYV7zyVTxLEsEI7UezUuNZ6l+xy
        ZMSCJc5Hv1mX5z9ofcAQilXQ8pJ093eDg68vHwo=
X-Google-Smtp-Source: AMrXdXuZ+ZKXjgvm0yk1XxYhVzW8HBiqiMXFvPQxzZ+gudmvzMALrH7+KOLlFD7XxVtwXIwZ/lL4MQ==
X-Received: by 2002:a5d:4104:0:b0:242:2390:15f with SMTP id l4-20020a5d4104000000b002422390015fmr1012145wrp.64.1671626535856;
        Wed, 21 Dec 2022 04:42:15 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d4f87000000b00236576c8eddsm15103603wru.12.2022.12.21.04.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:42:15 -0800 (PST)
Message-ID: <1b5cdec7-a7f7-4af0-b966-fbc3c649c07e@linaro.org>
Date:   Wed, 21 Dec 2022 13:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] KVM: x86: Fix trivial typo
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>, kvm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
References: <20221220-permited-v1-0-52ea9857fa61@chromium.org>
 <20221220-permited-v1-2-52ea9857fa61@chromium.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221220-permited-v1-2-52ea9857fa61@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/22 23:20, Ricardo Ribalda wrote:
> Permitted is spelled with two t.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>   arch/x86/kvm/emulate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

