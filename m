Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612AF5F7C43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJGRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:32:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE9BC44E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:32:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 044565C00D5;
        Fri,  7 Oct 2022 13:32:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665163919; x=
        1665250319; bh=UFRh/83Bkh5gjHTT0p6dZH9JJ3M4HOjeJ6B4cYvrhrU=; b=x
        JRXamX7rJ3U167b4EqfJtDn9oSxz6iIfwCjun7OK2y6b+Jxqe/+13ET8/8Qju8En
        QX25W6qvCxmVMca695HWptF03Hr90jAvqFydH5gz/uOX57KGsctTEoeY0gbi2waZ
        jcMxLrtVjcMaZICZl2qYsCRG2EOmUg+K11jCcHz6R7+glenkiXLboRgToB5El6GO
        UsvExncbEwPetXQ53sbYfkQEYO5bsXo6mJ4vdUFQmLWAm1jzclbYErsD1jK++jQv
        7gUHQAedv1OS9bbvYyM4WTRMFwPpQgYo5JRBg1rnNmSMZPFCMsjwGaqtbHmIeWV5
        U+Yfv9/FCyX1qJZmLSq1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665163919; x=1665250319; bh=UFRh/83Bkh5gjHTT0p6dZH9JJ3M4
        HOjeJ6B4cYvrhrU=; b=FQyCX8fwgbZdgJNBzd5bnpwXX0PnA/hIkbwQDwUHV2yd
        82Gk6y7ieS+Wj+s3v65gwq+zRIe5z9hlcm1LpaTYItjmn73ebs+GVcwWJxiR/mmb
        Sx5N/23MJnmgq50v3j4rKsb3msM9pQfjJ70QBDVytR6YkuWpH2hSu/taDvm8CS3A
        3ugEhMIeDHKaJWpVycfw75r2VWP0FFY6HUsrBFAHEwVRQtBa4z8IftvsUg2TqQUZ
        znmM07TLEbYKXWlObVsDy95R54oAQau4ZZL+khqI8pgtunFXVn2zyDTRtJ8TsoY8
        LC4QFxFPaABGtIgU+uy+mr3Wubg8GNzyffzlMrvKiQ==
X-ME-Sender: <xms:j2JAYz__eb26N6woZ7JP8w9oSaoIEKlJMeR_SRQyQ136_TC66XfyzQ>
    <xme:j2JAY_tjToDfHD3WC0a2aNs9labvQsdy1RMpFvOvh4JwsEq9FyP3PdZ6beoE_lnus
    lSrkIlhtYIKBps>
X-ME-Received: <xmr:j2JAYxBs-NsUahAfR6a0KCGWOcWIs2-KIThP_Pn1TWgSK_b_rNushYAR5Ati>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeekteegiefhteehffegvdeggeej
    udelleeltdffveevtdetfeejuefgieeuhfeuleenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    uggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:j2JAY_fOf52dLvqa7MBlVVkZcPs8JbyPLHifBw50ao1c75zjyvwPCg>
    <xmx:j2JAY4PNVB0VTZ3HQhye0YQeg4BaDctVCR2nW4BG9PNrzHkMUvYpLg>
    <xmx:j2JAYxnPaT156m7jJyRc5C7Ypq0BlMzgl0lvgfVD9zCZTkngbmadYw>
    <xmx:j2JAY1oe3O0nreGAxgCVAKWRoMzFMkkXxofuHjlGgWyz7C22BWlR5Q>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Oct 2022 13:31:58 -0400 (EDT)
Date:   Fri, 7 Oct 2022 13:31:54 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/2] xen/gntdev: Fixes for leaks and VMA splitting
Message-ID: <Y0BijRE6/gdBr9Bn@itl-email>
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <9aa1e6ba-a153-8dfa-ce28-3ab78b26c6e4@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icHkrWgI+wqJhboV"
Content-Disposition: inline
In-Reply-To: <9aa1e6ba-a153-8dfa-ce28-3ab78b26c6e4@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--icHkrWgI+wqJhboV
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 7 Oct 2022 13:31:54 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>, "M. Vefa Bicakci" <m.v.b@runbox.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/2] xen/gntdev: Fixes for leaks and VMA splitting

