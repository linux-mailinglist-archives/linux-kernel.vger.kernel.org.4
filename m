Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45026E8D39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjDTIyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjDTIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:53:31 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D78420E;
        Thu, 20 Apr 2023 01:51:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q2B2Z35wMz9v7Hf;
        Thu, 20 Apr 2023 16:41:10 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAXy0H0_EBknIE7Ag--.1945S2;
        Thu, 20 Apr 2023 09:51:13 +0100 (CET)
Message-ID: <a98ddf946c474a3500bdcd72766c6cb0043278ff.camel@huaweicloud.com>
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mengchi Cheng <mengcc@amazon.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, kamatam@amazon.com,
        yoonjaeh@amazon.com
Date:   Thu, 20 Apr 2023 10:50:57 +0200
In-Reply-To: <c16dd895-f488-241d-0be8-e56e5f0c1adb@schaufler-ca.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
         <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
         <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
         <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
         <72b46d0f-75c7-ac18-4984-2bf1d6dad352@schaufler-ca.com>
         <82ee6ddf66bb34470aa7b591df4d70783fdb2422.camel@huaweicloud.com>
         <91f05dc4-a4b7-b40a-ba1a-0ccc489c84b2@schaufler-ca.com>
         <5c50d98f1e5745c88270ae4ad3de6d9a803db4c6.camel@huaweicloud.com>
         <48c6073f-59b0-f5d1-532e-fe4b912b939d@schaufler-ca.com>
         <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
         <c16dd895-f488-241d-0be8-e56e5f0c1adb@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAXy0H0_EBknIE7Ag--.1945S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr1Utw4DXF45tF13Jr1xuFg_yoW8JrW7Xo
        WfJrsrAw48tr1UJr1UG348JryDAa1rGr4UJrWqqr1UJF17tw1UCr15Gr1UJF4UGryUKFWD
        X348J345Zryjqrn8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4hE9AABsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 14:00 -0700, Casey Schaufler wrote:
