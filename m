Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D210C629609
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKOKgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKOKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:36:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D402611E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:35:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j4so23819862lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4UHGwxwnt4Cc6rH/RttAuD4Amllt6tSRn4Nm+z5DoY=;
        b=cHznuR12/gE+BOW9xg+YW6XmVqpxjnb7ke+DgJambMA+vmlrRniD9930zKDtQqbU2J
         kUOQyUJlwr7OD8BjraGTuVh6KtB+gTEcR5HtvL1IXj8QgZqfdQ+W1pxgaIrpL34yYAYg
         zYqLIfgIFhhKzGDkFHVM2ak5CmtSuJi6KDD7FESP/tjDdhujuCcdowIoi+SMbRPGCOR1
         l2Qu/Br1aZOwvbRod0u3n8ilsRdj/oOyLwkMwxNqGeyfKkFJqrO0egNs0zOidZg+DYNU
         rNXlcBux6uvsa58FeOns9tK1MWVapp3zx0dxr8ZuaG9juGNM4Je796d3jQhEfjcCO/vy
         +sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4UHGwxwnt4Cc6rH/RttAuD4Amllt6tSRn4Nm+z5DoY=;
        b=y5wKfuf6Huw2ivPYI/lbHl90UUEWRgRCRN8i1NcIs2UX3cqhesNmmKwXSCgDJrYJqT
         O+QdnS+bTMMMFem+Nkx289NIcbMS65104yEBURKni7gL1bXlicXeLSZJEXDpnnWGLMYo
         g7AQ6TTt/g4wXCmrf+M72u+KZSkF/dxW+UVGndlZH1MMc4y3P2/rhtvwo5C7hQEdcM4g
         Z+aqQx+SX4aE9bA12eRaDbgbh+Uwe/mjI2O+PXCyEQqKDSCeWx1nXX8f6zGsJ8/ticuN
         RCmEnkBJEuTNWiJDI9p7it5uwcf6IRaUmiAWT3/YTRD8z72JbPgE1l4lwoafLPCY9nJf
         2udw==
X-Gm-Message-State: ANoB5pkoWp+7WyW2PffaE5n/sPG9puvJjPT5KreW50oxTLodnPNzkXij
        54Xk0T1fPl2TH9bpHXsjNS9Ksw==
X-Google-Smtp-Source: AA0mqf5BL3d+Gx9BcXZAHwX3sxhZR5kOKFTc3DJNBiRO1IsIjv+y+PQZA406NjuyI+8pDf/3Vvi6Gg==
X-Received: by 2002:a05:6512:12c4:b0:4a2:4df9:4cab with SMTP id p4-20020a05651212c400b004a24df94cabmr5600420lfg.56.1668508557768;
        Tue, 15 Nov 2022 02:35:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b004a46a9cebe2sm2152572lfs.289.2022.11.15.02.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:35:57 -0800 (PST)
Message-ID: <c21e0e3d-5970-d905-3b6f-54a1ddacd052@linaro.org>
Date:   Tue, 15 Nov 2022 11:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] MAINTAINERS: rectify entry for MICROCHIP USB251XB DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115103153.28502-1-lukas.bulwahn@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115103153.28502-1-lukas.bulwahn@gmail.com>
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

On 15/11/2022 11:31, Lukas Bulwahn wrote:
> Commit fff61d4ccf3d ("dt-bindings: usb: usb251xb: Convert to YAML schema")
> converts usb251xb.txt to usb251xb.yaml, but misses to adjust its reference
> in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file reference in MICROCHIP USB251XB DRIVER.
> 
You know this could be just one sentence (instead of three paragraphs)
with a Fixes tag...

Best regards,
Krzysztof

