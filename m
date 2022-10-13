Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D25FE485
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJMVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJMVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD98E7AC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f23so3011292plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=KQgo2zXP+tJ/+H/TKYBwXrAsCTfldG+gzWEyNxscaqk=;
        b=RDWNAe37CYCOZe2uxcHMdedExNDFH/SiZvAZCHNCu8SzTaxrwyQ9iup+miR3QnzU35
         wZHbgDNVxXa0THLnrUwfl6wIfzrr5qMHocQRnPAB1Ag9VWY0mnS/t/uSxl3v93hTnuIx
         jtKvjCN1qbwX3SqEVtyjgHzA4F6nPc0xPaoie5K+nuaEVBbyUpZDZRFkYvVvm0tzDAg6
         S1ad6PlV5d5uik7mP3YDlm09URmNHb0mETYHm/VfIEY3WyTrycAwNfyEPpPXcRGtsrsQ
         zmOWh3aux8330/S2Z4sTdMTgbywajAhxnIl4S7ZuFasNFj+XqgiJocM38yFsMf8xyWNz
         nTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQgo2zXP+tJ/+H/TKYBwXrAsCTfldG+gzWEyNxscaqk=;
        b=mkw11rsiWVRjy6D9JlJi34w9niPVySOISScTkFpvRKTnSY4KZ8yZupaWqnnSGTzXbL
         tm/R7R4eGhC3yeZi14ZpgPFj3k17CzfvJ95NAh9yGjOBjxaTUxOi+7ew3tvWCwL+wHEb
         I7+5pa+OM520wQsMccfTpAYVMba2wRS+PodipAvqEHVri2XGiEZ/rGWb8iNqPpKI38iu
         EHsHMaVG4BC1X7qyr55uXukTUpDenyThMxgmJzJxQY2PzNJfMVjNyRGuFhyyWY9AaIwz
         B+HYlnXGeN0mXsJ7kpfjB4ikHm69aEe/gR5hTO0xMJKEOAzahsP4aS2qoYYJowXTpa7s
         2AAw==
X-Gm-Message-State: ACrzQf2LbujFGRJUs3nAIb/nnYjE4iKXPdTEsA6p1QF7HIV4GYAoTKFE
        D/2b8cywj/zbV3DzJ+xBploXYSCSfEb8Lrdq
X-Google-Smtp-Source: AMsMyM5DzIF+WC8Rtc/nrxiKYiQygQ4s4bkeci0ywjssXRYCIl652HaPHHzfnrcd3DPWxlgvTbV+Fw==
X-Received: by 2002:a17:90a:bd91:b0:20d:2add:96a4 with SMTP id z17-20020a17090abd9100b0020d2add96a4mr13574047pjr.195.1665697758098;
        Thu, 13 Oct 2022 14:49:18 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b001754064ac31sm278175pla.280.2022.10.13.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:17 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for ceph
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31054-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     idryomov@gmail.com, xiubli@redhat.com, ceph-devel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3699b2256dc2..8da92ff58b9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4771,7 +4771,7 @@ R:	Jeff Layton <jlayton@kernel.org>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-T:	git git://github.com/ceph/ceph-client.git
+T:	git https://github.com/ceph/ceph-client.git
 F:	include/linux/ceph/
 F:	include/linux/crush/
 F:	net/ceph/
@@ -4783,7 +4783,7 @@ R:	Jeff Layton <jlayton@kernel.org>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-T:	git git://github.com/ceph/ceph-client.git
+T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
 F:	fs/ceph/
 
@@ -17028,7 +17028,7 @@ R:	Dongsheng Yang <dongsheng.yang@easystack.cn>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-T:	git git://github.com/ceph/ceph-client.git
+T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/ABI/testing/sysfs-bus-rbd
 F:	drivers/block/rbd.c
 F:	drivers/block/rbd_types.h
-- 
2.38.0

