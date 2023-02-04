Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899168A920
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjBDJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 04:06:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFED29E2B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 01:06:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z3so5308531pfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tf2haQZAvqOYFO7mP/ikX0sl8c5419t6vefPZS0+RVU=;
        b=NHVbFkh09qxWx82o7msi/BePAgBvjhlyXaUT4f9fLbOSURdduhXYaw66gdytfx6M4W
         nIfKZzFekFZfrb176+N9VOgnjIb/2PHY6xDa+9AHydoK0aZUgHW57bkQ8QzvEjSZViIM
         9fNCD+zQ0rQU3kTIFgedPU1zC+rGFkC9T9xNBvT9A9ODPl9tLTmC7RngFy0P9Ce4Pkz4
         Wx7mlq/OnnncW8q5mQ/bqldQcsRa5agczgoqbEtY4wisHpkKXRrtxt6FYSli/84LDuZW
         u4cv2OebTHvIVvxeciWWVArNWqmyBXVk1xDCyD3jhpHbnWykWPsQDCFKSHIywm2ObLgx
         Yxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf2haQZAvqOYFO7mP/ikX0sl8c5419t6vefPZS0+RVU=;
        b=rLFEfGCJU0KTG4cVR0z0j6qY56U40s+sJ11QUPX1ITKUS9Va4g3DIB78JUPQmus7mH
         P3F41/4/DXAidMr1FOlH5ZAdHfBCwsl8mMMhOLqQfkT7QKUT6ssp2jp1N/hmm8Tl76RG
         MWvsajVB54zmuVAXUzomq1mFpuI6El7JV1ovHqDrTnJ88mkor/zHoXxsziOxTy+BkK+j
         1H3wPUmczjpmB36aPavRbfR/GsQ3DFetdHtmx0zWLic7iEWF4ZyC/eGP+Vh43ZbnE2Jz
         QHLh6d0f/GlwLTG0aA4fzRSkgne82MONGrkhOKccA6nEBH5ZlvkpufmXB/v5qYBYdrzi
         aoqg==
X-Gm-Message-State: AO0yUKWZZkaGqJYwjig7Jib2197BP8uerfE+Tb4nkgrcx03Lt1zPoo2F
        EbanWp/FboevqRuHOYJh8zxBjz2lJqDMwDcC
X-Google-Smtp-Source: AK7set+09PaTOq64k/lcVz6HAay5lSe5zNfHWTjIbZ/2ea7k8+S641z5gw4r1w97boNsUbcqs0j1ww==
X-Received: by 2002:aa7:9911:0:b0:592:5dd5:7655 with SMTP id z17-20020aa79911000000b005925dd57655mr11728250pff.28.1675501609788;
        Sat, 04 Feb 2023 01:06:49 -0800 (PST)
Received: from qxy-XPS-13-9360 ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id m8-20020a62f208000000b005891c98e1aasm3204430pfh.119.2023.02.04.01.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 01:06:49 -0800 (PST)
Date:   Sat, 4 Feb 2023 17:06:43 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Ping Xiong <xiongping1@xiaomi.com>,
        Xiaoyu Qi <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2 v3] f2fs: add sysfs nodes to set last_age_weight
Message-ID: <Y94gI9acVXF+LHPb@qxy-XPS-13-9360>
References: <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
 <20230202082028.9013-1-qixiaoyu1@xiaomi.com>
 <20230202082028.9013-2-qixiaoyu1@xiaomi.com>
 <3589331b-a3ec-87e1-790d-387439672ea5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3589331b-a3ec-87e1-790d-387439672ea5@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:31:58PM +0800, Chao Yu wrote:
