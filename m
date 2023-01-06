Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C36660094
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjAFMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjAFMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:53:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4543A68C9D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:53:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3473947wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lg95IM+tC9QCYXFR0tnjHxS+vn235dARGzTIx8x9G8U=;
        b=eS+0K5xrEdXJ+qZVvOYe5NfSn81rS6v8A8ERFmPKFsKzigcX3a5SUnTO+3AU4ALaMo
         fLfV99WcUCeU69909fU3Y/IyMrAd2rJ634S3+QGfnKWs5lQTXbPS9BogbiI3h5gZNx5e
         +ET/PD5w3qMwhMcKe819uUrg4Zr/OyZj0lS/LmeyUNes4fKnIfuD++JRC47qUxVzdSkH
         dqfFTPO2L6dZXkRlYwfspnx8yBmFpFBNCS4aqHRz1KsWjIdALm0Iil0tNrIL6NPPQDEt
         rkMMDjVM4ZHqWw//10BXlNzX/LtY20G0pUdQZZ2LvQciLgTxB2h1U9AvGiPo/ox1xVsS
         /jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lg95IM+tC9QCYXFR0tnjHxS+vn235dARGzTIx8x9G8U=;
        b=HNNeeHgetYSLP2Srt7yJ8AhDTelnOO9HoR2ze8aTaqUx0aWTsWuHx77POxjtesii/i
         ZS0pzp6du0euU28oLdQ+FaMLL8xONhJ/n6yAVY50VRM8poTkY1QjlHm/PqNJvge75Oyo
         R4Tr+uTtkbDWW/hV42QwaWCyyA7LWvvsnFPFrZhnqjQMR6SRiZkI2YcMoQPBFgMtc/Yy
         wP3HjfiOnQEmbmZAoi+txZDQ9Bz2s86rw2g9B0cQK2FG8itRaxhnE+WapWBlPIuwVtAn
         4YhPvFzRPwYjyiCiG2bVZzwg78o9ddVGno+dcZjm1YBKlYkUkyNwm2E7Uu/vLNBl1/sa
         0sEQ==
X-Gm-Message-State: AFqh2kqW3tNsf/rDkekp3iqxtu5Ekn06pUgyvssBEoQhfDJ8SSjIDZWx
        od/jqErh56U556Wt0Tf6mFbbeA==
X-Google-Smtp-Source: AMrXdXuHxUKRCMYm3YdYD25Npq9EAUUAqfZ5C0+8c7OUJHCMl/YfxQ/20dgGk6JdQB8y7rzM4XMwFw==
X-Received: by 2002:a05:600c:4e13:b0:3c6:e63d:fcfc with SMTP id b19-20020a05600c4e1300b003c6e63dfcfcmr39056559wmq.35.1673009590878;
        Fri, 06 Jan 2023 04:53:10 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q22-20020a05600c331600b003d9dd62deedsm1459302wmp.30.2023.01.06.04.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:53:10 -0800 (PST)
Message-ID: <312779f4-b999-7dbf-3c52-d02dd784e1bf@linaro.org>
Date:   Fri, 6 Jan 2023 13:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/4] dt-bindings: thermal: qoriq-thermal: Add
 compatible for i.MX93
Content-Language: en-US
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
 <20230105101748.6714-2-alice.guo@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105101748.6714-2-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 11:17, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add DT compatible string "fsl,imx93-tmu" to qoriq-thermal.yaml.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

