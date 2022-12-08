Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22212646C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiLHJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiLHJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:44:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680EA6E567
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:44:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so1205536lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Au11CpDwn/UURJjwp0rA3AGArUSenl9oJW8Wm3b2MRI=;
        b=oQVy6g6ftbqQnTmQTVvMb8OUxjzE6cI+OwClMDRYtJL4J7shXtdgl9dnIFESMg6CXE
         sqwdeTvpk+qjGrsm+NgWkouPci01Y2frsw5t7yX1DRHmgqOunKOtK3ff8qRUg8Bt6A84
         Lz01eBaKYwHp2SPGwO0/kHZYYcALchNo1wb9OaGkV2K3RFNjkOos7mwrjM3fwYhaH5Cl
         Tv06SYsr8e41IzLg1ZKClIDbCOinFFZwWjxbVSTs+84VG3IA7Je/PalFrAQL584XFyZ6
         hgnxUFkMqlfRGGUHzu+jDTev1aojSSEBZ2qbJY49MFOf1CiPoBozUAiK5YI4c/XvKlwo
         h2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au11CpDwn/UURJjwp0rA3AGArUSenl9oJW8Wm3b2MRI=;
        b=nmWaVlokrpCes2cTThCFfrlkO4jino+ga8XBWfF738DWcJg7ipN9ijmCjLINK0ZGJ2
         ngwEOWanq5nOXvBXauW675Vaycpot0E980GMxqhs/8OpleeFcrrra3GJuL5UOvpsCmFw
         AqpPdYz+4kdhPc2Fl1ptc75JtyADNjtG0xMP9bCsdIoA25J5w9JAjqHL/5VmLDv905rt
         u8wPXQWeiA2lvAS3EgIVsA9/9N7A8GyjR95JSy8T0wXOFXR7P+6+fwrq9MzgFPoyEtHq
         O4YWbTWOFJbx/A4ESqLKoNulqgHtJtcr3CG3z3f/KdXTyFkr5cjKBz7yDkysZylfKnXs
         pmsQ==
X-Gm-Message-State: ANoB5pnQ6u4TwZ9u6X1uSk+Vz3Sbi27VgNBhhFs9loLSiHJZes5NiJjZ
        lw2t3oxY7cWIV7qgJLr3yDlBAQ==
X-Google-Smtp-Source: AA0mqf7iPq8OR3W99hPV0n9RoC8HsGux0XFBkldIaraeJ45vK01ol6MYOTxEh2bE5pnb0/WQaoLOKA==
X-Received: by 2002:a05:6512:3f0b:b0:4b5:22:7fbc with SMTP id y11-20020a0565123f0b00b004b500227fbcmr19179516lfa.183.1670492681820;
        Thu, 08 Dec 2022 01:44:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p21-20020a05651212d500b00497b198987bsm3273986lfg.26.2022.12.08.01.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:44:41 -0800 (PST)
Message-ID: <4dd69cca-3ae1-7fda-b1ad-01087449afa0@linaro.org>
Date:   Thu, 8 Dec 2022 10:44:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 9/9] dt-bindings: mtd: mediatek,nand-ecc-engine: Add
 compatible for MT7986
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
 <20221208062955.2546-10-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208062955.2546-10-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 07:29, Xiangsheng Hou wrote:
> Add dt-bindings documentation of ECC for MediaTek MT7986 SoC
> platform.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

