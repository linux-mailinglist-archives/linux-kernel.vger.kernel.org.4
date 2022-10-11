Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01725FAD52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJKHUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:20:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE651AF3C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:20:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u21so18807346edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=alaMRFyTqgWPSUYwvVsV66h29Ch4dJMbSbv8FxTJjaA=;
        b=bkE8MOcfXqF5ZXU3ub0tTJyX9Oh+0UBLtCHv3tBLdtXqlRc2YXsxFznTqRCgdOrPkY
         cXJ+zNb/4EbEwRih5hzPht0wW/RPwKVKig9a5kk5IPsVNHvX1kMj/b8NyvnT6xeRFdEl
         UW9FuAXNj4FbIvHMTJ0zymQbyVZ8yFj/IojpJmHw5hGp2NSuyfg2UP1vx7jca6Gq2apH
         UV9WiGVC8GPTY1iKRHn5Tc76rJ4bY07OImHid2+MohiyGeEjhCFC6yl0uMtBO0rPPKU1
         V16tbXYnTDiUt1R89HIiXNflPAkpcANC5bPCnr5qjgnMdXmOnvFVeEBk5qED3zDmjcuG
         SJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alaMRFyTqgWPSUYwvVsV66h29Ch4dJMbSbv8FxTJjaA=;
        b=sHW8wn4slZIdwj7wcemE/YZODkNBU3Egeq2z8djWVcMFIfj191GjPEsx07QgEpRXGC
         tvxQOraYvXTxKR45XOxnSoXkVX32kdwVu4IE5Zcq5GagqdZuWgJtJQfGZxC3MG/J6MRc
         QkY2PYcP7MOZsLsGoKDLs6X52rjG7gLWiOZ/Pti3pb989kiuL2P8/MZ2hVxy8pXcRydR
         JLYzMzuVZgxezH983HpDdbjh755BsT6PVQIDKkHUxANdwoa7rVxVaCkQV8TjZmWjZDAK
         LV8oOGr/Qx5XsJ5bgc6s9dO4fLtoRLuW9C0tCztZZZXyMTYnJY3skplOoS25uZg+IbW/
         ehzw==
X-Gm-Message-State: ACrzQf3CMuVrWdIUER9erk81qnxzgvnwzsckoqdzyoVS1xFUzfw98MTX
        KtVMjwuZ7K1mUBaxNBBrYrEyN7AfsBX24SEmWPXZ7w==
X-Google-Smtp-Source: AMsMyM6ng/DQEStWl0sVu7PZ9rayjv3N7kALGp5vzQ5bTLIjhkEvP6vOacybQL5Z2v6RtytTK3Y7aTxqmzxJ8y9QQ3o=
X-Received: by 2002:a05:6402:448:b0:45c:8de5:4fc with SMTP id
 p8-20020a056402044800b0045c8de504fcmr203354edw.133.1665472798912; Tue, 11 Oct
 2022 00:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220927120857.639461-1-max.kellermann@ionos.com>
 <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com> <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
 <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com> <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
 <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
In-Reply-To: <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 11 Oct 2022 09:19:48 +0200
Message-ID: <CAKPOu+_4CLD2qJsUhhe4K0QqrC9mLmargEimibvVXdAHq6RCUw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 4:03 AM Xiubo Li <xiubli@redhat.com> wrote:
> No, it don't have to. This could work simply as the snaprealm hierarchy
> thing in kceph.
>
> Only the up top directory need to record the ACL and all the descendants
> will point and use it if they don't have their own ACLs.

Not knowing much about Ceph internals, I don't quite understand this
idea. Until somebody implements that, I'll keep my patch in our Linux
kernel fork.
My patch is a very simple and robust fix for our problem (it's already
in production use). It's okay for me if it doesn't get merged into
mainline, but at least I wanted to share it.

> For multiple clients case I think the cephfs capabilities [3] could
> guarantee the consistency of this.

I don't understand - capabilities are client-specific, not
user-specific. My problem is a user-specific one.

> While for the single client case if
> before the user could update its ACL just after creating it someone else
> has changed it or messed it up, then won't the existing ACLs have the
> same issue ?

You mean ACLs for "real" files/directories? Sure, some care needs to
be taken, e.g. create directories with mode 700 and chmod after
setting the ACL, and using O_TMPFILE for files and linking them to a
directory only after updating the ACL.

The difference to snapdir is that the snapdir doesn't actually exist
anywhere; it is synthesized by the client only on the first acess, and
may be discarded any time by the shrinker, and the next access creates
a new one with default permissions. All those snapdir inodes are local
to the client, and each client has its own private set of permissions
for it.

Even if you'd take care for updating the snapdir permissions after
creating a directory, that would only be visible on that one client,
and may be reverted at any arbitrary point in time, and there's
nothing you can do about it. That's two unsolvable problems (no client
synchronization of snapdir permissions, and no persistence).

Max
