Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0EF622D10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKIOAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKIOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:00:21 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DF25CA;
        Wed,  9 Nov 2022 06:00:19 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id y25so5509866ual.2;
        Wed, 09 Nov 2022 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1q1ey5fhREYDGshcJw06uEVvGTSWFkREglO2CjwYh4Q=;
        b=bsnppBgcoFlVGnBGlUxdK3695nkMWz8c+4GDLASQK8SrC2ZmrzTP51fte+OvxZwYO7
         EoMw263dI8250LFyyKmj111VRkcx3dJzhuzAdtJpMdQV6Q02+XFL1+n1cBJWbBZQW2G5
         6j9xL1PI2BNIqTsZEY87H/KFXKA9xeGNHZ8a2jjpuY8x3DXVUpDOg0H7K3O/tqti//4q
         9vTCjzvh7z1a1Xv3OQjiT0aHmoSxqx4ESF0tIkyyZMfLRu+K7OzX2ywH1xgJbRmKZZT4
         fFFQBaci48Dgh4wbaSMn3m9YxwrwGTihG7RagWZYaPZN/f/07ZJ/sT1AODmG3Zjho01K
         oipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q1ey5fhREYDGshcJw06uEVvGTSWFkREglO2CjwYh4Q=;
        b=e+HlXtj39GgeyeZTRdT6J843KUzP/1W1mhAHZFznNy4LlUFHPWQ3zF0m8DaQcOkaWT
         IIAUFnd6BekBdhoYFp2mWzdLYgquS2ez/kmhZKKdnnyZqASIzI3ZakBgW/ZVp8xJNqj/
         vSq1fA1C8C7TrXHvRY1FOGeGsaecB3wF9L1qTTI6V5suWSGXr1L0sMv901GXAr6TsUzv
         iIGl0zQC6WRa9R+E6qgRP9dGwmIH2bfLWbUWSlocdHDeAiRdhPLUGd1T51I7TpOGYOii
         ZbAQw6CEz5vDF/rvwbANIFzGeVMGNCXV9Z3eRkEmWdgOAywLpgj0gtN3g2r2m8TnwB+W
         gnvg==
X-Gm-Message-State: ACrzQf3NQv6RLDaii24DtzYlq7PPK4165rvqs2VqmNwz2RYofLeQu+Ws
        C+ZFpk3KeOP6rF9Dk9uykvUWxoE9zLRet2RQQ9y66SfU93g=
X-Google-Smtp-Source: AMsMyM4dQ8rfyvE/3wpEkML4nG5hKMgothmggrJv4+wlGABiX7sLHekK7APX7TKi2JiULN1gefiY4FdXTjvZPH4F0dA=
X-Received: by 2002:ab0:74ce:0:b0:411:dae:ee7d with SMTP id
 f14-20020ab074ce000000b004110daeee7dmr18808156uaq.9.1668002418392; Wed, 09
 Nov 2022 06:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com> <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
 <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com> <CAKFNMomK=C4JY7ftNQs7Zs3dr0m=e_k-vVXTfmR-mpumuGUtDw@mail.gmail.com>
 <CAKFNMokX6wudO+WJbdc4-1gTXLXn59=dvm0CLGeXAFiA+kJXdg@mail.gmail.com>
 <CAKFNMomUYhQOHnKJohN_84ROhaD4TgPD=bsV0SPG992uG-8fCQ@mail.gmail.com> <3157f29e-5f82-92d3-4ecf-c4fa2b9b13c2@huawei.com>
