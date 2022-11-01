Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99258614AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKAMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKAMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:38:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8018B12
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:38:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g7so23371943lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni6vn8aimD8dBtlaB3MTAcv0y7oV6QdV9767C4/MxeM=;
        b=Gs6+JT0tW5QX4OtsTieCfJKqxvl9a2tvmT9u/J87RBt11BEKk5vkf1j6z2UZuG+wwH
         JI3BWdvb92O6Dmwkup0hjqy9bn2+CTGBe/ongbaVe57a90KY5/uwbJcX29ovrVobTt9q
         pcDD/oITjc1M/vas1KJAU9gmNDsW23p6vaD9rA8sSSA6AuC0zoy9U2nua8T+e0XFdssL
         HXP3VkMoJyN9X00Rr9Gs0ctZk5T9u4pKYvFnsROszQbfaqF54/uoBMzUc72kdjIJuLmG
         bmth3KxSC6Z8VHYeUW+bWWFmFIovpIArTcAZpe2uF0LzrISG9NeIZ1/AOESCtLY26bq0
         MsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ni6vn8aimD8dBtlaB3MTAcv0y7oV6QdV9767C4/MxeM=;
        b=ijL88XghNNEeC1rQqaDxicP0X1n0dT1y7PAff5er4Kq+zmasue11asny7WuPWLMlm2
         3p0OURvVS0oCm1/V1DrHKIYAAwLzOJ7jSOanA/cjX1BlCuIT2/zM6DjutKRk2t4V8xQO
         tq0vOkdwa3ZvlOwG1gY6SdIBukyu/Rtfq4CIuv/kXktn0uDmME2K3awdA6amC3u+7TLj
         vRYqwNAH9ib5IzwdD3IcsR0y8c1dBIVOdLWMuy/KFYD5nXxWkKc5WRFWe6yAdLkO4H21
         f9t72IxDS/9Ee6t3d287ENdRDCCCUNn7sqGddaElcQlqJ49kIAdNMK2MuUucPIRpOYlz
         NAMQ==
X-Gm-Message-State: ACrzQf05l+5/swCw4QrHG+Bv2fNCUkUhfG6S9BhhCN5NeJDnjCJfnMbO
        7bRgi94PIRMxGA3vYUQR8gA=
X-Google-Smtp-Source: AMsMyM4YBxuKAD1N/O56UOTNdKrmaccrmfHrTbOOo7N3Dz51hpmvObZj7Ulwam3JZzNyYa+SbRUiVQ==
X-Received: by 2002:a05:6512:220c:b0:4af:a589:44eb with SMTP id h12-20020a056512220c00b004afa58944ebmr6993568lfu.383.1667306296952;
        Tue, 01 Nov 2022 05:38:16 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id p21-20020a2eb7d5000000b0026e897e3236sm1771625ljo.6.2022.11.01.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:38:16 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v2 0/2] some checkpatch fixes in the file rxtx.c
Date:   Tue,  1 Nov 2022 12:37:58 +0000
Message-Id: <cover.1667305446.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

These fixes are focused on the function s_vFillRTSHead

v2: changed confusing changelog messages

Tanjuate Brunostar (2):
  change the function name s_vFillRTSHead
  Join some lines of code to avoid code lines ending in (

 drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

-- 
2.34.1

