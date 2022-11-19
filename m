Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA5630F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiKSQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiKSQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:44:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855D2AD8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso9817498wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VffRppO5L4I+42G3gpefRFyn8naqUL/OOSscjv4Et0U=;
        b=rpuR6IU4ETTpzvWivXSiMVXRcAnWbHxQupUHI9JGpoekt00+21U1SfqRxDDgzUB4dj
         9CMVGwjXNgedd3xfkNm9H3CiXiZa4CxeX19j2k2FeAi9vUKRePDCHloIize2syDfyGrC
         2wjL+gyM7pAxVfU2wMT8mE5I6hIAExv3ISIONccB9gI4eHKSDX/E+lKhUjWM8nfCQ3Hn
         SnoHnmMD4XUSq0tJHTNBN7VTIg43G2pmrXH1+Q0mfj5GvTZJjZbXRVDdzDaYevVDqrhU
         34C97sNGLJHQ1dkt5/a4/t8czEY25s89U1zetSnzPNre6/NWPc1nBYu4MvuUIesz1qAI
         d0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VffRppO5L4I+42G3gpefRFyn8naqUL/OOSscjv4Et0U=;
        b=z9j1JfDSZRhm+Un1DeqarWmSfrlbew0FhhpzNGghwMx8t0WR2L2nyphvZKPUYYn7Il
         YL/GAqv8dtqzOmSWdgdD6N5X14sV/lFYHHYxx7DCM3euxqZDdkLdGDOhchnlPcmC5WwR
         EeCE/MtlvfBocw90MUvpqb9hRx/F7K16Lyhet+IGS99EMEmn6sGKU1zV+qw2YliKTSxV
         qdtZi/JHcSbqO7rb+DsNuFY1pJllGDAcH1qDmdGYk+IwSXK+xVJizxQp/ZQUuhvirefZ
         TUD6EyYF8zfYR9witgM3yLXENMD7Wky1hVFJGBcTY1ffyHoa70tfOQMnrr8B5rlETecd
         Ku6A==
X-Gm-Message-State: ANoB5pmxRuQ+OsHRSTr7G6e2PB+n8/beMjO402EYuJ76SO+7PCSXzfEx
        IhY4p1P+QufMtfQSjV02Lu/Bsg==
X-Google-Smtp-Source: AA0mqf7BxHfY6qfboxWA1K+5jRFpMX1L/Guhdo4RWm9Ocw9L+jWu5fg/VyWWhdiyOW3DhC8AVoIvAw==
X-Received: by 2002:a7b:ca49:0:b0:3c8:353b:2553 with SMTP id m9-20020a7bca49000000b003c8353b2553mr7902034wml.18.1668876269213;
        Sat, 19 Nov 2022 08:44:29 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm12312220wmf.8.2022.11.19.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 08:44:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: sc8280xp: add audio support
Date:   Sat, 19 Nov 2022 16:44:22 +0000
Message-Id: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds audio support for sc8280xp Lenovo x13s.
Support for Headset Playback/Capture, Speaker Playback and DMIC is
tested.

A prebuit ASoC topology file available at
https://git.linaro.org/people/srinivas.kandagatla/audioreach-topology.git/tree/prebuilt/SC8280XP-LENOVO-X13S-tplg.bin


Thanks to Johan, Kryz and Konrad for reviewing v1.

Changes since v1:
	- ordered bindings consistently across nodes.
	- removed some unnecessary bindings.
	- some trivial changes suggested by Krzysztof and Konrad.
	- renamed label for regulator for consistency reasons

Thanks,
Srini

Srinivas Kandagatla (3):
  arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
  arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and LPASS
  arm64: dts: qcom: sc8280xp: Add soundcard support

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 217 +++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 359 ++++++++++++++++++
 2 files changed, 576 insertions(+)

-- 
2.25.1

