Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708F36E133C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDMRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:12:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E501B4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:12:16 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id gb12so13987031qtb.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681405935; x=1683997935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdGAVmsoTCF3y26q/e3koPed6S+/37Tv/FP0omN5R7Y=;
        b=T74YjVxwFqqN3Mb1q5sKlJ/s1SnH+lFUVXw/YHomlGgEWk49qZcRP6beva7bsmFp4w
         JWFavkFHyIaFs167FzL4d2e77LAAevZ0a+Y8qmBlTRZtHC7AdX/DjhQEzNE5vTfYAURa
         mg2Av0rzj/wf5j3hOlaWeZUjhWcJqpqVak+psV6huOF+rOq8oCrojWQih72o2BcV2rzQ
         ql0SueYX+7r+k/KZLdvzjK6cGqse7gmlGj3PDAsxZuK+5wVOXGIFuUhZMrXUAHcIzwgK
         GWuo5uVCKEExaCSvcJkP+ozQIrXkzGirXsgsBjsOK1Ze03hJiGkm1g4HTaTBo9m1K40G
         RZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405935; x=1683997935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdGAVmsoTCF3y26q/e3koPed6S+/37Tv/FP0omN5R7Y=;
        b=kyQjrDKsE2OBuX6jgzJOOzK96PTm1eZ+AOO0SHEEkQnX6RjBJyJuLIb2Z5nCSWMVNf
         bZOgsCSuRMls1zjZ2lVL0/vAuIxpfYGs+v4ZNdmzNLK1YdPk/OU2F4CqVptwcsxDJHhS
         ruDoIDcpwk3e0ifOALCQAsjDDmgcKuxpJxHF7NcilNE/tuJcCBKa6+UJTeNSh1HnkFQe
         qgleZrFlpcrhd2lFQaSUMksMHOJZMFDqWrp5CJXTnhRDMjarOHwCHzpc8NRnq9GA+pNt
         ZR24j6p4zjndqM5khNPNQ0K6d+gHnzxTE3afpf5tVV4vZsxusGoxkPUc5Bc5vyxemWfY
         Xpcw==
X-Gm-Message-State: AAQBX9dMz7BNNhFccBhDtOLWVR9NBCVhGpY0D9VyOTbBvGN83ZhgzsU/
        Jxpfu0VVWP6BNwYz0GZR6xRR5KSG6uX9md1Tn6kzrA==
X-Google-Smtp-Source: AKy350YzqrdtZMK5jVV0DcosmEslCmJ1WSRul9YGMh6Fq0NYh7iqJb6N1OWRXPNdm35IvX9AZCfPtmhhe4y1hZ8d43U=
X-Received: by 2002:ac8:5945:0:b0:3e6:970e:a405 with SMTP id
 5-20020ac85945000000b003e6970ea405mr889280qtz.6.1681405935505; Thu, 13 Apr
 2023 10:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
 <ZDcSG2t3/sVuZc67@dhcp22.suse.cz> <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
 <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
In-Reply-To: <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 13 Apr 2023 13:11:39 -0400
Message-ID: <CA+CK2bDCKUDJu+Vx1PF9hsBGzbrN05fkyw7AHAKd0YYfTkhp5g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:25=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 13-04-23 11:05:20, Pavel Tatashin wrote:
> > On Wed, Apr 12, 2023 at 4:18=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Wed 12-04-23 13:13:02, Andrew Morton wrote:
> > > > Lots of questions (ie, missing information!)
> > > >
> > > > On Wed, 12 Apr 2023 19:59:39 +0000 Pasha Tatashin <pasha.tatashin@s=
oleen.com> wrote:
> > > >
> > > > > HugeTLB pages have a struct page optimizations where struct pages=
 for tail
> > > > > pages are freed. However, when HugeTLB pages are destroyed, the m=
emory for
> > > > > struct pages (vmemmap) need to be allocated again.
> > > > >
> > > > > Currently, __GFP_NORETRY flag is used to allocate the memory for =
vmemmap,
> > > > > but given that this flag makes very little effort to actually rec=
laim
> > > > > memory the returning of huge pages back to the system can be prob=
lem.
> > > >
> > > > Are there any reports of this happening in the real world?
> > > >
> > > > > Lets
> > > > > use __GFP_RETRY_MAYFAIL instead. This flag is also performs grace=
ful
> > > > > reclaim without causing ooms, but at least it may perform a few r=
etries,
> > > > > and will fail only when there is genuinely little amount of unuse=
d memory
> > > > > in the system.
> > > >
> > > > If so, does this change help?
> > > >
> > > > If the allocation attempt fails, what are the consequences?
> > > >
> > > > What are the potential downsides to this change?  Why did we choose
> > > > __GFP_NORETRY in the first place?
> > > >
> > > > What happens if we try harder (eg, GFP_KERNEL)?
> > >
> > > Mike was generous enough to make me remember
> > > https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/.
> > > GFP_KERNEL wouldn't make much difference becauset this is
> > > __GFP_THISNODE. But I do agree that the changelog should go into more
> > > details about why do we want to try harder now. I can imagine that
> > > shrinking hugetlb pool by a large amount of hugetlb pages might becom=
e a
> > > problem but is this really happening or is this a theoretical concern=
?
> >
> > This is a theoretical concern. Freeing a 1G page requires 16M of free
> > memory. A machine might need to be reconfigured from one task to
> > another, and release a large number of 1G pages back to the system if
> > allocating 16M fails, the release won't work.
>
> This is really an important "detail" changelog should mention. While I
> am not really against that change I would much rather see that as a
> result of a real world fix rather than a theoretical concern. Mostly
> because a real life scenario would allow us to test the
> __GFP_RETRY_MAYFAIL effectivness. As that request might fail as well we
> just end up with a theoretical fix for a theoretical problem. Something
> that is easy to introduce but much harder to get rid of should we ever
> need to change __GFP_RETRY_MAYFAIL implementation for example.

I will add this to changelog in v3. If  __GFP_RETRY_MAYFAIL is
ineffective we will receive feedback once someone hits this problem.
Otherwise, we will never hear about it. I think overall it is safer to
keep this code with __GFP_RETRY_MAYFAIL flag.

>
> > In an ideal scenario we should guarantee that this never fails: that
> > we always can free HugeTLB pages back to the system. At the very least
> > we could steal the memory for vmemmap from the page that is being
> > released.
>
> Yes, this really bothered me when the concept was introduced initially.
> I am always concerned when you need to allocate in order to free memory.
> Practically speaking we haven't heard about bug reports so maybe this is
> not such a big deal as I thought.

I suspect this is because at the moment it is not that frequent when a
machine is reconfigured from having a lot of HugeTLB based workload to
non-HugeTLB workload.

Pasha
