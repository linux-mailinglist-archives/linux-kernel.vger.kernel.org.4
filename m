Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D495B5707
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiILJRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiILJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:17:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A01BEB2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:17:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x1so7980727plv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pkSyBLlwJErkL0Jp1WY33gxocwSF8tkX0lIBYeleLpI=;
        b=ZnQ2N7YNGUs9xZi3LN7q7IdzKT3JTX6xzhWO7zFQQRU78Eu+nV2F8c4oXvvcqqsi/E
         xQ8s8yQtlrW50KRLNSZRiFUq7YVLzAxzMRWBjoIfJAjuD08Vz4pyIu/zgNdaRUt4sEtJ
         MH31RhGf0BnD+tFyk43/JR4lotDDX6aIrrX6feGJ/HQL4hJK72uB0t74dYcZZeKlZ8v5
         /xR9rS8cK4j0RyGu/n3Hq6/D7zF34kpNAnFz2hYEx76Q+ni+rE1B6sWKLacSurB5svfm
         WO4v1HFTuBLa8bMdoZEgQ0bBu3NS52cwecO1XI7QX4xjuOVxv707AYebpnLySI9SDw00
         c12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pkSyBLlwJErkL0Jp1WY33gxocwSF8tkX0lIBYeleLpI=;
        b=BuwWGN/JXQ/eZdGENois3zZ1VzVv0YkvlcokiRZR17wNXYOHjj8WJ3e047h6FFtkKP
         mjvBlnbwLPqst/3wdZRCg/L1hG/VYimo461dvyxabjJ+UChWlWwdoCnPopucPKHpSHFT
         SCfvPcubkNQYLKJWnnttMEnCQF4+HD3uW2l38h0jp5eQUVGdIRAFYPF2lU1TZaCUHpfl
         lP/zAZzeRjccrA3gsXRWwmnKOz4etneR4VKbnK6vco2N1dcarQLqPkL7qzZH9LuAaYco
         48gYt1gEgqeKBvt0HI6CqPRpOVsaIygEYCbIGD6iO7pM8QSLVwbbJIigResJ20S4WSwq
         aUPw==
X-Gm-Message-State: ACgBeo1yr+f+EZP+Bguy6LUb/OlRkNjav6zfA96Y0EMHyCnroBaSQRxb
        Ejd5lwmrCPNrADCyncigiwnOEw==
X-Google-Smtp-Source: AA6agR6o8lnbjquNhzk+TyGQIbULur9DJcymfnjCVHgkIanPMtyr5J75MWP5u2Fv0V+rA6ezxKzJWw==
X-Received: by 2002:a17:902:d34a:b0:176:b8ad:ba76 with SMTP id l10-20020a170902d34a00b00176b8adba76mr26760710plk.139.1662974219737;
        Mon, 12 Sep 2022 02:16:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id o65-20020a62cd44000000b0052dbad1ea2esm4857026pfg.6.2022.09.12.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:16:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [PATCH 0/3] arm64: qcom: Introduce Qualcomm Cooling Driver suppport
Date:   Mon, 12 Sep 2022 14:46:40 +0530
Message-Id: <20220912091643.3537857-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
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

This patchset introduces the arm64 dts and defconfig changes for introducing
the Qualcomm Cooling Driver (aka Qualcomm Thermal Mitigation Driver).

Several Qualcomm Snapdragon SoCs have Thermal Mitigation Devices (TMDs)
present on various remote subsystem(s) (for e.g. the Compute DSP, aka cDSP),
which can be used for several mitigations for remote subsystem(s), including
remote processor mitigation, rail voltage restriction etc. 

At the very top-level, the dts is supposed to describe a TMD node, which
should further represent the remote subsystem(s) present on the SoC and
further each child of a subsystem should represent the separate cooling devices
available on the remote subsystem.

Note that this patchset is targeted for the 'linux-arm-msm' tree and the thermal
driver/dtbinding patchset/changes targeted for 'linux-pm' tree has been sent as a
separate patchset (see [1]). Note that without the PATCH mentioned in
[2] this patchset will not compile cleanly.

This patchset is based on the latest 'linux-next/master'.

[1]. https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-1-bhupesh.sharma@linaro.org/
[2]. https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-4-bhupesh.sharma@linaro.org/

Cc: andersson@kernel.org
Cc: robh@kernel.org
Cc: daniel.lezcano@linaro.org
Cc: rafael@kernel.org

Bhupesh Sharma (3):
  arm64: dts: qcom: sm8150: Add qmi cooling device nodes
  arm64: dts: qcom: sa8155p-adp: Enable qmi cooling device
  arm64: defconfig: Enable Qualcomm QMI cooling device driver

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  4 ++
 arch/arm64/boot/dts/qcom/sm8150.dtsi     | 62 ++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |  1 +
 3 files changed, 67 insertions(+)

-- 
2.37.1

