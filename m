Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCB714DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjE2QJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjE2QJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:09:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29901C4;
        Mon, 29 May 2023 09:09:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso22997155e9.0;
        Mon, 29 May 2023 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376538; x=1687968538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EWH1RGi3evo5KxNcmukt363dFuq46wqFUtOjsuXhA8=;
        b=jQWMhVOJqrhhSLKnkMuB/L/2hC8SDBzu1rHeomtE8ZHb1H8SRPhi8BFlt6zA2V1nzu
         80MNtbfVt2Jcq1qnzY8v/DYSIeNtkB9B61vaJfc0bAucpcI+StpT/pFFsXXT8vcYAr1t
         FHwgL0WH4KEyUeJPRYhipiuxOvvRSLpnnNqJ7xWjIG7Q2KfFvBg8v4cVYXR8upiZ9BTB
         gTtaSfYDiXWLD6BUPqAMRJbhcfW6uO04W3RoW7Bu3SpsYQ74lFVc1ZQG03Sk/OBkTCNs
         vB8RjvCqHGAc4ncYQY9efNDbVRMm3ssoeDolQJaRuwZdAomcHoSBzBn24YJF3REha6pf
         NERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376538; x=1687968538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EWH1RGi3evo5KxNcmukt363dFuq46wqFUtOjsuXhA8=;
        b=QW5fUWAjObh6E4X9eeOYEMTdMG3S3QEPAQJCn74z1frhHaRmkTIka6XbDpOEB5TXIf
         XEcRhy19L2RNGYBVzJx8vBNxdcikIFT0gSDgnjcdRYcv3Ge95GXSQmGrKEFbgq5JRyG5
         imrnRVrGESffgcl0OZ8dnxen1cMyiu5C+bZuJji1puFWqmNqGPc+s2EhwHVPk3m462ay
         ePiAQLRx7S4W4GEhOCIfAYclK06g7FluUkqbP4RO8IU+L5UuJ6oA520OLtRmqIVAKAGs
         w/KLoIgbcWqNfY0nEEHM1baDsnPIoeqzjsF/0Auqg4WiXkMhUC2+7bKka8mjozIaTQSr
         6Whg==
X-Gm-Message-State: AC+VfDx5V/lOay0xsClnbH6UC8GiR0y2evJ1JHhHKs97/ZL85pzJnjMT
        3HZJZzUZWLK5wCLYXVHcISo=
X-Google-Smtp-Source: ACHHUZ6D5hrPwjDQc5UEg00LPOMeU4uSzujA/kxxLTkMASJjd1jfli8yHkc3tVvDbHl3qIB3XT0Jjg==
X-Received: by 2002:a05:600c:22d0:b0:3f6:f56:9ad with SMTP id 16-20020a05600c22d000b003f60f5609admr9718894wmg.13.1685376538448;
        Mon, 29 May 2023 09:08:58 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003f0ad8d1c69sm18229641wmm.25.2023.05.29.09.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:08:57 -0700 (PDT)
Message-ID: <cabc40f3-d1cb-bdd0-bd96-1a51cb861579@gmail.com>
Date:   Mon, 29 May 2023 18:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] MT8192/95: Set correct MSDCPLL rate
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, weiyi.lu@mediatek.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, tinghan.shen@mediatek.com,
        seiya.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2023 11:30, AngeloGioacchino Del Regno wrote:
> This series improves both stability/reliability and performance for
> eMMC and SD cards on MT8192 and MT8195, where the PLL may be set at
> a sub-optimal rate from the bootloader.
> 
> This was tested on MT8192 Asurada Spherion and MT8195 Cherry Tomato
> Chromebooks.
> 
> AngeloGioacchino Del Regno (2):
>    arm64: dts: mediatek: mt8192: Make sure MSDCPLL's rate is 400MHz
>    arm64: dts: mediatek: mt8195: Make sure MSDCPLL's rate is 400MHz
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 ++
>   2 files changed, 4 insertions(+)
> 

Whole series applied, thanks a lot!
Matthias
