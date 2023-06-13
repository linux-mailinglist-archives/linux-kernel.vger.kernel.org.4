Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710572E6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbjFMPMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbjFMPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:12:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7A118;
        Tue, 13 Jun 2023 08:11:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FD525C0145;
        Tue, 13 Jun 2023 11:11:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 13 Jun 2023 11:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686669115; x=1686755515; bh=0MYD55e2IXMwoYKYllG2nqmHi+XPVXTet6b
        nmleJ71Q=; b=KnrLo4IjXkDjYj5dn8CARWrB4IqBFmFgHiPhkDJZVtYRdRVxbpm
        lkkTTXq/qFMObGQpEGwnFLnEKTx1dmHwYwTPDAQRVTBTF79JX6CoQWCuvq/b1CuL
        T8TQB0MPtEDzXc6tQSCBzeI+uG08OqOWxbGPvCE+LhZ+MC4+8jqwV0Ohn8t3Lgx8
        zD7lor/7MoadZqSeOuv0wEgJDtBwIGh47MG9iOfL46IgzkHNmYvVQD8u/r239qTc
        TLxQIPPBUa6xhScmmo9tJxmPitLSTnud89z/HUuYeEHo/uwQlntUjKR5pKDDXzVT
        UeFgzWy1iI/OE5Hj9nQtNE9DEc8PBLinwfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686669115; x=1686755515; bh=0MYD55e2IXMwo
        YKYllG2nqmHi+XPVXTet6bnmleJ71Q=; b=X96i/QI8lNYjBMU3c8PxmItFWqXm2
        KwbCOfeKogK3ZKXWUDv2pNF+LMqoexnBmxarApyTE2xXXAQpXIGc8xNrDNqE0Wym
        te3lahcb/yBq9VDkX6CX3uoKsYGbHfV4c3KGlTYZ5h+m7hYTOq8SXxwst4ChMbAs
        M7UyCF7V3iNiWRlwwkxKfEgsrJIHDvWjU3A8rOkJCzwFQKd4E6iSZHHB8QNX+TZ0
        3MT/LkbnRDF4cEfa3QCYiXItG5vw9PRp9v+2swGDrfiK+1TFbAt4yRFhvWebtg6v
        T3E+CXAmnZ70k35FXsYuJAfQtRM0CehS/EFGV1LCdr4uD+F/Vv9kOKcNA==
X-ME-Sender: <xms:OoeIZJmdY7rS8IN0Lyv1-PACtyFdvvIS5YuHR_zZaglev4T0uC4qiQ>
    <xme:OoeIZE2sAxvdjDqX149qAdEknUJ-vNLQFn3s7ILpeYO_mu5DF8gJZv1O2fW4glLwr
    Vw8zPtSgwp4XiM>
X-ME-Received: <xmr:OoeIZPriuWHrBJlmlYyb-ZkqsN1RpttF8ArPfhtpnN4-lfY-JHw2e5ETmug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepueeuveelheevvdeuvdfhiefhleff
    tdehuedvfefgveegfefgiefhudehveehtdefnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:OoeIZJmsbe2ywAf1XbdhDTUjwK7Ku0WwIoyy_lwTEVm3MwsuMGAw1w>
    <xmx:OoeIZH23E6hllqarN3EkF8t79tDr9_Kd1b7sMa-2jwly2AlRd3Pu6A>
    <xmx:OoeIZIsKYlWfjV0uCXypmvCO9H9l31VKcw0GlN1_k34VXK7jhAjTHg>
    <xmx:O4eIZH_KScF2XsSvRp1xMNXQ6vvMAYUWB1DNSv_KBhCsBnkLvOgGKA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 11:11:54 -0400 (EDT)
Date:   Tue, 13 Jun 2023 11:11:49 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <JBeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] xen: speed up grant-table reclaim
Message-ID: <ZIiHONDTTdZjcBXo@itl-email>
References: <20230610153232.1859-1-demi@invisiblethingslab.com>
 <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
 <ZId7ixbqlCSygtvb@itl-email>
 <1150fd9c-25c8-c91c-4ca2-2c587e3fbb43@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jXCcFDlqGesoyNm8"
