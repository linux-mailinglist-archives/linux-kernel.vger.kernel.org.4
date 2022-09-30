Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67DB5F1674
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiI3XDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3XDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:03:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B6F1D7BD3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:03:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q83so4393208iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SqBsvh6C88KVHki7t4Nj5RWCZOuW9N4jEM2i1kXUX1A=;
        b=QV19rN7u49LBgxsERfExNXC4Qifjr+PujO83hWUsqQwWJAXOvZDMqMjRVEDwq/nUYr
         8y2bG+TTsCRkpKYIxMWp8TqRP9q0NhNbhHKapcl7ZvaDlrJTayOSthJN8uY5l9d557x9
         i/hEw2f9ra0wkORLPbcYwdezMlEVBHVdwUCkjEiJh7tiOGHh48T0sJ9EquqQ1m5DhnQ8
         1ycYF/JTKxFOBImu3XQsT+D0d2yQO0F6wmMGdzGRtRwL5UBCP7gM0lmrYUwAPIWwx3t0
         Yr8+kmTHepP1iIeY3YZxS+B1BGhJde4gU45irp5VKxeWy7uNtfVblAI+gIl/XxNQRTov
         W/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SqBsvh6C88KVHki7t4Nj5RWCZOuW9N4jEM2i1kXUX1A=;
        b=Y8NGgFOIdOxAb4/O2ddY4LfWYJRyfnVB8z1fYcxkTdaB/QGXfoJzvqyXNDdCAvjPzl
         gc5nhVwTrGQVnpr0ssNrx+Gn8qTdu3skhyM5yrIkyRMLU+DjXPJ/aoG8sE1QxLnY50qg
         9ZnAu5cTuref0241+20ekEHY6JKOOvMbyrCR08lAtv5QRaONiHPbmrlPtuwisVEo28ZN
         JK+9uHe/gJXTmoKXJCYQROJimoU4cG75VFd5ipbebXhj1EO6T6Wkjr7AEQ9HqbxrG0Uk
         qv/mAmOj+7WmSzbN9SO8ibu/Wtpm6JJyR005dqN79jVQWu0yJTm+Zd4oskh+ktgr38a6
         igCA==
X-Gm-Message-State: ACrzQf0hYo5KqA67w6oZFZAMH1Cu3ZOLvDM0jj7cW+jCUhlxC7s49WHw
        lnNIMmjZujHznO/HB4yzhNZLLEXuN9NUdxdwzyWXzA==
X-Google-Smtp-Source: AMsMyM6/1Zo86oY4qRLob+fDqU88N1JO4RXTZoZZODrBjD9wJqjFTLtKUMBKFRj4TR8qKrKyDwQEelk6KAJ1qvm8qrk=
X-Received: by 2002:a6b:5d02:0:b0:6a3:46d5:a08d with SMTP id
 r2-20020a6b5d02000000b006a346d5a08dmr4696832iob.2.1664578981372; Fri, 30 Sep
 2022 16:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com> <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
 <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
In-Reply-To: <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 1 Oct 2022 01:02:25 +0200
Message-ID: <CAG48ez3DNXjH+h+VFAiBwg+ebwxM6a_VsF=QKzXCDEE7QzTNvA@mail.gmail.com>
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 1:00 AM Jann Horn <jannh@google.com> wrote:
> So I think this change is actually a no-op - the only thing it does is
> to return 0 if write==1, !_PAGE_RW, and _PAGE_DIRTY. But the check
> below will always return 0 if !_PAGE_RW, unless I'm misreading it?

Er, to be precise, it will always return 0 if write==1 and !_PAGE_RW.
