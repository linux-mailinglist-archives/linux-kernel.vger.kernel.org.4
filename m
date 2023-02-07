Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D415C68D171
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjBGI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBGI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:26:31 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4B4EF8D;
        Tue,  7 Feb 2023 00:26:30 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t1so8232398ybd.4;
        Tue, 07 Feb 2023 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnR0rvO8n7tyVdnpylOr297xpsBR1VkzYY2ahlh+35M=;
        b=GMGrbOAFET8/XeIh/XhWMs5iL9+c0lxMeDFYaKRSGkGi39tSyqoEh3FuChL2ne7VcL
         kYRy0P9poOvJVzpHXuYdrT+E1zTWVXRpNkmOvySOGZwn40JG0IBFIoLAmRJzlJgR2lbc
         oUS2ygHyxJJ2o7KBn5AK4Y5PpwBgq93iGBkQLR/Bgqmz2BEffXlrSDLjzZFznmHwh41H
         Xd327DQpiwoZ7AFSaczIZ2gI3cMj0qCadMxfOFhyep2VdHDrgLiNNyVm64Vid0yldk0S
         HZZ6zrNOLDGsaWxUge9EBwNMvd6JbrKpq5v9amGDB1qRFXkzd/xJXJ3ktwTaSsHo8Zpv
         bDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnR0rvO8n7tyVdnpylOr297xpsBR1VkzYY2ahlh+35M=;
        b=DhJIvQMp+Yz79Ka1tKYYXyAi3gLqhfr+9rVScPnLs2JCa8DbPYuM+G4ABd4Jete0TX
         mUGvrlPJiYOgjK1arKm8dorkqnNq3EgBkSfZ9Cn7KspG4uN6UImVHY9ucg3t7goUd8AP
         SjmP8r9SuFQcYlxDiT09A/mukFnzpk5zajuqzxf2sIJcjB5XvyRbBwhYjQlY2t8X0DkW
         5ICfVynN7HodrqqwdFpuAU+FQdGvZuCLMXN4TcgyXsdphDFkAhYbTCvPqF3Ku4wc4wT8
         cXFk2WmVVM2slfVnXsWyY1UQ+eN5XIm1eii2Ki0nmiicRjV7I04ymz3Cx18alB1154hU
         CRFg==
X-Gm-Message-State: AO0yUKU4S9UB9xe8Fdk48DhqbpwQhg++YKLSUIGwAgA5d0bU05SilRUe
        46McyDA4KDndQsvV5aK5Ah3XRsGStXKYhApgdH0L3dQ1meo=
X-Google-Smtp-Source: AK7set+ir/62DPXKv/j+xTFzYrFmUNP42qtldAPuUE11K0H8CHgloF334k6sO+GhE4DeNajGzGWyqTWAspsv9JCRTQ4=
X-Received: by 2002:a25:43:0:b0:864:9aee:7b7e with SMTP id 64-20020a250043000000b008649aee7b7emr273838yba.244.1675758389812;
 Tue, 07 Feb 2023 00:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20230203072819.3408-1-zhongjiezhu1@gmail.com> <Y90egBL6HSoEdz2P@rowland.harvard.edu>
 <CAJnoMhNYDXjfttiio+P7k6W1fDU3N=jbjmZe+ZRVON=bqm0yvw@mail.gmail.com>
 <Y+EaIRHZfLs49w9L@rowland.harvard.edu> <CAJnoMhO_AWU0ABoJN_EQZ9BpnpgxSeuv26PqOJ1feLh_CdJHsg@mail.gmail.com>
 <Y+HObaGgp3fwrL/7@rowland.harvard.edu>
In-Reply-To: <Y+HObaGgp3fwrL/7@rowland.harvard.edu>
From:   Zhongjie Zhu <zhongjiezhu1@gmail.com>
Date:   Tue, 7 Feb 2023 16:23:44 +0800
Message-ID: <CAJnoMhMDcvsB18PnFxRrnJA+VGWCBmJUjFGjWZToYXB36+Xmtw@mail.gmail.com>
Subject: Re: [PATCH] USB: core: hub: fix usb_hub worker blocking
 drain_all_pages() worker issue
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 12:07 PM Alan Stern <stern@rowland.harvard.edu> wrot=
e:
>
> On Tue, Feb 07, 2023 at 10:02:51AM +0800, Zhongjie Zhu wrote:
> > On Mon, Feb 6, 2023 at 11:17 PM Alan Stern <stern@rowland.harvard.edu> =
wrote:
> > >
> > > On Mon, Feb 06, 2023 at 11:33:15AM +0800, =E6=9C=B1=E5=BF=A0=E6=9D=B0=
 wrote:
> > > > Yes, this is a very special case.
> > > >
> > > > It will happen only when disconnecting the mass storage if there ar=
e
> > > > too many files in the storage, and the scanning operation is runnin=
g,
> > > > and the file system is not unmounted.
> > > > It looks like this issue should be fixed in the usb mass storage
> > > > driver, but I don't find an appropriate place.
> > >
> > > That's not surprising, because usb-storage doesn't know anything abou=
t
> > > what's happening on the mass-storage device it connects to.  All it d=
oes
> > > is send the commands that it gets from the SCSI subsystem to the devi=
ce
> > > and receive the results back.  It has no idea whether there is a moun=
ted
> > > filesystem on the device, if the filesystem contains any files, or
> > > whether a scanning operation is running,
> > >
> > > A better place to look for fixing this might be the filesystem code.
> > > That's where the information about mounting, files, and scanning can =
be
> > > found.
> > >
> > > Alan Stern
> >
> > The problem is there is a for loop in the invalidate_inodes(), this
> > function is in the block device driver. when the usb_disconnect is
> > called, the filesystem is not umounted, userspace applications will be
> > noticed the usb storage is disconnected, and then do the umounting
> > work.
> > the invalidate_inodes() is called in the usb hub worker, and will run
> > for a long time. To fix this issue, the long running loop need to be
> > moved out from the usb hub worker.
>
> Oh, maybe I didn't understand.
>
> You've got a USB mass-storage device with a mounted filesystem and a lot
> of dirty inodes, right?  Then a USB disconnect happens, and as part of
> the disconnect processing, invalidate_inodes() runs for a long time.
>
> Do you know why it takes so long?  The I/O operations shouldn't need any
> time; they will all fail immediately because the device has been
> disconnected and so there is no way to communicate with it.
>
> Alan Stern

Yes, invalidate_inodes() will free all the inodes related to the
supper_block, there are more
than 20 thousands inodes (some times more) need to be freed, the perf
record shows the
cpu is busy running the spin_lock and spin_unlock in the
invalidate_inodes(). The work in
this function is to free all the inodes with the super_block.
Maybe I need to find out why the spin_lock is running so much first.
