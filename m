Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DF6A2D44
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBZDZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZDZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:25:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD59113D5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677381950; x=1708917950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tiUWi8OQSt6X2sj/g0kn2A/Oic6Z8oIetTb6HPn1WRQ=;
  b=M6LEw5sjBAAV9k3xGVvolOaZjusju0td5pdxJK7KtP0guqYhb1oF+3i+
   Xv/9eYGF0u0ejCmD5/09wWNWHRiG4M41/LJNvkymGPcK2fFHx1UmB84OG
   s8WaLpZJ7UMwjd+LricZc6eo/IGUHqdk8M+ufo/8CgM5/DomUMVWOYe5j
   SjIA3x9mvXHydxWj1h7toHE4embQF0wE89BOYyfyfadGAbyOM65opRNOw
   oKCKBF7nCLpS+9uj+7oETJROVx5m5k2hQ/VcYB2LtrPZd/62Xo0+2X7zj
   MXeEkn3QGeuEVqsKHwNn0tgOIkTMfUvehsZK8TpwwBHBeCw/yiDmDPEtz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="361231972"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="361231972"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 19:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="705717696"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="705717696"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2023 19:25:47 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pW7fX-0003XH-0w;
        Sun, 26 Feb 2023 03:25:47 +0000
Date:   Sun, 26 Feb 2023 11:24:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Subject: fs/netfs/iterator.c:139 netfs_extract_user_to_sg() warn: unsigned
 'npages' is never less than zero.
Message-ID: <202302261115.P3TQi1ZO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1ec35eadc3b448c91a6b763371a7073444e95f9d
commit: 0185846975339a5c348373aa450a977f5242366b netfs: Add a function to extract an iterator into a scatterlist
date:   5 days ago
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230226/202302261115.P3TQi1ZO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302261115.P3TQi1ZO-lkp@intel.com/

smatch warnings:
fs/netfs/iterator.c:139 netfs_extract_user_to_sg() warn: unsigned 'npages' is never less than zero.
fs/netfs/iterator.c:139 netfs_extract_user_to_sg() warn: unsigned 'npages' is never less than zero.

vim +/npages +139 fs/netfs/iterator.c

   106	
   107	/*
   108	 * Extract and pin a list of up to sg_max pages from UBUF- or IOVEC-class
   109	 * iterators, and add them to the scatterlist.
   110	 */
   111	static ssize_t netfs_extract_user_to_sg(struct iov_iter *iter,
   112						ssize_t maxsize,
   113						struct sg_table *sgtable,
   114						unsigned int sg_max,
   115						iov_iter_extraction_t extraction_flags)
   116	{
   117		struct scatterlist *sg = sgtable->sgl + sgtable->nents;
   118		struct page **pages;
   119		unsigned int npages;
   120		ssize_t ret = 0, res;
   121		size_t len, off;
   122	
   123		/* We decant the page list into the tail of the scatterlist */
   124		pages = (void *)sgtable->sgl + array_size(sg_max, sizeof(struct scatterlist));
   125		pages -= sg_max;
   126	
   127		do {
   128			res = iov_iter_extract_pages(iter, &pages, maxsize, sg_max,
   129						     extraction_flags, &off);
   130			if (res < 0)
   131				goto failed;
   132	
   133			len = res;
   134			maxsize -= len;
   135			ret += len;
   136			npages = DIV_ROUND_UP(off + len, PAGE_SIZE);
   137			sg_max -= npages;
   138	
 > 139			for (; npages < 0; npages--) {
   140				struct page *page = *pages;
   141				size_t seg = min_t(size_t, PAGE_SIZE - off, len);
   142	
   143				*pages++ = NULL;
   144				sg_set_page(sg, page, len, off);
   145				sgtable->nents++;
   146				sg++;
   147				len -= seg;
   148				off = 0;
   149			}
   150		} while (maxsize > 0 && sg_max > 0);
   151	
   152		return ret;
   153	
   154	failed:
   155		while (sgtable->nents > sgtable->orig_nents)
   156			put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
   157		return res;
   158	}
   159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
