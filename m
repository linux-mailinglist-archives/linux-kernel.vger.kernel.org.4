Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AF6712C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjAREqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjAREpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:45:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D45582A8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:45:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 78so23639955pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgLdZY95SndgcyNayQmxOdJ0Ym9jsDdjWpZ5HTkP+n4=;
        b=kA04TT2SWyelTnwWu3VzoKC2lS+ElZrLAswlaptiKeua2oH/N/FOx9BPJCBF03Upyw
         Ea1TY0Q7sa/dgvR1Fm05BnsLeHS0EhPAL/pZ1BCsQVYDQnAKtEjMR+qxoxy9GVvrJm5W
         Z4hXbul8TcR0WliJSP9LMGT2VxNuRvvPoFPqQF4tEgLa7K5W0z3qxYXi4szwoHjCq2t1
         a7pJyUduDg/fJt6gJ3M+Xb7lJUsvh+Koh/GxjlHBdOAgWDb4ZaHB4RIpNjhInUjUp9/O
         dayYfKZ4Cbe7Jfk0XLRiau3EregczJwjfRQWb5xlAv/FNzH5g8dP1FqqmJcL3azVTi7T
         BorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgLdZY95SndgcyNayQmxOdJ0Ym9jsDdjWpZ5HTkP+n4=;
        b=R8teJApgi0TiWzSuD+RQROypDQ1uwP7FrSX+0CpJibAxHY6K+vj9/umyRJ2xFp62Pr
         BCA7ExzpfPPbPkfa7PH40gn4nmcsdLSieV2Kfx4Pz/+qhcYV+fX2esfCTBJSGXuGcpth
         3/ksHn/1QqFagxiTiHMqUefkyVOXZCSTCZOqBv8jswYVCxgmKiZ1csyNaAM/xXZWuSnY
         tl13yfbPHaZ3ReT8UToJ64Gk3M3rfHXJ6pJzG1vXkD48XlDdDTxe1ViaCZwzV4IM26zj
         avVEb8I3CdoxBLfwNjbUCkvhnZLRtLcWLMtCNamzvCE1HRQ2gOfoBPRgEstp2EkC8FJw
         rHZw==
X-Gm-Message-State: AFqh2krNAC86RrPyQYNpD4fbzDUp0OlLJ818WV+ET6oFHW25YK7nrpan
        fJAEHD1gzeJ2T+bPfyXDXlPZ4s6ojrQ=
X-Google-Smtp-Source: AMrXdXvcpQMDd5Il1H0XAbL82o8MyvvYHbcS6jd/GLlhIKTon/W4rX+AzpyR98pPPnfSeN6mdbT0EQ==
X-Received: by 2002:a62:6104:0:b0:588:a156:6a3d with SMTP id v4-20020a626104000000b00588a1566a3dmr6242169pfb.26.1674017129702;
        Tue, 17 Jan 2023 20:45:29 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:45:29 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: defconfig: Enable USB onboard HUB driver
Date:   Wed, 18 Jan 2023 04:44:17 +0000
Message-Id: <20230118044418.875-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB onboard HUB driver, used on Amlogic boards.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: - none
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..42c3528a2473 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -923,6 +923,7 @@ CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_HSIC_USB3503=y
+CONFIG_USB_ONBOARD_HUB=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
-- 
2.38.1

