Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E872D037
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjFLUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjFLUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:09:53 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75B7107;
        Mon, 12 Jun 2023 13:09:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BA5D5C00EF;
        Mon, 12 Jun 2023 16:09:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 12 Jun 2023 16:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686600590; x=1686686990; bh=w4PC2hcyqKw9l+AT+MtdSBx+TgTVoNSCI4D
        kMzt4z5s=; b=jdl26A0DE5l2x90+ua4kXg7pGubgakMq2isPOTpVZdrLGHMj1e2
        sDxH+41Yp2Lrod1/dcaUeNaxVKXAWUN1aJgnW329YTyOkNlCqpYBjR6aZHd7wNfG
        Wh6/4AsYdK7paw2JRrEKjJ+F630O2Y8RflIlAQSLn1/5s9wXRIF6wkXcwx6vLRrW
        2jv6XE0jZ62BMAqB/7Uhpjx825fIoLAcFa5W+PVHsJJSOqVBcPApF+2rfasO35gz
        skkrBJeKGextTviMcNlBv+hZu2KyK67PDw8fbfPdWnIEMZAP8peoD9crQmQK/5qA
        ImVQ7Ij2ryt8m9EZm2wwb+HwrVQGK204xPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686600590; x=1686686990; bh=w4PC2hcyqKw9l
        +AT+MtdSBx+TgTVoNSCI4DkMzt4z5s=; b=IAvEN0O/HamDP+V/Pw5Jz8zuFNxQC
        NYco3bA7tpdhF8MnBB2naxS4Gmk9oGjf8eV4qFvndL9XWfF/ljXbvOHeSgdmbaTX
        MyIFkV67wxpxPSlIG6WyNMBZDeSYGExJR/hQOgLt8pzdovd52kxQo2G6hJZKg1sW
        JijfcJFqtqdS7QLAqfNwi7jqvkCzRtUPHF1/Vf7xqI4s1lHEzDUAez5Mm0YDBqrS
        9uy+W8afIQa2qH7usVudySG+pTAxFc1nd7ulZEMQFEkQJiBgC98urLCKB4m4X0lU
        nsA7mm30YNga7g7bdnsE0IICt5yX1gC2KVpUryjjGJ/+TvI3JP9CmhM5Q==
X-ME-Sender: <xms:jXuHZHakA9FlcgaMsbqisYKzYOD5MmCOAMv0Pq6UYJGk9zrG91LnIw>
    <xme:jXuHZGYmDX0VLI-DuBLBz-3OaNQikdjCFDW9vG9oWD3yQd2N-VTZ0f_mcrJyCEX9P
    HfXZf2i9Hym-X4>
X-ME-Received: <xmr:jXuHZJ9VgeDxs5GwuZ-o3HQLiZFQaCNDGwVHXTBoFoxUKARA1KAmST67u8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:jXuHZNq6dd8EijI-AoPdO2YUg9slvrUp-lVDxy20uG79FH3fJoe5Bw>
    <xmx:jXuHZCovPHRhodmrNmClPZMJtRx6wE5iMUkLnpdHeCAVSbz7XCa8kw>
    <xmx:jXuHZDRtnvercilt6-MGQIrHNQ_FtCM0ur7Tl3rzzUnhCfsqj6pSGw>
    <xmx:jnuHZPBUofbrGfwCyfag-NczP1ijuWGj4_yqcb3aS1Ay2pJU-7QFeQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 16:09:49 -0400 (EDT)
Date:   Mon, 12 Jun 2023 16:09:44 -0400
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
Message-ID: <ZId7ixbqlCSygtvb@itl-email>
References: <20230610153232.1859-1-demi@invisiblethingslab.com>
 <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JO1X+NAnjhRPpHa5"
Content-Disposition: inline
In-Reply-To: <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JO1X+NAnjhRPpHa5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 16:09:44 -0400
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

On Mon, Jun 12, 2023 at 08:27:59AM +0200, Juergen Gross wrote:
> On 10.06.23 17:32, Demi Marie Obenour wrote:
> > When a grant entry is still in use by the remote domain, Linux must put
> > it on a deferred list.
>=20
> This lacks quite some context.
>=20
> The main problem is related to the grant not having been unmapped after
> the end of a request, but the side granting the access is assuming this
> should be the case.