Content-Disposition: inline
In-Reply-To: <1150fd9c-25c8-c91c-4ca2-2c587e3fbb43@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jXCcFDlqGesoyNm8
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2023 11:11:49 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <JBeulich@suse.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xen developer discussion <xen-devel@lists.xenproject.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] xen: speed up grant-table reclaim

On Tue, Jun 13, 2023 at 08:45:31AM +0200, Juergen Gross wrote:
> On 12.06.23 22:09, Demi Marie Obenour wrote:
> > On Mon, Jun 12, 2023 at 08:27:59AM +0200, Juergen Gross wrote:
> > > On 10.06.23 17:32, Demi Marie Obenour wrote:
> > > > When a grant entry is still in use by the remote domain, Linux must=
 put
> > > > it on a deferred list.
> > >=20
> > > This lacks quite some context.
> > >=20
> > > The main problem is related to the grant not having been unmapped aft=
er
> > > the end of a request, but the side granting the access is assuming th=
is
> > > should be the case.
> >=20
> > The GUI agent has relied on deferred grant reclaim for as long as it has
> > existed.  One could argue that doing so means that the agent is misusing
> > gntalloc, but this is not documented anywhere.  A better fix would be to
> > use IOCTL_GNTDEV_SET_UNMAP_NOTIFY in the GUI daemon.
>=20
> I don't think this is a gntalloc specific problem. You could create the s=
ame
> problem with a kernel implementation.

That is true.

> And yes, using IOCTL_GNTDEV_SET_UNMAP_NOTIFY might be a good idea.
>=20
> > > In general this means that the two sides implementing the protocol do=
n't
> > > agree how it should work, or that the protocol itself has a flaw.
> >=20
> > What would a better solution be?  This is going to be particularly
> > tricky with Wayland, as the wl_shm protocol makes absolutely no
> > guarantees that compositors will promptly release the mapping and
> > provides no way whatsoever for Wayland clients to know when this has
> > happened.  Relying on an LD_PRELOAD hack is not sustainable.
> >=20
> > > > Normally, this list is very short, because
> > > > the PV network and block protocols expect the backend to unmap the =
grant
> > > > first.
> > >=20
> > > Normally the list is just empty. Only in very rare cases like prematu=
re
> > > PV frontend module unloading it is expected to see cases of deferred
> > > grant reclaims.
> >=20
> > In the case of a system using only properly-designed PV protocols
> > implemented in kernel mode I agree.  However, both libxenvchan and the
> > Qubes GUI protocol are implemented in user mode and this means that if
> > the frontend process (the one that uses gntalloc) crashes, deferred
> > grant reclaims will occur.
>=20
> This would be the user space variant of frontend driver unloading.

Yes and no.  The main difference is that a frontend driver can prevent
itself from being unloaded while it still has grants outstanding,
whereas a user space process cannot prevent itself from being killed.
The closest a user space process can get to making itself unkillable is
to use mlockall() and mark itself ineligible for the OOM killer.  This
would likely require anything that used grants (including vchans!) to be
a privileged daemon that exposes an API over an AF_UNIX socket, which
would be a substantial change in the case of Qubes OS.

> > Worse, it is possible for the domain to use
> > the grant in a PV protocol.  If the PV backend driver then maps and
> > unmaps the grant and then tells the frontend driver to reclaim it, but
> > the backend userspace process (the one using gntdev) maps it before the
> > frontend does reclaim it, the frontend will think the backend is trying
> > to exploit XSA-396 and freeze the connection.
>=20
> Let me sum up how I understand above statement:
>=20
> 1. Frontend F in DomA is granting DomB access via grant X for PV-device Y.
> 2. DomB backend B for PV-device Y is mapping the page using grant X and u=
ses it.
> 3. DomB backend B unmaps grant X and signals end of usage to DomA fronten=
d F.
> 4. DomB userspace process maps grant X
> 5. DomA frontend F tries to reclaim grant X and fails due to DomB userspa=
ce
>    mapping

All of these are correct, but there is some context that is missing.

> So why would DomB userspace process map grant X? This would imply a malic=
ious
> process in DomB. This might be possible, but I don't see how such an atta=
ck
> would relate to your problem. It could happen with any malicious userspace
> program with root access in a domain running a PV backend.

