Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E27151A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjE2WP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjE2WP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:15:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15469F7;
        Mon, 29 May 2023 15:15:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4effb818c37so4008743e87.3;
        Mon, 29 May 2023 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685398533; x=1687990533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omqCaXtVC+28c1kFU0RPDtI49AzoCHe4tZEXBsZDVYE=;
        b=gP4Yj2e6yHQP6kwcNhQJOznSJm0upDrS12CVyrB9FNFm70wYYBHEIB7Fk4xACCtOC+
         gzfbw8WSAtKIA9LtlVt2buW/MTXVSgsCIE6+g1GKYVk7AFLp/xtT+D04WUMbq8l//N8+
         3Kk84zdAyAzqb4UIN5Jt+sL1VMOKdW67Im1ZPchJkFEctdPIVF+LNCEYYiK7dpHlHl0F
         9YnOrsoiwUxakQMdo8wLgDjkgTxSJI7Pj2Gil91F7vphwE6jyYPjHmIcPYyJzpprUjDx
         YcJZxAJywV2dzmTl6DK6bhPcWW9JQHjn88WKYhECc0hJVCgrFI56kyDWebukOS1iBeiq
         c/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685398533; x=1687990533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omqCaXtVC+28c1kFU0RPDtI49AzoCHe4tZEXBsZDVYE=;
        b=eY/GT182vPrvCnHYtit2kAPEz7BY4NFho9IbzulMUWtBEBjCiWtyaWKEGHE0LFCe0u
         ikynB3wotmUUxTT/vzaXRimgNBP8vKirLFBM4wA9TgI64BHmbfdmxGXzAhIsnXuBzITn
         +CAe69F204Bar0t+JnV6a4V0JWHx3PzEfavL5DSAdEKTUwRnwnF3r+D2XLF0BFMMr0RN
         +K3DXopradMKUVcTj71HOVvQ4AluYj/H6DAyWlZVzfNeq3Duk8vgfBAJ1N0vKhYQzdiH
         TAYUDAr6d4CLqSLE1ZZM7Zy7TcibaxooB8An8wTtMKqKDKHsOjSGS3RMeKf3MYMpUFuZ
         FEsA==
X-Gm-Message-State: AC+VfDzxmtjlvh2+vI8gxtIUO2qbKUQGyuQvCm8jI36NhH336T2PLnJO
        T4ttppvDBMZLv834VLhXcVNWTQTa1xU=
X-Google-Smtp-Source: ACHHUZ7W8aOor5s+8ZSQ0DagnTbiBBnZeZiFLUkTd8wBNVbYn/RZV4eB5iZHdtnz4PUbctZ9nmW5+A==
X-Received: by 2002:ac2:5a1e:0:b0:4f4:d41b:f421 with SMTP id q30-20020ac25a1e000000b004f4d41bf421mr17708lfn.33.1685398533040;
        Mon, 29 May 2023 15:15:33 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b004eb12850c40sm132993lfi.14.2023.05.29.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 15:15:30 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Thermal zones for pm8226, pm8841 and pm8941
Date:   Tue, 30 May 2023 01:14:58 +0300
Message-Id: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal sensor for pm8226, which is using on chip VADC channel to
report PMIC die temperature. Add thermal zone configurations for
PMIC thermal sensors found in pm8226, pm8841 and pm8941.

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add thermal sensor and thermal zone config
  ARM: dts: qcom: pm8841: Add thermal zone config
  ARM: dts: qcom: pm8941: Add thermal zone config

 arch/arm/boot/dts/qcom-pm8226.dtsi | 39 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8841.dtsi | 33 ++++++++++++++++++++++++-
 arch/arm/boot/dts/qcom-pm8941.dtsi | 31 ++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.34.1