The GUI agent has relied on deferred grant reclaim for as long as it has
existed.  One could argue that doing so means that the agent is misusing
gntalloc, but this is not documented anywhere.  A better fix would be to
use IOCTL_GNTDEV_SET_UNMAP_NOTIFY in the GUI daemon.

> In general this means that the two sides implementing the protocol don't
> agree how it should work, or that the protocol itself has a flaw.

What would a better solution be?  This is going to be particularly
tricky with Wayland, as the wl_shm protocol makes absolutely no
guarantees that compositors will promptly release the mapping and
provides no way whatsoever for Wayland clients to know when this has
happened.  Relying on an LD_PRELOAD hack is not sustainable.

> > Normally, this list is very short, because
> > the PV network and block protocols expect the backend to unmap the grant
> > first.
>=20
> Normally the list is just empty. Only in very rare cases like premature
> PV frontend module unloading it is expected to see cases of deferred
> grant reclaims.

In the case of a system using only properly-designed PV protocols
implemented in kernel mode I agree.  However, both libxenvchan and the
Qubes GUI protocol are implemented in user mode and this means that if
the frontend process (the one that uses gntalloc) crashes, deferred
grant reclaims will occur.  Worse, it is possible for the domain to use
the grant in a PV protocol.  If the PV backend driver then maps and
unmaps the grant and then tells the frontend driver to reclaim it, but
the backend userspace process (the one using gntdev) maps it before the
frontend does reclaim it, the frontend will think the backend is trying
to exploit XSA-396 and freeze the connection.

> > However, Qubes OS's GUI protocol is subject to the constraints
> > of the X Window System, and as such winds up with the frontend unmapping
> > the window first.  As a result, the list can grow very large, resulting
> > in a massive memory leak and eventual VM freeze.
>=20
> I do understand that it is difficult to change the protocol and/or
> behavior after the fact, or that performance considerations are in the
> way of doing so.

Would the correct fix be to use IOCTL_GNTDEV_SET_UNMAP_NOTIFY?  That
would require that the agent either create a new event channel for each
window or maintain a pool of event channels, but that should be doable.
This still does not solve the problem of the frontend exiting
unexpectedly, though.

> > To partially solve this problem, make the number of entries that the VM
> > will attempt to free at each iteration tunable.  The default is still
> > 10, but it can be overridden at compile-time (via Kconfig), boot-time
> > (via a kernel command-line option), or runtime (via sysfs).
>=20
> Is there really a need to have another Kconfig option for this? AFAICS
> only QubesOS is affected by the problem you are trying to solve. I don't
> see why you can't use the command-line option or sysfs node to set the
> higher reclaim batch size.

Fair.  In practice, Qubes OS will need to use the sysfs node, since
the other two do not work with in-VM kernels.

> > Fixes: 569ca5b3f94c ("xen/gnttab: add deferred freeing logic")
>=20
> I don't think this "Fixes:" tag is appropriate. The mentioned commit didn=
't
> have a bug. You are adding new functionality on top of it.

I=E2=80=99ll drop the "Fixes:" tag, but I will keep the "Cc: stable@vger.ke=
rnel.org"
as I believe this patch meets the following criterion for stable
backport (from Documentation/process/stable-kernel-rules.rst):

    Serious issues as reported by a user of a distribution kernel may also
    be considered if they fix a notable performance or interactivity issue.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> >   drivers/xen/Kconfig       | 12 ++++++++++++
> >   drivers/xen/grant-table.c | 40 ++++++++++++++++++++++++++++-----------
> >   2 files changed, 41 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index d5d7c402b65112b8592ba10bd3fd1732c26b771e..8f96e1359eb102d6420775b=
66e7805004a4ce9fe 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -65,6 +65,18 @@ config XEN_MEMORY_HOTPLUG_LIMIT
> >   	  This value is used to allocate enough space in internal
> >   	  tables needed for physical memory administration.
> > +config XEN_GRANTS_RECLAIM_PER_ITERATION
> > +	int "Default number of grant entries to reclaim per iteration"
> > +	default 10
> > +	range 10 4294967295
> > +	help
> > +	  This sets the default value for the grant_table.free_per_iteration
> > +	  kernel command line option, which sets the number of grants that
> > +	  Linux will try to reclaim at once.  The default is 10, but
> > +	  workloads that make heavy use of gntalloc will likely want to
> > +	  increase this.  The current value can be accessed and/or modified
> > +	  via /sys/module/grant_table/parameters/free_per_iteration.
> > +
>=20
> Apart from the fact that I don't like adding a new Kconfig option, the he=
lp
> text is not telling the true story. Heavy use of gntalloc isn't to blame,=
 but
