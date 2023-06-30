Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFC74407F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjF3Q67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3Q6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94D3C24
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688144320; x=1719680320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sUvFn7BQUsTfjsY4UYm8QejPHUhKXjjAIB5/x9BcE9s=;
  b=PpUCCfCHUEqhxsvhUPQR3QwJHj/RFmb0kjyuo7G3JoTDlIA2mW01uSTe
   9jKMSVxMUlS5JtrGkiXTh8BiUXLvJkmcs4ybsPQKXi/mJpiMG5WIOSidU
   il5GX0sz0x4FoSmFG0Q2AYIzqzIGqn2EtsWm1wM0ou1burdhZOqE7bhEW
   qoa2mm5NIyTmbL9TvJIkD15nbtRxJimwUhH9lie2KlN5+x5tFviY4+MUj
   4nNpc9M9/916Oc1mthzYCvzCvTYVVvMh1aiFURokQWkjnBJ2hG8MiY6Gk
   l2qtsk3SEfB1mMpl+UdLauYBoHe58uA0hEp5pBte6dgjTQc12FFaYcF4H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="361292404"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="361292404"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 09:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="747480980"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="747480980"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 09:58:36 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFHS7-000FAt-1c;
        Fri, 30 Jun 2023 16:58:35 +0000
Date:   Sat, 1 Jul 2023 00:58:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Simo Sorce <simo@redhat.com>
Subject: net/sunrpc/auth_gss/gss_krb5_mech.c:325 gss_krb5_lookup_enctype()
 warn: unsigned 'i' is never less than zero.
Message-ID: <202307010010.uGvpzuSy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e55e5df193d247a38a5e1ac65a5316a0adcc22fa
commit: ddd8c1f975ee7c2fc60ea836540b5b10f97ac919 SUNRPC: Export get_gss_krb5_enctype()
date:   4 months ago
config: x86_64-randconfig-m001-20230629 (https://download.01.org/0day-ci/archive/20230701/202307010010.uGvpzuSy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307010010.uGvpzuSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307010010.uGvpzuSy-lkp@intel.com/

New smatch warnings:
net/sunrpc/auth_gss/gss_krb5_mech.c:325 gss_krb5_lookup_enctype() warn: unsigned 'i' is never less than zero.
net/sunrpc/auth_gss/gss_krb5_mech.c:325 gss_krb5_lookup_enctype() warn: unsigned 'i' is never less than zero.

Old smatch warnings:
net/sunrpc/auth_gss/gss_krb5_mech.c:301 gss_krb5_prepare_enctype_priority_list() warn: unsigned 'i' is never less than zero.
net/sunrpc/auth_gss/gss_krb5_mech.c:301 gss_krb5_prepare_enctype_priority_list() warn: unsigned 'i' is never less than zero.
net/sunrpc/auth_gss/gss_krb5_mech.c:325 gss_krb5_lookup_enctype() warn: we never enter this loop

vim +/i +325 net/sunrpc/auth_gss/gss_krb5_mech.c

   312	
   313	/**
   314	 * gss_krb5_lookup_enctype - Retrieve profile information for a given enctype
   315	 * @etype: ENCTYPE value
   316	 *
   317	 * Returns a pointer to a gss_krb5_enctype structure, or NULL if no
   318	 * matching etype is found.
   319	 */
   320	VISIBLE_IF_KUNIT
   321	const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype)
   322	{
   323		size_t i;
   324	
 > 325		for (i = 0; i < ARRAY_SIZE(supported_gss_krb5_enctypes); i++)
   326			if (supported_gss_krb5_enctypes[i].etype == etype)
   327				return &supported_gss_krb5_enctypes[i];
   328		return NULL;
   329	}
   330	EXPORT_SYMBOL_IF_KUNIT(gss_krb5_lookup_enctype);
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
