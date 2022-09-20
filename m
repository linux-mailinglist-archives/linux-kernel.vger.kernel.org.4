Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808CB5BDC27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiITFMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiITFMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:12:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0455A3D6;
        Mon, 19 Sep 2022 22:12:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso478928pjq.1;
        Mon, 19 Sep 2022 22:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hieuqC/+avTp7NyRpbsgLzd7KWLHcCM8U8nlz2nVQOs=;
        b=ewZ+GnbA5RwQm1x8VJpNNStM68zjr696+8myESKWdVoZ1yelstoSNd+EsY7BSzwb0q
         O7nZSd9AuazuO3bDB2lfZXwxjENsEHGFbgDrBnNPBY8LxitNZeV51XdjSvedoUoIwyei
         jw2fQ/NMfFWwws4verURLZ+uaaA+PcOmUqaaHSKx3JOhqDhWybIUqHE62j7Xw/kIs7DS
         zB3gEocSZzREL0sM++bbMmjlZwYppIXTyoz+/qxXhr5j17QFuHmZVboMXQYP7ntRJ60J
         qSiSr0a0qzlL1SkcCQDdHmN1lmwBBw2Jyn7EVIBOlmXS9sIPp/4qzvkRR1L6JOibJ4KL
         QnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hieuqC/+avTp7NyRpbsgLzd7KWLHcCM8U8nlz2nVQOs=;
        b=icCm6hM2eW969W8jvNexJNSsRfL6CewvHd1fqYVCKj5slEK80Sq9ioIopdYQTsoGD6
         BvRovZaFm4NVoeHL8SlE7mvJvrwoTMgr0mR1lOuPJB+1miWW7LDFkAFNztYeAZC8szFQ
         wPzYfQLe/sJ//43QeeWlJ1FV4jaBRZDC2baOq/2I4gA/57cRCtcz5neOJFmN2uZEepDN
         U81TtvHidb0WEnNTj06aHVGy5nATsjVG4Po6MAqp63zklkYsi2QhC46bgNPKgPFSGy25
         OVhrEPcirC6xZFDpYD44CG/8cuync/SU6q6PH/6eimFL89o51n9vDA6PNi2wFs1AvTTV
         DxNA==
X-Gm-Message-State: ACrzQf0YLb7pSQUOPXuXWuHc/F68QOJOYgXG7LJCoKxXeBtLExBMHoFU
        bB6byl+68/oIUerI+Yp/MdY=
X-Google-Smtp-Source: AMsMyM6QmudCzh5fVZIFbg5+ZNAjkLCNvk+YDUEuRnX7a1VCYslM5bjIo5fouBluyYL7Ubx4cueuTw==
X-Received: by 2002:a17:902:f542:b0:178:4f50:ac1c with SMTP id h2-20020a170902f54200b001784f50ac1cmr3112685plf.127.1663650723700;
        Mon, 19 Sep 2022 22:12:03 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b00176d8e33601sm336189plg.203.2022.09.19.22.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:12:03 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     luiz.dentz@gmail.com
Cc:     18801353760@163.com, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, rafael@kernel.org, soenke.huster@eknoes.de,
        syzbot+5a2d2b4a8ca80ad216a9@syzkaller.appspotmail.com,
        syzbot+e653e3f67251b6139aaa@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [syzbot] BUG: corrupted list in kobject_add_internal (4)
