Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51CA63BB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiK2Hyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiK2Hyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:54:43 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DD55A90
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:54:39 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e15so8095007ljl.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPR+p+kGl+0k/RjkknsYsCEKzKVPPKTVLJLFeCPw9io=;
        b=lReZcflhNFJ/RsdgzdE0hHMbkCizNZqtojH2rU+NvNrVEkpKcKrmCz582QluIoq7bD
         RufFlKdraGBy+VOFCZhPNqoavidkndtCyDTiyAdA1FbJ2NLwfzMjwg1KiGktB38DrZNC
         p8hLR/3i7XMboYFsI/gfQ/Urw15zTRx41DyXjy8ooFNLTVCkd1iLHHgtEBP9S9GIxp/O
         5k84n2584baNQBDhAKZ6+CRh+iW+wK/VPHktHk6WD6l03nF3lTmj/WoLwPuFVrE4kqrM
         ah8AMQJcGtBu9dJ2qBvAZi9IKj0caQpuBY239uDGJVcv5Ya2Ye87pRLcaTYDytl2AQvL
         mW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPR+p+kGl+0k/RjkknsYsCEKzKVPPKTVLJLFeCPw9io=;
        b=RCrHEgyw+INumahpVcRwwNoWONQhQR+YsBi0u8lCXUqrcXFbvZnSjESSYvzYcx4SS8
         LkLAhndfIBWVbPUiJVOdqNcLFIYhhSZHqg3HVneYIRTVbAErJ1pooTDap8zvJN7SDLfW
         FPKaVQoHaqh9WUhZiyW63eK3X9gCZyzLhfgKEYz5sGJ6UqYRO93t+wyOKWXOWUuQIr38
         fGR3yGmywKxKTVp0a1wD0AY5PnbDc3OaJ3cXQtBYhCAOQ7Ojq0Bg1KG96HgUEvO5MxnA
         84vI9/WKBRHVr6lMFZhTCWR98CCHnMAKtogF7y2N5YUlYBYKG79vAEchB1EdINV9H3pF
         PNIw==
X-Gm-Message-State: ANoB5pk6RNpnm2yjwz6Akzit05MURrHDP/VCnrPKYKUkTzb0/5t+MC0J
        993srT+wupO60EdmYigBr5zEfA==
X-Google-Smtp-Source: AA0mqf6ySTkqODS6y9U19ECH7tmUJLsWx5XNO7n57w5Hfp/bOMMqDtpocgZ+mTigVC5v1IbYhIgA5A==
X-Received: by 2002:a2e:b809:0:b0:279:9b4a:c325 with SMTP id u9-20020a2eb809000000b002799b4ac325mr4599936ljo.79.1669708477552;
        Mon, 28 Nov 2022 23:54:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d23-20020a05651c089700b0027776efa48csm1429844ljq.91.2022.11.28.23.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:54:37 -0800 (PST)
Message-ID: <cd0e324f-eaa9-4d63-9122-391a9dd48e7b@linaro.org>
Date:   Tue, 29 Nov 2022 08:54:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for Radxa ROCK Pi E25
Content-Language: en-US
To:     Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20221129070614.19720-1-amadeus@jmu.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129070614.19720-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 08:06, Chukun Pan wrote:
> Add devicetree binding documentation for the Radxa ROCK Pi E25.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Same comments about subject as your other patch

Best regards,
Krzysztof

