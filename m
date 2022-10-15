Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C149C5FF7B0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJOAtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJOAtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:49:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF82647
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:49:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so9419039pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQKr6gxcoyxbVjA/4utImOsMAnHB8ip1bwqG26rMhL0=;
        b=UNaV+xml2akMbPhD2QHmFAA8pfCMe+3CkGKIM72CP1hO+V/OAyZ9/cBQxOEE7dgQq4
         v5KaiMedRXdVjRLj2/4q03YlrRHnmyBYA05i4epji0U1mO7XL00ry82NsBb5slWwEPrG
         ohpL4iEFpvBjbupLCA/wiaAvRHB12BMZEisx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQKr6gxcoyxbVjA/4utImOsMAnHB8ip1bwqG26rMhL0=;
        b=kgCiDGU+x7VcFEXSZHBxxOukU0uY7LYXtOr7G1KSWPfhKcR+UEvxql/f+xbHcaJo4+
         lFWYLanoKzVD6IVGzuVjyAhGJSmmDUpAm1J7V1gWBtvnieYMJmX8z4Tv/QRLYLkgua/Q
         FwoBleiS0jkYqUDKBZ3r8PFUPTwJ+5SJ3IF7l4hxvhjXsv820Lu49eVvfUMIzsrJ70yr
         iux6qa+VvC5WO9ByxwyyFJ6GVE7ZjB+udJtR+PaBrMv2u3nXxBr3WaOhH3vv/21OssQE
         OqXWul6dmd7GlJj0afEIBBCxesmJsdkHekeLOY6pIc0tD0PE3yY0JryTeqGVxyePe2Se
         3T9w==
X-Gm-Message-State: ACrzQf18NjO/0UqH6L7HU5xX1Y6cfZBaSMLobfWZsQOavQAd14s//aHl
        4L5Jxb/OzpDc427WBA8M8A10cQ==
X-Google-Smtp-Source: AMsMyM5M+YvV5wFht/uuppEYJ/Zz+P9fRYkhf/H0EYK2VZM6XBBCA5PfpfebdJ8em7GzUb7eg+YdAA==
X-Received: by 2002:a17:90b:17c4:b0:20d:4d79:55b1 with SMTP id me4-20020a17090b17c400b0020d4d7955b1mr631817pjb.125.1665794977885;
        Fri, 14 Oct 2022 17:49:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:9d:2:9f6e:fc87:d13f:1fa6])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b00179f370dbe7sm2256142pla.287.2022.10.14.17.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 17:49:37 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH RESEND 2/2] soc: qcom: stats: Mark device as having no PM support
Date:   Fri, 14 Oct 2022 17:49:34 -0700
Message-Id: <20221015004934.3930651-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221015004934.3930651-1-swboyd@chromium.org>
References: <20221015004934.3930651-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver purely exposes information from memory to the kernel. Let's
mark it as not having any device PM functionality, so that during
suspend we skip even trying to call a suspend function on this device.
This clears up suspend logs more than anything else, but it also shaves
a few cycles off suspend.

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/qcom_stats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index d6bfd1bbdc2a..d89453a77408 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -217,6 +217,8 @@ static int qcom_stats_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, root);
 
+	device_set_pm_not_required(&pdev->dev);
+
 	return 0;
 }
 
-- 
https://chromeos.dev

