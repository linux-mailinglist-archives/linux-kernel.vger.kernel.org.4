Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E3706D36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjEQPuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEQPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:50:30 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E789B4;
        Wed, 17 May 2023 08:50:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19a16c8d70cso331732fac.2;
        Wed, 17 May 2023 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684338629; x=1686930629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp91NGnKmeqxxoPve0tp68TOqbttZMnuUPLj0Q3dWTU=;
        b=rJXSO/0X4+mzvSMqlu3yV9L9H0UXivozzdyBZqYg6JjDmXtv07VuicUfnm60os3S7I
         t2fJxmqanTJEi6FdOSh9wmD27QKUaD+g7lM/rKPO5BWY2hUa2XuCAeECxkU9rurBM3pT
         FdiFkbId85/P926KA73YTmYerNuyu+XhjNiW7j4M3VwfdSdL/Euuj5xGvSk0ZQui0xo9
         mzfOlr8bDmGA6AzNPkswcWiIdEWjYybuYeaq8EO/Rt2cFcAdz9Jvbp083Ix/ECVZzWiU
         9fG6IxLRSVW5K1YL7TTVgb/lUM59KFeKt87F25l10P9HZB4xERHu19evEDVzKMNIEZbQ
         eL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338629; x=1686930629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp91NGnKmeqxxoPve0tp68TOqbttZMnuUPLj0Q3dWTU=;
        b=HBYvfnhU/w2OUM1hRQw7RmbVdDo0XiJeveJ+y7NH9pumwBonGojuE2dO628YrrnUAh
         94CPiKYmBofgAFyO2sFBdtpkocecAzzqEtpCpblntDE+tLW+bwBruRVft0kdbnlVpVUE
         VqyUZKOkOjk9MleZKsVupLOCdQxuD49UAyRLBhIuvo6XRgEcP3NPJbEnT5jOT4oi3W+K
         eGNIRH/k6FbccRLSyTQtsH9KVvQ4eKn2GVlvDw8cBG0ia3o8SHIUDau9RCWtY7rxSGWC
         UzvWRMFaf8QMLj0ZL+GvRLMlCyZIqhGJ70EX4l23U9NlTNWroRY6ZEwPxAUnAvYnb3I8
         vdKw==
X-Gm-Message-State: AC+VfDwMy6UPpTAh4mhpsUZxskSTBSL6wvNsw5yuxpX1rgOVahuMN4HR
        OkjsGv7sFNeEF+WJ77EOLhCGndv3XiQ=
X-Google-Smtp-Source: ACHHUZ7K8Eo+Dtt/BSqfYqy7/jYDy3fdJ0SpVW60FvcQe1BxCxYQAw6G9CVl2/hxhQg++VdOOs33UA==
X-Received: by 2002:a05:6871:40f:b0:187:c066:a395 with SMTP id d15-20020a056871040f00b00187c066a395mr19239901oag.0.1684338628696;
        Wed, 17 May 2023 08:50:28 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:3754:4771:3b5:e909])
        by smtp.gmail.com with ESMTPSA id j5-20020a056870a48500b0018b12e3a392sm14214468oal.42.2023.05.17.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:50:28 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v14 00/13] hp-bioscfg driver
Date:   Wed, 17 May 2023 10:50:13 -0500
Message-Id: <20230517155026.28535-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next

History

Version 14
	Only patches marked [update] changed between version 14 and 13
	Sorted commit patches alphabetically
	Rename ordered-attributes to order-list-attributes

	Patches
	 Documentation
	 biosattr-interface 		[update]
	 bioscfg
	 bioscfg-h
	 enum-attributes 		[update]
	 int-attributes
	 order-list-attributes
	 passwdattr-interface
	 spmobj-attributes
	 string-attributes
	 surestart-attributes 
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS


Version 13
	Only patches marked [update] changed between version 12 and 13
	Sorted commit patches alphabetically
	Rename ordered-attributes to order-list-attributes

	Patches
	 Documentation 			[update]
	 biosattr-interface 		[update]
	 bioscfg 			[update]
	 bioscfg-h 			[update]
	 enum-attributes 		[update]
	 int-attributes 		[update]
	 order-list-attributes 		[update]
	 passwdattr-interface 		[update]
	 spmobj-attributes 		[update]
	 string-attributes 		[update]
	 surestart-attributes 		[update] 
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS

Version 12
	Only patches marked [update] changed between version 11 and 12

	Patches
	 Documentation 			[update]
	 biosattr-interface 		[update]
	 bioscfg 			[update]
	 int-attributes 		[update]
	 ordered-attributes 		[update]
	 passwdobj-attributes 	[deleted]
	 string-attributes 		[update]
	 bioscfg-h 			[update]
	 enum-attributes 		[update]
	 passwdattr-interface 		[update]
	 spmobj-attributes 		[update]
	 surestart-attributes 		[update] 
	 Makefile ../hp/Makefile ../hp/Kconfig [update]
	 MAINTAINERS


Version 11
	Only patches marked [update] changed between version 10 and 11

	Patches
	 Documentation
	 biosattr-interface 		[update]
	 bioscfg
	 int-attributes
	 ordered-attributes
	 passwdobj-attributes 		[update]
	 string-attributes
	 bioscfg-h
	 enum-attributes
	 passwdattr-interface
	 spmobj-attributes 		[update]
	 surestart-attributes 		[update]
	 Makefile ../hp/Makefile ../hp/Kconfig
	 MAINTAINERS

Version 10
	Break down changes to single files per patch
	Removed SPM/statusbin support
	Patches
	 Documentation
	 biosattr-interface
	 bioscfg
	 int-attributes
	 ordered-attributes
	 passwdobj-attributes
	 string-attributes
	 bioscfg-h
	 enum-attributes
	 passwdattr-interface
	 spmobj-attributes
	 surestart-attributes
	 Makefile ../hp/Makefile ../hp/Kconfig
	 MAINTAINERS

Version 9
	Includes only sysfs-class-firmware-attributes documentation

Version 8
	Includes only sysfs-class-firmware-attributes documentation

Version 7
	Includes only sysfs-class-firmware-attributes documentation

Version 6
	Breaks down the changes into 4 patches
	SureAdmin-attributes was removed

Version 5
	Remove version 4 patch 1
	Address review changes proposed in Version 4
	Reorganize all patches number and file order




Jorge Lopez (13):
  hp-bioscfg: Documentation
  hp-bioscfg: bioscfg-h
  hp-bioscfg: bioscfg
  hp-bioscfg: biosattr-interface
  hp-bioscfg: enum-attributes
  hp-bioscfg: int-attributes
  hp-bioscfg: order-list-attributes
  hp-bioscfg: passwdobj-attributes
  hp-bioscfg: spmobj-attributes
  hp-bioscfg: string-attributes
  hp-bioscfg: surestart-attributes
  hp-bioscfg: Makefile
  hp-bioscfg: MAINTAINERS

 .../testing/sysfs-class-firmware-attributes   | 102 +-
 MAINTAINERS                                   |   6 +
 drivers/platform/x86/hp/Kconfig               |  16 +
 drivers/platform/x86/hp/Makefile              |   1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile   |  11 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 317 ++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 988 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 486 +++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 +++++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        | 440 ++++++++
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 454 ++++++++
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 540 ++++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 389 +++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 404 +++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 132 +++
 15 files changed, 4749 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

-- 
2.34.1

