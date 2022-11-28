Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424D63B09A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiK1R6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiK1R5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:57:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7F29832
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:46:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f13so18568139lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEOQc33dh/AvjD98uU08ScRRQgB0t4Sl60gjFCfdd8U=;
        b=yhQe2+hZGfKl6Eo7WYzGcxfG3vjSEekJKA7nkO4rCuvo1+vY9HSx7lTw++LjKu/T/q
         oGUXqhJeeq5zkrNXRdMIXEFvx25L9KApHsNm/KXgY0St375VrGNtLItCRFyN29hplOG6
         9gc1TkStI7/j15OBs11Mxh9rYZyPpUVHBhF5knolHECXFL5+3duh5oHFGVTX0TJZqCY2
         0BJY2g5+4peU0+TLiFM8tpUkUUinQ3YyvZAY2e5+mZWFJ+hkAWMBIXi4Dwl0uIXDo4R2
         C9RP3oO6WQ6L7MTO7JCOcqg4KnvKi2GPBqUPL+ljPwNKtpXPJ7tbsnyXLpyeNVrQ1Nxu
         pXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEOQc33dh/AvjD98uU08ScRRQgB0t4Sl60gjFCfdd8U=;
        b=lmxwgjGJcyD/ROP3INyi4p7UYPce7X8mPvBy65+jfIRiqQyCVqAeT4qOjJ/W8X5BPc
         97JmNPShrxWNIGxhs7yT1leToKiHwLwNdqUFHB/jQpMXxnQ5qSmc6Htitt2ye6uv+eaP
         x7tw37EqWMmIlnv3SYAM0jtKVOl85Zrw/MQpUir5LtJIoNnLhbf0OlPx62Bc2et6Wlq4
         /uKMoUJB+XiBuAaXjp4NevyHQbUg7sTPaGpEkJBYEhPQSiL9v9wx8R9lnoDHDYmDHQLb
         XuyF8gWGs41eE3Q78FPSXCmwEOebOO8ZQo8bzCI3Km5Zwt9LEoIZ7ldSIAbaVrEoJd2k
         gxXA==
X-Gm-Message-State: ANoB5plM1u+T+cZyVsiTeLvGegaKC1VgymPC4aR8Q+QB2yDxw1tui0TR
        HkCiE5P5sjG/VxCqFRdEEBg1ig==
X-Google-Smtp-Source: AA0mqf7Y8q4j5Qp8K52/Qdd96mqJajrlcpd3UQv1lIPTFAuR7uwCLpQ1Ju2x51BwH5f5CeII2zXU/A==
X-Received: by 2002:a19:4901:0:b0:4b4:e3b8:c6af with SMTP id w1-20020a194901000000b004b4e3b8c6afmr11777772lfa.291.1669657569898;
        Mon, 28 Nov 2022 09:46:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b12-20020a05651c032c00b0027741daec09sm1252772ljp.107.2022.11.28.09.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:46:09 -0800 (PST)
Message-ID: <dbf8082b-679a-b2d5-6568-3f9a93e52501@linaro.org>
Date:   Mon, 28 Nov 2022 18:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RESEND PATCH 1/2] dt-bindings: nfc: nxp,nci: Document NQ310
 compatible
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221128173744.833018-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128173744.833018-1-luca@z3ntu.xyz>
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

On 28/11/2022 18:37, Luca Weiss wrote:
> The NQ310 is another NFC chip from NXP, document the compatible in the
> bindings.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> RESEND to fix Cc


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

