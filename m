Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25966C689E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCWMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCWMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:41:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EAA26CCC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:41:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so40300112edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVG2u0PxjcHnMZyDP5cFJRBQ+0w73Zdls1zxTkcKhxE=;
        b=l3b1/M2Cn2SD61AbMUAh/TBwjjFbzcvydms1Cs14uahXwTgTcqnU0eN+PlYSNNct87
         ZsAbO0RVQhGJoSm8skL4YDslmEpoWEiQQjDaUhpccrGwlnMMqmP/ro6TTynL8D+rwupr
         UIOU0nT3PJOD1ICiEoO5iKc6JgWeCu8XqAR7OC3gQCNyNXdkwKNXvmTpIu4zUY8gijRt
         upRtubyIV+CGhLZvzv99c3CXUVyoSjDR1o7U4GfxgFyFy7WLp8Pt5FHqItgOgQYjcICu
         6dvdEMsdqCfNYksFSukzPbusrBR/W8mGj62rPQrQcC5Oo9YNnwafeT3H+HrBC+bLjIrS
         Hstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVG2u0PxjcHnMZyDP5cFJRBQ+0w73Zdls1zxTkcKhxE=;
        b=d1NFv/v90BVBt6iOCuRhNSPv0Nh4IHmzQkl7vyTFUgX6k3XzI4X7mCnM/Z66raOHiN
         8RNwM27c/3/skkWndLxFS8+Uv1jB+6GCN//trXuw2nmPfNd8QZpUA2B90hhyJn/WROpg
         +rbzSh15wP2vZxK/WkjduXQOXD3sCbnklXoqen7/sfIVFbqsSO/JYjIx7MTunFP12eHH
         bCd4XwOAfOpflBMzuAm/ZKgz/X18BVTbg3AvJnOMh2EtmvjoRt2iTtdbWdF1obHrhXYt
         d3yHnTf6Ygt9hMClBaWzgP2ZSulJPuveYFj3iSZKWW0KqnCluTGm6tCAV0cPcGpgqLZr
         t8zA==
X-Gm-Message-State: AO0yUKVy+WsOBDNh0Figxn/SN0+cAbOEIBnRZecYOHUGzwKL12kWTC3U
        xfGMYk6ei6CYMFgwT4TtnX4=
X-Google-Smtp-Source: AK7set/s2gwiKYde2VbiZIdsbRdcq5OBQtmxNrG1px1Vx8f93IvxUqwfvBJe2xjX2loauCDmeXu5Dg==
X-Received: by 2002:a17:906:960f:b0:92f:e4c5:5a28 with SMTP id s15-20020a170906960f00b0092fe4c55a28mr10840307ejx.54.1679575309342;
        Thu, 23 Mar 2023 05:41:49 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709061c8100b0092669fb4ba1sm8597116ejh.130.2023.03.23.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:41:49 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
Date:   Thu, 23 Mar 2023 17:41:41 +0500
Message-Id: <cover.1679573474.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several cleanup issues reported by checkpatch.pl in module
staging/rtl8192e in file rtllib_rx.c

Khadija Kamran (4):
  staging: rtl8192e: remove extra blank lines
  staging: rtl8192e: add blank lines after declarations
  staging: rtl8192e: add spaces around binary operators
  staging: rtl8192e: remove blank lines after '{'

 drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
 1 file changed, 29 insertions(+), 44 deletions(-)

--
2.34.1

