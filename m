Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4144373124B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbjFOIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244920AbjFOIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:34:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272E294D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:34:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-97881a996a0so253507966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686818082; x=1689410082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Iup8VQNhl0stIDF+NtcLsVwne6Lkml2Ei0ct6/cSec=;
        b=b+zjG3JFTQ7EwjgMRqIAIxDAWGf8Mtgj47ozpBUTfjEN+ShwZ896y0vx68UDc/U6xS
         fyiuO6f7lGaTT2Cijt9kQijua6uW9P8fh675h53fv5FaoO/JcxVYDgarxgM740lXy7BS
         QrQZ/j4tmgICJcjDhearcMV/DiaKjdAoQHfCcUTYBJpId5Z2e23hZzdOK7CXVVZGiGX0
         X9Ngw/Mmr2NUbhZp8uLbCn/d+UOqiNTHL+6+VETkjNqjdu8jTiT/qfdydLR5bs820sEM
         6ehlRaBivKLseRk8QNkEl60vKBCvAe3Gmk5Pjc6F3bfSaLDMxvUQOUqVW5ekBP1c00w6
         tdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818082; x=1689410082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Iup8VQNhl0stIDF+NtcLsVwne6Lkml2Ei0ct6/cSec=;
        b=WIqrwojc1mh/AbURIF3H9qszHgofq7NEGnN9BfbB/VRLzwet5/TF8ugi7X+ebeddtB
         Y738w/+bya9OW2nuAJx+RcmY7JZ5aRNPmX7rc14YQSgdAyw7qlkE4C+E36Ej2IS42QBP
         JL/I+tuYgkt+e95UWrxC4Jbg9W7tMfU6sBvGNbxIryyI1CGy+oCG9PXv4mdDkiX59PIk
         RcLBabtGAubMB8hmqRArTUUuUHL/GFmEPLT8pBCz8DE2rqj/+X2fKUoU45s2/mepsH/c
         W0cmGupIeCDrVAU3KdtMKXshR4wVnj3Cjz4R9xWEbnx09IBnq+GR9isnJcWKdjxQ+qke
         2wSA==
X-Gm-Message-State: AC+VfDxO9WEJq6x899T4eTno2z/aQC48+L7DnD1PHnpuUDwOHEixlNfM
        wLQHcrdXU/PDGwFsyaRrqoCzfw==
X-Google-Smtp-Source: ACHHUZ49mdKDX4D1IVd2EIxLIsTaIb1/nyceVdoyxS1eb2z7KL+iBlG2flpGnrAmQkcXmzH8v9sucw==
X-Received: by 2002:a17:907:3f83:b0:94f:704d:a486 with SMTP id hr3-20020a1709073f8300b0094f704da486mr17808684ejc.32.1686818082440;
        Thu, 15 Jun 2023 01:34:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709060ac600b009745ecf5438sm9000371ejf.193.2023.06.15.01.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:34:42 -0700 (PDT)
Message-ID: <2e5b85cb-018f-d912-629f-8204ffdbf12c@linaro.org>
Date:   Thu, 15 Jun 2023 10:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/15] dt-bindings: reset: mt8188: Add VDOSYS1 reset
 control bits
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-8-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614073125.17958-8-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 09:31, Hsiao Chien Sung wrote:
> Add MT8188 VDOSYS1 reset control bits.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---

Squash it with previous. You are touch the same file adding almost the
same bits...

Best regards,
Krzysztof

