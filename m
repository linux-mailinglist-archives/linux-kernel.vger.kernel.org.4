Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA160612E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJTNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJTNMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:12:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5ED1413BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:11:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so34158399wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNOCO5Wzuq4FvlmMhHTUbdlTAohmkL46icpaXsf0/1Y=;
        b=QOuQgD+AnywmC273rOOD7wCOi9HQmQ56/7iOyJ75teIxtA4bmAPiRAFH7PSBR0ASfw
         ciaQkCMdpZ3rGKVFQGqUNCuTm8pFMpxtTWKEXSHu/UyfQTQCZUXjzbNmXvY7s5AiZMW4
         nKmyPm5BUA0zx39xS1iwxsU4qtfDjZQMuiPYNBFlLjObNpeA85XSgnoK6rn/OO6VmQ4p
         MdXmni/HcMV3Ewqmn4sfA1F1KWBC+Ing3I0xvg3QNRPAto+7zYp2AwrJyhOMZevSWDHu
         i+jbtGn+397825BiRkIuE3ks1wxsnV4onWdReX/vE+3+NOVOHO/VS1vkBilzwfj64BC0
         EmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNOCO5Wzuq4FvlmMhHTUbdlTAohmkL46icpaXsf0/1Y=;
        b=yT3XELujS/g13G65/YUo3VHaLKN6G7EMwbl1JNeMz4Ov3qkJUMw3UFbH3lEHZtvdfl
         L++UgL2V4iZuQVowWeiP6dHVccI1WaY4Qu/9/rNEfPAk6tu5++K6FeDyWnxKXrfJhaCt
         vWIcOGFvCqsxME9HHqhdBJyCGwjS2t2krWBzBV/y9fqe23CtDnCr8WOWRWmUQ4VP3qnd
         pndE/88PtVBmhHHgXuxx8OCtsy0uWhGzpXTYpxbDrX0waTd/hnjkG/hXjcuQyxGSkqCj
         xYW8PM4kkDHKrMVDJ17rGucG1ouyiV/fEZmSPQPT2pPZAvHWDalu9N4KLDcjfbMpWphX
         WPWw==
X-Gm-Message-State: ACrzQf12ZsBxDsN0RFVqUAQ+owvfyH1U8aCWyx6rhrzUkpkOMLxqbSBA
        ejp64b1Ik39RW3ozVu/ayU6k0w==
X-Google-Smtp-Source: AMsMyM6GCgm7Wfy7/CKyZj0ERQNdjCwx/MEL17rx5YpYMjNxqw7Ii8gcVJ3PP2LGk67rqCwyUTs5hA==
X-Received: by 2002:a5d:668f:0:b0:22e:47be:3fa7 with SMTP id l15-20020a5d668f000000b0022e47be3fa7mr8558572wru.200.1666271435924;
        Thu, 20 Oct 2022 06:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a82:90b0:2979:1615:9a68:f204])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b00228dff8d975sm16453927wru.109.2022.10.20.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:10:35 -0700 (PDT)
From:   fchiby@baylibre.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
Cc:     Fadwa CHIBY <fchiby@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] mediatek: pwrap: Add mt8365 pwrap support
Date:   Thu, 20 Oct 2022 15:09:53 +0200
Message-Id: <20221020130957.25197-1-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fadwa CHIBY <fchiby@baylibre.com>

Hello,

This series contains patches related to the support of mt8365 pwrap.

Regards,
Fadwa CHIBY

Fabien Parent (3):
  dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
  soc: mediatek: pwrap: add support for sys & tmr clocks
  soc: mediatek: pwrap: add mt8365 SoC support

 .../bindings/soc/mediatek/pwrap.txt           |   3 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 114 +++++++++++++++++-
 2 files changed, 113 insertions(+), 4 deletions(-)

-- 
2.25.1

