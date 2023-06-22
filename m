Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4073A5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjFVQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFVQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:16:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264B1BD3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:16:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so2085601f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687450591; x=1690042591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmGI8fpO4hj8qhrgOMp2k1vrFf/BptTZ76S4/582UxE=;
        b=AsO0sqHiUpVRbNCT1c2nhW0kfmo7RcXuuL/ulmARat46Qi9ri8lDonoAewT+oqwVtd
         VLEESoRpresbHCI5FVVVQlSmDT0LbODq0dVGwt+4uMmFiw0B8E2kwjv7sL3lJ+HN2LCq
         HCwR9m0ZxB3SmWOMR51B9hll1xo5nKyjyNMFI1K6t8WKpXPeHh07NemgIi7zKdbt9x0k
         1U4Q593FN51WVyg4xjjOlO6nO1bZplJMYVyaJ756K5bQjUmEh8AM9HZVdUrZz2xTWVfM
         d9oIkP/lsha62GNVsH8o1Gq7jpJpOKCqsYSWzjcQB7y8S/JJbHHDmqNLLpw4qkLnL51Z
         9Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450591; x=1690042591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmGI8fpO4hj8qhrgOMp2k1vrFf/BptTZ76S4/582UxE=;
        b=at8IVO5dbKF9WXEOMkbYkM0Yfko7vet8EC/+HeJyc4CwtzWfmX2123xQs0nFjvPIIE
         OqMz5kzfvdXy3KJjvs/ddr8H+Mi1AoBtJbC6pOT+JZXO85UfXtpp3G9EOp9L8FG9ZMFi
         C+2bYgF8jF0DgZ9S8qV8YtDplZ/c78H6dDaYHhTgGRPBbzv+7cBDAerAP0RZ4FDX3FFU
         Z6uTt7Q0VaGfpXaYOdKdmQkAx6XF6Xo2rlXsvkwtRXQQWkPYvFmZo5eywbP6g3aUgFfK
         KjUkd6aGAVWvt8f2EXIfeGqaFtaGMh074LaW/dU3SF1FJ0Rf/7d9aGyJBw/gjf8bpudD
         PU+A==
X-Gm-Message-State: AC+VfDxV/VIxO+d+TCs8saB3JAhu8W9x0WSilAkXSJxDIHvKXtCzgF+9
        R5O4Pwu6YAX9eA8mUmx+3lKr0g==
X-Google-Smtp-Source: ACHHUZ7x0V8vbmVljF4pDKsRKU1+avu539J/OBX21LHkRZCTSHLCdZo37JtP2kcBGGTnHArXTMOzcw==
X-Received: by 2002:adf:f488:0:b0:311:1b0b:2ec8 with SMTP id l8-20020adff488000000b003111b0b2ec8mr16901097wro.52.1687450591319;
        Thu, 22 Jun 2023 09:16:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v15-20020a1cf70f000000b003f8d770e935sm19467755wmh.0.2023.06.22.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:16:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 18:16:26 +0200
Subject: [PATCH] usb: typec: nb7vpq904m: fix CONFIG_DRM dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-sm8x50-upstream-redriver-config-fix-v1-1-005ab6f4d1f5@linaro.org>
X-B4-Tracking: v=1; b=H4sIANlzlGQC/x2O0QqDMAxFf0XyvECtbLj9ythDrakGtJVERRD/3
 bDHc7gc7glKwqTwqU4Q2lm5ZIP6UUEcQx4IuTcG73zjXt7jWhaOqHN7PB1ui65CYUahXngnwVh
 y4gETH9gmFyg15Gv/But1QQk7CTmOVszbNJlchGz7P/D9XdcNCUhZMJAAAAA=
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YWuwhuhkh0Fmn1XOEG+D982lsVlbMVXfL+uI6GDRnW0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklHPewjaRA11780sbOr5fywRw8Mgw3aMI9KonBbh6
 4xGNvG6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJRz3gAKCRB33NvayMhJ0QdvEA
 C6iiVHnaEIUDRzT1TFCOeTvewbi9X+Im4pq/qql/rJNXR7O4YbZwK96wuFaqziN9WRdUzJfOcMC+nZ
 tQy3/gBjwK7XKA1e3KfvmqQJFCk/qLd8Hdq2Zv7TAmJb6QU8h7LlPahF2+s8v8sl+BDD+71xrYwFhV
 AmMq53yR9EScS9UPX3ClCdJPPhzFFVrEzccf5xIuXzhbSkEksDUEsNXveJn7VX3R9+iAmFpvX7ft+B
 ieRYDtJt+sOx5q+9G7uPA7kdL68HXEe/9MKhwZxbSsYdwmdwVQ8btFIr9D0sLG2c2qhdpJwudxwPZh
 yq3TAU029++Ex22kK77+PZLUiQuQ/mxWFF4sQuGni19Gb8kBWHffjTH+xKh6SHifBdfo7CpJDCd4Es
 wk3XRC7Ff0Xbt24x9oN+XEkXYBGk+NOrIcbOHaGLyoHUDKINNy94f+GAEJa2g8PX7fpOwOgWglVhRY
 bpto6WIsnKBwcoXF+GxjHMQNg6tpMpP86MRUCUfuZMyzLHROqHGqd9WMGB2EMgDcySlJJukr64L1vt
 3YZxyC4yk+/eaOTp4aPLCWsIdu7cs0o4ge6Vrv1n9wSJPyLPRx2OBNCgAjXkcKblbWzVOgmIEJakRD
 ZqziJmfDUa5pVNbI5VpDIsd6+tLLzn06DsWhXYeEBu2S0fEqmk0AjozQnoYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following config set:
CONFIG_DRM=m
CONFIG_DRM_PANEL=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_TYPEC_MUX_NB7VPQ904M=y

vmlinux fails on the following symbols:
  ld.lld: error: undefined symbol: devm_drm_bridge_add
  ld.lld: error: undefined symbol: devm_drm_of_get_bridge

Add dependendy on DRM || DRM=no since CONFIG_DRM dependency is optional
and guarded by:
IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
in the drive.

Also add "select DRM_PANEL_BRIDGE if DRM" to clarify DRM_PANEL_BRIDGE
is required if CONFIG_DRM is enabled.

Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
Reported-by: Arnd Bergmann <arnd@kernel.org>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
This is re-spin of [1]

[1] https://lore.kernel.org/all/20230622101813.3453772-1-arnd@kernel.org/
---
 drivers/usb/typec/mux/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 8c4d6b8fb75c..784b9d8107e9 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -38,6 +38,8 @@ config TYPEC_MUX_INTEL_PMC
 config TYPEC_MUX_NB7VPQ904M
 	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
 	depends on I2C
+	depends on DRM || DRM=n
+	select DRM_PANEL_BRIDGE if DRM
 	select REGMAP_I2C
 	help
 	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C

---
base-commit: c87d46a9e8ebd2f2c3960927b1d21687096d1109
change-id: 20230622-topic-sm8x50-upstream-redriver-config-fix-8f0aef3e2129

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

