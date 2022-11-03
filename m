Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC2618736
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKCSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKCSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:14:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF9617E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:14:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3929645wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/U/F+0RMZTg6izVpulD63LQRaLW/I74SsRWCBM6RrQ=;
        b=JqsGAPkugzPWEY/QK/ba6O11TdN/xz9kFK7zJCOJ8fDedzjks82r/tNsCtWs0tT7O7
         fN3aYih3CSfPfsh9M2JdQI5G0HMAkI0QqwVqu2v0thHPzPrgbRnXSgB8iB17Kfz2BxoC
         f64uc2rvactjKuRNaSrc4HWUtgFBOZlKfQVcUHhgbXSwdOLBvUyjNaaNfWs6z9kCZbLl
         lt+OCL6hPizb/4QGk3OBRSuSWv7pwKyXRHSvxZ358/ZB2OqetpkxSVYNLkgScYziv4sP
         CMp+gO5GS0gFmKpTkOB6mJwjfkWoaopawHgoDZYJ1jIhdUdB92Ji+m7v27IkgkhzFsno
         h9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/U/F+0RMZTg6izVpulD63LQRaLW/I74SsRWCBM6RrQ=;
        b=Lps1bYxJU2gQ1ic+4jTxX7nuKGhB7t1VAk1q8XnrqmEsq2Cjrp9HHf7pmMjRfKMLXl
         q403kKvX38s0xXdhzwJEwvMZ5nbQEP5TwY4gvYpEzwhFf8eJ4fEanNjsicrcWv2GEO36
         aZK5DRuJzVGsZtudFu3N09gQKMRnCN9f3BRJn0ouM98z4WTC0tZsrMsGTisI30/nIVGd
         Ov5bip8ZrGKM16dFEyQT14tDi0n/aJWpX13uTMsBZJFQk2Luc9jR8XVxOvPbUSPBON2A
         FTE9GI2b5QdvqcBNEQiBanUR5RCtuf3X4HiyKT0EID6uhdr3XKLqNCkx3OfNAgX9h4gA
         LZrQ==
X-Gm-Message-State: ACrzQf1QYggrAcruCkVEzInfp8QdILNc1bAryU8Nen/X72kGedlOL9MF
        HEAjQaDdVOohZv28BsYE979VBw==
X-Google-Smtp-Source: AMsMyM72yJTivNBhzs8qu13Mgo+FanuE5j3ElGM59crwQb+Zfh1WyWeFP0xjp693nPpU1/LJTvGVCQ==
X-Received: by 2002:a05:600c:1694:b0:3cf:56a9:fe64 with SMTP id k20-20020a05600c169400b003cf56a9fe64mr25532921wmn.112.1667499282563;
        Thu, 03 Nov 2022 11:14:42 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (254.31.102.84.rev.sfr.net. [84.102.31.254])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003b49ab8ff53sm639212wmb.8.2022.11.03.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:14:41 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] AM62x watchdog support
Date:   Thu,  3 Nov 2022 19:14:38 +0100
Message-Id: <20221103181440.232727-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
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

This patch series adds support for AM62x watchdog.

Changes since v0:
	- Mark MCU & WKUP watchdogs as reserved
Link: https://lore.kernel.org/all/20220630070826.11074-1-jpanis@baylibre.com/

Changes since v1:
	- Rebase patch to v6.1-rc3
Link: https://lore.kernel.org/all/20220718122328.251602-1-jpanis@baylibre.com/

Julien Panis (2):
  arm64: dts: ti: k3-am62: add watchdog nodes
  arm64: dts: ti: k3-am625-sk: mark MCU and WKUP watchdogs as reserved

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  9 +++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts     | 10 +++++
 4 files changed, 73 insertions(+)


base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.37.3