> the fact that your PV-device implementation is based on the reclaim
> functionality. TBH, someone not familiar with the grant reclaim will have=
 no
> chance to select a sensible value based on your help text.

That=E2=80=99s a good point.  Qubes OS will need to use the sysfs value any=
way
in order to support in-VM kernels, so the Kconfig option is not really
useful.

> >   config XEN_SCRUB_PAGES_DEFAULT
> >   	bool "Scrub pages before returning them to system by default"
> >   	depends on XEN_BALLOON
> > diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> > index e1ec725c2819d4d5dede063eb00d86a6d52944c0..fa666aa6abc3e786dddc94f=
895641505ec0b23d8 100644
> > --- a/drivers/xen/grant-table.c
> > +++ b/drivers/xen/grant-table.c
> > @@ -498,14 +498,20 @@ static LIST_HEAD(deferred_list);
> >   static void gnttab_handle_deferred(struct timer_list *);
> >   static DEFINE_TIMER(deferred_timer, gnttab_handle_deferred);
> > +static atomic64_t deferred_count;
> > +static atomic64_t leaked_count;
> > +static unsigned int free_per_iteration =3D CONFIG_XEN_GRANTS_RECLAIM_P=
ER_ITERATION;
> > +
> >   static void gnttab_handle_deferred(struct timer_list *unused)
> >   {
> > -	unsigned int nr =3D 10;
> > +	unsigned int nr =3D READ_ONCE(free_per_iteration);
> > +	const bool ignore_limit =3D nr =3D=3D 0;
> >   	struct deferred_entry *first =3D NULL;
> >   	unsigned long flags;
> > +	size_t freed =3D 0;
> >   	spin_lock_irqsave(&gnttab_list_lock, flags);
> > -	while (nr--) {
> > +	while ((ignore_limit || nr--) && !list_empty(&deferred_list)) {
> >   		struct deferred_entry *entry
> >   			=3D list_first_entry(&deferred_list,
> >   					   struct deferred_entry, list);
> > @@ -515,10 +521,13 @@ static void gnttab_handle_deferred(struct timer_l=
ist *unused)
> >   		list_del(&entry->list);
> >   		spin_unlock_irqrestore(&gnttab_list_lock, flags);
> >   		if (_gnttab_end_foreign_access_ref(entry->ref)) {
> > +			uint64_t ret =3D atomic64_sub_return(1, &deferred_count);
> >   			put_free_entry(entry->ref);
> > -			pr_debug("freeing g.e. %#x (pfn %#lx)\n",
> > -				 entry->ref, page_to_pfn(entry->page));
> > +			pr_debug("freeing g.e. %#x (pfn %#lx), %llu remaining\n",
> > +				 entry->ref, page_to_pfn(entry->page),
> > +				 (unsigned long long)ret);
>=20
> I'd prefer not to issue lots of prints (being it debug or info ones) if t=
he
> reclaim is expected to happen with a specific PV-device.
>=20
> My preferred solution would be a per-device flag, but at least you should
> switch to pr_*_ratelimited(). Same applies further down.

What do you mean by =E2=80=9Cper-device flag=E2=80=9D?  These grants are al=
located by
userspace using gntalloc, so there is no PV device on which the flag
could be set.

> >   			put_page(entry->page);
> > +			freed++;
> >   			kfree(entry);
> >   			entry =3D NULL;
> >   		} else {
> > @@ -530,21 +539,22 @@ static void gnttab_handle_deferred(struct timer_l=
ist *unused)
> >   		spin_lock_irqsave(&gnttab_list_lock, flags);
> >   		if (entry)
> >   			list_add_tail(&entry->list, &deferred_list);
> > -		else if (list_empty(&deferred_list))
> > -			break;
> >   	}
> > -	if (!list_empty(&deferred_list) && !timer_pending(&deferred_timer)) {
> > +	if (list_empty(&deferred_list))
> > +		WARN_ON(atomic64_read(&deferred_count));
> > +	else if (!timer_pending(&deferred_timer)) {
> >   		deferred_timer.expires =3D jiffies + HZ;
> >   		add_timer(&deferred_timer);
> >   	}
> >   	spin_unlock_irqrestore(&gnttab_list_lock, flags);
> > +	pr_debug("Freed %zu references", freed);
> >   }
> >   static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
> >   {
> >   	struct deferred_entry *entry;
> >   	gfp_t gfp =3D (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KE=
RNEL;
> > -	const char *what =3D KERN_WARNING "leaking";
> > +	uint64_t leaked, deferred;
> >   	entry =3D kmalloc(sizeof(*entry), gfp);
> >   	if (!page) {
> > @@ -567,12 +577,20 @@ static void gnttab_add_deferred(grant_ref_t ref, =
struct page *page)
> >   			add_timer(&deferred_timer);
> >   		}
> >   		spin_unlock_irqrestore(&gnttab_list_lock, flags);
> > -		what =3D KERN_DEBUG "deferring";
> > +		deferred =3D atomic64_add_return(1, &deferred_count);
> > +		leaked =3D atomic64_read(&leaked_count);
> > +		pr_debug("deferring g.e. %#x (pfn %#lx) (total deferred %llu, total =
leaked %llu)\n",
> > +			 ref, page ? page_to_pfn(page) : -1, deferred, leaked);
> > +	} else {
> > +		deferred =3D atomic64_read(&deferred_count);
> > +		leaked =3D atomic64_add_return(1, &leaked_count);
> > +		pr_warn("leaking g.e. %#x (pfn %#lx) (total deferred %llu, total lea=
ked %llu)\n",
> > +			ref, page ? page_to_pfn(page) : -1, deferred, leaked);
> >   	}
> > -	printk("%s g.e. %#x (pfn %#lx)\n",
> > -	       what, ref, page ? page_to_pfn(page) : -1);
> >   }
> > +module_param(free_per_iteration, uint, 0600);
> > +
>=20
> Could you please move the parameter definition closer to the related
> variable definition?

Will fix in the next version.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--JO1X+NAnjhRPpHa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSHe4wACgkQsoi1X/+c
IsHOxA/+Opak4BIZx8LtC0pNIOfHOaiSQpa3+u9k+ZVT+XK8aOlq0O4/Xls4NOED
adAuJYptDhGpvUvfvo4AKKXmYQNintguTaCKsXgU8v/cXkiQ8uGLszG6FxX/aDh8
fI22EloLk6rCB+WvmKrcqqmSl8yzruKFp3GrZgSjWZhYGrYydgJlrLC7jNCSyMl1
U6sws4V5bkpeL5Y0/7vmy8AEwUJmxLwRI82X1MwDtrpki9yeMGdAPEgTi3OudViD
856lLdxavipFsjQmNkcw40xUPtADG2RcP1sgMp2Qsai447XOehGEG8RRyQ/sNU0d
016EiDRQxuWlhdViD4P+VEOnKmKgrPOdpzQc1ISJ03xMDuKhK3Eo8dEgenuDlMRr
SMXd7yHb6gxHW1gZtbH0D9PIMyT5U0pAHQT1VY084HZZahKdoHfnesQSB5eQjjuB
Wy7gzIhEQci4g8xdJxkxzazjCildaJv4pDqATxLIi+Qw6LQQtwT7+0cxU6IuFiVy
PZ15jLTlo/R4B12XtXaJnDvswZdAXm2Sx780Dpf3ptQpYauOnJsAkeKDXFvLSJzc
PBe3IN/1m3t+eB/2u8rczZPHHrCQboG/rMzOjlRhK/0Jmi1YcitcIQS+VrJhSu7X
vAsAe598NTYGWNxYIQMZR/491qBeiapCuWwxeyEqOdoEfVm4Q7U=
=g7U9
-----END PGP SIGNATURE-----

--JO1X+NAnjhRPpHa5--
