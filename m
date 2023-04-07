Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B426DB453
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDGThu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDGThs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:37:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2059CD;
        Fri,  7 Apr 2023 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680896266; x=1712432266;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=weBJwIjqEna6+z89gcYkPRC8lEijMlTfTNZaTTEeeNk=;
  b=ULexbXs8ina2XkzNhvlstejSAcRnKPfA0vHMqpnDZiymrDl2e2PUWdAC
   Rgjz//UoI073PV8IppJWdjVrSA7Qw3xbR2ZOfsUYlor4zxXAp+/DCbkCC
   7nUyq0CJ3X2ntDYDplZRAW8HhRbOZ5lmEgB3B2SmHuqUnuZoMv/x1nL9J
   8qdQDh96aKXeL9sMAqhp59CuiczvMFFQvRK9NhDw07uDbdW4vcz6QCMD/
   TLZQUQTJGkoUf+J3aaxveS8ZHlvB3yWu6aPM/TXGHQ6kqC1F/5nYnfeIh
   xRB5bNk0VV5JFL5aE0JIbbqeTesc7SOLiZ1qxJowt6Uf4eWgRkjJosyTr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="429341155"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="429341155"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 12:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="756819847"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="756819847"
Received: from bjcleere-mobl2.amr.corp.intel.com ([10.212.83.122])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 12:37:45 -0700
Message-ID: <37694343f8b89dc0469d4a1718dad8f5f8c765bd.camel@linux.intel.com>
Subject: [PATCH] crypto: ixp4xx - Remove COMPILE_TEST from Kconfig
 dependencies
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     clabbe@baylibre.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Date:   Fri, 07 Apr 2023 14:37:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

COMPILE_TEST was added during the move to drivers/crypto/intel/ but
shouldn't have been as it triggers a build bug when not compiled by
the target compiler.  So remove it to match the original.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304061846.G6cpPXiQ-lkp@intel=
.com/
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/ixp4xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/ixp4xx/Kconfig b/drivers/crypto/intel/ixp=
4xx/Kconfig
index af3cc5688328..4cfb1e37f45b 100644
--- a/drivers/crypto/intel/ixp4xx/Kconfig
+++ b/drivers/crypto/intel/ixp4xx/Kconfig
@@ -1,6 +1,6 @@
 config CRYPTO_DEV_IXP4XX
 	tristate "Driver for IXP4xx crypto hardware acceleration"
-	depends on (ARCH_IXP4XX || COMPILE_TEST) && IXP4XX_QMGR && IXP4XX_NPE
+	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
 	select CRYPTO_AES
 	select CRYPTO_DES
 	select CRYPTO_ECB
--=20
2.34.1