> On 4/19/2023 6:46 AM, Roberto Sassu wrote:
> > On Tue, 2023-04-18 at 09:02 -0700, Casey Schaufler wrote:
> > > On 4/18/2023 12:05 AM, Roberto Sassu wrote:
> > > > On Mon, 2023-04-17 at 09:41 -0700, Casey Schaufler wrote:
> > > > > On 4/13/2023 12:11 AM, Roberto Sassu wrote:
> > > > > > On Wed, 2023-04-12 at 13:29 -0700, Casey Schaufler wrote:
> > > > > > > On 4/12/2023 12:22 AM, Roberto Sassu wrote:
> > > > > > > > On Tue, 2023-04-11 at 10:54 -0700, Casey Schaufler wrote:
> > > > > > > > > On 4/11/2023 10:23 AM, Roberto Sassu wrote:
> > > > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > > > 
> > > > > > > > > > Very very quick modification. Not tested.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > > > ---
> > > > > > > > > >  security/smack/smack.h     |  2 +-
> > > > > > > > > >  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
> > > > > > > > > >  2 files changed, 23 insertions(+), 21 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > > > > > > > > > index e2239be7bd6..f00c8498c60 100644
> > > > > > > > > > --- a/security/smack/smack.h
> > > > > > > > > > +++ b/security/smack/smack.h
> > > > > > > > > > @@ -127,7 +127,7 @@ struct task_smack {
> > > > > > > > > >  
> > > > > > > > > >  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
> > > > > > > > > >  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> > > > > > > > > > -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> > > > > > > > > > +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
> > > > > > > > > See below ...
> > > > > > > > > 
> > > > > > > > > >  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
> > > > > > > > > >  
> > > > > > > > > >  /*
> > > > > > > > > > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > > > > > > > > > index 8392983334b..b43820bdbd0 100644
> > > > > > > > > > --- a/security/smack/smack_lsm.c
> > > > > > > > > > +++ b/security/smack/smack_lsm.c
> > > > > > > > > > @@ -54,12 +54,12 @@
> > > > > > > > > >  
> > > > > > > > > >  /*
> > > > > > > > > >   * Smack uses multiple xattrs.
> > > > > > > > > > - * SMACK64 - for access control, SMACK64EXEC - label for the program,
> > > > > > > > > > - * SMACK64MMAP - controls library loading,
> > > > > > > > > > + * SMACK64 - for access control,
> > > > > > > > > >   * SMACK64TRANSMUTE - label initialization,
> > > > > > > > > > - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> > > > > > > > > > + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> > > > > > > > > > + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
> > > > > > > > > >   */
> > > > > > > > > > -#define SMACK_INODE_INIT_XATTRS 4
> > > > > > > > > > +#define SMACK_INODE_INIT_XATTRS 2
> > > > > > > > > >  
> > > > > > > > > >  #ifdef SMACK_IPV6_PORT_LABELING
> > > > > > > > > >  static DEFINE_MUTEX(smack_ipv6_lock);
> > > > > > > > > > @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> > > > > > > > > >  				     const struct qstr *qstr,
> > > > > > > > > >  				     struct xattr *xattrs, int *xattr_count)
> > > > > > > > > >  {
> > > > > > > > > > -	struct inode_smack *issp = smack_inode(inode);
> > > > > > > > > >  	struct smack_known *skp = smk_of_current();
> > > > > > > > > >  	struct smack_known *isp = smk_of_inode(inode);
> > > > > > > > > >  	struct smack_known *dsp = smk_of_inode(dir);
> > > > > > > > > >  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> > > > > > > > > > +	struct xattr *xattr2;
> > > > > > > > > I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
> > > > > > > > > It also looks like it could move to be declared in the if clause.
> > > > > > > > > 
> > > > > > > > > >  	int may;
> > > > > > > > > >  
> > > > > > > > > >  	if (xattr) {
> > > > > > > > > > @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> > > > > > > > > >  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> > > > > > > > > >  		    smk_inode_transmutable(dir)) {
> > > > > > > > > >  			isp = dsp;
> > > > > > > > > > -			issp->smk_flags |= SMK_INODE_CHANGED;
> > > > > > > > > I think you need to keep this. More below.
> > > > > > > > > 
> > > > > > > > > > +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
> > > > > > > > > > +			if (xattr2) {
> > > > > > > > > > +				xattr2->value = kmemdup(TRANS_TRUE,
> > > > > > > > > > +							TRANS_TRUE_SIZE,
> > > > > > > > > > +							GFP_NOFS);
> > > > > > > > > > +				if (xattr2->value == NULL)
> > > > > > > > > > +					return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +				xattr2->value_len = TRANS_TRUE_SIZE;
> > > > > > > > > > +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
> > > > > > > > > > +			}
> > > > > > > > > >  		}
> > > > > > > > > >  
> > > > > > > > > >  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> > > > > > > > > > @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
> > > > > > > > > >  			 * If there is a transmute attribute on the
> > > > > > > > > >  			 * directory mark the inode.
> > > > > > > > > >  			 */
> > > > > > > > > > -			if (isp->smk_flags & SMK_INODE_CHANGED) {
> > > > > > > > > > -				isp->smk_flags &= ~SMK_INODE_CHANGED;
> > > > > > > > > > -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
> > > > > > > > > > -					XATTR_NAME_SMACKTRANSMUTE,
> > > > > > > > > > -					TRANS_TRUE, TRANS_TRUE_SIZE,
> > > > > > > > > > -					0);
> > > > > > > > > > -			} else {
> > > > > > > > > > -				rc = __vfs_getxattr(dp, inode,
> > > > > > > > > > -					XATTR_NAME_SMACKTRANSMUTE, trattr,
> > > > > > > > > > -					TRANS_TRUE_SIZE);
> > > > > > > > > > -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> > > > > > > > > > -						       TRANS_TRUE_SIZE) != 0)
> > > > > > > > > > -					rc = -EINVAL;
> > > > > > > > > > -			}
> > > > > > > > > > +			rc = __vfs_getxattr(dp, inode,
> > > > > > > > > > +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
> > > > > > > > > > +					    TRANS_TRUE_SIZE);
> > > > > > > > > > +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> > > > > > > > > > +					       TRANS_TRUE_SIZE) != 0)
> > > > > > > > > > +				rc = -EINVAL;
> > > > > > > > > Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
> > > > > > > > > It's not going to get set in smack_init_inode_security(). The inode will
> > > > > > > > Isn't that the purpose of the inode_init_security hook?
> > > > > > > No. It initializes the in-memory inode. 
> > > > > > I hope I'm not mistaken here...
> > > > > > 
> > > > > > I make a small example. Filesystems call
> > > > > > security_inode_init_security(). Ext4 does:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n54
> > > > > > 
> > > > > > security_inode_init_security() allocates new_xattrs. Each LSM fills
> > > > > > new_xattrs. At the end of the loop, if there is at least one xattr
> > > > > > filled, the initxattrs() callback passed by the caller of
> > > > > > security_inode_init_security() is called.
> > > > > > 
> > > > > > The ext4 initxattrs() callback is:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n35
> > > > > > 
> > > > > > which scans the xattr array and, for each xattr,
> > > > > > calls ext4_xattr_set_handle().
> > > > > > 
> > > > > > Maybe I'm overlooking it, but ext4_xattr_set_handle() is setting xattrs
> > > > > > on the disk. Am I wrong?
> > > > > Yes, you're wrong. I tried your change, and the SMACK64_TRANSMUTE isn't
> > > > > set on the sub-directory when it's created. The __vfs_setxattr() call really
> > > > > is necessary. 
> > > > Could you please also check if there is any change with this fix:
> > > > 
> > > > Replace:
> > > > 
> > > > 	xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
> > > > 
> > > > with:
> > > > 
> > > > 	xattr2->name = XATTR_SMACK_TRANSMUTE;
> > > > 
> > > > Thanks
> > > Unless I'm missing something really obvious there's no way that any
> > > of the evm/ima changes would obviate the need for the __vfs_setxattr() call.
> > > It's real easy to verify correct behavior, see the attached script.
> > > (you'll want to change the "notroot" value to a user on your system)
> > I got some errors during xattr removal, so not sure if my patch was
> > working properly or not (it happened also without it, didn't
> > investigate more).
> 
> The script is demonstrating that those xattrs don't exist when they
> shouldn't, si all is good there.
> 
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
> 
> OK, I see that. Looks like the original implementation was poorly
> thought out/tested.
> 
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
> 
> That would explain the observed behavior.
> 
> > So, as a quick test, I kept this patch with the change to xattr2->name, 
> > and skipped the label override in smack_dentry_create_files_as(). It
> > worked, I get the same result as without overlayfs. Wondering if the
> > process label override is necessary in other cases.
> 
> It's possible. It's been a long time since I've looked at this.
> I'm tempted to take a change to make overlayfs work upstream and
> then worry about the ima changes. There seems to be a lot more
> going on with the ima changes than is obvious from what's in the
> Smack code.

We could also set only SMACK64 in smack_inode_init_security(), and move
SMACKTRANSMUTE64 later, when we figure out how to fix the case of
overlayfs.

IMA and EVM would work in both cases.

Roberto

> > Roberto
> > 
> > > > Roberto
> > > > 
> > > > > > Thanks
> > > > > > 
> > > > > > Roberto
> > > > > > 
> > > > > > > > After all LSMs provide one or multiple xattrs, xattrs are going to be
> > > > > > > > written to the disk with the initxattr() callback of filesystems.
> > > > > > > > 
> > > > > > > > There is a small mistake above (XATTR_SMACK_TRANSMUTE instead
> > > > > > > > of XATTR_NAME_SMACKTRANSMUTE, as we are providing just the suffix).
> > > > > > > but I'm pretty sure the __vfs_setxattr() call is necessary to get
> > > > > > > the attribute written out. With your change the in-memory inode will
> > > > > > > get the attribute, but if you reboot it won't be on the directory.
> > > > > > > 
> > > > > > > > 95 Passed, 0 Failed, 100% Success rate
> > > > > > > > 
> > > > > > > > There was a test failing in dir-transmute.sh, before I fixed the xattr
> > > > > > > > name.
> > > > > > > > 
> > > > > > > > Thanks
> > > > > > > > 
> > > > > > > > Roberto
> > > > > > > > 
> > > > > > > > > know it's transmuting, but it won't get to disk without the __vfs_setxattr()
> > > > > > > > > here in smack_d_instantiate(). Now, it's been a long time since that code
> > > > > > > > > was written, so I could be wrong, but I'm pretty sure about that.
> > > > > > > > > 
> > > > > > > > > I think that you should be fine with the changes in smack_init_inode_security(),
> > > > > > > > > and leaving smack_d_instantiate() untouched. 
> > > > > > > > > 
> > > > > > > > > >  			if (rc >= 0)
> > > > > > > > > >  				transflag = SMK_INODE_TRANSMUTE;
> > > > > > > > > >  		}

