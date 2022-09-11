Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5A5B5062
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIKRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiIKRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 13:49:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6865AA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:49:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l14so15258481eja.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pPPmEhZFME2nJneDVNzT2ko3F6Kn85qH2e/NdwR3mTY=;
        b=ZHoP3/hh697Gv8CwxUR/6//HdZA/uJDHS/Sxf2bSba4VjIozwv6+fWT4J2msxeAh5U
         rPTld0BkuOGn32dOQN7ejzhaeARYGjz1nau3U1YtyZBf+UHdr5fFpPfC7I4xNXBFHjZa
         blGD30yjinzqBOnZdYm7GtcrbaG5ho5K5Eo4I24vlyI7TAbJD/zjOHFf2w1iZbvMo6nt
         FtdNm+RDNk73gbXpQqwGqHa4PYEKlHGR26cItRc2kPsUzJKghnY38Eb8PcLp4hxQZO8N
         MPYEPXnuull17yuqf5Wt7ucRF+e6UeX5/5tllS9WzSpHFp7Kr+CH/iOc8oB+I9tjAmrd
         IPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pPPmEhZFME2nJneDVNzT2ko3F6Kn85qH2e/NdwR3mTY=;
        b=FJRLo5Fv1Mk60tbOqIpuv24Gxn9RmMjhtuu2oR7xRSCBQo6My1CFFkRiDH5FwhfQFf
         B/ZCTC0FedxydnbtiZ1I3d4iwUnGMY727MBh6qpdw7uypTHJbrgyJhbNUfa0GZ9656VD
         QAt0sJ3DFZ29WrbLNu15DeUGgJrdLJ5fJOBXf6FPjNp8X177zCvz1t5sStJuV3ov/0mM
         cR0q6bqDlKc4eXEcC7Mctp1joEYauhJtt5wZQbOPg8m9XQtdLByrTPzvYs6K5tOLkbC8
         PTuMp/oEGBryZoSy0dv6KZW/Qjn6kbwVNbG3OFRsB9eiXSLI560iU5k0F1ESVSbzUPTM
         BQwQ==
X-Gm-Message-State: ACgBeo0mOLAv/lPsKgF2JdP9cKdp+dG/xWpi0c3n3x2flj7qWjrJAa9Q
        fYi75Deh+0fesz86Pv+EjZo=
X-Google-Smtp-Source: AA6agR7+/yEqjMO2d5PwaVdr/iK1JPL0B2OUft0DU+5NbB8iewMTjyFu7AwoeesyYZIOZ1ml5jDm7Q==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr16167601ejc.243.1662918581603;
        Sun, 11 Sep 2022 10:49:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b007336c3f05bdsm3265393ejf.178.2022.09.11.10.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 10:49:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: remove recv_osdep.h header
Date:   Sun, 11 Sep 2022 19:49:30 +0200
Message-Id: <20220911174933.3784-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
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

This series removes the header recv_osdep.h.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (3):
  staging: r8188eu: make _netdev_open() static
  staging: r8188eu: remove unused prototypes from recv_osdep.h
  staging: r8188eu: remove recv_osdep.h

 drivers/staging/r8188eu/core/rtw_br_ext.c     |  1 -
 drivers/staging/r8188eu/core/rtw_cmd.c        |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c       |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  1 -
 drivers/staging/r8188eu/core/rtw_recv.c       |  1 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  1 -
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  1 -
 drivers/staging/r8188eu/include/osdep_intf.h  |  3 +++
 drivers/staging/r8188eu/include/recv_osdep.h  | 23 -------------------
 drivers/staging/r8188eu/include/rtw_recv.h    |  3 +++
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 +--
 .../staging/r8188eu/os_dep/osdep_service.c    |  1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  1 -
 14 files changed, 7 insertions(+), 35 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/recv_osdep.h

-- 
2.37.3

