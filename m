Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8DF6B764A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCMLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCMLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AA6504A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bp27so5001242lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMd/fSoMYLuM7nLGHQDb8PX/xkwXM/q1Im1epEv8KM8=;
        b=hOJ2OIfcQ8xmOUjCn3bxJpYAGXWj68VTQ5iYJZ4OSb94VIBEomBBAl9kDiPCg2pJ4r
         PLDG5GH5uQhx0HoIFFnSUULNMCeF6B1OFxY4OGsMEezU09bkRqzVX/40rlxTFnMb0yNL
         AoWzp4zxNMuf5d6DyZUUmsNllrorc0AmUyYaQ7VO/ivT5GSssvB7kAF8+wmdT1YkdFWs
         UduOL+1ltbv0U/oNLQDA72LXVL+En/Annqc6mghhfur6pQyv7cVHGy+8TDA2h0oT5ZOr
         S36b9fmVd48KL2AvY6tnKkuxd2dvE5tZAVVaWkinXmjQ+tbztxHNLe15kTnCaQS3g5iW
         D9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMd/fSoMYLuM7nLGHQDb8PX/xkwXM/q1Im1epEv8KM8=;
        b=0xlC7I3ZzK3oi/pCHXtqOhKASbxl7tnfk1I5teWlknjgRMAsiEsQGDVGSnMgKA5whV
         K+uU0seKXosO5lDZEtDmIrykgbMYVsMw5Kgz2b92f5G48fjPtHkzLfLo5PYbFrV6J8Ez
         CZw97BoR+carRZDANZYhijUehAmqCPRdpNNln21kN7cMI5D8SlcqiR/M+eLx5Fr3oB2Z
         bGFLnX8OCrmV5Fg0ta+n/0CwaVPNNDX1+/w+gckGvDTmgDheCuf5yzAWX8wkOERw7zSg
         rFCfUN6KU8gWj5rUIK5e25wbgn6yBwty9Uv8DaGgXCoSS4nqOiDiOtLqwIykfsANxY95
         KccA==
X-Gm-Message-State: AO0yUKV5rktSHXkEWy58gTP7Zy74tXfyNYvhgkh/CDfmwFHHv7vBotA8
        kM7h/AhsdNAgdzzGwpu5NkR+kwk21JHWQFFH2SM=
X-Google-Smtp-Source: AK7set9zmrkT7t9m8xfL27x8Lgvt0fcFSb+J0GYy9/1OhupDm3dJ64Pl4oe7T5QQ9b8ckQwMYHzSGQ==
X-Received: by 2002:ac2:5106:0:b0:4db:3a92:2c85 with SMTP id q6-20020ac25106000000b004db3a922c85mr9821478lfb.67.1678707681234;
        Mon, 13 Mar 2023 04:41:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i2-20020ac25222000000b004d86808fd33sm948465lfl.15.2023.03.13.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 12:41:09 +0100
Subject: [PATCH v2 3/7] soc: qcom: icc-bwmon: Remove unused struct member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v2-3-04db989db059@linaro.org>
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678707675; l=851;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=a+7UxhwPe8d61BMoAwcf5BTpQhH1To5AXAuiYkU2/Ik=;
 b=jUx0oZRfG7dGC/yyC6ZvD4X+x5wFkeq9oqlm+aYDu6ZAmyyHWKxjetMpSaN0o4ZZeWXm+sEeHUqy
 epkaJ87nDnBsnP6G6l6VMN7r+lHUQJOYofaPmZBasDh8Iw2jifMv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bwmon->regmap was never used, as the regmap for bwmon is registered
through devres and accessed through bwmon's regmap_field members.
Remove it

Fixes: ec63dcd3c863 ("soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 2fe67a3cd2d7..3a3230a62ad9 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -184,7 +184,6 @@ struct icc_bwmon {
 	const struct icc_bwmon_data *data;
 	int irq;
 
-	struct regmap *regmap;
 	struct regmap_field *regs[F_NUM_FIELDS];
 	struct regmap_field *global_regs[F_NUM_FIELDS];
 

-- 
2.39.2

