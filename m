Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C6D5BFA27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIUJGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIUJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:06:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F984D144
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:06:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t14so8731477wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=YlOaZ6C3yAJ/aS44zIKSNojaTSxqANNH+S78zy9aQaE=;
        b=TuWsxRhKIorV+7QTvrJDsrcLrBFdKo92O6JaZd68/TjFSsk76qqTpKH/I/6k9IEduh
         IJzMQAlm6SGgZruIFfzYIHAQAF1yaIasb0kcmFlRAdAHsQwfqXA2/n6f8iPeBmJxq9Rk
         VHB907OKAn6fiOPHgA9cStNY29hVxrD98RxkuqZDtG2Iiafk1NGFxRqpd84JjYpwaD44
         iGisoLE+/OOxf+BxmPI4HrLBdO4cRYeWuSz1U2RmZ0E7vx2+yAolwG/2bzHWO4S1VftB
         HHywW/UW6m7s4PFCJzBbrOh0mAJ79avRiOgqbdXV/pY9NIKt0oQw6CkdSsvATRsDfAd1
         7ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=YlOaZ6C3yAJ/aS44zIKSNojaTSxqANNH+S78zy9aQaE=;
        b=O/P0cj+BXikatESDpBkQ22JQ46bzzn0rr8G8+dmmm5THjvN0iW3y1zCLcT7YkBmOE6
         MdbVuBz6656uRf0yzzMM0QueDeFkFoDYZwCZkvtUzn+bp4+Gzt+6CsWHk+hYl6r/wBtM
         dvjy54BX+82t87ak3QOUoWEe37/c1Hzb8RCe8GTMwECJMK8VA9FMCn7A5bpGYr6Sa7pk
         CGAuB6H/hRM+b1a9HiNpiKCmHW9xPAShE0xppAPiAsUzjiOch4+c634RO6WQN0ZYgQua
         iCRKeDV1LX6vg6QAGT9AZgjWQ6DHTNtN17y2QoKB1bPHgX3PVTZg2bPHrdRNT+whUul5
         WF0A==
X-Gm-Message-State: ACrzQf3iUqvpMrPECQu3UNHD/nASius8uukCeJKvl6xSEbxNZfQChvhp
        LseaD6/M5DnAahpj5bvFDAkziw==
X-Google-Smtp-Source: AMsMyM42NavANSTAghtyxj3MYsPr2GmPZ07dDOBdJPIoYd0shxRMkSBgdEVFh25V7jOgraUEmSjlMw==
X-Received: by 2002:a5d:6d09:0:b0:228:d897:af3c with SMTP id e9-20020a5d6d09000000b00228d897af3cmr17030766wrq.78.1663751162644;
        Wed, 21 Sep 2022 02:06:02 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p10-20020a5d638a000000b0022b0064841esm1975482wru.59.2022.09.21.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:06:02 -0700 (PDT)
Subject: [PATCH v2 0/1] arm64: dts: mediatek: mt8183: disable thermal zones without trips.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANzTKmMC/w3MwQ6CMAwA0F8hPdtklKDo33Rb45qMYlbwIOHf3fFd3gkuTcXhNZzQ5Kuum3XQbY
 BU2N6CmruBAlF40ojrvozLhFmdYxXHvUhbueJvs67jg3dODwo8hTnP0JvILhgbWyo9sqPW6/oD5i+5 iXcAAAA=
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 21 Sep 2022 11:05:32 +0200
Message-Id: <20220921-mt8183-disables-thermal-zones-up-v2-0-4a31a0b19e1e@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        daniel.lezcano@linaro.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663751161; l=665;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=S7JAPzoUeXRvMPnCB2alosR6eDyieqz4xvRnHA5NCuY=;
 b=odNUw+Emjf+xXwX3bR9Day0u1Ui6ErZ2Qcb7uwlnF81tAHCJZx3R4ZtBqJLKiJU5tfZf08tTiydr
 o0p2IYTLDFg50ovDicFI4xTm7PUsH2cM+bcYaOje1HFyQOeK2Sns
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal zones without trip point are not registered by thermal core.

tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
only.

Disable the zones above and keep only cpu_thermal enabled.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Amjad Ouled-Ameur (1):
      arm64: dts: mediatek: mt8183: disable thermal zones without trips.

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)
---
base-commit: 60891ec99e141b74544d11e897a245ef06263052
change-id: 20220921-mt8183-disables-thermal-zones-up-6ac720a305d5

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>
