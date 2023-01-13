Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2C66930C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbjAMJee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbjAMJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:28:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBD948CCD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:26:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja17so14835142wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBILbsDemyg2wqqLqcvsyl90/r+YyiYMgxhIHYXDi+k=;
        b=fDnrLkiFVnWaOqJFi04+e25RZGTzXZNK0Z4tY2UAkZd4pGEcQefkqsc47NF4wdpWYw
         Zee7uHq+v1f5I6Y62wrG3xqc3r1Z96WGNOgC4jFtI4ROY/UFElDrTRWJCx4SdfRcCaWv
         DvgpZMLVR+djCsm7n6wLlQETAlAkYL9xPXRPfixguiGWvoxUqX5gmxBaLibVczdUTPA7
         T17ncV7HaNXzu7WGi6VJf5XvTzT+Axs2+4LsVnDEcPrWk9wFPUaq0xgHtLYKMaJi9/o2
         MNh3jhS1Mg5AxALKIuM2mhIJ7dBDir2o2jJlA+h8FJNmsQ6TKMafLULzsT5k05dJuWmJ
         dXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBILbsDemyg2wqqLqcvsyl90/r+YyiYMgxhIHYXDi+k=;
        b=430Lz2vMRLsVjZTFRD7S2hO+YmN2R03GwTe02FlVUwHFBWddnkPRZLYrsBOG0R87aP
         RohNfoIZLozCZmXdIU816p0RTkf4CcgIpVKkfRnQVtpRzIDO9NN53qEGcvuD84MfEwmT
         iojEQHczJdV3X+K/jG1vXatY0W/XyvJBupr2qRbR9MQg1hd/jOVOfAEWOG6YqFXMpEsV
         bTuT7CViweG7MioPXl+Z6jbYGNnNSGDE0MfS3RfkSUC55kYUfUZUaL2wbLUHY2Aopdmi
         RXD3k9olIlK3F7Zb0u8kgvsRgedbqiwQCG11R5v0xlzgWODUfXk+Fjv9J+sfhotxM7w+
         jqlA==
X-Gm-Message-State: AFqh2kpPZuS2JW1ILgM0HWH9Xy/MjyCNAqiAnf6cdUxljqedrW5SQcyA
        qL07aDrCEeYKzusbMt3CENo=
X-Google-Smtp-Source: AMrXdXsGQPd5Vn8PcSQDQSMtm3zkObx3Shco6JYdBVaDiBPsQ8SiSmQKPkhuiBWzKQM7B2/YFy8P0g==
X-Received: by 2002:a05:600c:3b93:b0:3d2:1bf6:5796 with SMTP id n19-20020a05600c3b9300b003d21bf65796mr58748727wms.35.1673601989558;
        Fri, 13 Jan 2023 01:26:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b003a6125562e1sm26363824wmq.46.2023.01.13.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:26:28 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:26:26 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Yangtao Li <frank.li@vivo.com>,
        jaegeuk@kernel.org, chao@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] f2fs: use iostat_lat_type directly as a parameter in the
 iostat_update_and_unbind_ctx()
Message-ID: <202301131759.qq5Cubxn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105042240.24738-1-frank.li@vivo.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/f2fs-use-iostat_lat_type-directly-as-a-parameter-in-the-iostat_update_and_unbind_ctx/20230105-122414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230105042240.24738-1-frank.li%40vivo.com
patch subject: [PATCH] f2fs: use iostat_lat_type directly as a parameter in the iostat_update_and_unbind_ctx()
config: alpha-randconfig-m041-20230110
compiler: alpha-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
fs/f2fs/iostat.c:228 __update_iostat_latency() error: buffer overflow 'io_lat->sum_lat[type]' 3 <= 3
fs/f2fs/iostat.c:229 __update_iostat_latency() error: buffer overflow 'io_lat->bio_cnt[type]' 3 <= 3
fs/f2fs/iostat.c:230 __update_iostat_latency() error: buffer overflow 'io_lat->peak_lat[type]' 3 <= 3

Old smatch warnings:
fs/f2fs/iostat.c:231 __update_iostat_latency() error: buffer overflow 'io_lat->peak_lat[type]' 3 <= 3

vim +228 fs/f2fs/iostat.c

a4b6817625e71d Daeho Jeong 2021-08-20  211  static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
2804a18e00dbd6 Yangtao Li  2023-01-05  212  				enum iostat_lat_type type)
a4b6817625e71d Daeho Jeong 2021-08-20  213  {
a4b6817625e71d Daeho Jeong 2021-08-20  214  	unsigned long ts_diff;
2804a18e00dbd6 Yangtao Li  2023-01-05  215  	unsigned int page_type = iostat_ctx->type;
a4b6817625e71d Daeho Jeong 2021-08-20  216  	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
a4b6817625e71d Daeho Jeong 2021-08-20  217  	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
61803e984307c7 Daeho Jeong 2022-06-10  218  	unsigned long flags;
a4b6817625e71d Daeho Jeong 2021-08-20  219  
a4b6817625e71d Daeho Jeong 2021-08-20  220  	if (!sbi->iostat_enable)
a4b6817625e71d Daeho Jeong 2021-08-20  221  		return;
a4b6817625e71d Daeho Jeong 2021-08-20  222  
a4b6817625e71d Daeho Jeong 2021-08-20  223  	ts_diff = jiffies - iostat_ctx->submit_ts;
2804a18e00dbd6 Yangtao Li  2023-01-05  224  	if (page_type >= META_FLUSH)
                                                                 ^^^^^^^^^^

2804a18e00dbd6 Yangtao Li  2023-01-05  225  		page_type = META;
a4b6817625e71d Daeho Jeong 2021-08-20  226  
61803e984307c7 Daeho Jeong 2022-06-10  227  	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
2804a18e00dbd6 Yangtao Li  2023-01-05 @228  	io_lat->sum_lat[type][page_type] += ts_diff;
                                                                      ^^^^^^^^^
Mixup between META_FLUSH and NR_PAGE_TYPE leads to memory corruption.

2804a18e00dbd6 Yangtao Li  2023-01-05 @229  	io_lat->bio_cnt[type][page_type]++;
2804a18e00dbd6 Yangtao Li  2023-01-05 @230  	if (ts_diff > io_lat->peak_lat[type][page_type])
2804a18e00dbd6 Yangtao Li  2023-01-05  231  		io_lat->peak_lat[type][page_type] = ts_diff;
61803e984307c7 Daeho Jeong 2022-06-10  232  	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
a4b6817625e71d Daeho Jeong 2021-08-20  233  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

