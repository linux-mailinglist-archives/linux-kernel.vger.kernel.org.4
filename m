Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF05B3BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIIPcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIIPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF7923D3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:31:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so3296558lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BvCXK3YQt13LeJapsx/v8Xr4fEe64m3JS7hEavSdj6k=;
        b=AXANFeMvuASemcbrpl0qNmBJaM4SfLLb49QfgpAESk6Q/BLHIVQnylJZrHSDveuEa9
         0PoUPllENRkfFM2UkOUNIKY5AjnFqNHPyCuMDx6BIt1X1/HkTlaC31+gMuIFq3/ZibzH
         SFraiPdNfM0DAc0lDzyApKD5fpJFrtPDN01Dd3TdZU1AfiTjVBt8lrURtlamZSd8voVS
         rgpeflEiEjVhsBilmiBaYnNW25Vv63ferNVKWFq9d7Cxg/xq9zUdo7ZHiXw9ZHoc+/Q0
         g2yiOEL+xv4uzgrhvtdSq/K9axzuEvks1lLf/1Yj8PCC34jgPd6PiMZBQCnBcX4eptXi
         2fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BvCXK3YQt13LeJapsx/v8Xr4fEe64m3JS7hEavSdj6k=;
        b=Pq32O+W82thEnkwXRTkVj+FBA4kpr+ng5x2IHDnZQQyZMF+6du3MNDgSnINaUSPNTX
         5Gk4ie0rxMiH8bWBQW1m07ypI2DnP09z8fClHd3MJtJ3SCs1yU9AcAKobUUPf6+Rt6fS
         /0WUpq47UIuyZcp9C8Wo68ccnlPhXp0iHMPNZTqUr2I9JR7/rFH9q0XMYbxZUNPoSsbG
         0cO0SqqUBS/L6Ba7wwXitytQ53h286EQcVcgjhGQTER8kuTJ4ujBHmbH9oEfxZHQmU2B
         OIBL1ws5+35g2cNOZnAGX+GRgwh05eUV1HTORmVbSRN6J4FxrzlpORxiRJcdjkxhX58o
         wT/g==
X-Gm-Message-State: ACgBeo3//W8S1bCuS2I3q2G24F6Y8HHD95CF5KA++4zopLLGuHEcv1/T
        GmunE3fsT0WkZpBLGuUs/5xong==
X-Google-Smtp-Source: AA6agR7Zd7IRUHOhcUXLKhW0kDnZxC9nQxGqcrpEnbQbCu13nvdQHY9NW7WmFbYYOhqSjSsta8L9aA==
X-Received: by 2002:a05:6512:1395:b0:48d:81b:4955 with SMTP id p21-20020a056512139500b0048d081b4955mr4408315lfa.307.1662737448433;
        Fri, 09 Sep 2022 08:30:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6-20020a05651c00c600b0026ac3fedd20sm117314ljr.86.2022.09.09.08.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:30:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 4/4] memory: mediatek for v6.1
Date:   Fri,  9 Sep 2022 17:30:37 +0200
Message-Id: <20220909153037.824092-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
References: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Topic branch.

Best regards,
Krzysztof


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-mediatek-6.1

for you to fetch changes up to 673e71df5ccfaefeb32bb5b3130a5d397b742194:

  memory: mtk-smi: mt8188: Add SMI Support (2022-08-30 20:54:05 +0300)

----------------------------------------------------------------
Memory controller drivers for v6.1 - MediaTek

Add support for the mt8188 SMI memory controller.

----------------------------------------------------------------
Chengci.Xu (4):
      dt-bindings: memory: mediatek: Add mt8188 smi binding
      memory: mtk-smi: Add return value for configure port function
      memory: mtk-smi: Add enable IOMMU SMC command for MM master
      memory: mtk-smi: mt8188: Add SMI Support

 .../memory-controllers/mediatek,smi-common.yaml    |   4 +-
 .../memory-controllers/mediatek,smi-larb.yaml      |   3 +
 drivers/memory/mtk-smi.c                           | 109 +++++++++++++++++++--
 include/linux/soc/mediatek/mtk_sip_svc.h           |   3 +
 include/soc/mediatek/smi.h                         |   5 +
 5 files changed, 114 insertions(+), 10 deletions(-)