In-Reply-To: <3157f29e-5f82-92d3-4ecf-c4fa2b9b13c2@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 9 Nov 2022 23:00:01 +0900
Message-ID: <CAKFNMomJvOGQZa3ApOYaNFAvUPAus2vztvbUw_6PkX3MNMCW4g@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 12:26 PM Liu Shixin wrote:
> On 2022/11/9 1:50, Ryusuke Konishi wrote:
> > Hi Liu Shixin,
> >
> > I'm sorry for my repeated emails.
> >
> > On Wed, Nov 9, 2022 at 12:13 AM Ryusuke Konishi wrote:
> >>> I think the most likely cause is metadata corruption.  If so, we
> >>> should fix it by adding a proper sanity check, yes.
> >>> However, there is still the possibility that the error retry logic
> >>> after detecting errors has a flaw. (I believe at least this is not a
> >>> problem with normal paths.)
> >>> The sufile state inconsistency above is hypothetical for now.
> >>> Either way, I'd like to make sure what's actually happening (and where
> >>> the anomaly is coming from) so we can decide how to fix it.
> >> I noticed that this syzbot report has a disk image "mount_0.gz", so I
> >> tried to mount it read-only.
> >> The result was as follows:
> >>
> >> $ sudo mount -t nilfs2 -r ./mount_0 /mnt/test
> >> $ lssu
> >>               SEGNUM        DATE     TIME STAT     NBLOCKS
> >>                    0  26760730-10-29 19:40:00  -de   527958016
> >>                    1  26760730-11-01 20:29:04  -de   527958016
> >>                    2  1176433641-11-01 02:01:52  -de  2983038235
> >>                    3  -1158249729-11-01 04:57:19  a--       25375
> >>                    4  1970-01-02 21:24:32  a--           0
> >>                    5  -1415215929-01-02 00:19:15  --e  1631451365
> >>                    6  841067190-01-02 13:02:59  -d-  3101461260
> >>                    7  1495233207-01-02 01:31:11  -de  1697748441
> >>                    8  1875753393-01-02 21:54:14  -de   337757600
> >>                    9  648878284-01-02 21:06:08  ---  2133388152
> >>                   10  2122778986-01-02 17:49:43  --e   874605800
> >>                   11  55846197-01-02 09:50:53  -de  4262365368
> >>                   12  1872396026-01-02 06:45:18  ---  1051768258
> >>                   13  820920473-01-02 19:28:35  --e  2932336675
> >>                   14  2128306755-01-02 10:17:45  ---  3568501216
> >>                   15  1457063063-01-02 01:24:17  --e  2330511560
> >>                   16  586864775-01-02 16:08:15  ---   355283425
> >>                   17  -824870041-01-02 22:47:26  -d-  4177999057
> >>                   18  1562176264-01-02 08:06:45  ---  1312597355
> >>                   19  -392925420-01-02 17:08:27  -d-  3811075948
> >>                   20  1927575458-01-02 21:26:51  -de  1384562525
> >>                   21  2139923505-01-02 08:16:04  -d-    41861305
> >>
> >> Here,  we can see that neither segment #3 (= ns_segnum) nor #4 (=
> >> ns_nextnum) has the dirty flag
> >> ("d" in STAT).   So, as expected, this seems to be the root cause of
> >> the duplicate assignments and oops.
> >> The proper correction would be, therefore, to check and reject (or
> >> fix) this anomaly while outputting an error message
> >> (or warning if fix it at the same time).
> >> It should be inserted in mount time logic because the segments that
> >> nilfs2 itself allocates are always marked dirty with
> >> nilfs_sufile_alloc().
> > I will change my opinion.
> >
> > Considering the possibility of sufile corruption at runtime, it seems
> > that the sanity check should be done on every nilfs_sufile_alloc()
> > call.
> >
> > I now think nilfs_sufile_alloc() should call nilfs_error() and return
> > -EIO if the number of a newly found vacant segment matches
> > nilfs->ns_segnum or nilfs->ns_nextnum.

> Before we add the first segbuf into sci->sc_segbufs in nilfs_segctor_begin_construction(),
> there is no possibility existing duplicate segnum. And the subsequent process should
> not be affected by sufile corruption. So I think it's enough to only check for case alloc==0.
> I don't find any other possible wrong scenarios.

I think the problem is not yet fixed.
With your patch, I still think there are scenarios that cause
duplicate segment assignments:
(1)  If the segment at nilfs->ns_segnum is in a clean state due to
sufile data corruption, and
if sci->sc_write_logs is empty and nilfs->ns_segnum == nilfs->nextnum
to start writing a segment from the beginning, then
nilfs_sufile_alloc() is called in nilfs_segctor_begin_construction()
and nextnum can be
equal to nilfs->ns_segnum.
This nextnum is stored in segbuf->sb_nextnum, and if segbuf is spliced
with nilfs_segctor_extend_segments(), the segbuf->sb_nextnum will be
used for sb_segnum of the added segbuf, and the list corruption of
sb_segsum_buffers can happen between these two segbufs.

(2)  If the segment at nilfs->ns_segnum is in a clean state due to
sufile data corruption, and
if sci->sc_write_logs is not empty and segbuf->sb_rest_blocks <
NILFS_PSEG_MIN_BLOCKS,
then nilfs_sufile_alloc() is called in
nilfs_segctor_begin_construction(), and the retrieved nextnum is set
to
sb_nextnum of the appended segbuf there, and this sb_nextnum can be
equal to nilfs->ns_segnum.
Then, if the segbufs are spliced with nilfs_segctor_extend_segments(),
the last segbuf->sb_nextnum will be used for sb_segnum of the appended
segbuf.  Therefore, list corruption of sb_segsum_buffers can happen.

