Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1956E64F766
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 04:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLQDpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 22:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQDpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 22:45:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969DC76;
        Fri, 16 Dec 2022 19:45:38 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id ay32so4277291qtb.11;
        Fri, 16 Dec 2022 19:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItbcAsV7adGw2IAMCQUtrEQW5WhY2O45Ebyft+pkklk=;
        b=YHb09iSuqUpK5wugnNjDBTO188ZMSclkCnGtyXOo7jBXxLi00THeSwzjGaakDY380a
         DX/BCtuRICe2ldqaZFdFAJYMFDNLMY318RHo5DQMu9ZxBlgm+oWoHzrOjeBcTKgA21eb
         chKQ3IZIvpQ++ACKYOzrwmMFgkB1jI7ehkjBQmSaBlSNGQtEuUggG6F236bDUmXV99kW
         TUpXmti5zuGwl4X7tDSJSuo6u0/qJha7zNZQ81KO+KSc/aAIQH4MiXbIWq2M6+UTBZV+
         zZX3Ii5IQIkN3nv1Vsh7wEdbJVKENqqDDDZ10F+D8ZMR16Ztk5kq0K7g42Ouby1plwhd
         NAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItbcAsV7adGw2IAMCQUtrEQW5WhY2O45Ebyft+pkklk=;
        b=zU0mZyysvZkRdpi+9goI/n4LfvF3E0nurRAgSE2/zERpURSdPWyUImPZOkfQIdyKO/
         29dJLUGWSVcXshC939wzrEZlm3VgSsdRcA6+Rql/KF7kE7un0rUpCs2xApyWfCVi98if
         YQV872HGvr9ep52szpyeQIVhQLwWlNPaNSJHe5NA/QVRExQOmS+RbGLBcA3Ng0C+p2i+
         ZwkwA3As3SAkIJrtoXSU7CvfmsmVUpU2Wq6zA+W2A0iGjUoHFhyUspL+c/vwdX6BizOX
         XGZL7bgKkq8RVR/AkRd39PjfKEvjS08nZjERN/RFu7Bc2wQkakfDJzcPG7MuayRHvvFM
         nYCQ==
X-Gm-Message-State: ANoB5pm2zqHho31MI7OeYdx+dA8Niewxan0jTzvUhtqEn1Vt7EnivHKX
        WAjv2YtuFDfIqTW30mw9nHU=
X-Google-Smtp-Source: AA0mqf5pL/bGIwWqOU/HE1CWWSw9kAtBRjqzTMkie3C0X0ihch1pxvEfvnruacER/71IqDIC5M88fQ==
X-Received: by 2002:ac8:7286:0:b0:39c:da21:6b7e with SMTP id v6-20020ac87286000000b0039cda216b7emr45997164qto.3.1671248737916;
        Fri, 16 Dec 2022 19:45:37 -0800 (PST)
Received: from Slackware.localdomain ([191.96.227.93])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a16aa00b006ecfb2c86d3sm1523433qkj.130.2022.12.16.19.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 19:45:37 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts: kconfig: Added static text for search information in help menu
Date:   Sat, 17 Dec 2022 09:13:23 +0530
Message-Id: <20221217034323.14880-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Added few static text to explain how one can bring up the search dialog box by
pressing the forward slash key ,anywhere on this interface.


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/kconfig/mconf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 9d3cf510562f..93dc4850ff2a 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -161,6 +161,12 @@ static const char mconf_readme[] =
 "(especially with a larger number of unrolled categories) than the\n"
 "default mode.\n"
 "\n"
+
+"Search\n"
+"------\n"
+"Press forward sash(/) anywhere will bring up search dialog box\n"
+"\n"
+
 "Different color themes available\n"
 "--------------------------------\n"
 "It is possible to select different color themes using the variable\n"
--
2.38.1