On Fri, Oct 07, 2022 at 07:17:41AM +0200, Juergen Gross wrote:
> On 03.10.22 00:20, M. Vefa Bicakci wrote:
> > Hi all,
> >=20
> > First of all, sorry for the delay!
> >=20
> > These patches continue the code review for the following patches:
> >    https://lore.kernel.org/xen-devel/20220912040002.198191-1-m.v.b@runb=
ox.com/t/#u
> >=20
> > The original description of the patch set is as follows:
> >=20
> >    "The changes in this patch series intend to fix the Xen grant device
> >    driver, so that grant mapping leaks caused by partially failed grant
> >    mapping operations are avoided with the first patch, and so that the
> >    splitting of VMAs does not result in incorrectly unmapped grant pages
> >    with the second patch. The second patch also prevents a similar issue
> >    in a double-mapping scenario, where mmap() is used with MAP_FIXED to
> >    map grants over an existing mapping created with the same grants, and
> >    where grant pages are unmapped incorrectly as well."
> >=20
> > A summary of the changes from v1 is as follows:
> > - Addressed Juergen's code review comment regarding the first patch.
> > - Amended the description of the second patch to note that the described
> >    issues are encountered with PV domains.
> >=20
> > Verification notes:
> >=20
> > - I have tested these commits on top of Linux v5.15.70 and v5.15.71, and
> >    I verified that they compile successfully on top of the tag
> >    "next-20220930", which corresponds to the base commit ID included at
> >    the bottom of this e-mail.
> >=20
> > - My tests consist of using a kernel with Qubes OS v4.1's patches and
> >    these patches on my main computer for day-to-day tasks, in conjuncti=
on
> >    with Qubes OS's version of the Xen hypervisor v4.14.5, with the latt=
er
> >    custom-compiled with CONFIG_DEBUG.
> >=20
> > - I used a test program that verifies the following scenarios with an
> >    unprivileged paravirtualized (PV) Xen domain:
> >=20
> >    - A program mmap()s two pages from another Xen domain and munmap()s
> >      the pages one by one. This used to result in implicit unmap errors
> >      to be reported by Xen and a general protection fault to be trigger=
ed
> >      by Xen in the affected domain, but now works as expected.
> >    - A program mmap()s two pages from another Xen domain and then
> >      attempts to remap (via MAP_FIXED) the same mapping again over the
> >      same virtual address. This used to result in similar issues
> >      (implicit unmap errors and general protection fault), but now is
> >      rejected by the kernel.
> >    - A program mmap()s two pages from another Xen domain and then
> >      attempts to mmap() the same mapping again to a different virtual
> >      address, by passing NULL as mmap()'s first argument. This used to =
be
> >      rejected by the kernel, and it continues to be rejected by the
> >      kernel.
> >=20
> > - Unprivileged PVH Xen domains were also sanity tested with the same
> >    test program. I should note that PVH domains worked as expected
> >    without these patches too.
> >=20
> > - Finally, I have verified that the original "g.e. 0x1234 still pending"
> >    issue does not appear after rapidly resizing GUI windows in Qubes OS
> >    v4.1.
>=20
> Series pushed to xen/tip.git for-linus-6.1

Thanks!
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--icHkrWgI+wqJhboV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmNAYowACgkQsoi1X/+c
IsET/A//T7lUkkW0Asz4OA/e1UJcpTOuhv17BLYolj8QuDkNfiWix8EXsVX+BfkE
ok4HZW4qD6mYB3OzO0NjweeGQt7I1JtAxCu8uwlHA93f3vqRwntr/Cch7tDqloZ7
0P4YbGiyCzmCB3bsD6bh2AqsFO6uH0bIegiYOMLnXGcpDdQiiJx+wJ62LFqfW1A7
YkW3P0t6bDBFT90WBMy4v0apS4culhw5VOnLE6EIklj+xhSfZoags77z/Ua+Dg9w
blQAaS+bF4Evatf2ZwE/nfYGlPrbPYWRjh9T9kAyFO3PcwrppV1EiDLjM19lK8Vo
57DfdSpHBAmpFTLt4GFJyNf/AoB/jOlpw4LuVpLqgPVrWw17eEHNz7amK9bILJzo
3Y5R1xckDNg0rHyiVD+Vr27CSLadcCn6DSdnSuGOk3sT5iGaci8FGv3NRtOODS9J
MaiM7FyH4D7ttjrz+agrSFk/1/a2cbBKMAwBPy0qglfv8C/Alm11gZCojjFWxSAZ
O6gTN/MgbI7FUeYWX0fv9y6SzUurXG5lfxyTCQCSiECCnFbmuwBOa2W+br24AAgq
oKB38+t5Ax6ObXheQBMFhOm1WsD7Zln5YHLRWgC3Wu9ZSx836a1tey0oFJ5VNzrH
Y2M3ETghA702QUsZiBZX2wH38n+ttptCJotAvIh3bJv5ePia3ac=
=6gwm
-----END PGP SIGNATURE-----

--icHkrWgI+wqJhboV--
