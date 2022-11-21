Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2E63230F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKUNEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKUNEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:04:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A966B9DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:04:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s5so2554076wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEFzLLCkAmvtlRGpGupffHTbi3RRZZNgjCKpe17ieh4=;
        b=eqHihs4AcVn+xQ+OVkfyxrDbP49/t1D2NXZWCE8Nf1TcMfJSpCta1cqOQTDt6U0pvr
         uvE5pnP7ggEOiWwPWmJUaAOEcv3xDSCVTV3YsjPfyTuVO6StUfQ3zq0lVAFoNIQBmXR5
         k81wmk0FmhO5CHmm/Rwn52+6ZnXf8FedX0f+m8bmxHFjdrGVPQiaIE6RMlxjpsMqPJhC
         3IqCiv+zvRuhcP1OAj8gszLUzWNCo92fiweewkfz5MKMQlAWipwBrfL9cYOz2GiU0KMi
         QbkjIqpzsycUGrgBAzD9ddqLVI6oTj5/d3bs9DOnLTrvggC15VWcUzTbxvsjWIIa++8C
         4JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEFzLLCkAmvtlRGpGupffHTbi3RRZZNgjCKpe17ieh4=;
        b=FdSBPPqYQS5kUcalGszduGOzdd0Ly3/ZNzoIiBW4PqFxrulIfZ73vy1Tl4oFVOV+1I
         nCyQUZ4v/NGun5v+LFcICXPx1fYdChCLVfI1j/3o2rRt+kIB1h7mUDC3W8uOGdv4R1ap
         SYAIzzft4Vcsdjn5sSwXnznPYblyF3tKmhsXd3pqE5/6Sa3JFWLTDanmt13trYu2qjzx
         LvwDp1TZULYbVgR2EUEWnhOtwMQkqSc4PpLwtSYcYjpKf0ZAgC5oAmmAkR+CEUee4muW
         FdaiOPWBk5IT7zHLOJgUzxlGC9Rk8P1nRSsoX/NFmIgPkrjOvRMVP+ntj/4p6pQ3+PSq
         pfAg==
X-Gm-Message-State: ANoB5pn0jKuBiBsY2Pf7ap8Ihp9wK+gfaiDIV5qvb65A4x/dE9mcEEcD
        Jt4g162fkHk9zG47dfd/uK7o5Q==
X-Google-Smtp-Source: AA0mqf5avd6Nllh4br5WicJ/f6/ceeoinz6Q6U5GDS03HqAQEXv2oGhNaGAGT72tb3xNfaYgixohqA==
X-Received: by 2002:adf:db4e:0:b0:241:c694:f4b9 with SMTP id f14-20020adfdb4e000000b00241c694f4b9mr7006738wrj.552.1669035855214;
        Mon, 21 Nov 2022 05:04:15 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm11133898wrw.59.2022.11.21.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:04:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/3] arm64: dts: qcom: sc8280xp: add audio support
Date:   Mon, 21 Nov 2022 13:04:00 +0000
Message-Id: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


Thanks to Johan and Kryz for reviewing v2.

Changes since v2:
	- removed lots of stray lines.
	- ordered include files.
	- moved all the nodes before pinctrl
	- fixed subject line to include x13s.
	- rebased to latest qcom dts branch.

Thanks,
Srini

Srinivas Kandagatla (3):
  arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
  arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and LPASS
  arm64: dts: qcom: sc8280xp-x13s: Add soundcard support

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 +++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 359 ++++++++++++++++++
 2 files changed, 572 insertions(+)

-- 
2.25.1

