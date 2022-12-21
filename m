Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9686532E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiLUPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiLUPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:06:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3122B07
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:06:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so23929046lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubvr28/+nbrlzq2tH+BDAbtPZ6+thGRVV4LTQxz5gTQ=;
        b=LaqAzs5/sYibTYizBl1Qgzo1Zia0Fix0tx27T6a6X6Ye2r+/ckIodI+v/Q5ZrBQylC
         oG/CXxgOLc5ZiS0bx2nZSZ2HEbd1DBBIqLkKLolkiO8wJgZj36cN9cQuwGPeq4u5CDte
         Kq9RaxfM164mYp3cWafS8EBvTrzMLazlJ20iupuoLJcWVzN/nruq+iyO5v08wCHOKZBV
         dSWbmtGGXyHGv12zBbJaTMerEe3re0IHziSqEmFWrk6COOGETvdI3E+mh68jai11y/9T
         1ezY/xLRk+Oj7ACuJ8LFdxFQN7v7OBuRvTy6/e44X8/HU9CVQuYxrMfuQc6ahe64ZLWj
         isIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubvr28/+nbrlzq2tH+BDAbtPZ6+thGRVV4LTQxz5gTQ=;
        b=5wMBKDmhBrubOLt4MnrtoXuMWSHbc5DBBVascua6FzOEeWBBiO2ArG4kG43tB5R1jo
         OC1HPAS+FN1gd7YU7NdDXL7Zvhgoq455t2osp1uETosh+Lvj7zEIO4T51PFPtlsCuwRT
         TYtfsuhsXaJldoth2vrlNkS8kiZKRtdX3GH/W6ouaXSsx2B+JoJmR0VdNDEMjFQbGH7m
         wceBzNfrFsenPrPfqZwIn1Km6+oSKci+Hp5WNWcWbJtzkhLbCM0ILfmAgSjTdNdw7SWt
         Q84avCmXAeNeYkhQQpA9VjiarkOBY+L16tNVW6kBxUbhNbs2U4hwnrAsLQIDJXuTj/iS
         C7Bg==
X-Gm-Message-State: AFqh2krrg7TVtma1IETuTYd1o5zXzBklumhDxrb/EOjgLVZ7sfuKqkAf
        xVBDZcSwZdULm/j1jKbso0SUNw==
X-Google-Smtp-Source: AMrXdXt+ZOwykqlelHux/xLhDhuRfzyrojLar4zCv78pPdtuapTCz2QBY88SMECPZnsZkenjpl+KhA==
X-Received: by 2002:ac2:5dce:0:b0:4b5:b988:b409 with SMTP id x14-20020ac25dce000000b004b5b988b409mr660702lfq.21.1671635188786;
        Wed, 21 Dec 2022 07:06:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a21-20020a056512201500b00499aefcf68esm1853539lfb.292.2022.12.21.07.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:06:28 -0800 (PST)
Message-ID: <0dda49c1-2162-d473-0c4c-591519096008@linaro.org>
Date:   Wed, 21 Dec 2022 16:06:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat
 1
Content-Language: en-US
To:     Yuteng Zhong <zonyitoo@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6MQ2b8JyST6fPVE@VM-66-53-centos>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6MQ2b8JyST6fPVE@VM-66-53-centos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 14:57, Yuteng Zhong wrote:
> From: DHDAXCW <lasstp5011@gmail.com>
> 
> Add devicetree binding documentation for the EmbedFire LubanCat 1.
> 
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> ---

Thanks for the changes. The SoB chain is not correct - wrong order.
"DHDAXCW" does not look person's name and we need real names.

Best regards,
Krzysztof