Date:   Tue, 20 Sep 2022 13:10:25 +0800
Message-Id: <20220920051024.4991-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZKm_YcMeRTouY6z+748WNYFnkD_UFWCQd8Yts7mNEnxGw@mail.gmail.com>
References: <CABBYNZKm_YcMeRTouY6z+748WNYFnkD_UFWCQd8Yts7mNEnxGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On Tue, 20 Sept 2022 at 00:55, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> Hi Hawkins,
>
> On Mon, Sep 19, 2022 at 1:42 AM Hawkins Jiawei <yin31149@gmail.com> wrote:
> >
> > On Sat, 17 Sept 2022 at 09:47, Hawkins Jiawei <yin31149@gmail.com> wrote:
> > >
> > >Hi,
> > >
> > >On Fri, 26 Aug 2022 08:27:06, AM Sönke Huster <soenke.huster@eknoes.de> wrote:
> > >>Hi Luiz,
> > >>
> > >>On 25.08.22 20:58, Luiz Augusto von Dentz wrote:
> > >>> Hi Sönke,
> > >>>
> > >>> On Thu, Aug 25, 2022 at 8:08 AM Sönke Huster <soenke.huster@eknoes.de> wrote:
> > >>>>
> > >>>> Hi,
> > >>>>
> > >>>>
> > >>>>
> > >>>> While fuzzing I found several crashes similar to the following:
> > >>>>
> > >>>>
> > >>>>         [    5.345731] sysfs: cannot create duplicate filename '/devices/virtual/bluetooth/hci0/hci0:0'
> > >>>>
> > >>>>         [...]
> > >>>>
> > >>>>         [    5.430464] BUG: KASAN: use-after-free in klist_add_tail+0x1bd/0x200
> > >>>>
> > >>>>         [    5.430464] Write of size 8 at addr ffff88800bfcc468 by task kworker/u3:1/43
> > >>>>
> > >>>>         [    5.430464]
> > >>>>
> > >>>>         [    5.430464] CPU: 0 PID: 43 Comm: kworker/u3:1 Not tainted 5.19.0-12855-g13f222680b8f #2
> > >>>>
> > >>>>         [    5.430464] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > >>>>
> > >>>>         [    5.430464] Workqueue: hci0 hci_rx_work
> > >>>>
> > >>>>         [    5.430464] Call Trace:
> > >>>>
> > >>>>         [    5.430464]  <TASK>
> > >>>>
> > >>>>         [    5.430464]  dump_stack_lvl+0x45/0x5d
> > >>>>
> > >>>>         [    5.430464]  print_report.cold+0x5e/0x5e5
> > >>>>
> > >>>>         [    5.430464]  kasan_report+0xb1/0x1c0
> > >>>>
> > >>>>         [    5.430464]  klist_add_tail+0x1bd/0x200
> > >>>>
> > >>>>         [    5.430464]  device_add+0xa6b/0x1b80
> > >>>>
> > >>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
> > >>>>
> > >>>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
> > >>>>
> > >>>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
> > >>>>
> > >>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
> > >>>>
> > >>>>         [    5.430464]  hci_event_packet+0x636/0xf60
> > >>>>
> > >>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
> > >>>>
> > >>>>         [    5.430464]  process_one_work+0x8df/0x1530
> > >>>>
> > >>>>         [    5.430464]  worker_thread+0x575/0x11a0
> > >>>>
> > >>>>         [    5.430464]  kthread+0x29d/0x340
> > >>>>
> > >>>>         [    5.430464]  ret_from_fork+0x22/0x30
> > >>>>
> > >>>>         [    5.430464]  </TASK>
> > >>>>
> > >>>>         [    5.430464]
> > >>>>
> > >>>>         [    5.430464] Allocated by task 44:
> > >>>>
> > >>>>         [    5.430464]  kasan_save_stack+0x1e/0x40
> > >>>>
> > >>>>         [    5.430464]  __kasan_kmalloc+0x81/0xa0
> > >>>>
> > >>>>         [    5.430464]  device_add+0xcae/0x1b80
> > >>>>
> > >>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
> > >>>>
> > >>>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
> > >>>>
> > >>>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
> > >>>>
> > >>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
> > >>>>
> > >>>>         [    5.430464]  hci_event_packet+0x636/0xf60
> > >>>>
> > >>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
> > >>>>
> > >>>>         [    5.430464]  process_one_work+0x8df/0x1530
> > >>>>
> > >>>>         [    5.430464]  worker_thread+0x575/0x11a0
> > >>>>
> > >>>>         [    5.430464]  kthread+0x29d/0x340
> > >>>>
> > >>>>         [    5.430464]  ret_from_fork+0x22/0x30
> > >>>>
> > >>>>         [    5.430464]
> > >>>>
> > >>>>         [    5.430464] Freed by task 43:
> > >>>>
> > >>>>         [    5.430464]  kasan_save_stack+0x1e/0x40
> > >>>>
> > >>>>         [    5.430464]  kasan_set_track+0x21/0x30
> > >>>>
> > >>>>         [    5.430464]  kasan_set_free_info+0x20/0x40
> > >>>>
> > >>>>         [    5.430464]  __kasan_slab_free+0x108/0x190
> > >>>>
> > >>>>         [    5.430464]  kfree+0xa9/0x360
> > >>>>
> > >>>>         [    5.430464]  device_add+0x33a/0x1b80
> > >>>>
> > >>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
> > >>>>
> > >>>>         [    5.430464]  hci_le_cis_estabilished_evt+0x517/0xa70
> > >>>>
> > >>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
> > >>>>
> > >>>>         [    5.430464]  hci_event_packet+0x636/0xf60
> > >>>>
> > >>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
> > >>>>
> > >>>>         [    5.430464]  process_one_work+0x8df/0x1530
> > >>>>
> > >>>>         [    5.430464]  worker_thread+0x575/0x11a0
> > >>>>
> > >>>>         [    5.430464]  kthread+0x29d/0x340
> > >>>>
> > >>>>         [    5.430464]  ret_from_fork+0x22/0x30
> > >>>>
> > >>>>
> > >>>>
> > >>>> I think I fixed a similar issue in d5ebaa7c5f6f ("Bluetooth: hci_event: Ignore multiple conn complete events"). Here, the problem was that multiple connection complete events for the same handle called hci_conn_add_sysfs multiple times, but if it is called with an existing connection conn->dev->p is freed.
> > >>>>
> > >>>> This is because device_add is called - its documentation contains this sentence: "Do not call this routine or device_register() more than once for any device structure".
> > >>>>
> > >>>>
> > >>>>
> > >>>> This here is similar: First, an hci_le_conn_complete_evt creates a new connection.
> > >>>>
> > >>>> Afterwards, an hci_le_cis_estabilished_evt with the same handle finds that connection, and tries to add it to sysfs again, freeing conn->dev->p. Now, an event that might use that connection such as here the hci_le_conn_complete_evt triggers a use after free.
> > >>>>
> > >
> > >Syzkaller reports a bug as follows [1]:
> > >------------[ cut here ]------------
> > >kernel BUG at lib/list_debug.c:33!
> > >invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > >[...]
> > >Call Trace:
> > > <TASK>
> > > __list_add include/linux/list.h:69 [inline]
> > > list_add_tail include/linux/list.h:102 [inline]
> > > kobj_kset_join lib/kobject.c:164 [inline]
> > > kobject_add_internal+0x18f/0x8f0 lib/kobject.c:214
> > > kobject_add_varg lib/kobject.c:358 [inline]
> > > kobject_add+0x150/0x1c0 lib/kobject.c:410
> > > device_add+0x368/0x1e90 drivers/base/core.c:3452
> > > hci_conn_add_sysfs+0x9b/0x1b0 net/bluetooth/hci_sysfs.c:53
> > > hci_le_cis_estabilished_evt+0x57c/0xae0 net/bluetooth/hci_event.c:6799
> > > hci_le_meta_evt+0x2b8/0x510 net/bluetooth/hci_event.c:7110
> > > hci_event_func net/bluetooth/hci_event.c:7440 [inline]
> > > hci_event_packet+0x63d/0xfd0 net/bluetooth/hci_event.c:7495
> > > hci_rx_work+0xae7/0x1230 net/bluetooth/hci_core.c:4007
> > > process_one_work+0x991/0x1610 kernel/workqueue.c:2289
> > > worker_thread+0x665/0x1080 kernel/workqueue.c:2436
> > > kthread+0x2e4/0x3a0 kernel/kthread.c:376
> > > ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > > </TASK>
> > >
> > >I think they are the same problems:
> > >A hci_le_conn_complete_evt creates a new connection, and calls
> > >hci_conn_add_sysfs(). Then hci_le_cis_estabilished_evt with the same handle
> > >finds that connection, and will also calls hci_conn_add_sysfs(), which maybe
> > >triggering corrupted list bug.
> > >
> > >Link: https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a [1]
> > >
> > >>>>
> > >>>>
> > >>>> I bisected this bug and it was introduced with  26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections").
> > >>>>
> > >>>>
> > >>>>
> > >>>> The same happens with hci_le_create_big_complete_evt: Here, multiple events trigger the following bug:
> > >>>>
> > >>>>
> > >>>>
> > >>>>         [    6.898080] BUG: kernel NULL pointer dereference, address: 0000000000000058
> > >>>>
> > >>>>         [    6.898081] #PF: supervisor read access in kernel mode
> > >>>>
> > >>>>         [    6.898083] #PF: error_code(0x0000) - not-present page
> > >>>>
> > >>>>         [    6.898085] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > >>>>
> > >>>>         [    6.898090] Workqueue: hci0 hci_rx_work
> > >>>>
> > >>>>         [    6.898092] RIP: 0010:klist_next+0x12/0x160
> > >>>>
> > >>>>         [    6.898128] Call Trace:
> > >>>>
> > >>>>         [    6.898129]  <TASK>
> > >>>>
> > >>>>         [    6.898130]  ? bt_link_release+0x20/0x20
> > >>>>
> > >>>>         [    6.898133]  device_find_child+0x37/0xa0
> > >>>>
> > >>>>         [    6.898136]  hci_conn_del_sysfs+0x71/0xa0
> > >>>>
> > >>>>         [    6.898138]  hci_conn_cleanup+0x17a/0x2c0
> > >>>>
> > >>>>         [    6.898141]  hci_conn_del+0x14a/0x240
> > >>>>
> > >>>>         [    6.898144]  hci_le_create_big_complete_evt+0x3d8/0x470
> > >>>>
> > >>>>         [    6.898146]  ? hci_le_remote_feat_complete_evt+0x3e0/0x3e0
> > >>>>
> > >>>>         [    6.898148]  hci_le_meta_evt+0x155/0x230
> > >>>>
> > >>>>         [    6.898150]  hci_event_packet+0x328/0x820
> > >>>>
> > >>>>         [    6.898152]  ? hci_conn_drop+0x100/0x100
> > >>>>
> > >>>>         [    6.898155]  hci_rx_work+0x725/0xb70
> > >>>>
> > >>>>         [    6.898157]  process_one_work+0x2a6/0x5d0
> > >>>>
> > >>>>         [    6.898160]  worker_thread+0x4a/0x3e0
> > >>>>
> > >>>>         [    6.898162]  ? process_one_work+0x5d0/0x5d0
> > >>>>
> > >>>>         [    6.898164]  kthread+0xed/0x120
> > >>>>
> > >>>>         [    6.898165]  ? kthread_complete_and_exit+0x20/0x20
> > >>>>
> > >>>>         [    6.898167]  ret_from_fork+0x22/0x30
> > >>>>
> > >>>>         [    6.898170]  </TASK>
> > >>>>
> > >>>>
> > >>>>
> > >>>> I bisected this bug and it was introduced with eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections").
> > >>>>
> > >>>>
> > >>>>
> > >>>> I am not really sure how to solve that. As far as I understand, previously we simply set an unused handle as connection handle, and checked for that before setting the correct handle and adding it to sysfs. But here, adding it to sysfs seems to happen in a different function and the handle is already set.
> > >>>
> > >>> We should probably check if link-type, if it is an ISO link it shall
> > >>> not be created via Connection Complete events and they have their own
> > >>> events to create that.
> > I wonder if we can check the connection type in hci_le_create_big_complete_evt()
> > and hci_le_cis_estabilished_evt(), as below:
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 6643c9c20fa4..5b83473d51b5 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6795,8 +6795,16 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
> >
> >         if (!ev->status) {
> >                 conn->state = BT_CONNECTED;
> > -               hci_debugfs_create_conn(conn);
> > -               hci_conn_add_sysfs(conn);
> > +
> > +               /* Only ISO_LINK link type need to register connection device
> > +                * here, others will register in their relative
> > +                * Connection Complete events
> > +                */
> > +               if (conn->type == ISO_LINK) {
> > +                       hci_debugfs_create_conn(conn);
> > +                       hci_conn_add_sysfs(conn);
> > +               }
>
> We should probably just bail out if conn->type != ISO_LINK which can
> be done much earlier.
Thanks for explanation.

>
> >                 hci_iso_setup_path(conn);
> >                 goto unlock;
> >         }
> > @@ -6901,8 +6909,16 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
> >
> >         if (!ev->status) {
> >                 conn->state = BT_CONNECTED;
> > -               hci_debugfs_create_conn(conn);
> > -               hci_conn_add_sysfs(conn);
> > +
> > +               /* Only ISO_LINK link type need to register connection device
> > +                * here, others will register in their relative
> > +                * Connection Complete events
> > +                */
> > +               if (conn->type == ISO_LINK) {
> > +                       hci_debugfs_create_conn(conn);
> > +                       hci_conn_add_sysfs(conn);
> > +               }
> > +
> >                 hci_iso_setup_path(conn);
> >                 goto unlock;
> >         }
> >
> > It seems that this patch can pass the syzbot test.
> >
> > Link: https://lore.kernel.org/all/0000000000004f9ca105e8ba8157@google.com/
> > Reported-and-tested-by: syzbot+5a2d2b4a8ca80ad216a9@syzkaller.appspotmail.com
> >
> > Link: https://lore.kernel.org/all/0000000000008a7a3f05e8ad02f6@google.com/
> > Reported-and-tested-by: syzbot+e653e3f67251b6139aaa@syzkaller.appspotmail.com
> >
> > >>>
> > >>
> > >>But then the problem of duplicate hci_le_cis_estabilished_evt / hci_le_create_big_complete_evt still exists, isn't it? For example if the connection is created through a hci_le_cis_req_evt, and afterwards two hci_le_cis_estabilished_evt arrive, the second event calls hci_conn_add_sysfs a second time which frees parts of the device structure.
> > As for this problem, I wonder if we can check the connection state in those
> > functions as below, liking patch
> > d5ebaa7c5f6f("Bluetooth: hci_event: Ignore multiple conn complete events"):
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 5b83473d51b5..f6b62cfcf082 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6794,6 +6794,14 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
> >         }
> >
> >         if (!ev->status) {
> > +               /* The HCI_LE_CIS_Estabilished event is only sent once per connection.
> > +                * Processing it more than once per connection can corrupt kernel memory.
> > +                *
> > +                * As the connection state is set here for the first time, it indicates
> > +                * whether the connection is already set up.
> > +                */
> > +               if (conn->state == BT_CONNECTED)
> > +                       goto unlock;
> >                 conn->state = BT_CONNECTED;
> >
> >                 /* Only ISO_LINK link type need to register connection device
> > @@ -6908,6 +6916,14 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
> >                 conn->handle = __le16_to_cpu(ev->bis_handle[0]);
> >
> >         if (!ev->status) {
> > +               /* The HCI_LE_Create_BIG_Complete event is only sent once per connection.
> > +                * Processing it more than once per connection can corrupt kernel memory.
> > +                *
> > +                * As the connection state is set here for the first time, it indicates
> > +                * whether the connection is already set up.
> > +                */
> > +               if (conn->state == BT_CONNECTED)
> > +                       goto unlock;
>
> These changes look good, please send a proper patch.
OK, I will add some error message and send a proper patch.

>
> >                 conn->state = BT_CONNECTED;
> >
> >                 /* Only ISO_LINK link type need to register connection device
> >
> > >>
> > >>>> Best
> > >>>> Sönke
> > >I wonder that if we need both two patches? Because they
> > >seems to be used to patch different bugs?
>
>
>
> --
> Luiz Augusto von Dentz
