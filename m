Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB78E616C67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKBSg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiKBSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA46C2F676
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2LZi3yU3n7R/W4GuO9j//JNe6TLauoqoSJ+PuigISI=;
        b=Y6RmZFOR73EALSyfaV2bE0L24NL5a41dlOm8eBdCP9amuAKVt23asQgFgwCxZGIS0O9P8A
        lRHAmPAYusRvClFbzkTs/wr9srl8z3P1XOuJMFkQoCzdzl1t+VDXV6x1107Y7J1g9nkSkm
        9ZqoCyjc6DypKIKWoie1+/4B1vPUXQ4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-uTSVHww9Paiazf0g_1oFwg-1; Wed, 02 Nov 2022 14:34:20 -0400
X-MC-Unique: uTSVHww9Paiazf0g_1oFwg-1
Received: by mail-qt1-f198.google.com with SMTP id g3-20020ac84b63000000b003a529c62a92so6145112qts.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2LZi3yU3n7R/W4GuO9j//JNe6TLauoqoSJ+PuigISI=;
        b=P0C4VrEfH+CGBvGfQ2BYcHHYGoUz7nOOlVw8En80/tvY0RhuWgEk083ARfcn42NbVD
         H+xiTPcdbdnpHMSx5cTMR6Wh/aKpdEsN9bioStae8xnD7bXrVYXrIPgv7zJ9L0SeglvA
         uSDV6w7yEgvu9eCq18IvnmB8XPmPKSW2YRCjtvKgCwnoYEMavBJHfoX851mdngQZhn3a
         a9/tCatFqxtU4zMSiBas5NKBXIGYqhY+pXudztEcxkX+PMz8wife229EIp30q+PT4tGS
         W9LDXSCgtNEc95PxQrzkQJfdwBT7C8RW5hXKkZBPQF9SCDSJBNX0gboHKiQkN/HX3Chv
         +9ew==
X-Gm-Message-State: ACrzQf15a4UHo+NDfHFkbUoyj4z0pHg6Tp9VDirHkWZXtuEe12wrAXhD
        PU885vomo9oQY1hMPmoyZJoFsppLAEBOFKtm0dkCtkBIZUjIHCYLPbRs79xTK+YBh4AwRiprU9W
        Vtav44DFb3MbXpwGIh/Z9FwRS
X-Received: by 2002:a05:6214:20e2:b0:4bb:7aa5:bf0a with SMTP id 2-20020a05621420e200b004bb7aa5bf0amr22430252qvk.112.1667414059596;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5c7dwIqNgpqOLvhPHAiOA2g1SXDg3luIhlombymy6f4ZTzz3+a5A/2CAiuRdtosOetG1hbOw==
X-Received: by 2002:a05:6214:20e2:b0:4bb:7aa5:bf0a with SMTP id 2-20020a05621420e200b004bb7aa5bf0amr22430223qvk.112.1667414059378;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a409400b006bbf85cad0fsm9161228qko.20.2022.11.02.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:18 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:34:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
Message-ID: <Y2K4Kd8JRWa1noLB@x1n>
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru>
 <Y1Wbi4yyVvDtg4zN@x1n>
 <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com>
 <Y1f2IR+h4i2+/swj@x1n>
 <CADxRZqz+Sk=yxrJQ8B7UVkrcct9w6nUeiaaVn7QTFL59isFLDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxRZqz+Sk=yxrJQ8B7UVkrcct9w6nUeiaaVn7QTFL59isFLDA@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 04:13:20PM +0300, Anatoly Pugachev wrote:
> On Tue, Oct 25, 2022 at 5:43 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 25, 2022 at 01:22:45PM +0300, Anatoly Pugachev wrote:
> > > On Sun, Oct 23, 2022 at 10:53 PM Peter Xu <peterx@redhat.com> wrote:
> > > > On Fri, Oct 21, 2022 at 07:06:03PM +0300, Anatoly Pugachev wrote:
> > > > >
> > > > >     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redhat.com
> >
> > Maybe we need to have the minimum revert for v6.1 before we have more
> > clues.
> 
> Just a quick update on 6.1.0-rc3
> 
> Tested again with 6.1.0-rc3, segfaults dpkg... applied patch - no dpkg
> segfaults.

Andrew, shall we apply the minimum revert for this patch for now?  The
one-liner was attached in this email I replied to Anatoly:

https://lore.kernel.org/all/Y1Wbi4yyVvDtg4zN@x1n/

Thanks,

-- 
Peter Xu

