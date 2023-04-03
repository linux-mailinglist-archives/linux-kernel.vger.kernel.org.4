Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD636D4351
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjDCLVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDCLVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:21:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6E4224
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:21:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er13so74876344edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680520861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSGbPNvPB+JspcMZAM7knRh0d6tq6zqNpiPGf74AOAk=;
        b=GSRqITYHxQvX4a+vFTAh0mGJOK8s75BHXaBTK7FjohiEENwEwJqpv8RnAt+DKFC4B0
         PqYcfmzIduKRaEguCAIwu782Mn0U2Qmil6Rm2zwZiijMpb9zvKEBbzNeMQcS4KFhw/4B
         v4nDpR9kcOl1pRePVbJm5lXI4c5DcEFfZL/z0R0lxAwKwvDiEUw0ns31TeUfu+gtrVuM
         ZLrSCh/GlaGIt47LB3SCWmzqHaK+cn7Q76Eg8Oi1g09acL1Jd5j5ct71GBwbe3V0hi5P
         PpToOZeh7QkcVUK9z7gxx4fiXZ7k6gcEZ6scoKIwMfcuPibX6J4Cl+OpD/JcGZmj7T1U
         Lr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSGbPNvPB+JspcMZAM7knRh0d6tq6zqNpiPGf74AOAk=;
        b=6ZJaDRIRqua8kX58gKSFVadcAvzJW5F7YirTnxQgGVLK6POUt+8FhKGpAzkKw68iEi
         LfEAzYsaxZMMpFBbkUKdsVvzKfRSKxz4+UjaOZZo6xPOp9hhkpZL1n4YjpjFil3UHJWF
         bjTWohe1GDE+KSSiPOiQHMEbALc7kRrSaAl27CKIv2yWOjbApWVJQFCjFUjljxVVkZI7
         q/pRp+KL6Z0aQz0I8MXPG+f8ichZpEVcNeBbqtQ9AeXEL4dW1eCOlDX0YksvjqpoEhqo
         68ndCohkW32tMnnIsYPRdouJNHiNRshBhIGSMvpALYSG9IoeD6YyQLdP42vaTUQTv7W1
         Vrxw==
X-Gm-Message-State: AAQBX9f9M/8tn80vPhDrg00udeOrJ0J8Cb45ZZTTnSnaLMwWSV7f8a5R
        V0llG/PnXHZhLaMda5bwVMk=
X-Google-Smtp-Source: AKy350Y758ypGm4nbge2JI3sswU+UqJX9IukkLLnBaBtKLA2khnktn53Px0p8a/quttJT+79zP8qbg==
X-Received: by 2002:a17:906:1cc5:b0:931:42d2:a77f with SMTP id i5-20020a1709061cc500b0093142d2a77fmr34597474ejh.15.1680520860851;
        Mon, 03 Apr 2023 04:21:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b009310d4dece9sm4402997ejc.62.2023.04.03.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:21:00 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:20:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev
Cc:     oe-kbuild@lists.linux.dev,
        Heming Zhao via Ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error
 code 'status'
Message-ID: <1e7d7076-ddd6-41b3-b824-673986c35477@kili.mountain>
References: <9e1d6835-34fc-49cd-869e-d99d9b546d17@kili.mountain>
 <4154b815-3be4-53de-1bc0-ca87ecb925a4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154b815-3be4-53de-1bc0-ca87ecb925a4@linux.alibaba.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the kbuild bot is not supposed to send duplicate warnings.  I
don't know why it was sent again...

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7b50567bdcad8925ca1e075feb7171c12015afd1
commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
date:   11 months ago
:::::: branch date: 15 hours ago
       ^^^^^^^^^^^^^^^^^^^^^^^^^
Something happened on Apr 1.

:::::: commit date: 11 months ago
config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230401/202304012244.gX4H4rBO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

regards,
dan carpenter

On Mon, Apr 03, 2023 at 07:07:37PM +0800, Joseph Qi wrote:
> Hi,
> IIRC, we've discussed this before.
> Success return is expected in case of 'hard readonly'.
> So this a false positive report.
> 
> Thanks,
> Joseph
> 
> On 4/3/23 2:14 PM, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   7b50567bdcad8925ca1e075feb7171c12015afd1
> > commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
> > config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230401/202304012244.gX4H4rBO-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Link: https://lore.kernel.org/r/202304012244.gX4H4rBO-lkp@intel.com/
> > 
> > smatch warnings:
> > fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error code 'status'
> > 
> > vim +/status +1809 fs/ocfs2/super.c
> > 
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1803  static int ocfs2_mount_volume(struct super_block *sb)
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1804  {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1805  	int status = 0;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1806  	struct ocfs2_super *osb = OCFS2_SB(sb);
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1807  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1808  	if (ocfs2_is_hard_readonly(osb))
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29 @1809  		goto out;
> > 
> > Hard to tell if this should be an error path or not...  Canonical
> > problem with do nothing gotos.
> > 
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1810  
> > 5500ab4ed3b8f0 Gang He                     2019-03-05  1811  	mutex_init(&osb->obs_trim_fs_mutex);
> > 5500ab4ed3b8f0 Gang He                     2019-03-05  1812  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1813  	status = ocfs2_dlm_init(osb);
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1814  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1815  		mlog_errno(status);
> > a52370b3b182f7 Gang He                     2018-01-31  1816  		if (status == -EBADR && ocfs2_userspace_stack(osb))
> > a52370b3b182f7 Gang He                     2018-01-31  1817  			mlog(ML_ERROR, "couldn't mount because cluster name on"
> > a52370b3b182f7 Gang He                     2018-01-31  1818  			" disk does not match the running cluster name.\n");
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1819  		goto out;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1820  	}
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1821  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1822  	status = ocfs2_super_lock(osb, 1);
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1823  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1824  		mlog_errno(status);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1825  		goto out_dlm;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1826  	}
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1827  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1828  	/* This will load up the node map and add ourselves to it. */
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1829  	status = ocfs2_find_slot(osb);
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1830  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1831  		mlog_errno(status);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1832  		goto out_super_lock;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1833  	}
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1834  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1835  	/* load all node-local system inodes */
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1836  	status = ocfs2_init_local_system_inodes(osb);
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1837  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1838  		mlog_errno(status);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1839  		goto out_super_lock;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1840  	}
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1841  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1842  	status = ocfs2_check_volume(osb);
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1843  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1844  		mlog_errno(status);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1845  		goto out_system_inodes;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1846  	}
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1847  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1848  	status = ocfs2_truncate_log_init(osb);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1849  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1850  		mlog_errno(status);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1851  		goto out_system_inodes;
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1852  	}
> > c271c5c22b0a7c Sunil Mushran               2006-12-05  1853  
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1854  	ocfs2_super_unlock(osb, 1);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1855  	return 0;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1856  
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1857  out_system_inodes:
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1858  	if (osb->local_alloc_state == OCFS2_LA_ENABLED)
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1859  		ocfs2_shutdown_local_alloc(osb);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1860  	ocfs2_release_system_inodes(osb);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1861  	/* before journal shutdown, we should release slot_info */
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1862  	ocfs2_free_slot_info(osb);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1863  	ocfs2_journal_shutdown(osb);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1864  out_super_lock:
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1865  	ocfs2_super_unlock(osb, 1);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1866  out_dlm:
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1867  	ocfs2_dlm_shutdown(osb, 0);
> > 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1868  out:
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1869  	return status;
> > ccd979bdbce9fb Mark Fasheh                 2005-12-15  1870  }
> > 
