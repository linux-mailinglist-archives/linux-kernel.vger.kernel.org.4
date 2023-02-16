Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE50699274
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjBPK7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBPK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:59:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4338669
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:58:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eq11so2212928edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yei8ThvI1DB0prMx1DJC9Vbkm4whBS/JFNUI6to2Eac=;
        b=e8ayJaDeHMVROUGX98n51AQS93WuqGQnG5QqGC+MyiNJghIbI83JLUNzSbowWGprBm
         ts/gdhKxjgzrqv1R7+vD1+htQ/RWTtAlhA+/R5OuJbOzzLs7tb1O6j5KOExS5OWauGJV
         Ow4N6TBbfWNgdoUWypIFCLGp6HapPV+GHDIe7Cu4xI0jPyepav0nRt+Z+xhZsknaE99E
         XmtHnd7Asc8az5prDwB3JPT4uWnzUuSRZLzQnTMEps/3WfoZLoZfdvFR6KNC90YDjs00
         Xu05pVfMF1PQlHHQW1ccq4b587oVksGZVKtiD6lRJxUQtNfmyruqotAlnOt18fYp78Hd
         fAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yei8ThvI1DB0prMx1DJC9Vbkm4whBS/JFNUI6to2Eac=;
        b=Dl8qrcGxv4GG14SSZKHNR2kybjlxRT/hwu8JVRs6QBfG0OMI82x0gSKtfpG2UTcGs1
         ldPh+lwuR1NB5wGjW84VHD4FqrtzsjsZOYKMYBCo4wtTDKEursSLVoLsj8SiF3qS8HUh
         pI8d79+MOiG04mZHbMpV2Y0/82ucKvijAta4M0ed0o6dxCeiXw0RMqnuyt2BaWfb7RAL
         0RtnSE6nnewWIlp9OvW1u7U2PYtDau0t6peXAgwIzVh2+3TjxJyPitk92VbL+o1odP6W
         N7DJFrPFTu21Illm/xRYqmxluXM3ZJfP7lJTgQA7oIDtP8ciLfjzTQLkl+Wn37wQElvw
         22pA==
X-Gm-Message-State: AO0yUKUYIOiYZZ/UrIclwtCzw1rCcqyyaxvZ2x8gnNEXTlfcXHNTVZ2L
        65xe+RNmUOtAJ/yp/+Br9FaOth3KUSqa7+Y/
X-Google-Smtp-Source: AK7set96+1dYEvKZCx0zyJzU/+txtxZhg+Q8T4oRJyuGdXlhzrtykb8//QojwLmQSgi13Zqq8t6RXQ==
X-Received: by 2002:aa7:c656:0:b0:4aa:a5b3:15e6 with SMTP id z22-20020aa7c656000000b004aaa5b315e6mr5085672edr.0.1676545114365;
        Thu, 16 Feb 2023 02:58:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004acdf09027esm689428edi.4.2023.02.16.02.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:58:34 -0800 (PST)
Message-ID: <c316e930-6ecc-48a9-4ef5-505e2339e506@linaro.org>
Date:   Thu, 16 Feb 2023 11:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/16] PCI: samsung: Change macro names to exynos specific
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121416epcas5p4de066199144cba18858e68f6d0ccb1c0@epcas5p4.samsung.com>
 <20230214121333.1837-4-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-4-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 13:13, Shradha Todi wrote:
> Since the macros being used in samsung file are for exynos
> only, renaming it to be more specific.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-samsung.c | 116 +++++++++++------------
>  1 file changed, 58 insertions(+), 58 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

