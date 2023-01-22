Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB34676AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAVDBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAVDBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:01:30 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA223DB7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:01:25 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4a263c4ddbaso127681647b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ne6qQGUuq72y7Dfk6gWGSHwmrqqO2LzbmO36IfFBAE=;
        b=qPXfA7zuuF7h+5B3sMdAgOrhEWDHPkMy4WvRUWUO+PIG6n2ZGkQuqP00BdG2BrL5wo
         68D5MlNGA+tow+zAllzQxxAr7eOQqxM8beX8K7EojYpsMoUEa7klBXXgJ0AmuwDGQKFn
         vSZo3pgSR+hfszPe4HV30F6oJ3ObqzrJ2qCHacSk6eRAOsmWVUo6Wr9+NJqO3aiv/fmd
         wlxB/VCwnVST84wmoOtVscKNqLUTleoQFhinZ7q/9Skhxv6scNOWBGFZ4eaC+azQ8hrw
         REXoHqSq6Cmh4MEyx0I+5myj9leBvd9+QoL8xnMZrajv99TUQtx7Ro0rgOvhvGqViufG
         fEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ne6qQGUuq72y7Dfk6gWGSHwmrqqO2LzbmO36IfFBAE=;
        b=bcCQWiEWPk19wHQoXwjC1CcGgPytJ7Ek72cz92tJ8YQkiHjNMJ/SwLUcRfvVCga3wh
         ZMcn/lmxS4vI9M+XpQE1g2+9MYcnoeVB61Op8ePsnFsSSITZfIheD8bHXChSEVaWP9ev
         +8FkbayzwKiN/f0Pz63BSIixn/QT0iHexeowz3GmB0egytj/xh7ftRX+XN7pjxyHnXW4
         63/FQ+0ED+WjTtZmdLrTdPKHnqyMSRPzgvqlGVQlJSuhn9JnsfMuz39D9IT23uqkSJDh
         c3hdot26Za0VCK0ptSUTDIKCehPJ/95u58TaPG9g2xVnvKpfsnnuUem00T0ODOLNS4Rs
         5d2g==
X-Gm-Message-State: AFqh2krCUz3bbmM8CMEwUH0rCqtTJovrqSnMHzxypoGzzNPDvghH+QKJ
        1KET9lrSpnydCKVL9VF/XlTpaMbcpUo839jXjm6FXw==
X-Google-Smtp-Source: AMrXdXv/qHeBECVBALHenwwxx1YjVufFnnq+u0AOBgD7yd3K4Rdgbc9H5t37w9N0PQbMbJBqYvnqRkbDlVKktH9eYoE=
X-Received: by 2002:a81:1b8b:0:b0:4ff:774b:7ffb with SMTP id
 b133-20020a811b8b000000b004ff774b7ffbmr1068529ywb.218.1674356484788; Sat, 21
 Jan 2023 19:01:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com> <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
 <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
 <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
 <20230120013055.3628-1-hdanton@sina.com> <CAJuCfpF9tCx4mjYFyX+p7qO9qt+rm=UMSdBt-uzaOqE0ThG04g@mail.gmail.com>
 <20230120090001.3807-1-hdanton@sina.com> <CAJuCfpFShuXs_CcfXR6PjYyXemapbuHPG0oZQJb_Y9ZpCUGZXg@mail.gmail.com>
 <20230121051746.4100-1-hdanton@sina.com>
In-Reply-To: <20230121051746.4100-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 21 Jan 2023 19:01:13 -0800
Message-ID: <CAJuCfpESYRYavQOkDYyJhurpEcV5ioUMb=i4Q0EJ1UpVpyRfAA@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Munehisa Kamata <kamatam@amazon.com>, Tejun Heo <tj@kernel.org>,
        ebiggers@kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mengcc@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 9:18 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Fri, 20 Jan 2023 08:28:25 -0800 Suren Baghdasaryan <surenb@google.com>
> > On Fri, Jan 20, 2023 at 1:00 AM Hillf Danton <hdanton@sina.com> wrote:
> > > +++ b/kernel/sched/psi.c
> > > @@ -1529,6 +1529,7 @@ static int psi_fop_release(struct inode
> > >  {
> > >         struct seq_file *seq = file->private_data;
> > >
> > > +       eventpoll_release_file(file);
> >
> > Be careful here and see the comment in
> > https://elixir.bootlin.com/linux/latest/source/fs/eventpoll.c#L912.
> > eventpoll_release_file() assumes that the last fput() was called and
> > nobody other than ep_free() will race with us. So, this will not be
> > that simple.
>
> The epmutex serializes eventpoll_release_file() and ep_free(). And this
> is in psi_fop_release(), so no chance is likely left for another release.
>
> > Besides if we really need to fix the order here, the fix
> > should be somewhere at the level of cgroup_file_release() or even
> > kernfs to work for other similar situations.
>
> Good point but cgroup and kernfs have no idea of psi trigger.

Yes, that's why I think if we really need to fix the order here and do
it properly, it won't be straightforward. IMHO wake_up_pollfree() is
an appropriate and simple fix for this.

>
> The bonus of the uaf is check polled file upon release in scenarios like
> the psi trigger.
>
