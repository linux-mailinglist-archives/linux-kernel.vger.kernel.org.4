Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E068CC69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBGCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGCFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:05:39 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CA199E8;
        Mon,  6 Feb 2023 18:05:38 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-51ba4b1b9feso178752187b3.11;
        Mon, 06 Feb 2023 18:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhnCh5zbjhk3Y70RN8FbNeJAsxe56/TZZOL0mVxexa4=;
        b=j5ziuwLFNxKsh0LI7undd8Qv0R6OS8N+bmxkOp8Eoe8LTs+7B6UEhBKnX6f4plnHgq
         LoP8FFn71pgnl0Phed9KT9xdjbgF64rUt74JCKYxE++rJ+n5SWoIAx9I8no1nYFwj91F
         7tndIhCf3FC4cnJUOEPlQD+/g+9qOmzpHRmJKA9RrHg9mAnObS0cxyLS9l6kZ9cKCk4i
         2Lf7N+meu0rKdWLPQNlLMyOMog/77heaOAgAzXzlflrAra1XXCJoyMoO5wG0tzHzn1Nf
         JWdK8w6LtfipC3NHuKiYUqYKYoPNmJg8mW035AQlZAoM4Z+XE7DYTxzlxhlK0eBAUYvD
         T38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhnCh5zbjhk3Y70RN8FbNeJAsxe56/TZZOL0mVxexa4=;
        b=06WIYyZbnfdhSjcGt/mHGO9yNUCHL51ACjxEy3dOS4o9+j0dWdmn5FeidnEHhs2B9j
         UJ+ExwlXdR8nvhXyhYwX5iZ26dkiEAJXm9Yn+AlQUUkXBNk0/ubdlX6XEDjvU0EYMpdg
         7tnlw+h+cHEEpQMkud1OEN/DKU3EtpIHP/Co/YfL7Enxs15fTblwL8dz3MD4h2XpeeV6
         6+2CMwqtyvOFRwkHHc3PgwpMO5zv7PTtftJHQErq5WbmgH9lJYTsT/ajCGNxGmL2xYzh
         ScVAQ7dpFRf2Mrr/W9YGIMBLqfXd/vc5NyhH5bccLCs7/h11o/+0DKcAbWD7XUIvvpoF
         au3g==
X-Gm-Message-State: AO0yUKVuJFFNC1upUJoyrRd5Rc/UPmC8UNnXGBmFhQ6HPN8sdamLdgK9
        zR9p73Z6QcAGEsOJ1uHWTsSmvERT0VDA8N36urqgPmgbm14=
X-Google-Smtp-Source: AK7set9f8IE+gzmaLDyr/TJX0zSap+HP43BG7NtRj5/xZBEK8KSrpFl6SIjIwFtz17J6pMEUjr88sHE36y9LidPZr04=
X-Received: by 2002:a81:6086:0:b0:4fd:25ef:8e1f with SMTP id
 u128-20020a816086000000b004fd25ef8e1fmr148326ywb.166.1675735537366; Mon, 06
 Feb 2023 18:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20230203072819.3408-1-zhongjiezhu1@gmail.com> <Y90egBL6HSoEdz2P@rowland.harvard.edu>
 <CAJnoMhNYDXjfttiio+P7k6W1fDU3N=jbjmZe+ZRVON=bqm0yvw@mail.gmail.com> <Y+EaIRHZfLs49w9L@rowland.harvard.edu>
In-Reply-To: <Y+EaIRHZfLs49w9L@rowland.harvard.edu>
From:   Zhongjie Zhu <zhongjiezhu1@gmail.com>
Date:   Tue, 7 Feb 2023 10:02:51 +0800
Message-ID: <CAJnoMhO_AWU0ABoJN_EQZ9BpnpgxSeuv26PqOJ1feLh_CdJHsg@mail.gmail.com>
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

On Mon, Feb 6, 2023 at 11:17 PM Alan Stern <stern@rowland.harvard.edu> wrot=
e:
>
> On Mon, Feb 06, 2023 at 11:33:15AM +0800, =E6=9C=B1=E5=BF=A0=E6=9D=B0 wro=
te:
> > Yes, this is a very special case.
> >
> > It will happen only when disconnecting the mass storage if there are
> > too many files in the storage, and the scanning operation is running,
> > and the file system is not unmounted.
> > It looks like this issue should be fixed in the usb mass storage
> > driver, but I don't find an appropriate place.
>
> That's not surprising, because usb-storage doesn't know anything about
> what's happening on the mass-storage device it connects to.  All it does
> is send the commands that it gets from the SCSI subsystem to the device
> and receive the results back.  It has no idea whether there is a mounted
> filesystem on the device, if the filesystem contains any files, or
> whether a scanning operation is running,
>
> A better place to look for fixing this might be the filesystem code.
> That's where the information about mounting, files, and scanning can be
> found.
>
> Alan Stern

The problem is there is a for loop in the invalidate_inodes(), this
function is in the block device driver. when the usb_disconnect is
called, the filesystem is not umounted, userspace applications will be
noticed the usb storage is disconnected, and then do the umounting
work.
the invalidate_inodes() is called in the usb hub worker, and will run
for a long time. To fix this issue, the long running loop need to be
moved out from the usb hub worker.
