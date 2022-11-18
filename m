Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F266B62EF11
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiKRIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbiKRIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:17:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B693CC3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:17:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a29so6982866lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPhJE6VPTyo0qcaO20Sn281HINRzDdh0cJ106EjQf1E=;
        b=ROvHAxbJ/IuPIP2V9+pObdDyhK8B+4WzRv7zamnhvubvuRQuxb/CHuBJ0nk7Z+cTHx
         FsPp0T2yJsa5MEq1P78Ds1LGKetgiuo1BdbOH9QDRjZwf5Q+veWRUyG+Kw97CUTMW2XG
         WGMl7OdONQeEVxFjCTVdPYDBLWjKIruVvYvBUPwbeX3PjaVt+6bUuEzfbVeB+dOGEkcQ
         KOMPfiRa6TUakJ47YGRM3Hg5eqKdYn+LoAsW7NpviQAPmXMpInFL08shmIW3VA3ZfQrl
         aNZBXfyv1BAWFz+VkzEzwGZlTbXzrjt0EY876LzSPb3JfAGs/piYzeTZ/mBIDFIDhEgF
         bBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPhJE6VPTyo0qcaO20Sn281HINRzDdh0cJ106EjQf1E=;
        b=ONhF/vWjgsCV6tOL2Io7M0sD4GGj7BXXleBYhRKlVKt0OHZHz18lp0pfKKca2DWww6
         sZOeo9cPdtIWAiAFonPi9iGVeLbrhllrCNYwF0xTSDcQmfWVcWzg/nHcZlbdX7kYahoU
         TR8QMfwnAQ2nZriJegpRH1Qv+UiXWjPsL72y3Wkau299CuFC4hRLDM+lkCFWDb0flFQE
         MWXj5/Wzlxku8RCtCiLNbBXOZIeDiYaZTFJBaHwNZANO/8Ae20PnYvJMcsaHau5/yFhQ
         Qp/R+p7z7XYy9pIFNan/AnAWPsaHuO3nudYl77JrkRw6E6eXR3Zul1DiKqZ6A7brvHrD
         A+CQ==
X-Gm-Message-State: ANoB5plIs8uP947fasxnivS4nTbDtjH8CzI9fo0Ry0dtLJJQUNp5HJj3
        ZPygUKfu8vSCTXCzHNQL2wJHJw==
X-Google-Smtp-Source: AA0mqf4GUPLpKm7SefwU0ytUKYrPVdXOQuxVrXO3s0xQxqSx6/W95ez8orUQIe+uED2zAXLivIxQPw==
X-Received: by 2002:a05:6512:3244:b0:4a2:3d81:8aed with SMTP id c4-20020a056512324400b004a23d818aedmr1939706lfr.500.1668759459918;
        Fri, 18 Nov 2022 00:17:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25f63000000b004b177293a8dsm560876lfc.210.2022.11.18.00.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:17:39 -0800 (PST)
Message-ID: <4e5e4f63-a950-f8f4-fe62-1982b66eb8a3@linaro.org>
Date:   Fri, 18 Nov 2022 09:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/7] dt-bindings: mfd: syscon: Add mt8365-syscfg
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
References: <20221117210356.3178578-1-bero@baylibre.com>
 <20221117210356.3178578-4-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117210356.3178578-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 22:03, Bernhard Rosenkränzer wrote:
> Document Mediatek mt8365-syscfg
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

