Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3025648304
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLINyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLINyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:54:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB973F69
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:54:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d20so3234960edn.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=uZxmnAltC/TUl2zjR5eDxQLiAAZciTA+T7W8WnsB+F8=;
        b=SKyHoHQmWl8JTBHt+lyEeCAkLam1UcmIy99kWXNOay4fka7zTwQBmKeXoDyfl3+GGB
         Y+IFpZU2ILrdbMjQQnb7/l5zk80S2oeBXEw1aYvOVG+kUVESiKKFfKtflF87PAr4Vu4u
         m9YDhDYaTD++8iZV+PepmcQkv0u2Bhwkw5ErQeYAYdyLes8Kn/tqKSAj7+DgyKDkHjsh
         U7lFa7G7wkcTFD2IEhiOeEJU8rd8RDCd98EDzVC0M2thB6vdi3xc08fdBuasp8jKOyAA
         zycx63y3G4YfpKqpU9TtZvtb55nP0OPRb9m5wLZIV0r9k9NuQGDJFnk4Bck13Z25388Q
         DeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZxmnAltC/TUl2zjR5eDxQLiAAZciTA+T7W8WnsB+F8=;
        b=4zgFGZrWstey95LcwHb67wyLpIc5AG0euSTuLh/dQ5dUBTQpnrYQj8NA4qdQfuFRqk
         4e3+hIONked411g+jbu1373zs3H4XCIV4/2wgEClzppyNGHOgNxRoxboMMcCU6wnPEga
         wfSOHgLbzAe6tWa+kKmt/tJ/enC9JEWJrWzds4VspeICsjFPBT5dlNutDkaWZQxj3Kfo
         ss88ckf5SqWBkHiI5wUQR+l0/aln5fjoOaow/Hew/LNLe6D01rHgnK1Q//a9BqyU1YXs
         YJcTS3ESzrtIl3jOhQ1bvfo8cv2LwJi12qMHjtEusQS/5v8BExRYc0nfYXpdNO3EmAoN
         pcaA==
X-Gm-Message-State: ANoB5pmp3AuVzk60nW+vHyE72SErHcyk5WYq3nvfrM+VceQIHw8XWXTr
        MmpU8keHieWgkLTzxxjQEP1WbA==
X-Google-Smtp-Source: AA0mqf4sH2aM9ERvdqbtbDd2i3lz9CQzsDKOssDrXykRzFaj1bN5SEGhKqlzScGgLUbcl2swVxhkPg==
X-Received: by 2002:a05:6402:3907:b0:461:4c59:1284 with SMTP id fe7-20020a056402390700b004614c591284mr5103442edb.12.1670594047980;
        Fri, 09 Dec 2022 05:54:07 -0800 (PST)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id k19-20020aa7c393000000b0045b4b67156fsm656371edq.45.2022.12.09.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:54:07 -0800 (PST)
Subject: [PATCH 0/3] Add PM6150L flash LED to Fairphone 4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP09k2MC/w3LQQqAIBAAwK/EnltQSbF+Y7amYCYudQn/nsc5zA
 dMLRHDNn3Q6E2c7jIg5wl8dOUkTMcwKKGUVGLFUBesl5FaZAzZcUS/aEE2GK+NhfF2x4R7c8XHMc
 uTc+8/dZ/LdmgAAAA=
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 09 Dec 2022 14:54:05 +0100
Message-Id: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.11.0-dev-64ef0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the necessary nodes and configuration for supporting the
flash LED found on the Fairphone 4 that's powered by the pm6150l flash led
block.

This depends on the patches by Fenglin Wu adding the driver, the latest
revision can be found at [0].

[0] https://lore.kernel.org/linux-arm-msm/20221110065420.2451436-1-quic_fenglinw@quicinc.com/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Pavel Machek <pavel@ucw.cz>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

---
Luca Weiss (3):
      dt-bindings: leds: spmi-flash-led: Add pm6150l compatible
      arm64: dts: qcom: pm6150l: add spmi-flash-led node
      arm64: dts: qcom: sm7225-fairphone-fp4: configure flash LED

 .../bindings/leds/qcom,spmi-flash-led.yaml         |  1 +
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |  6 ++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 23 ++++++++++++++++++++++
 3 files changed, 30 insertions(+)
---
base-commit: 0392f3ea67781a215382d2dba7d172d83d4aa37b
change-id: 20221209-fp4-pm6150l-flash-c450e8f6c568

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>
