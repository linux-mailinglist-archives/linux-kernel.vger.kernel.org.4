Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759946E8D32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjDTIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjDTIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:50:54 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F34C18;
        Thu, 20 Apr 2023 01:49:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q2B0T5nZ7z9v7Gw;
        Thu, 20 Apr 2023 16:39:21 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAXxTtK_EBkfX87Ag--.1933S2;
        Thu, 20 Apr 2023 09:48:24 +0100 (CET)
Message-ID: <2f90828cc8e9e1ab369790a3da687790c4348b0f.camel@huaweicloud.com>
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mengchi Cheng <mengcc@amazon.com>
Cc:     bpf@vger.kernel.org, casey@schaufler-ca.com,
        dmitry.kasatkin@gmail.com, eparis@parisplace.org,
        jmorris@namei.org, kamatam@amazon.com, keescook@chromium.org,
        kpsingh@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        nicolas.bouchinet@clip-os.org, paul@paul-moore.com,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        selinux@vger.kernel.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, yoonjaeh@amazon.com,
        zohar@linux.ibm.com
Date:   Thu, 20 Apr 2023 10:48:06 +0200
In-Reply-To: <20230419192516.757220-1-mengcc@amazon.com>
References: <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
         <20230419192516.757220-1-mengcc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAXxTtK_EBkfX87Ag--.1933S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw18ur43Cw13Kr48AF4ktFb_yoW7Aw4xpF
        Z8Ga43Krs5Jw17CayvvF47AF4F9rWkGa15XFnFgry7AF13Kr1Igr98Xr12kryxJrsY93Wq
        vF4jvr9xZr4Uu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4hE8wAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 12:25 -0700, Mengchi Cheng wrote:
> > I got some errors during xattr removal, so not sure if my patch was
> > working properly or not (it happened also without it, didn't
> > investigate more).
> > 
> > However, I saw another discussion related to transmute:
> > 
> > https://lore.kernel.org/linux-security-module/20230419002338.566487-1-mengcc@amazon.com/
> > 
> > I add the people in CC.
> > 
> > The steps described were so easy to understand and executed, I tried
> > without and with overlayfs.
> > 
> > Without:
> > 
> > # echo "_ system rwxatl" > /sys/fs/smackfs/load2
> > # mkdir /data
> > # chsmack -a "system" /data
> > # chsmack -t /data
> > # mkdir -p /data/dir1/dir2
> > # chsmack /data/dir1
> > /data/dir1 access="system" transmute="TRUE"
> > # chsmack /data/dir1/dir2
> > /data/dir1/dir2 access="system" transmute="TRUE"
> > 
> > It seems to work, right?
> > 
> > With overlay fs it didn't work, same result as the one Mengchi
> > reported. Since Mengchi's solution was to set SMK_INODE_CHANGED, and I
> > want to get rid of it, I thought to investigate more.
> > 
> > Looking at smack_dentry_create_files_as(), I see that the label of the
> > process is overwritten with the label of the transmuting directory.
> > 
> > That causes smack_inode_init_security() to lookup the transmuting rule
> > on the overridden credential, and not on the original one.
> > 
> > In the example above, it means that, when overlayfs is creating the new
> > inode, the label of the process is system, not _. So no transmute
> > permission, and also the xattr will not be added, as observed by
> > Mengchi.
> > 
> > Hopefully I undertood the code, so in this particular case we would not
> > need to override the label of the process in smack_dentry_create_files_
> > as().
> > 
> > If you see smack_inode_init_security():
> > 
> > 	struct smack_known *skp = smk_of_current();
> > 	struct smack_known *isp = smk_of_inode(inode);
> > 	struct smack_known *dsp = smk_of_inode(dir);
> > 
> > [...]
> > 
> > 		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> > 		    smk_inode_transmutable(dir)) {
> > 			isp = dsp;
> > [...]
> > 
> > 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> > 
> > This code is telling, if there is a transmute rule, and the directory
> > is transmuting, set the label of the new inode to the label of the
> > directory. That should be already the result that we wanted to obtain.
> > 
> > The current code should have been doing it by overriding the label of
> > the process in smack_dentry_create_files_as() with the label of the
> > parent directory, and letting the inode being created with the
> > overridden label of the process. The transmute xattr is not set due to
> > the problem described above.
> > 
> > So, as a quick test, I kept this patch with the change to xattr2->name, 
> > and skipped the label override in smack_dentry_create_files_as(). It
> > worked, I get the same result as without overlayfs. Wondering if the
> > process label override is necessary in other cases.
> 
> If I understand correctly, removing the if block below is what you suggested.

Yes, more or less is what I did.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cfcbb748da25..a867288e9de9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4769,8 +4769,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>                  * providing access is transmuting use the containing
>                  * directory label instead of the process label.
>                  */
> -               if (may > 0 && (may & MAY_TRANSMUTE))
> -                       ntsp->smk_task = isp->smk_inode;
> +//             if (may > 0 && (may & MAY_TRANSMUTE))
> +//                     ntsp->smk_task = isp->smk_inode;
>         }
>         return 0;
>  }
> 
> This way will have issue in the following situation on the vanila kernel.
> data in the lowerdir has "_" label before overlay and dir1 is already
> created in the lowerdir.
> # chsmack /data
> /data access="_"
> # chsmack /data/dir1
> /data/dir1 access="system" transmute="TRUE"
> Apply overlay on data directory and set the smack rule in the same way.
> data has the same smack label.
> # chsmack /data
> /data access="system" transmute="TRUE"

I'm using an older kernel, but I get _ instead of system.

> After that, remove dir1 and mkdir dir1 again. dir1 did not get the correct
> label.
> # rm -r /data/dir1
> # mkdir -p /data/dir1
> # chsmack /data/dir1
> /data/dir1 access="_"

Unfortunately, it cannot work:

Thread 3 hit Breakpoint 1, smack_inode_init_security (...) at security/smack/smack_lsm.c:959
959	{
(gdb) p dir->i_ino
$12 = 9169116
(gdb) p dsp
$13 = (struct smack_known *) 0xffffffff831fc0a0 <smack_known_floor>


ls -i /home/root/data_work/
9169116 work

So, transmuting is decided on the working directory.

If I do:

# chsmack -a system -t /home/root/data_work/work/
# mkdir /data/dir1
# chsmack /data/dir1
/data/dir1 access="system" transmute="TRUE"

I obtain the expected result. However, this problem is due to how overlayfs works:

static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
				    struct ovl_cattr *cattr)
{

[...]

	newdentry = ovl_create_temp(ofs, workdir, cattr);
	err = PTR_ERR(newdentry);
	if (IS_ERR(newdentry))
		goto out_dput;


The good news seems to be that, once you set the label to the correct
directory, transmuting works with the changes I proposed.

Roberto

> Since I am not very familiar your change. Could you help check with your
> patch will this issue also happen? 
> 
> 
> Best,
> Mengchi
> 
> >  
> > Roberto

