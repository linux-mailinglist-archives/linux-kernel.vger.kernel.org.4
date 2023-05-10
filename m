Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D396FDAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEJJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjEJJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:39:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD130C7;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so48253095ad.3;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18EQqAro/ad1eftntjuXlU/cZiRt+RKEhODutQksVwo=;
        b=DfigwJZ47/bLQRCdvJigqpDLCygUkaZN0OoF7QunAKjpfeOCNVoGWnJxQsgaUEY49P
         /sv0qtlgs7i5MTFMgXiuOXRxGekp2O+SyBTphRr2ab90LAIw98OCxz7BpdHLzLBiqN7T
         /+8EXgV3mAPaHUSwdtgJxv2WrrXlGPwf82VG2UwgxOylrqrPUk3Y9Tv1COjDSHposDKJ
         V6OcPyRJkN5gdO5PRi0SyttrM8VfP0tcwCN7X08TOPjopCjrEKD1RkWoyda4sb4NQ3AY
         jz8Y5owjqM2DMzTtHXW3o7wL7XLaN9c0unNgasfM3wyd5m9zmVPQRbqo8O9UMtfTLXe0
         RYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18EQqAro/ad1eftntjuXlU/cZiRt+RKEhODutQksVwo=;
        b=bE6Bc07WFYTtHhUgClYltDym6Vqr87sKPyCKNA9+LmuBmSrjF8BrfBCgWluNRqRrDB
         ubGHwEUVoQlUtKtt5+NjNI256Qqyp97/TCn6pGl93IPNILWt/NGyWg/yHUeaPr7IYMCS
         ia6K+NtzTx/SGAZ5ap3SPHflR27WjI9jWUTw2WgMhrm4kix8m0M9s8opaZGCpPDgibol
         8XJTdu9CvzeRk9qUksM8A2tUIRewzXEcKQh2lSx7O+jXNdBFI8Qxck4LRrJ6TQ9ACHdC
         ++s3LWV9nQYbc9F0lGl0jukX8MhVsj8r+AhwlOk12X4h1T+xOCZ/HuhagwRsKYn0JYri
         ve+w==
X-Gm-Message-State: AC+VfDzOxMDKzQlwzZizQPXmtwgmIEXMeaJizyM15iuOjwSO/wV0jfOK
        NrLTIbBQudHSxnJLGegbkQA=
X-Google-Smtp-Source: ACHHUZ4+uwuvU7/tAnLudmCDhFqpNl7vDBQiZNvzmWs9AIz082YvGqdnUQuDNvkkkkMEj9ffJUAfWA==
X-Received: by 2002:a17:902:da90:b0:1a2:2091:eeae with SMTP id j16-20020a170902da9000b001a22091eeaemr20945498plx.40.1683711588919;
        Wed, 10 May 2023 02:39:48 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001aaf5dcd762sm3272082plr.214.2023.05.10.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:39:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 57A811068F8; Wed, 10 May 2023 16:39:43 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 0/3] dc395x stale reference cleanup
Date:   Wed, 10 May 2023 16:39:30 +0700
Message-Id: <20230510093933.19985-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3714; i=bagasdotme@gmail.com; h=from:subject; bh=TWTNCLmcRakutTicPxbt0ytozPj8yzxWmym8TVOTjjc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCnRaSH1cW8L+Zi9Ft3r+z1ja8aGrw/ZNxet/3lgyTKxY N6aL/qHOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRpw2MDDvFhO2Sb5UtEE3f lO5loVl0aeHeFcUvGHT5sl2X/FEUaGP4nyhXYXn0tVPapYtvD/82/hwryaJx94Ga5/77b04fn5f 1iBEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small stale reference cleanup series for DC395x driver. The shortlog
below should be self-explanatory.

This series is based on fixes branch of scsi tree.

Changes since v1 [1]:
  * Do not explicitly mention linux-scsi list in MAINTAINERS
  * Keep the attribution to the 2.4 driver but reword it to remove mention
    to 2.5/2.6 version
  * Use web.archive.org snapshot of 2.4 driver link.

Bagas Sanjaya (3):
  MAINTAINERS: Drop DC395x list and site
  Documentation: scsi: dc395x: Replace non-functional twibble.org list
  Documentation: scsi: dc395x: Reword original driver attribution

 Documentation/scsi/dc395x.rst | 11 ++++-------
 MAINTAINERS                   |  3 ---
 2 files changed, 4 insertions(+), 10 deletions(-)

Range-diff against v1 [1]:
1:  aaec6b1333457f ! 1:  8db1313161119c MAINTAINERS: Drop DC395x list and site
    @@ Commit message
         Emails to DC395x list bounce (550 error) and visiting the site returns
         404 page.
     
    -    Drop both twibble.org links, replacing the list with linux-scsi list.
    +    Drop both twibble.org links. The driver should now be covered by
    +    linux-scsi list.
     
         Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
     
    @@ MAINTAINERS: DC395x SCSI driver
      M:	Ali Akcaagac <aliakc@web.de>
      M:	Jamie Lenehan <lenehan@twibble.org>
     -L:	dc395x@twibble.org
    -+L:	linux-scsi@vger.kernel.org
      S:	Maintained
     -W:	http://twibble.org/dist/dc395x/
     -W:	http://lists.twibble.org/mailman/listinfo/dc395x/
2:  af1800664dcc46 ! 2:  70a3006779bcb6 Documentation: scsi: dc395x: Replace non-functional twibble.org list
    @@ Metadata
      ## Commit message ##
         Documentation: scsi: dc395x: Replace non-functional twibble.org list
     
    -    Now that the mailing list has been replaced in MAINTAINERS with
    -    linux-scsi list, do the same in the documentation.
    +    Sync mailing list address in the documentation to follow MAINTAINERS.
     
         Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
     
3:  ed579e038a7984 ! 3:  379a2d4ceed777 Documentation: scsi: dc395x: Remove reference to 2.4 driver
    @@ Metadata
     Author: Bagas Sanjaya <bagasdotme@gmail.com>
     
      ## Commit message ##
    -    Documentation: scsi: dc395x: Remove reference to 2.4 driver
    +    Documentation: scsi: dc395x: Reword original driver attribution
     
    -    The 2.4 driver link returns 404. As no one runs 2.4 kernel anymore,
    -    remove the stale reference.
    +    The Linux kernel isn't in 2.6.x anymore, but rather the major version
    +    has advanced much (currently 6.x). Reword the attribution.
     
    +    Also, replace 404'ed 2.4 driver link with web.archive.org snapshot [1].
    +
    +    Link: https://web.archive.org/web/20140129181343/http://www.garloff.de/kurt/linux/dc395/ [1]
         Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
     
      ## Documentation/scsi/dc395x.rst ##
    @@ Documentation/scsi/dc395x.rst: be safe to use. Testing with hard disks has not b
     -driver (which this driver started from) at
     -http://www.garloff.de/kurt/linux/dc395/
     -
    ++This driver is evolved from `the original 2.4 driver
    ++<https://web.archive.org/web/20140129181343/http://www.garloff.de/kurt/linux/dc395/>`_.
      Problems, questions and patches should be submitted to the `Linux SCSI
      mailing list <linux-scsi@vger.kernel.org>`_.
      
[1]: https://lore.kernel.org/linux-doc/20230505082704.16228-1-bagasdotme@gmail.com/

base-commit: 1a7edd041f2d252f251523ba3f2eaead076a8f8d
-- 
An old man doll... just what I always wanted! - Clara

