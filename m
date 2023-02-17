Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C569A9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBQLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBQLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:08:56 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416636FF7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:29 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i13so1357448lfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewR/4MOaiU/gINYjhrHIOMUBrRkWJaPJ1oY+QNSiKsM=;
        b=S21p2k5B7+ccuNrH49EVUY2chKPzOt6KOrQTxeG1nClJN2/0d9Lj14K69gFVKHinV7
         4c85JGX28yJeJXGGYcbYgOHXKt4pF6HrpmCXCCtjJ+MxeKpnhmtO4HVZk3iWiDd3QJI6
         lRWyza0rFgEjtCVT4ryn2GpKa50/7xmcjOxvYQNRFY5y3X3X9Bdl/yie51J0CQZ9F1ge
         PsKTe65Znn39FWpN/Tajp5qeeb9BKU+P6tl8f7oYWyLfZuAzgjUwt5t+6xlEvzOGKohq
         QeA7TDLgKqZGHCRwnbTgJv/E20G0X8QiYoDp8ChYw4W0IB0lGURhNqWIfnO6LZKk+PkA
         pe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewR/4MOaiU/gINYjhrHIOMUBrRkWJaPJ1oY+QNSiKsM=;
        b=0b7WWQ2AnfPeRvlWEr5zOkZUyJDE9vOFWwomJ507EEeK5j5pbaCiGNVrEus+pURD90
         3zK9vI3PSMK447TqX1I/itaZUlwKk1iBWlOhZSwptSfXjM4Gxl7UeX1QZAQaOHEbzR6o
         HVRXtOf7/KxAwnGxu1eyUPOHkBePuh1l1NBBR7/Bjgo0XNpXGQ20qCVfO9toVEVwi53T
         d4tUK1pUrICympEo9IJnt5/kUQMcBvBdJk9EVpoyxIVAGHgZStJUQzdsUavy+PtSYD1q
         zvT+eM9i5ILZdSu/XT0tLghGFMVyLY5L9M7A6OuBR2Y3EjHpYqnlURgHudc+SXMkROr6
         FeeQ==
X-Gm-Message-State: AO0yUKWwpPsviiBGgit7sNG2z7BcXlXudN4BAETXXEqaZFoutFOGtZ2E
        Hm6XE0/97tBWfsjySbA8DkJkKg==
X-Google-Smtp-Source: AK7set+tbj3V9zMl/QBoojJKTbQHkMgFQ1ehkWHZjbZ4vBazZpNTDQNpZSqk+7DE1gaP3qvW/8QZIQ==
X-Received: by 2002:a19:f505:0:b0:4d5:9682:6ec6 with SMTP id j5-20020a19f505000000b004d596826ec6mr3390390lfb.18.1676632107320;
        Fri, 17 Feb 2023 03:08:27 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004b57162edfasm640162lfo.117.2023.02.17.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:08:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 12:08:24 +0100
Subject: [PATCH v10 1/6] MAINTAINERS: Add entry for Qualcomm
 CPRv3/v4/Hardened driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v10-1-67aed8fdfa61@linaro.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676632104; l=932;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hptcp7dy1Sql4Uyt2uSdMeDXtFfyCQiQgPMybKBOj9o=;
 b=VpPxFVfL31OkKA613+uvqzds3QqewiPbWDKdnpR6gN5BMpxCjp7H1np2ABHaCFpzUlXvVoYUykgH
 LyH0TTnhDrUVuIt1vw3PsUv4D+2FUGiyUmUfoSuxR+UXKQlZK9YE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add maintainers entry for the Qualcomm CPR3/CPR4/CPRh driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, update AGdR's email]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a56002bcbcd..c31dd8da2a4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17259,6 +17259,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:	drivers/soc/qcom/cpr.c
 
+QUALCOMM CORE POWER REDUCTION v3/v4/Hardened AVS DRIVER
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/soc/qcom/cpr3.c
+
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org

-- 
2.39.1

