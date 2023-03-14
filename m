Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8966BA18C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCNVlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCNVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:41:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA91205B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:41:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t11so21851530lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678830089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJbJbhHmfWRphQyjCoG06TRGjcEkjB+qtxbEL/wcPao=;
        b=bvXs0JGQVGwsouxWl23plCs+wUJ3fUe55Gbay+ZZrm3fSzHecgc1knsvl3AgIQ0Xlh
         qTXQHg4LHld0d7CpizOZww8nIM4+5apmx9aZRZKUTBvTU4LKq9/eiaL0lfxaMM1JP3ew
         aYwPtNV5AicU/bd8JOXeBsB9LvY/DKoK0RyhCoU2XZTdjYJCyNbz98/VrbmdUVdy9y3Q
         ybqGVVTjGaqXVaG5HDQ6eZ9uY9O0SrKNCGuY0QylCNCz3acP7EpUpOobzZHzE4sW1syZ
         ArijTF7/JzxckErIbQd6a4Y6c1EjZW7ySXeHOwOT1AEgPORGIv2RLBuShUpHtJFW5uYO
         Ijew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678830089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJbJbhHmfWRphQyjCoG06TRGjcEkjB+qtxbEL/wcPao=;
        b=iHOJxsS62O/ZeeOHlDiBzkoQBqxmFVLl960BmubFvdIdl35nrElu/azZ9/tJUUii5q
         Vd2DMqOqWNJZu6jfhezkxpRtHSh9Cx6ug/fpt5fzPF5Yf5qhzZo24ANb7zqLRpHoFoN2
         BPrC/a5jjsDGAk34SsLwOBtbIgJpZ5u+TKYrvor82/URf6qzI6z7e/BBRkujODzEsyVJ
         xkVOzNHBpOf4Q9yUQWZZZfCfo3sfnNiLZVteLHgs0mSPRfGJooP5OnpHPfL9fpp8Am5e
         zxMBRB3SR/r0fOy6Z3bsC1xMsWiHEV7tV7FeSUJddggXbWH3CC5HHvFP+wWOPgmtnnuu
         VPpA==
X-Gm-Message-State: AO0yUKXGMEqE6l25DoN5BFTgcSAZD2geiiI37F5kyTLEebrO6TCP62uK
        08KYJ7ZQQQQSuvy4wRJa803X8w==
X-Google-Smtp-Source: AK7set+zGz+kgTDd+q2pcd51jFxsurqODbs8Gp8uIegKUaGNsfjBocbIVz2gxjmT2ml0v+lHYmHnVg==
X-Received: by 2002:ac2:5584:0:b0:4ac:b7bf:697a with SMTP id v4-20020ac25584000000b004acb7bf697amr1189480lfg.4.1678830089590;
        Tue, 14 Mar 2023 14:41:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id g20-20020ac25394000000b004e81e9d77c7sm549081lfh.107.2023.03.14.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:41:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 22:41:16 +0100
Subject: [PATCH 2/2] soc: qcom: socinfo: Add IDs for QCM2290/QRB2210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-scuba_socinfo-v1-2-acd7a7ab9d46@linaro.org>
References: <20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org>
In-Reply-To: <20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678830085; l=843;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RJTyIBDlTKEL0jArZuG+aQJ7NYRyjHSZeISjxtHbSGo=;
 b=JESjGlnjSVq2/d08hgRFFXLUDqCzOQ2f2AlCqUKcwq7Ty8XzEL7tX47kTmBjtYqKQl9gvgdfL9a2
 0Vp65BI6BzMnbzidvwH+YIlAO0VuALo9oU4hDMFBoU4HwOI45xJt
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing IDs for scuba and its QRB variant.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e9012ca1a87b..dfc0fc3e90ca 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -424,11 +424,13 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SC7180) },
 	{ qcom_board_id(SM6350) },
 	{ qcom_board_id(QCM2150) },
+	{ qcom_board_id(QCM2290) },
 	{ qcom_board_id(SDA429W) },
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(SC8280XP) },
 	{ qcom_board_id(IPQ6005) },
+	{ qcom_board_id(QRB2210) },
 	{ qcom_board_id(QRB5165) },
 	{ qcom_board_id(SM8450) },
 	{ qcom_board_id(SM7225) },

-- 
2.39.2

