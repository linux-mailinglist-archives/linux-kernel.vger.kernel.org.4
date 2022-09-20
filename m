Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312FF5BDE28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiITH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiITH2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:28:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44405D0F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:28:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so2420924lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LEa7ivpH2zwvXQJXdB4Tn1ym+X+L1/H3MJkj59kIHEs=;
        b=q2F6OXaJ/xe0qfhB6YkE7kg7HTC3g7R/1lUquS/H0zAyLLypNM/4x1rc+84XEsuM13
         vLAK9TLXOSC/tIhpwJ4ZwH17gtQ1k+tcelXxMxZ/HwRS71eohh3AMYFME1LXplaAJqRU
         C7jpgNCaTmLptbNN8HN4pns95A4mDEu2z36Nxg0Cq5PGALiH4floLRWf7TrYbAOBigVG
         bM2O60R7B0j2po3ewDrQ76LS8UqiPNeJ7RQB5mwJv4A5YidXTNLnTdneHpYHqZ7aIhvY
         Y3VWsyorN47ZXa2L5zJagwWzNLyCwQx9TkNVcfFjRAvkOZVxjgNqPXkPA9FhmNhlQCSD
         H7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LEa7ivpH2zwvXQJXdB4Tn1ym+X+L1/H3MJkj59kIHEs=;
        b=3Xj7MRdkK4UfY2H1csFJWGKz8Mv9g2Fk1WJM0xUxwiIifKbI1ElVK1cONbpsOjnAi2
         N6XlKApxJW3stdw6DtxWediv4EqWd1+vy1sY5VsEMaEU1AxDe8Y9BG0KZOanxbqfqz1b
         3oDYehf0XhKE1Nx/JH6C8l6lFQ0uItL/VYycMQxCqKGsmFvJTggjpTLKntFC5yV8hpXI
         yxTlunKgsMitB9wx4v64inKEI87BoZmf69OPsAOUn2ydHH8g0YAVbOHZI6PrBUwPe1U4
         /O3y61kq2lyGQ0g95c1UFPWnkbid3Tad/klpr49jPsgnVufOnvMFQO/Z+MeCt0Z/GsjL
         Qz7g==
X-Gm-Message-State: ACrzQf3rWdY1tXYAhKmJ/NgtG2ww+wyfWYRCflIaZVlgc2jb2OxD6Qym
        gtFro81GBlHPwyU9mj7dYitH+A==
X-Google-Smtp-Source: AMsMyM6BC+/vWwZ8kkOFP7DhJcNDVAlVNmT8NQuqfdZw0mpLVr5cFLYoCJpMuRnEERHFxjROUC+zxA==
X-Received: by 2002:a05:6512:16a1:b0:48a:87a2:103c with SMTP id bu33-20020a05651216a100b0048a87a2103cmr8342967lfb.554.1663658923276;
        Tue, 20 Sep 2022 00:28:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o13-20020a05651205cd00b00492aefd73a5sm173407lfo.132.2022.09.20.00.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 00:28:42 -0700 (PDT)
Message-ID: <36bd1c19-8fbd-0903-704d-447117b2007a@linaro.org>
Date:   Tue, 20 Sep 2022 09:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml &
 related changes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Jordan Crouse <jorcrous@amazon.com>
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 00:08, Bhupesh Sharma wrote:

(...)


> 
> Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
> The qce block supports hardware accelerated algorithms for encryption
> and authentication. It also provides support for aes, des, 3des
> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
> authentication algorithms.
> 
> Note that this patchset is dependent on the dt-bindings patchset (see [1]) sent to devicetree list.
> 
> [1]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/

If it is dependent on the bindings only, keep them together. However I
don't think this is the only dependency. You add here several
compatibles which are not supported.

Best regards,
Krzysztof
