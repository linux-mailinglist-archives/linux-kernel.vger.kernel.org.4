Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67A627A59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiKNKWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiKNKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:21:58 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522461BEAC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:21:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so18475122lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgnoGZsYxARor/OCp/6dnWx9J4VVIiEe0uaBuw5cWvk=;
        b=X6YMAf8ibewIU+D3PzUclDDzp8GeUq8NOXS5p4KqiO0xk1gFK3Cv7kZXBe3CybK6Cq
         y7MJxu4bX3COpToy6wUDUVdV/yD2kVcka4EbaAzcB7IlA16P1isqp8jjHaaRm2JBuCUm
         ILDGvMrbvAyThchjp1pAmtHof2e/jeZyU4GqrtZqlH5Yp1am41cu5/HpAe3QppBO2zzH
         Dn4U9yjaHjBs99Co0ewCQZm+9+WaT/2059PkzgRwqChCLTM6P88HJIT2Q+hn6htZDgBS
         Ih65atG0LXq3M0as9GGnLLHGfH+FvZDo6ZMuPNAzpZVuPm2Gg/zrQORgio9nQtSDZaee
         QrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgnoGZsYxARor/OCp/6dnWx9J4VVIiEe0uaBuw5cWvk=;
        b=zWrXTLjkV9vTbo835auw9zgwnnvJt0GYAWeJ45I02k7bpXsq8vUmaT4qg6LHzULb8N
         yi7FLm4YFHgOgsdj3NJS2+RtrUQ7RA+4NrGYgHArClz21kPwFUbHUguXhdCJIZUPserJ
         nk0eKsVBo3r8HMkTKZPfSTX4IhXXk+kdn/6LE2lSSlucoMFaoxOVy6ij6nWNLGM+q96K
         B28ZYmHUhDOM8y0GHkQ1a/uY1wkTSNvii9WzTbpX+tCEHJdJaaRzM7Bh+FtFJKApGTil
         izidi1/TJ58jBnWRbmcSUgeouXenQG/phmfI5fkfou15a93N9cafZDH4pXK3ZQPcf4d4
         aLEw==
X-Gm-Message-State: ANoB5pmINWhjyhGXvgQnCW1hGkzcD8RB3XculD3L0LsnYNvL+UaK/8ik
        lDXD1rCRu4T9QwyUjQRTemQcug==
X-Google-Smtp-Source: AA0mqf4ZpyyLf9KjUSnx4MxnRjq6NDx8ExuP9U5TgOYBfHBsk1rEV1fb15/VVoT6MZibItMgYxsZ+Q==
X-Received: by 2002:ac2:4d32:0:b0:497:5e53:cbb8 with SMTP id h18-20020ac24d32000000b004975e53cbb8mr4469173lfk.325.1668421315578;
        Mon, 14 Nov 2022 02:21:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p9-20020a2eb989000000b0026e90b478c6sm1937705ljp.114.2022.11.14.02.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:21:55 -0800 (PST)
Message-ID: <d8c0fb0e-d3ab-5e2a-2cf1-5d7dea8cac6f@linaro.org>
Date:   Mon, 14 Nov 2022 11:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 07/18] mfd: max77693: Replace irqchip mask_invert with
 unmask_base
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-8-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112151835.39059-8-aidanmacdonald.0x0@gmail.com>
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

On 12/11/2022 16:18, Aidan MacDonald wrote:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

