Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC297496F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjGFIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjGFIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:00:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F71BE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:00:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso3718235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688630424; x=1691222424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93L8BkPgEfdpngtMZOT+90bXoBGPqeAdqsv/Z4sCp6I=;
        b=vU150XI9RDT22VBPIwT5mYMka69+Kv9fzSDZpO62LhYUTzg6WLSHtDoGe/gcfFQGR/
         UhrYqb5fDziNFbOSypz2z78fKWyyjVV6hV20yMOVXczDmP1878TWgV9xq7atIZzXrteB
         BOrjtLs/APd41gYW0q6Odz0YgZW4anlVDfY9rzq+hJu38UNCoeEahZQispC4MwreCLe1
         rrn7KQT8G2knMYzx51bwSOxpZCibwWYfYtgtLkkgZ1aGfFYTa59BHl86Q88Hqs4zzqKz
         YK3aJ5LcBctCXPdEhCpV/q7yxUr/TjOwZ1JuJNUsSHEfy+efMU5UfUkEue+fGsrnveax
         RkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630424; x=1691222424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93L8BkPgEfdpngtMZOT+90bXoBGPqeAdqsv/Z4sCp6I=;
        b=JNM8L+xxH87wsZfuYtRN0YGMbEEHx1GtYQOb7b6HG0DozRTcWete68q5KaZTl1aWyG
         sGPthv7LXtrtSduHP3tcf2CDT+JTqGSuS+1r0S6MzzJn83KOdMbQvMlxWFItLgysU+We
         lP5eMV04jOdqB9OGjVyAdVkmTRzO8+WZub7JJDe8OuShkB8kSyJ8XbCIJY6pBJDaQkoC
         ufR7DUZrnBKaES4wO97ZJbeFGcKy46gE5CPeBOoiv7SfCtxKSm9i/qpsv/F15vLL9mg+
         Ly/1Gr4wYzntZq1WaOyFdwkzUHeHKbvV0BfAyjYX+LINgPD4ksgQCJyHL/BehAi3r94c
         CFeg==
X-Gm-Message-State: ABy/qLYOjUQINEFRgwT1hO7e20+/t87Vp+XoEU5D2UkERkpD7vWTB8c0
        7dujSt9A/ZzVFD6mMFyMgby4WQ==
X-Google-Smtp-Source: APBJJlH0UmwL97d4yl5LZFrPLIyAm9frS5cCiPHFs9ODvBbOTYDidw/cS4bYqCerJ4g5RTh7W0WAmQ==
X-Received: by 2002:a1c:ed0d:0:b0:3fa:934c:8350 with SMTP id l13-20020a1ced0d000000b003fa934c8350mr712696wmh.27.1688630424030;
        Thu, 06 Jul 2023 01:00:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003fbb1ce274fsm5587375wmn.0.2023.07.06.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:00:23 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Jul 2023 10:00:20 +0200
Subject: [PATCH 2/3] arm64: dtb: amlogic: meson-g12-common: change
 aobus-pinctrl node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-2-63ed070eeab2@linaro.org>
References: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-0-63ed070eeab2@linaro.org>
In-Reply-To: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-0-63ed070eeab2@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=j0QAC12CtwfrA2b91cLW5DK1eWrkH7AjxGLlYCOHUHQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpnSUU9xjNbx3BwIiYJT5nPcv/ge5kWU6GfeJ0s8k
 hFc3PyeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKZ0lAAKCRB33NvayMhJ0UHQD/
 4xq6D1Guxs5dlH6ct0+eIOmFXYCUrg+J/IQlW6wT6+ghlC3C6MNL4cKteErw41khgrHPUGMTj7tEkc
 y0e7CELHvDwEZE+Geo0j74JxjrjVhCXLoEJkSff2jdR4cWCx9FTQKmjhLKOsgjP3rv/5cKoQd16luY
 alwYX41SnyHIzKjJsrxXHcERxx6cgoDzVsFz/FoIIpUzBOkVVjJ5nJ/L1ZhdmNQmGLKJMAhs3fwbqW
 1pTCh1BQdfGBqWNFxY0eRgHwRWLo9qTGXnMlaNRX9tSaRLwxxR+9yRuccPgSChBnFqgMXRoRvZVduV
 ZeIVP+VxHUJ1nyOt1I/PCuRvMRjh7sARFMAxjJpnkarG5bKKe9G7yVVlJXNe88amcIgl0qo0IZ/Edr
 4iqMfdKBuBmUJWD3wxZohrarpybgCuxvvOZczrF74ZaAHsR2B3GtkpOLY9RdZ2gKzrDhpTmY+ZOFSn
 JQqBJEIVzpV1fnrw4Ptz644zqrCh24KiujitJvDh2Mp9oQoSQJJC49fReigZq/EgpjQoR/+nHliXlF
 w3tFhI4ngmyUTHe+Vqw6tGGBmtBmHswKXfRfOzFsZsORERL7gn/6bEXsbWHpZdM6e9lQlOyVnNu+EX
 8MytTF78aJJqmimWcjZtzbsbPkgdXZsgNDwlKjAt2etYgD1nqQoIpWFqQsiw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expects name to be "pinctrl", fix it.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0c49655cc90c..6d39faba7c3f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1733,7 +1733,7 @@ clkc_AO: clock-controller {
 					clock-names = "xtal", "mpeg-clk";
 				};
 
-				ao_pinctrl: pinctrl@14 {
+				ao_pinctrl: pinctrl {
 					compatible = "amlogic,meson-g12a-aobus-pinctrl";
 					#address-cells = <2>;
 					#size-cells = <2>;

-- 
2.34.1