The complete sequence of events is as follows:

 1. DomA userspace process C allocates grant X via gntalloc.
 2. DomA userspace process C tells DomB userspace process to map grant X
    via e.g. a vchan message.
 3. DomB userspace process S receives message telling it to map grant X.
 4. (optional) DomB userspace process S checks that DomA userspace
    process C is still alive and finds that it is.
 5. DomB userspace process S gets preempted.
 6. DomA userspace process C exits or is killed.
 7. DomA kernel KA deallocates grant X.
 8. Frontend F in DomA grants DomB access via grant X for PV-device Y.
 9. DomB backend B for PV-device Y is mapping the page using grant X and us=
es it.
10. DomB backend B unmaps grant X and signals end of usage to DomA frontend=
 F.
11. DomB userspace process S is scheduled again.  It finally gets the
    chance to use gntdev to map grant X.
12. DomA frontend F tries to reclaim grant X and fails due to DomB userspace
    mapping by S.

Given the current kernel API, I=E2=80=99m not aware of any way to avoid thi=
s race
unless C (and possibly S) are unkillable.  Even with the check in step 4
there is still a TOCTOU problem.  Neither kernel has any visibility into
the userspace messaging protocol, so DomA has no way of knowing that S
has been told to map the grant in the future.

There are four other potential solutions I can think of.

1. If a gntalloc handle is closed while it still has mapped grants, leak
   the remaining grants.  It=E2=80=99s okay to reclaim the pages those gran=
ts
   refer to, but the grants themselves would not be usable until reboot.

2. Assume that =E2=80=9Cbackend has not unmapped grant=E2=80=9D is due to t=
his race, and
   fall back to deferred reclaim instead of closing the connection.  For
   this to work, either the data would need to be discarded by F, or S
   would need to follow some sort of protocol where it always checks
   that C is alive after mapping the grant but before writing to the
   newly mapped page.

3. Implement AF_VSOCK or a similar protocol for kernel-mediated inter-VM
   communication, and send grants as control messages.  This means that
   both kernels are aware of grant lifetimes and can avoid this race.

4. Same as 3, except that grant table entries are replaced by
   capabilities that must be sent over Argo.  This is obviously the best
   long-term solution, but it also requires massive changes in all PV
   protocols, so it isn=E2=80=99t practical in the short term.

Additionally, I wonder if grant operations should require CAP_SYS_RAWIO.
Userspace use of grants very much seems like a raw I/O operation,
inasmuch as it is bypassing the protections Linux normally provides.

> > > > However, Qubes OS's GUI protocol is subject to the constraints
> > > > of the X Window System, and as such winds up with the frontend unma=
pping
> > > > the window first.  As a result, the list can grow very large, resul=
ting
> > > > in a massive memory leak and eventual VM freeze.
> > >=20
> > > I do understand that it is difficult to change the protocol and/or
> > > behavior after the fact, or that performance considerations are in the
> > > way of doing so.
> >=20
> > Would the correct fix be to use IOCTL_GNTDEV_SET_UNMAP_NOTIFY?  That
> > would require that the agent either create a new event channel for each
> > window or maintain a pool of event channels, but that should be doable.
>=20
> I think this sounds like a promising idea.

Me too.

> > This still does not solve the problem of the frontend exiting
> > unexpectedly, though.
>=20
> Such cases need to be handled via deferred reclaim. You could add a flag
> to struct deferred_entry when called through gntalloc_vma_close(),
> indicating that this is an expected deferred reclaim not leading to
> error messages.

Deferred reclaim can handle this most of the time, but there is still a
race (see above).

