Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569C25F864A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJHRrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJHRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:47:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91DF360B3;
        Sat,  8 Oct 2022 10:47:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y8so7454314pfp.13;
        Sat, 08 Oct 2022 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUKqsoczDPOBHc9UJMJ32o/8VoKU4i+itPLa1Q+iQ9Y=;
        b=cgXb+yf1vpIgca4vkBfoQySGaX5MZ1vXyTllIcSyDn02GZxjCrQGwHp2cdBYXCZaP4
         +O3mRY7Fu5KxlrtvlmXrkr9/ONuISrRh2/lZFj0MHOrTMgwYxfLim+Mc5nH/MLSe3/0c
         ivGlt9vQG1v1K9E/4ezJSpYZ+wLdtGtmjnxTw+v8HfE6pc4HC5tTxEhacw0POuXpg9ZU
         iHKdcJYkT0xrHJaw9WTP3S8QSCdeEVorJ6jEFFH5Y4pQvqTm7aD51BWej/RZRw19hyQ9
         VrEgXVn+DCthIog2aJssGLS0WcD6mIs7dm7AzWcGD2yyBCQ0AiXVcVSA+wXiwDMo+2GG
         2iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUKqsoczDPOBHc9UJMJ32o/8VoKU4i+itPLa1Q+iQ9Y=;
        b=loR47aU9bJXiFm3tmLJe7O5FzWS+aYIzQRRNTqnm+MkDUlXwka6fRuH9Sr5OJjcTpq
         NSb/QF1s0RGuHGyfQJPk3mfAxoKolYMgLC7h+7SFnjQQFBdboq/1H6smK8RZqIpd6ept
         e2MAYI07TwX7KDtvi8CJsSeXS9nh1bcuEqu0jYC438qTGV8B7LgKJFqZLdH9K/WFVz+x
         5WPb/DubM07cmxI6GR+ssy2kQAxa2Zax/Hq0Ug05UPxIxbdP1V5eZvXOrKwKdNgQCgJx
         4BomACk4bz7Bky7OrwH+nDW6eAypq8Lch7qJHoDFSm5DqpWRG8Fx+VdAhIRCvq8FyiRa
         x9iw==
X-Gm-Message-State: ACrzQf04rcwE2/RBm8097nsc8wQEkMsbJhAGvUsftepn4YhEOFVKDV6n
        1ggO9/jKzK59tTvRQCnQrq5VAO5b7Sce7g==
X-Google-Smtp-Source: AMsMyM7SEReD9dmbpYyhucd07Cu2MlcX0ordg6+BHgsy4+jH9Zc3WtO5aEXV9bFISJMBXXqIRJg6Yg==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr10829161pfb.43.1665251233619;
        Sat, 08 Oct 2022 10:47:13 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id o9-20020a170903210900b0017f7d7e95d3sm3583270ple.167.2022.10.08.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 10:47:13 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v3 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
Date:   Sat,  8 Oct 2022 23:16:57 +0530
Message-Id: <20221008174658.336470-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221008174658.336470-1-sireeshkodali1@gmail.com>
References: <20221008174658.336470-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Audio DSP PIL found on the Qualcomm MSM8953
platform. The same configuration is used on all SoCs based on the
MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd0941e552..70b3a37c4814 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -950,6 +950,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
+	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
 	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},
-- 
2.37.3

