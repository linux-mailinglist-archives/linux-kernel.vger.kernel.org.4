Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B724B69C7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBTJdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBTJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:33:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8958680
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:33:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u10so685198pjc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auUSvs8UsdFaj/xThMRdjaVCog/Zx9EFkKoJMU//YhU=;
        b=VEzgNlH1ZIpSeIIW4BHakqAskqPavaOvnwg+FDMkymbI+7fRGLlkwr/700K8ZFQqJg
         aqdAQuNVLlRPa6+vEKtYLb6ZYTpXrj7248N7dJQSbSTS3XLrbD5J2mXlMnb5MW20z/lv
         vfcUsoDMycHnvx4SXBpfS5WMxKHzjKjYiqqR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auUSvs8UsdFaj/xThMRdjaVCog/Zx9EFkKoJMU//YhU=;
        b=xuEjHt2su15FJu195EXIH8VBh62cQDGjuV/iJwkgbyI4OjBLF+mVPvZLFqgGBdNdlx
         2+gYjw044d3eWLaEwwuNcgAFyaYBwvJv8uRH3/XPHCdo63S16DwdlFWCOBEAsYKm8DsI
         EWhL2f+LcSHVlSzcD+sGxHYqJFqjN6OHbztQ0kteBeHvJg+6ALaadlpAmhvE/ETPbOde
         zY+QctBa2OY2SIb1s9GTDOxYemX4EvD8Mo3yIfgnbULwNG0sUlF5cdA3xtz9kUJTHP4u
         CZzH4jRGeHvqq7sKzxtQWHjCvbmrmthsj6IOo1ZfRJNWdzqFKzD7ivych5gsG18KIE/t
         3Qww==
X-Gm-Message-State: AO0yUKVBrkygvn81HqMwoSlFc/xTghj7z3go6fuX1MI4SCzRtGGmqsqh
        47kv7zjTfeHSYsGny7GUU1YyxQ==
X-Google-Smtp-Source: AK7set/mx+AT01XAXlnDozbSnH6dwDZECdvgBPrkFE3Z+Q+N302TjAwATXil1kIEzmGxWYX76fcotg==
X-Received: by 2002:a17:902:f94e:b0:19b:e73:809c with SMTP id kx14-20020a170902f94e00b0019b0e73809cmr764263plb.1.1676885628697;
        Mon, 20 Feb 2023 01:33:48 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:22dd:c2d9:add9:3828])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b0019324fbec59sm7427728plb.41.2023.02.20.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:33:48 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: mt8183: kukui: Add scp firmware-name
Date:   Mon, 20 Feb 2023 17:33:43 +0800
Message-Id: <20230220093343.3447381-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index fbe14b13051a..8390e89dbc83 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -807,6 +807,8 @@ &pwm0 {
 
 &scp {
 	status = "okay";
+
+	firmware-name = "mediatek/mt8183/scp.img";
 	pinctrl-names = "default";
 	pinctrl-0 = <&scp_pins>;
 
-- 
2.39.2.637.g21b0678d19-goog