> > > > To partially solve this problem, make the number of entries that th=
e VM
> > > > will attempt to free at each iteration tunable.  The default is sti=
ll
> > > > 10, but it can be overridden at compile-time (via Kconfig), boot-ti=
me
> > > > (via a kernel command-line option), or runtime (via sysfs).
> > >=20
> > > Is there really a need to have another Kconfig option for this? AFAICS
> > > only QubesOS is affected by the problem you are trying to solve. I do=
n't
> > > see why you can't use the command-line option or sysfs node to set the
> > > higher reclaim batch size.
> >=20
> > Fair.  In practice, Qubes OS will need to use the sysfs node, since
> > the other two do not work with in-VM kernels.
> >=20
> > > > Fixes: 569ca5b3f94c ("xen/gnttab: add deferred freeing logic")
> > >=20
> > > I don't think this "Fixes:" tag is appropriate. The mentioned commit =
didn't
> > > have a bug. You are adding new functionality on top of it.
> >=20
> > I=E2=80=99ll drop the "Fixes:" tag, but I will keep the "Cc: stable@vge=
r.kernel.org"
> > as I believe this patch meets the following criterion for stable
> > backport (from Documentation/process/stable-kernel-rules.rst):
> >=20
> >      Serious issues as reported by a user of a distribution kernel may =
also
> >      be considered if they fix a notable performance or interactivity i=
ssue.
> >=20
>=20
> Sure, this seems appropriate.

Thank you.

> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > > ---
> > > >    drivers/xen/Kconfig       | 12 ++++++++++++
> > > >    drivers/xen/grant-table.c | 40 ++++++++++++++++++++++++++++-----=
------
> > > >    2 files changed, 41 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > > > index d5d7c402b65112b8592ba10bd3fd1732c26b771e..8f96e1359eb102d6420=
775b66e7805004a4ce9fe 100644
> > > > --- a/drivers/xen/Kconfig
> > > > +++ b/drivers/xen/Kconfig
> > > > @@ -65,6 +65,18 @@ config XEN_MEMORY_HOTPLUG_LIMIT
> > > >    	  This value is used to allocate enough space in internal
> > > >    	  tables needed for physical memory administration.
> > > > +config XEN_GRANTS_RECLAIM_PER_ITERATION
> > > > +	int "Default number of grant entries to reclaim per iteration"
> > > > +	default 10
> > > > +	range 10 4294967295
> > > > +	help
> > > > +	  This sets the default value for the grant_table.free_per_iterat=
ion
> > > > +	  kernel command line option, which sets the number of grants that
> > > > +	  Linux will try to reclaim at once.  The default is 10, but
> > > > +	  workloads that make heavy use of gntalloc will likely want to
> > > > +	  increase this.  The current value can be accessed and/or modifi=
ed
> > > > +	  via /sys/module/grant_table/parameters/free_per_iteration.
> > > > +
> > >=20
> > > Apart from the fact that I don't like adding a new Kconfig option, th=
e help
> > > text is not telling the true story. Heavy use of gntalloc isn't to bl=
ame, but
> > > the fact that your PV-device implementation is based on the reclaim
> > > functionality. TBH, someone not familiar with the grant reclaim will =
have no
> > > chance to select a sensible value based on your help text.
> >=20
> > That=E2=80=99s a good point.  Qubes OS will need to use the sysfs value=
 anyway
> > in order to support in-VM kernels, so the Kconfig option is not really
> > useful.
>=20
> Nice.

Yeah, having one less Kconfig option is nice.