(3) If the segment at nilfs->ns_segnum is in a clean state due to
sufile data corruption, and then the segbuf is spliced with
nilfs_segctor_extend_segments(), nilfs_sufile_alloc() is called, and
the retrieved "nextnextnum" is set to sb_nextnum of the appended
segbuf, but this can be equal to nilfs->ns_segnum.
If one more segbuf is appended to the segbufs in
nilfs_segctor_extend_segments(), list corruption of
sb_segsum_buffers can happen due to the segnum duplication.

And please call nilfs_error() after detecting the metadata anomaly to
output this critical situation and  degrade the filesystem
appropriately (read-only for example).  This metadata corruption is a
critical situation and writes will continually fail.  File system
operations should not continue as if nothing happened.

I would like to ask you to reconsider how to fix it, but will also
comment on the current patch below.

>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 7be632c15f91..7b91c790b798 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -1326,7 +1326,13 @@ static int nilfs_segctor_begin_construction(struct nilfs_sc_info *sci,
>                 err = nilfs_sufile_alloc(nilfs->ns_sufile, &nextnum);
>                 if (err)
>                         goto failed;
> +       } else {
> +               /* Check the next segment has alreadly been allocated */

Here is a typo:  "alreadly" -> "already"

> +               err = nilfs_sufile_test_allocated(nilfs->ns_sufile, nextnum);
> +               if (err)
> +                       goto failed;
>         }
> +
>         nilfs_segbuf_set_next_segnum(segbuf, nextnum, nilfs);
>
>         BUG_ON(!list_empty(&sci->sc_segbufs));
> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> index 853a8212114f..8dff12c56891 100644
> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -399,6 +399,36 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
>         return ret;
>  }
>
> +int nilfs_sufile_test_allocated(struct inode *sufile, __u64 *segnump)

The second argument should be "__u64 segnum".  The type is different
from the above caller.

> +{
> +       struct buffer_head *su_bh;
> +       struct nilfs_segment_usage *su;
> +       void *kaddr;
> +       int ret;
> +
> +       down_write(&NILFS_MDT(sufile)->mi_sem);

Please use down_read()/up_read() since the operation of this function
is not mutative.
See nilfs_sufile_get_stat() for an example.

> +
> +       ret = nilfs_sufile_get_segment_usage_block(sufile, segnump, 1,

"segnump" should be "segnum".  If you use a pointer, this must be "*segnump".
Either way this is wrong.

> +                                                  &su_bh);
> +       if (ret < 0)
> +               goto out_sem;
> +
> +       kaddr = kmap_atomic(su_bh->b_page);
> +       su = nilfs_sufile_block_get_segment_usage(
> +               sufile, segnump, su_bh, kaddr);

Ditto.   "segnump" here should be "segnum".

> +
> +       if (nilfs_segment_usage_clean(su))
> +               ret = -EIO;
> +
> +       kunmap_atomic(kaddr);
> +
> +       brelse(su_bh);
> +
> +out_sem:
> +       up_write(&NILFS_MDT(sufile)->mi_sem);
> +       return ret;
> +}
> +
>  void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
>                                  struct buffer_head *header_bh,
>                                  struct buffer_head *su_bh)
> diff --git a/fs/nilfs2/sufile.h b/fs/nilfs2/sufile.h
> index 8e8a1a5a0402..02b61ca6f318 100644
> --- a/fs/nilfs2/sufile.h
> +++ b/fs/nilfs2/sufile.h
> @@ -24,6 +24,7 @@ unsigned long nilfs_sufile_get_ncleansegs(struct inode *sufile);
>
>  int nilfs_sufile_set_alloc_range(struct inode *sufile, __u64 start, __u64 end);
>  int nilfs_sufile_alloc(struct inode *, __u64 *);

> +int nilfs_sufile_test_allocated(struct inode *, __u64 *);

This should be:

int nilfs_sufile_test_allocated(struct inode *sufile, __u64 segnum);

Please include the variable name in the argument for newly added or
modified declarations.

Regards,
Ryusuke Konishi


>  int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum);
>  int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
>                                    unsigned long nblocks, time64_t modtime);
>
