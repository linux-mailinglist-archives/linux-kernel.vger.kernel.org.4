Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A30670E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjARAKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjARAKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:10:21 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248852885F;
        Tue, 17 Jan 2023 15:26:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id j1so7409100iob.6;
        Tue, 17 Jan 2023 15:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsS5lC1QJfFe34JX9hbM3urg0t2IXlMBldI7uh2r2K4=;
        b=fN0I0lzHjXkD1CxbOUY0tY7AAoelSbyJu5qiyTOP1Jfhj6x8THtvXe4/noMllELXDP
         yL7lap1J9PfFeqC8fex1a2gi2xqw5JhzYvniQ2EZiOSPulkUNbPyJSC9Wmjcjnm5xhD7
         gP8TIubeQmlzsPrrxvlO5GWLHEs0gQMidYOtqfhi6DP3tYzJKp05ilzNngfu3kbd3xbI
         vKfsGEkbmqJHn0eLYfo2qAI18M4VY9OkiuNZWbiOseRMho+VsufONGSONmRUI3BDRVeh
         M8o1f4zieJpiRYtRux7RfGSA7a1msWO0so9795LFYsZsovPpod+mpFTSgFIjut0dauG/
         3oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsS5lC1QJfFe34JX9hbM3urg0t2IXlMBldI7uh2r2K4=;
        b=7uWE4+31wATA+oELudL/PacqEZZzXJoz2v+HOzZHI5AA+ObdFPdy33vTjL/5XIi/7J
         Z7fwkDMh3vcSEa/ocs/cHVOK8BVSkAZG7kUr7T7s7xIlxlO22WQtODlZGfkB8uv1Qzv2
         KbOANzncB5YK6/lY6OM0f8359V/ZlgsthBbf9Mi3pbvKAANfWIaqmFJaxYk0QGjvm82L
         zu1HVDti4ikl9dpLWeJtq169M2XI4tFaVe9JmEbnHiX9e/EXbMn/frOcb0YdlG2AdvoH
         JOlCXNHyzn/yUO/V8gqwfFPytc2ULd/l3mEV4n3Xth3+zbMKaNwFewQMOrzSO1c2xEpQ
         J9hw==
X-Gm-Message-State: AFqh2krgegN8qT5ZTYGsfDHdMt80kGFf2mL+XaOiq04rqIBrY7n7MEh+
        t7teRVbWR8b+R9Ch4HYNNDaOhBOEpfo=
X-Google-Smtp-Source: AMrXdXvShhG2pbNyYTPsIDDm1UpLU8gXc6AsTcQBR9asKdcgdwsev+Nh4GXJRL2SPEyfhpKYybf5PQ==
X-Received: by 2002:a05:6602:209a:b0:704:a04e:9856 with SMTP id a26-20020a056602209a00b00704a04e9856mr3566555ioa.4.1673997980102;
        Tue, 17 Jan 2023 15:26:20 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id f3-20020a5edf03000000b00704878474c7sm206037ioq.53.2023.01.17.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:26:19 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: r8a774b1-beacon-rzg2n-kit: Sync aliases with rz/g2m
Date:   Tue, 17 Jan 2023 17:26:08 -0600
Message-Id: <20230117232609.477247-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon Embedded RZ/G2[MNH] boards all have the same baseboard
and all share the same PCB.  To make sure all instances appear
the same, make the aliases for RZ/G2N match the RZ/G2M to
keep them consistent.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts b/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
index 0cfa60a0827c..8b9df6afffde 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
@@ -14,6 +14,14 @@ / {
 	compatible = "beacon,beacon-rzg2n", "renesas,r8a774b1";
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &iic_pmic;
 		serial0 = &scif2;
 		serial1 = &hscif0;
 		serial2 = &hscif1;
-- 
2.34.1

