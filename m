Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0793708375
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjEROCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjEROCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:02:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA40E51;
        Thu, 18 May 2023 07:02:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so797599a12.0;
        Thu, 18 May 2023 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684418549; x=1687010549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2Hw87l7Ts/Jxr3HsiObApCTHPM3x3z16x4yMMIWg7U=;
        b=UbH1d1RvF5tQKqhb7d53yj0gbmWx4JmBW7ux3rULr/Kjj0RuhefLvFoKuKO0kuGFm/
         V0D0VT8n89q4OS2WsJqIWcEEGnQLhbvyhjaVN8TMCqRgmYZP5xKc07kNTiHAgLcgBEN5
         t0qTXum3ZUoTrHXW7fdqxSyPbp4wH8G+W/xmC0+/VP8HHr9PIhpcIaVu0bfaZpalwmS9
         OWPS3v9iQ6AlKx0SSIcmUEZQ8BvxeQzWx/KGKjoObMxmfzzpXCnqc3Mu4zIilMQyjhY3
         fCiYZ5oRZ22P5VxBilzTB1TFn2XsqMNN3abIdzGxRkEIWX9b4vVgbYfdBrR4p48cnFia
         jpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418549; x=1687010549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2Hw87l7Ts/Jxr3HsiObApCTHPM3x3z16x4yMMIWg7U=;
        b=SKUpUP2PehJpDex6UEG2I6Ag9j67xvU8LZlNwWGaZMw1lFe4vqVoKNOKuSffYRAo0D
         4FNU7GNuFatrO4w8maTosttiw6a2LXw5l3kNINUP4pgKlOyVavrehxrYxrsQ+nsc+enI
         bxvcJYO556WRfbJ3zuTR2RFOiBdwAS9ipCiXTxWmfJSa6dI465Xfwwl/sKrcyr4h8f5W
         OI/ReeupjHQJMgIVBfUCoZ5e4yjWIozNLK152pvQeyP2y8GKQ57l1LfmLpsg/ZmE2FrV
         15z5gPNMClOZ7SS/mwMc2MR203MP+ZDTHgEaUZV20xRRraBpiiGHnqTzlYAbRJxjMixU
         +WZQ==
X-Gm-Message-State: AC+VfDzvdwS0Fnpdzn7QCJ4ekXv5YRpFbC/Pocfo3hawTrpt3/crXVRC
        hEK3SFQVeHADvad61cLvNs6cWhkyN14=
X-Google-Smtp-Source: ACHHUZ4g1yJ2IoW8AWI40CmRxuC3p7yQTD2VvHNMhL4VhevYghbQIBuSPIaOlRiiJsnlkZZd26ikoQ==
X-Received: by 2002:a17:906:fd8c:b0:94f:3cf5:6d7f with SMTP id xa12-20020a170906fd8c00b0094f3cf56d7fmr38420982ejb.46.1684418549192;
        Thu, 18 May 2023 07:02:29 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-130-143-cbl.xnet.hr. [94.253.130.143])
        by smtp.googlemail.com with ESMTPSA id m14-20020a170906258e00b0096f272206b3sm997025ejb.125.2023.05.18.07.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:02:28 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srichara@quicinc.com
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [RESEND,PATCH 2/2] firmware: qcom: scm: disable SDI on IPQ5018
Date:   Thu, 18 May 2023 16:02:24 +0200
Message-Id: <20230518140224.2248782-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518140224.2248782-1-robimarko@gmail.com>
References: <20230518140224.2248782-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 seems to have SDI (Secure Debug Image) enabled by default which
prevents normal reboot from working causing the board to just hang after
reboot is called.

So, let disable SDI during SCM probe for IPQ5018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/firmware/qcom_scm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index bdc9324d4e62..c6a38ce49fb0 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1525,6 +1525,14 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	/* IPQ5018 seems to have SDI (Secure Debug Image) enabled by default
+	 * which will prevent normal reboot causing the board to hang after
+	 * making the reboot call.
+	 * So, make a call to SCM to disable SDI.
+	 */
+	if (of_machine_is_compatible("qcom,ipq5018"))
+		qcom_scm_disable_sdi();
+
 	return 0;
 }
 
-- 
2.40.1

