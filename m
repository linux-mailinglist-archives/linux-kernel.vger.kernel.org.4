Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0A361D99E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKELPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKELPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:15:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036613D2C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 04:15:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so10132271wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tP7byI0+Iy8thvBM9RxOZ1IAYRCUM1f3pZvYHntjIiU=;
        b=DOEVQebwcJYZ/5W4LsmNd5BxPP3oBR0tUoHQD+yVm7KtNQLdI33Kxpiyv6k1NPct3d
         TurVtwwBhEkn2mHX6TPae3EuT1hEMKdeiBcf88WBXTnIC577NYFCHOTGpLfIzv9UjqHz
         lKPbX/Lc8OMHGYc0Yp5Rwehx3aljErPfr9t21Mkn/V7wHwfa57zgGFAe+iye9YXky3Rd
         VHCv64i4uEGPsxNIn8Zzvp6VI/dDqGZZdUPeEWDFdDq3T3bIcPmavAhkFXfoqZgtw/a9
         3T4CVHiCkUbrSqtnin2DcXzehauiCY95qQP4m63W2/D+F7YuhW3Ae8RVQvkUW8dz6EG+
         EKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tP7byI0+Iy8thvBM9RxOZ1IAYRCUM1f3pZvYHntjIiU=;
        b=C0qiu7WLnJoG8G/N3q8Mnip88CgL2LztcGfSOQbBzlMmsmQLe3ln5ZMQDBfSzjDzhy
         Vg9L9WI6qGu7Tomy4k6j8T8EkdOVaCLj5cdqYWHLZSp+BEFjYGIUTEQUQtqRyZyBuuKe
         jF5VmOS5iIoTrIENbl24egd4zHrQwGo8oclreFUD2r+hBMBfI7xwJ/v7a+wQ0pBe1Ui8
         3NnoLNJsWtxZIS5jGLYAQWuaTIXNf1QYDCbAx35qR80qq0/PGG4+2234cdDUfzBq/saP
         30T0Fihqyd6Qo5qXn38N6uPklZ7WEDdKqREEZTJYsj2/agzx4DRwkPcLpRD740v5Wu4S
         MJcg==
X-Gm-Message-State: ACrzQf3m4QrtzQuGL6c6/x1RV6Y5Mkv2nvD66R8gtbHY+WxDdGpX7UgE
        Vnrmh9cAsy5Qh+wsdSHNP4U=
X-Google-Smtp-Source: AMsMyM6WU7D2DZTLSdga05zuSpJl+2j2RYGDDpUBqWXo2H5qPh665HWr76c5oJV4AiBpWLaaf+cC9A==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr25119107wrr.361.1667646945769;
        Sat, 05 Nov 2022 04:15:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v18-20020adfe292000000b00228dbf15072sm1846126wri.62.2022.11.05.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 04:15:45 -0700 (PDT)
Date:   Sat, 5 Nov 2022 14:15:40 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Heming Zhao via Ocfs2-devel <ocfs2-devel@oss.oracle.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error code
 'status'
Message-ID: <202211050722.8YGvtPaR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   10d916c86ecafeccaed89175ebf9b832dddde380
commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
config: alpha-randconfig-m041-20221030
compiler: alpha-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error code 'status'

vim +/status +1809 fs/ocfs2/super.c

ccd979bdbce9fba Mark Fasheh                 2005-12-15  1802  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1803  static int ocfs2_mount_volume(struct super_block *sb)
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1804  {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1805  	int status = 0;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1806  	struct ocfs2_super *osb = OCFS2_SB(sb);
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1807  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1808  	if (ocfs2_is_hard_readonly(osb))
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29 @1809  		goto out;

Unclear if this is an error path or a success path.  Honestly, I would
have thought the checker is correct that it looks like a failure path.

ccd979bdbce9fba Mark Fasheh                 2005-12-15  1810  
5500ab4ed3b8f07 Gang He                     2019-03-05  1811  	mutex_init(&osb->obs_trim_fs_mutex);
5500ab4ed3b8f07 Gang He                     2019-03-05  1812  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1813  	status = ocfs2_dlm_init(osb);
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1814  	if (status < 0) {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1815  		mlog_errno(status);
a52370b3b182f79 Gang He                     2018-01-31  1816  		if (status == -EBADR && ocfs2_userspace_stack(osb))
a52370b3b182f79 Gang He                     2018-01-31  1817  			mlog(ML_ERROR, "couldn't mount because cluster name on"
a52370b3b182f79 Gang He                     2018-01-31  1818  			" disk does not match the running cluster name.\n");
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1819  		goto out;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1820  	}
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1821  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1822  	status = ocfs2_super_lock(osb, 1);
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1823  	if (status < 0) {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1824  		mlog_errno(status);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1825  		goto out_dlm;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1826  	}
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1827  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1828  	/* This will load up the node map and add ourselves to it. */
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1829  	status = ocfs2_find_slot(osb);
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1830  	if (status < 0) {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1831  		mlog_errno(status);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1832  		goto out_super_lock;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1833  	}
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1834  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1835  	/* load all node-local system inodes */
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1836  	status = ocfs2_init_local_system_inodes(osb);
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1837  	if (status < 0) {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1838  		mlog_errno(status);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1839  		goto out_super_lock;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1840  	}
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1841  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1842  	status = ocfs2_check_volume(osb);
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1843  	if (status < 0) {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1844  		mlog_errno(status);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1845  		goto out_system_inodes;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1846  	}
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1847  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1848  	status = ocfs2_truncate_log_init(osb);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1849  	if (status < 0) {
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1850  		mlog_errno(status);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1851  		goto out_system_inodes;
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1852  	}
c271c5c22b0a7ca Sunil Mushran               2006-12-05  1853  
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1854  	ocfs2_super_unlock(osb, 1);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1855  	return 0;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1856  
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1857  out_system_inodes:
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1858  	if (osb->local_alloc_state == OCFS2_LA_ENABLED)
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1859  		ocfs2_shutdown_local_alloc(osb);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1860  	ocfs2_release_system_inodes(osb);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1861  	/* before journal shutdown, we should release slot_info */
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1862  	ocfs2_free_slot_info(osb);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1863  	ocfs2_journal_shutdown(osb);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1864  out_super_lock:
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1865  	ocfs2_super_unlock(osb, 1);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1866  out_dlm:
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1867  	ocfs2_dlm_shutdown(osb, 0);
0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29  1868  out:
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1869  	return status;
ccd979bdbce9fba Mark Fasheh                 2005-12-15  1870  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