> > > >    config XEN_SCRUB_PAGES_DEFAULT
> > > >    	bool "Scrub pages before returning them to system by default"
> > > >    	depends on XEN_BALLOON
> > > > diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> > > > index e1ec725c2819d4d5dede063eb00d86a6d52944c0..fa666aa6abc3e786ddd=
c94f895641505ec0b23d8 100644
> > > > --- a/drivers/xen/grant-table.c
> > > > +++ b/drivers/xen/grant-table.c
> > > > @@ -498,14 +498,20 @@ static LIST_HEAD(deferred_list);
> > > >    static void gnttab_handle_deferred(struct timer_list *);
> > > >    static DEFINE_TIMER(deferred_timer, gnttab_handle_deferred);
> > > > +static atomic64_t deferred_count;
> > > > +static atomic64_t leaked_count;
> > > > +static unsigned int free_per_iteration =3D CONFIG_XEN_GRANTS_RECLA=
IM_PER_ITERATION;
> > > > +
> > > >    static void gnttab_handle_deferred(struct timer_list *unused)
> > > >    {
> > > > -	unsigned int nr =3D 10;
> > > > +	unsigned int nr =3D READ_ONCE(free_per_iteration);
> > > > +	const bool ignore_limit =3D nr =3D=3D 0;
> > > >    	struct deferred_entry *first =3D NULL;
> > > >    	unsigned long flags;
> > > > +	size_t freed =3D 0;
> > > >    	spin_lock_irqsave(&gnttab_list_lock, flags);
> > > > -	while (nr--) {
> > > > +	while ((ignore_limit || nr--) && !list_empty(&deferred_list)) {
> > > >    		struct deferred_entry *entry
> > > >    			=3D list_first_entry(&deferred_list,
> > > >    					   struct deferred_entry, list);
> > > > @@ -515,10 +521,13 @@ static void gnttab_handle_deferred(struct tim=
er_list *unused)
> > > >    		list_del(&entry->list);
> > > >    		spin_unlock_irqrestore(&gnttab_list_lock, flags);
> > > >    		if (_gnttab_end_foreign_access_ref(entry->ref)) {
> > > > +			uint64_t ret =3D atomic64_sub_return(1, &deferred_count);
> > > >    			put_free_entry(entry->ref);
> > > > -			pr_debug("freeing g.e. %#x (pfn %#lx)\n",
> > > > -				 entry->ref, page_to_pfn(entry->page));
> > > > +			pr_debug("freeing g.e. %#x (pfn %#lx), %llu remaining\n",
> > > > +				 entry->ref, page_to_pfn(entry->page),
> > > > +				 (unsigned long long)ret);
> > >=20
> > > I'd prefer not to issue lots of prints (being it debug or info ones) =
if the
> > > reclaim is expected to happen with a specific PV-device.
> > >=20
> > > My preferred solution would be a per-device flag, but at least you sh=
ould
> > > switch to pr_*_ratelimited(). Same applies further down.
> >=20
> > What do you mean by =E2=80=9Cper-device flag=E2=80=9D?  These grants ar=
e allocated by
> > userspace using gntalloc, so there is no PV device on which the flag
> > could be set.
>=20
> In this case the flag should relate to the file pointer used for
> gntalloc_open().

What about adding a warning if a userspace process exits without having
cleaned up all of its grants, and a module parameter that controls
whether the remaining grants are reclaimed or leaked?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--jXCcFDlqGesoyNm8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSIhzcACgkQsoi1X/+c
IsHoTQ//f0QAB6i2y+l6aMe02fFTHW/1bW6CuPrYCq7DtV4y8uhsZqEuQah+EWvS
a/Rruhq71HCIngFwj1DmQx8YYS5VLND0cRTGFZajCanWU1dTbraOxjPJ45vZmls1
K48OQTw0CAuNY1oUbeGyfwIewF7PbuAwkT47t+VaNtHKZlTe7NQ/fq9Ckpsktvv6
DtTny8JpN+xRt4daTU7wjC6io/2GPsuqikQRAKTa69k4lDNUb9Gcs4iCT3NR5I/y
Z8G+Ot7RAo4Ln2DjY6V6JDhc9AMlBf8WMQ7rkwevpRUj1QQKny/NTMq5Rcw5SYEP
MbE0Ceonm3kK6o+tOU2gg7iqC2MD76Qn8xpRqr12xv9/9MPJD529ZVAESimb0Ln8
6xTVZbCxQODOQS541nN0WbUpeov9P69vL8uSy/kneIkq1DpPmpmAjoaWLTSFPYkt
GlmOLpvRbHBZdf3AkGRa6lNEq21a7RdjMjZ8eOaDM/0Bm5HMK0/ataaGjPSoBldP
T7gKhQPB18wJOpLtCnJkcHYx4ck7dDuPNjLvVezPGDKyCYn8n11UXW/FxW2eUqi6
CEgbdQJxdeP6cN1PP6HyivC5T+pNM6ySmHc26QnGEFBcizG424rYh18AjrG8EY0q
m0pdNYldV30Yh7agtuBU2buwB/KV65NepcCRDy8gvG3/Mzdv4jg=
=nH5M
-----END PGP SIGNATURE-----

--jXCcFDlqGesoyNm8--
