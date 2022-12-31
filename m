Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05D65A634
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLaTGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:06:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A569BE5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:06:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so36236538lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIySvWkaHMhvHNet3xt7JxoPX9peCF4NsB4XrthbUdQ=;
        b=DqhzdZ8GMGONjk1/mTp01nVTS73jara4hArPcV1nK4bXiYc9TbLAiKNZt4Q46wLOk3
         kUHVSzEfgAcdS6QoYjWNP2xExsCibkI4td+Z5kxheIMrxM9HNsJ04aQQyn+bFksXompC
         ZtkhNHUXgLBKEcUICB4qz6yqnrbPza3Ksaz5GJ+iDSp9b3gFIssULh1nr+83YqAgkRkJ
         EHPniaYDfdhwqccTrNmJ0ma/NUu/qFZcYHIsrePpconOOeQxnZn21Rc4uKx2ZaPAtECN
         Tg/UHmUXAMxMzNKxPghUA/NQ3uEsw67KOrlk1e8tOQg9ZBmlUnkGqRh0Yip6MAX2JIcf
         mLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIySvWkaHMhvHNet3xt7JxoPX9peCF4NsB4XrthbUdQ=;
        b=JOX45y+H+VtLUeheFjNlzrHDRmvOaWHvQ6b6EW18fh3Mnhl8vqEVH1tTdyofgpDaOP
         4VfzeRQz4mJ86uZEt50c7xnPnPi9rVGJ3upkJJe8nuzv4tZhik/4XjTCq+LpGm6xonAr
         COvBJOa4U/AGCYfOI34F1V/AJtAlYADEyjFq8TG7/vbCy9BSrrS2hujHlEe3G2k9pmf9
         zBTRtedwPi0RqG2bgPny2KU7bZ7xqztvcqVS57SJpTCGi/8KUZg8YxzFjCqXhQvRsZUc
         yS51NEGVz1J8o3y6GqUEliFqFDbgbrB8GE24P/BCveOJYAAjl3w6wDIKUGl1tsLtDpKZ
         1wcg==
X-Gm-Message-State: AFqh2kr7FWmmVK0cYzzmh+kxaONNG5igR0OMZ6aZUKAXnkeekYYyNLy9
        z8zw4sLAWinnKujc5T9hC45Dfw==
X-Google-Smtp-Source: AMrXdXuTfgdQbhaGaIjJutw1ngrQ/aadPT4CRRlOEuJUlZU1qHVVzJzumSK1QyfcO5SFZUTpCaL1Gg==
X-Received: by 2002:a19:f001:0:b0:4b6:e4c8:8a48 with SMTP id p1-20020a19f001000000b004b6e4c88a48mr11142739lfc.63.1672513559388;
        Sat, 31 Dec 2022 11:05:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o11-20020a05651205cb00b004cb34b81150sm80316lfo.282.2022.12.31.11.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 11:05:58 -0800 (PST)
Message-ID: <ea18d873-29a2-2311-d10f-ed3f82d2a46c@linaro.org>
Date:   Sat, 31 Dec 2022 20:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] media: dt-bindings: cedrus: Allow power domain
 references
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231164628.19688-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 17:46, Samuel Holland wrote:
> The Allwinner D1 SoC contains a separate power domain for its video
> engine, controlled via the "PPU" power controller. Allow the

"PPU" is not a nickname, so just PPU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

