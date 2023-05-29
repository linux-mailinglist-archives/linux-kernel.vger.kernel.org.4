Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E017714A99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjE2Nq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE2NqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:46:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E94EA;
        Mon, 29 May 2023 06:46:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30ae141785bso2307773f8f.3;
        Mon, 29 May 2023 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685367966; x=1687959966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AYQ9n22p6kGQgSL+k6B4EzgHqUeQB6SOyA61hXG0lI=;
        b=V/EeDWSgw/h4RDwCInZqp6hv1Kes/5qnN6lCMscvMfcHgYuQcvVCY1OjROwifMtTvU
         SkSMGpaYs576Qsp0BygcfUKwGyLxsAwTjgalEUJhPqkAg2jOKxe+07HQdY9PMGUAJif/
         GwyltWytfgoPGflsfCgk/4vRftg6kfjHT+jo/U6y3SZcIQ1KNejzonH/nHYaRX8yv9qu
         mzwTU6fsTAMq+kgDmzchOIXA6ZPHpSCTrhKTzmyBMfCeV2zzYU5i/euWeUwJroWse0yk
         q6LpkvLjPNnGdv7ZHm4Kgn+nCY77dotOVgnZ5V6V/6q5NQkJAYRUBQ/N/Q2iEv05k7Z5
         B7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367966; x=1687959966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AYQ9n22p6kGQgSL+k6B4EzgHqUeQB6SOyA61hXG0lI=;
        b=aDtT8VcPmgTljjUNQNe68JVAlBoA64wOn0OThgGuFlJdWbRytdFY0bnOnufIDg2uXF
         Ts1b96zAxC6GYw080EfYrGmdDbuLoMcb5BVdzwy/MAKhI6Ku7a6VCeM7NuNyFJEd81d7
         iAvCm3goO9NSsYHX2xCJ4tYhIE24s6YYWTLjnq/E8aP3fYVShl7PY8A5Snenf/2JDIej
         GhUXPNdyZ8XKUzgtr443u7PEh82IUxifgS0I3Nh1lx30fsw5RqC8RAaOU2uEvQ7GTZRI
         Fm2BZETWQ7ybOTA5BzAFzo3Pbi/FS4rnKfO3Pu9QIi587GZ+00eCrI/7eXCPF3PE6qv9
         hSHw==
X-Gm-Message-State: AC+VfDzm9sGY6cgFn5tB0+doiWBGeZScHvZo54BYvDcXPu3T5FU0PLrg
        SeRbzGF3hu/USxKexlxlPjw=
X-Google-Smtp-Source: ACHHUZ4DCP3yYPiV76uVb9gUCr0GOWhiUQLj+dUIEsUz95VI9sBskAqjc9u+6S35gzmLJKY8NS/DOg==
X-Received: by 2002:adf:e941:0:b0:309:53ba:9703 with SMTP id m1-20020adfe941000000b0030953ba9703mr8503887wrn.16.1685367966245;
        Mon, 29 May 2023 06:46:06 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u5-20020adff885000000b0030ae16132besm41563wrp.12.2023.05.29.06.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:46:05 -0700 (PDT)
Message-ID: <ec70aecd-3229-ee5f-1375-1a116a1f6213@gmail.com>
Date:   Mon, 29 May 2023 15:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 0/6] Add and update some driver nodes for MT8186 SoC
Content-Language: en-US, ca-ES, es-ES
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
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



On 24/03/2023 03:12, Allen-KH Cheng wrote:
> This series is based on linux for-next.
> 
> Changes since v4:
>   - compress the compatible strings for display nodes
> 
> Changes since v3:
>   - Add index for ovl in aliases
> 
> Changes since v2:
>   - Remove some unnecessary linebreaks for some nodes
>   - Use one line for some properties
>   - Drop "Fix the fallback for mediatek, mt8186-disp-ccorr" patch
>     (since this is applied in chunkuang.hu/linux.git/log/?h=mediatek-drm-next)
>   - Separate GCE into another patch
>   - Drop some patches which are appied in matthias github
> 
> Changes since v1:
>   - Remove the unnecessary trailing number
>   - Add aliases for ovl* and rdma*
> 
> Allen-KH Cheng (6):
>    arm64: dts: mediatek: mt8186: Add MTU3 nodes
>    dt-bindings: spmi: spmi-mtk-pmif: Document mediatek,mt8195-spmi as
>      fallback of mediatek,mt8186-spmi
>    arm64: dts: mediatek: mt8186: Add SPMI node
>    arm64: dts: mediatek: mt8186: Add ADSP node
>    arm64: dts: mediatek: mt8186: Add GCE node
>    arm64: dts: mediatek: mt8186: Add display nodes
> 
>   .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  11 +-
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 225 ++++++++++++++++++
>   2 files changed, 233 insertions(+), 3 deletions(-)
> 

Whole series applied, thanks!
