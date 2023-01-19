Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61A673A66
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjASNfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjASNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:34:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE857ED42
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:34:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1281563wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEuluooIe1Djy5Pq1DXpRGYzfjqm0LFTSxqLkps9dlU=;
        b=R3/MBCO1fZ0ko2of28QHp6yL51jXKDrPCWYgLX15MNRmeDeBb3WfLt5B4cv2oTK8nv
         waX8+Y4WuAQ7DWrcksP1MYMUzoOabYyoN2OdddTrkWYE1VT/WGHdRI9T45jv/qiKXNoG
         Gb1tTn1nKiMiPFsoBH/SUxANigq1GlLVWtoogB8K1rzJaKuBw1C5hqszllr3TGDj3H1J
         6wE5G3MZAk+N3CFY1jauEBf1P6FJnDTmZUvEHfKEuOwlZwY+fBPd0IezBGHOl6xco+kK
         YAo5xd3IeniD99t5E+1uvvO9W7WPWNiDhQAG5Y86HDlUmeIAVmkG0NB14arykyzalcIE
         P7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEuluooIe1Djy5Pq1DXpRGYzfjqm0LFTSxqLkps9dlU=;
        b=qYgje3hVHiCw0ovRL5mHKz9M6/GeWg0FpRy5NoxaP0sA8QjvMz0bb0BrXc44cCG3uE
         7bVqptnEiz0vbVCMOakXt0m9AVZ47UyOnKfmeg4496ddYFwg1dh2MzQlaEkVU/2k08wf
         YpKl2/oSil1f5J9c1xKQcUPYbalNawmN83dmeim52ht/PW4TFEEtG5N+zxBwypMGhJso
         MKdTDqhLZNkTs80sSHYX3kngPGO3PbCcahHzUKPJAkkPcS1JjLYhPeFSuiYW6zR3cw6L
         XK0/VwHq9vqKBiiV3d+ZGx7YuAL6NvznmA13Cwg++Cq5+vCMsS2V5uTeGiKnn37d9453
         zC5Q==
X-Gm-Message-State: AFqh2koScFlGra4IkyrKsIxbe7sI9V+1U7UwqPKWo/iz3U2t3YNylNIf
        1N2OP1O2zWUs5Rrbp1luTyDBFw==
X-Google-Smtp-Source: AMrXdXtiWkBP0Xweh+UUX5iU+3F6iXV1yxsDEBLCFSlq0agjo3MiueI+xACVmz5ZOnyuWlBe1zHJuA==
X-Received: by 2002:a1c:f203:0:b0:3da:fa42:bbf2 with SMTP id s3-20020a1cf203000000b003dafa42bbf2mr9960769wmc.28.1674135266748;
        Thu, 19 Jan 2023 05:34:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l11-20020a1ced0b000000b003dafb0c8dfbsm5945459wmh.14.2023.01.19.05.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:34:26 -0800 (PST)
Message-ID: <a0c944b3-d212-43bd-23a5-666b141a657b@linaro.org>
Date:   Thu, 19 Jan 2023 14:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add binding for AM69 Starter
 Kit
Content-Language: en-US
To:     sabiya.d@mistralsolutions.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20230119132958.124435-1-sabiya.d@ti.com>
 <20230119132958.124435-2-sabiya.d@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119132958.124435-2-sabiya.d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 14:29, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 

Subject: drop second/last, redundant "binding for". The "dt-bindings"
prefix is already stating that these are bindings.

> AM69 Starter Kit is a single board designed for TI AM69 SoC.
> The AM69 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive ADAS applications,
> autonomous mobile robot and edge AI applications.


With fixed subject:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

