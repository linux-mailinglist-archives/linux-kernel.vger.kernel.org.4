Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF701656942
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiL0J45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiL0J41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:56:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A7B498
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:55:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z26so18955066lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPELBybm3OZnPzS1qLb2eKjz0NHNGczcyBgATwq2AJ8=;
        b=a3UtnFcbLnbcl0VpqfiGS+3wdLVd8cVaF6vWs6Z73JN9u8GKOcwuHvZ7PeFo2Fz8Gb
         Dg33aK8GsX9rXOk5JHLN+UFwwLtUGge2vDJcLxDgKQBj0UlrAwxvRdTyIlqjOBxb6uL2
         3r8wy+ifXw9wMu+5ohSWs57+ivuQsve9TeeIsGrOCr3I2UKbfLcVTzYjnN3o5GN79Z8V
         4aixJ758qbUSfUaK04lAaM+3z/IdBQ94CY7xifFwzdw5ESD37q6+CFXOjjzRg1KEvOb9
         bx3izGa6470MaOEzPMLBZD6oRxIvl+pgygrs7v2swp3COdc38cNfCwdd7rXSjYmxbKqi
         A25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPELBybm3OZnPzS1qLb2eKjz0NHNGczcyBgATwq2AJ8=;
        b=XBqXegOwmvvXMLTKlP6lwlSFMN7qLmw+OFTfCiXaHm8IkseM3igFy1CMLGd0NUPH2+
         AaEpMzqxnUE9QqZXQawotPWzbxa+4y9cN3xsxGbMWPeTja26LBEZdI3gIp67fS9ND3+w
         Kz0IC5ZBmbMMVRKRtw0pIDxU6evEIRWMmKzCrrfRWtZgo0WpY55QtDhwXS1BF8gxkDZI
         3/SlBQjr7lUrWJbdP42cwYaIDT4Usx/KkhTuP4NSUEtcfh/Bx6I5ehZYUHvHSDnRCUfz
         iu7tFn92msFF8VtCsKqwLCs6FC4xW8Mefue2tFbdlJHFc6RWFJj78BO966JndYZ0X3qU
         zusg==
X-Gm-Message-State: AFqh2kpLLqksPZPYl/DS2WYxCtgVJXAdrGSPzYrElEnz8pBHP+/M1zot
        3Evtn33hf3VdlQFANl6A5JBg3yiYYv6641BR
X-Google-Smtp-Source: AMrXdXtltf4vB2TNQasjCgOUGdVW5TjMPZt530L9JnGeaOu3jfGKIVxewdonxiUQ0BeVA82qYm+DzA==
X-Received: by 2002:a19:f514:0:b0:4b5:61e8:8934 with SMTP id j20-20020a19f514000000b004b561e88934mr5295350lfb.64.1672134916572;
        Tue, 27 Dec 2022 01:55:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651205d100b00498f77cfa63sm2211382lfo.280.2022.12.27.01.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:55:16 -0800 (PST)
Message-ID: <1cc66b84-fcf3-2801-57ad-94430fa38055@linaro.org>
Date:   Tue, 27 Dec 2022 10:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM
 GFXI
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
References: <20221227095123.2447948-1-milkfafa@gmail.com>
 <20221227095123.2447948-4-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221227095123.2447948-4-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 10:51, Marvin Lin wrote:
> Add dt-bindings document for Graphics Core Information (GFXI) node. It
> is used by NPCM video driver to retrieve Graphics core information.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The comment about subject from v8 applies here as well. Once you receive
a comment apply it everywhere, fix all the issues, not only one.


Best regards,
Krzysztof

