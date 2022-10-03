Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723705F3131
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJCNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJCNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:25:03 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A191F2E6;
        Mon,  3 Oct 2022 06:24:58 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1329abb0ec6so281302fac.8;
        Mon, 03 Oct 2022 06:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UC6MSONY3vLkuMDaO7L4lnAgj63J2DwMG65oUzBFyAk=;
        b=jxh95zGmLlSlqmxTDEBPzJrsEA6XIc14CXD2paAJqCfpZDsxu/r+uMnLGxzw4aFTJK
         ofjfG2eveODmM2m3bzB31UcmOFqidTEir0pH+t/q0UwMcAnjlLFw+x1Cp0uIGIUy+8Tb
         pR47NhDNJJQjuSexu9MHFTJJaZQv8PcqFk1rBqD8T6UYpJcAX7oXCaxrpCUjhRLBMIUD
         H+fToOviEfQY/rl/CB2BZ6/Kj5UrIS+cMHEvYYWQnnmV0clnBDFgO84BTauRW8pymjFt
         4hoXd61jsEIiaYAx17Nqo7CPQQ9FU1HOK7DFGSBjvdXzjxqtzjqJTQGQh9fV388XuJGw
         lBog==
X-Gm-Message-State: ACrzQf03Xkx1R//RHreI+ARwphOIERg9ENuqIyKg4QKpDSa1RuwzAlrd
        3OiVDQzZYpvlHeFTFyKeGQ==
X-Google-Smtp-Source: AMsMyM71sXM3bBdvdcws90nBNoMbSopHlJ/SFYjN9kST5ujwFHp2n7tEk53k8931au5a/27ttw6cSw==
X-Received: by 2002:a05:6870:63a3:b0:132:8fec:b67f with SMTP id t35-20020a05687063a300b001328fecb67fmr825243oap.27.1664803498467;
        Mon, 03 Oct 2022 06:24:58 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a15-20020a056870b14f00b0013191fdeb9bsm2908984oal.38.2022.10.03.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:58 -0700 (PDT)
Received: (nullmailer pid 1863811 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20221001030752.14486-1-irui.wang@mediatek.com>
References: <20221001030752.14486-1-irui.wang@mediatek.com>
Message-Id: <166479591681.1661748.6265395941647267106.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mediatek: vcodec: Add the platform compatible to schema
Date:   Mon, 03 Oct 2022 08:24:48 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Oct 2022 11:07:52 +0800, Irui Wang wrote:
> There are venc node warnings when running dtbs_check, the clock-names
> was unexpected, missing properties '#address-cells' and '#size-cells'.
> Add the corresponding platform compatible to schema.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../bindings/media/mediatek,vcodec-encoder.yaml      | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


vcodec@17020000: clock-names:0: 'venc_sel' was expected
	arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb
	arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb
	arch/arm64/boot/dts/mediatek/mt8192-evb.dtb

