Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2090167247B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjARRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjARRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:07:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFC56880
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:07:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q10so15315307wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDIkYoUKpwXcLsPOXjkS4dZ5v5rzkth8xqHID8araZ0=;
        b=FOgryLaRWmZq/Y81am3nQJ17GCz3HZI7ullbQRnY1w7FYgVZ6usB1jiTp/182xIoev
         +mA9b1fXdI9bje/xAetkMgJV7zYyPpYMSQsPXpZP4kZGwJT9j9d41nxfm0w72+bYnFNW
         e08+bPUnDTjOWatpOAJ6HnMjysrgmQu1lv3UAL1GcJpwZw7Fb/e5Ke5RISfg5W8IhKtS
         mmnhAMkpB7L4KbeutChadu/r0JwKh40WAf4AODa4ThRtu9qqStc5bEiMXBwsjebF3mnB
         QOdlH7qVsJTO4wxBA3OntzYYJjSrfDrGCPDeuj3JgqHUQyciODphwZnU4ld62pq/fA5q
         Wd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDIkYoUKpwXcLsPOXjkS4dZ5v5rzkth8xqHID8araZ0=;
        b=dQrRo/bLfWk75Ly+T95C+WIpj7KgSCNPQfXbMh1uILAYtBNMcDmV/eyqIb+JlYyD1U
         4oGirbljgN1Aa5qC/6TC3Wf2lgGAfQSjJx7TGezz/AbBmato2qPUHTcIBKuqdOSkTmJq
         d4IOMetjl7AksJeWcQbJLgMas64rjvm0hRfebGFwLQ238PlWHznRnHdggjJK2KAh4LiE
         bRD2rkknv7IIHJ0AEyxPUqjFswuVGVUedJ2yBTS9Dt0xQvj2ZagcmsmX9BhCClZS5NHJ
         RPWeEOpQDKSRn7br0qsPZHsNT2MmmrdVEzYXo4++ZPYaofaBU7ceVx0hC0ZuW/CNbsZr
         ewgw==
X-Gm-Message-State: AFqh2kqDar347aFhyExB3AMNGbMN9i/TZ+uCiOvY94j7l+I5QoLqhljF
        nldKz3mj23z3GVJLW64tv66FiQ==
X-Google-Smtp-Source: AMrXdXtpVLS7rUfdb0GfV+Qbmu61zOK6asi1msFxCjzb6S0HTzIMy96OP7uli2T2dDGOkOmi1DDLdQ==
X-Received: by 2002:a5d:5270:0:b0:27c:88f3:8cb8 with SMTP id l16-20020a5d5270000000b0027c88f38cb8mr6249876wrc.25.1674061675940;
        Wed, 18 Jan 2023 09:07:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm9141443wrp.58.2023.01.18.09.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:07:55 -0800 (PST)
Message-ID: <95a39704-6a13-2d7d-3231-37fbc1906beb@linaro.org>
Date:   Wed, 18 Jan 2023 18:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: ti: Add binding for Siemens IOT2050
 M.2 variant
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
 <3f825ff8853b1ffd8228d3283c7da0483ddf55d5.1674059300.git.jan.kiszka@siemens.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3f825ff8853b1ffd8228d3283c7da0483ddf55d5.1674059300.git.jan.kiszka@siemens.com>
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

On 18/01/2023 17:28, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This new variant is derived from the Advanced PG2 board, replacing the
> MiniPCI slot with B and E-keyed M.2 slots.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

