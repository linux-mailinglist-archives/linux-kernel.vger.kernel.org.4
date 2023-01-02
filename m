Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5465B4FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjABQUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjABQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:20:09 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1B5B1D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:20:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 1so42149155lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3A8u/ZGvQ/u+zdMS+02ijfzhgqQE287Jcbfn2PLsGQ=;
        b=nsD1fDj9r8KfUFh6NXsi0K/iHf26iPOnFBnPk1q5gNFp5rh8g50KXmXNQ2R5AGnYZ3
         WQ58F2XqXuQRpE1bRd41laCI4AwErNQVTnvF8DAj52Hlm6r6dEuBFabHN130RNXxfKPA
         xDCDAnbPQuNxu4xa/qXt62R4S4vJ/eUFxS75HnRQ4u+nxoqwRPokye8bYohZr/AXlAt8
         UbcGOxld548ZSxrBbDNqBNvBUeFY50uyvZUDFF0+jF9pNGC4Y0jTAE0MGmi1vDAqcHig
         w6zLHKSULHPUcGi4eVXVbu51dm78bwsLRnho2sb40mJkcbM0KNmx7ovKlEgL2GX5X9HY
         9Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3A8u/ZGvQ/u+zdMS+02ijfzhgqQE287Jcbfn2PLsGQ=;
        b=p2jz/B/BGt1Aa1xCKz0VuCU0D2MxuCXhwlbv21fz+/D3TFRqZK4np55E6gxL29euvf
         wLOzyPfQdJm2hyFyPeQwqAJej4ooQnUpl99ZWuCK7aEcGT2ShuX0JjQECE4SEAYpCztC
         HXHp2OtoTaA76tKK9I6ePyWNs99TZiETTDQH0Bg+5O9k/YfrTU8y7pCl+U2h8pHOE6om
         tzAIw/Lpb5KZO8WQqlMuMnb34Wdk1VatqIRvtD/Pu2bk5WCzM4POgUrDx15w7XsA9g5g
         nGG8B2h9DODhZHatNKacDqWfDYRnMbIuUgApfjtq0teU63eDTyYtmmZy+p2b/V/bO0gz
         PEOQ==
X-Gm-Message-State: AFqh2krE2bhTx2LbFwF0omQ2Xc8tvwAvkZQ0LVyyB/W8ExEl4fULINYU
        lAf/snKvtoMJnFCsUQPCRDqc5A==
X-Google-Smtp-Source: AMrXdXufChGyPfDAtZg7eDw3Y+8UbIrIoQtz8mcF7V8z/KPz0mOltbTDF2y7e5TD5DohAD8pZKcxTg==
X-Received: by 2002:a05:6512:3135:b0:4b6:fdbe:773d with SMTP id p21-20020a056512313500b004b6fdbe773dmr11657064lfd.43.1672676406353;
        Mon, 02 Jan 2023 08:20:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q23-20020ac24a77000000b0048a982ad0a8sm4520838lfp.23.2023.01.02.08.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:20:05 -0800 (PST)
Message-ID: <43ee7ca8-de65-8c0a-20b4-e3cb5f10a3c8@linaro.org>
Date:   Mon, 2 Jan 2023 17:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 10/13] dt-bindings: mediatek: mt8188: add audio afe
 document
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
 <20221230055443.16024-11-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230055443.16024-11-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 06:54, Trevor Wu wrote:
> Add mt8188 audio afe document.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

This is still not fixed and you got comments about it. I am not going to
keep reviewing this patch. Implement the feedback.

Best regards,
Krzysztof

