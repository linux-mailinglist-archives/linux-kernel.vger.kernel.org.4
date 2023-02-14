Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38BD695C47
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjBNIJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBNIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:09:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7214610F4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:09:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so14702239wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pf9170XvU7zLLAHBJUBXw8LaXOs2tRKFoZ7PkVXYtIY=;
        b=LPaw8u0ct7tKtQNnm9Nx7k30Lqv1q3WeXUXy9e2Gd6QHcdvXAE67RvKMGi3qZWUoIg
         e7X/IdGd7CpY22bkryhv5EUqfE65YWzy5ilmG300PpNCUxugKDSMDMYqcTUWEc+Dk42s
         WwTMOFlV7+BYn6khsV4Zy3/9UsU5umHdY1eQB9h4+g5DeuRYUekGNH7+KEhF9pEzQPi4
         T6ACNEscTe7S2OTMWhgH40DZuPdbO1QD5BVzb4vvw4S7RKgVIux0yGq5rCuX+ynXd+CZ
         kAwHKytA8yjpvF1W6BzhCKYP8URTXGePXMGLjacd43Fo9mXqiRtBXQHGECvQJVS3e/i1
         pfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf9170XvU7zLLAHBJUBXw8LaXOs2tRKFoZ7PkVXYtIY=;
        b=XbU+s+Aej0Go7rGikRFSHW9g8fn6/uHQ90DAXZtUFX43OPYF1umtF+yBJ9rrH7KmI1
         +47aXyasGB/fWKUjCzJ31uQC+wxQyyVXqvuUdZShAUtC9By9cPZPHSOTyR5n11pwMwvN
         qMNZMp5G69brqI7AlI91zHH3khd/ZRlTILm3CPHjHOxfKUpQStvYDGsS0DGcEhqdP3yL
         TwE2Rx99Hx+BpQXxhFwbI5/5Sn6kcrHu8dsBnqlZzclLeUAEEW15GQ1zmFgC11/5R7aa
         e+zGMJnV7hjI2swQo6SBaWA2hoATAFhPmvni3WFyWL6cDXK4DsP6M6iilTARiMgtfVHI
         AqEQ==
X-Gm-Message-State: AO0yUKVqYe76bUL9K5nQQVpfS1z7eZIc0osCkQmgjiQouLJFcmksTboe
        U2tDtsNCDoYrabO/xduTuLPokw==
X-Google-Smtp-Source: AK7set8WK084Wm25gzk8fxH+tdMAdKMKDQpEY60rw+rQLHE2Nft2xLZqt5ECPRmIVsfYPqc19DrP/A==
X-Received: by 2002:adf:f685:0:b0:2c5:5687:5ed5 with SMTP id v5-20020adff685000000b002c556875ed5mr1183986wrp.18.1676362166084;
        Tue, 14 Feb 2023 00:09:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b16-20020adfe650000000b002c5534db60bsm6115122wrn.71.2023.02.14.00.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:09:25 -0800 (PST)
Message-ID: <1f03e625-3385-06bc-1800-d30ba5da6f0c@linaro.org>
Date:   Tue, 14 Feb 2023 09:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] dt-bindings: hwlock: sun6i: Add missing names
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230213231931.6546-1-bage@debian.org>
 <20230213231931.6546-3-bage@debian.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213231931.6546-3-bage@debian.org>
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

On 14/02/2023 00:19, Bastian Germann wrote:
> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
> and reset-names set to "ahb" as required by the driver.
> 
> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---

With the changes from Andre:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

