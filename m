Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099FA6EF2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbjDZKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbjDZKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDB4EC5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f199696149so30999485e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506189; x=1685098189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTMUBqSy4TNdyQBAp5j0UTas69JRH+59JZ3KQ1Hz96Y=;
        b=oaFAJ1Z+UkFi8STykLSvoTA+yBH9IhrrFwJno4E4FXVCIqpyltyYPOBmWgG7zc2Nxl
         ZXlLlynSViXhSTxDp8L3OO01ziE5M3uQZwDmuuJVqCo7ri0jPQVzGfUBPh5Lg4ilWoIz
         63ofTeWwbCoxld2+hX5IPaKSiv/xi2eMBZ7r9eJlbj7rHe9VyDKLhnAuuAQXccMrLcd2
         cm2QFkCYKEhXlFV3ZcddxkttUCaQ/54kdOZK0AYZTog/U9vldkvfBWQssKx/7zuOEd0p
         055HekU2L9hNM4XseYYL3r3ahh5Lz0yEx280ot9OQG5Jee23tkxMLHdyf6TbcLntoCDD
         tT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506189; x=1685098189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTMUBqSy4TNdyQBAp5j0UTas69JRH+59JZ3KQ1Hz96Y=;
        b=cUd+5JLE91BZ5jl5I8sGYcfmwZeRr+4Aj1uRN4C0NvtjOtn8o+oO4k5Vo0mm6zCyRb
         Bq2PF4j+vnwfv8tZWK5kh80PgDJaMy6ONIgfmUvRepOuP6kXwQM6e089BHgTMJoXIoFz
         GeVXJgj+C4S+MN9a0xL3gx+B6CrfuZyxJEuovXtbx6MEsrnqqO9PSDuM7byznlkuWV9O
         jzLunpFaqPj3YXa7RULMFdZdlLeo5KbZSlQRgbK97CkoXRmX720c4xXCSPOGDr/pqf6d
         llOwPTHNk+L6JbdiU5TcdbLjAJpfCr/VcTsBu0a2CzI4PaB9AFMmR6WDFvzWE6pirxhB
         UK6A==
X-Gm-Message-State: AAQBX9eMDxd/dxIaeEJlMzg0j38DYkag8mdwwclvo3pQ/Mfdep30KPBQ
        pv8Jvq4WWp4WZDR6zD3wl5tCkg==
X-Google-Smtp-Source: AKy350aG1/9hyV9txuVsYBd7+UE6jXE3/4ZuQtl8npgHxVbLqNGI8xD1ZHiMTXf8qYOYE3L23Mh4Xw==
X-Received: by 2002:a7b:c3d1:0:b0:3ed:2e02:1c02 with SMTP id t17-20020a7bc3d1000000b003ed2e021c02mr12220664wmj.23.1682506188959;
        Wed, 26 Apr 2023 03:49:48 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:48 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:11 +0200
Subject: [PATCH v6 11/12] arm64: dts: mediatek: add cpufreq support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-11-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=8Q6eOHc4c87inPFqFs4vtsSVYC3iqYyqZgc3XDzlolA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/hDpBoD878FPr2DkV8harEpFM3Ox7ZqJeskYq
 9y2/BeWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHURWUlEA
 C94wxHgmvDD3U4pZ3Ktd3ZX2/i5srtf7rftX3B/ytiHYHT49oUP/UuynlO9pWFTtOH8ZWlb7Hk+fEZ
 DyMDMaHj/mpCHuwBANQ2Pt04d4ew1qTca2cf4ID+lnXWQM4aIasWl4r5Rh+cnM1JRRed8x1PNjOjlv
 OVNfEC4MBeHyw0YlEW7HDJH+kq4RVYLCN2+QkRpt4xskXNaxQD/XXNEx0GPQ5oZCz277E8JWqYsA2f
 cPosCul0HCa4wM9pmAYVUujX+eeYalKi3FANg8MWs3I2H3eQOIFBmdFyXi7hcKh0SCvSfB/jWxU+1/
 I6WIK9QvUZD2LVEEG54j87RQ8OztFDkl0trp9G9lhfa/GjEPJIvBYCJ/cT7houHIaTdsCT8vy0fI5R
 mtFi1Qfiuwcb2L5EYCLq6V/qb1zwCwYmYuqWdiP+Qn5WtxEviNNJZOlkBQS95eufcKGyVEC0Mt5j/k
 ipo0Evw2evQuNNecOvQBffQhK/+kaWBPCh5Vv1W5bGWJzZ2I+8+EuAWsoo0gN7fyRxhtJJTGJKnmtv
 xDNGXCzQ3m8OgrENG3z7xkUPWUvAyzZBsPrhdTNkYaM3izBPmVxvlZeopUIStu8ZIIEVnVRT4ggzXB
 JAdIy4lO4WxIiyPc12Kib1emWJ7E0jEP5Z1Hr/t/LM8NExAezS+2jqtInakg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have cpufreq support, this patch adds proc-supply and
sram-supply for each CPU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 5a4c41dbd3a5..3ab897d5e468 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,26 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&cpu0 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
 &ethernet {
 	pinctrl-0 = <&ethernet_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