> On 2023/2/2 16:20, qixiaoyu1 wrote:
> > Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> > Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs |  5 +++++
> >   fs/f2fs/extent_cache.c                  | 15 +++++++++------
> >   fs/f2fs/f2fs.h                          |  1 +
> >   fs/f2fs/sysfs.c                         | 11 +++++++++++
> >   4 files changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 9e3756625a81..11af7dbb6bc9 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -669,3 +669,8 @@ Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
> >   Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
> >   		the data blocks as warm. By default it was initialized as 2621440 blocks
> >   		(equals to 10GB).
> > +
> > +What:           /sys/fs/f2fs/<disk>/last_age_weight
> > +Date:           January 2023
> > +Contact:        "Ping Xiong" <xiongping1@xiaomi.com>
> > +Description:    When DATA SEPARATION is on, it controls the weight of last data block age.
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index d9f12f404beb..ce99882ba81c 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -871,19 +871,21 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
> >   }
> >   #endif
> > -static unsigned long long __calculate_block_age(unsigned long long new,
> > +static unsigned long long __calculate_block_age(struct f2fs_sb_info *sbi,
> > +						unsigned long long new,
> >   						unsigned long long old)
> >   {
> >   	unsigned int rem_old, rem_new;
> >   	unsigned long long res;
> > +	unsigned int weight = sbi->last_age_weight;
> > -	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
> > -		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
> > +	res = div_u64_rem(new, 100, &rem_new) * (100 - weight)
> > +		+ div_u64_rem(old, 100, &rem_old) * weight;
> >   	if (rem_new)
> > -		res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
> > +		res += rem_new * (100 - weight) / 100;
> >   	if (rem_old)
> > -		res += rem_old * LAST_AGE_WEIGHT / 100;
> > +		res += rem_old * weight / 100;
> >   	return res;
> >   }
> > @@ -917,7 +919,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
> >   			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
> >   		if (tei.age)
> > -			ei->age = __calculate_block_age(cur_age, tei.age);
> > +			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
> >   		else
> >   			ei->age = cur_age;
> >   		ei->last_blocks = cur_blocks;
> > @@ -1233,6 +1235,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
> >   	atomic64_set(&sbi->allocated_data_blocks, 0);
> >   	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
> >   	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
> > +	sbi->last_age_weight = LAST_AGE_WEIGHT;
> >   }
> >   int __init f2fs_create_extent_cache(void)
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e8953c3dc81a..c3609cbc28c7 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
> >   	/* The threshold used for hot and warm data seperation*/
> >   	unsigned int hot_data_age_threshold;
> >   	unsigned int warm_data_age_threshold;
> > +	unsigned int last_age_weight;
> >   	/* basic filesystem units */
> >   	unsigned int log_sectors_per_block;	/* log2 sectors per block */
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 83a366f3ee80..a70cf674d8e7 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -686,6 +686,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >   		return count;
> >   	}
> > +	if (!strcmp(a->attr.name, "last_age_weight")) {
> > +		if (t <= 0 || t >= 100)
> 
> Could 0 or 100 be a valid value?
> 
> Thanks,
> 

0 and 100 can both be a valid value:

We may use 0 to set the new block age without refering to the previous
age. 100 doesn't make so much sence since the age will only be set
to a non-zero value on the first updated (after create, truncate,
etc.), but maybe we can do some tricks with a value of 100.

Let me update the patch.

> > +			return -EINVAL;
> > +		if (t == *ui)
> > +			return count;
> > +		*ui = (unsigned int)t;
> > +		return count;
> > +	}
> > +
> >   	*ui = (unsigned int)t;
> >   	return count;
> > @@ -944,6 +953,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block)
> >   /* For block age extent cache */
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, hot_data_age_threshold, hot_data_age_threshold);
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, warm_data_age_threshold, warm_data_age_threshold);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, last_age_weight, last_age_weight);
> >   #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> >   static struct attribute *f2fs_attrs[] = {
> > @@ -1042,6 +1052,7 @@ static struct attribute *f2fs_attrs[] = {
> >   	ATTR_LIST(revoked_atomic_block),
> >   	ATTR_LIST(hot_data_age_threshold),
> >   	ATTR_LIST(warm_data_age_threshold),
> > +	ATTR_LIST(last_age_weight),
> >   	NULL,
> >   };
> >   ATTRIBUTE_GROUPS(f2fs);
