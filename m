Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C310C62FF94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiKRVqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKRVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:46:41 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DE85165
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:46:40 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8CDB332008FF;
        Fri, 18 Nov 2022 16:46:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 18 Nov 2022 16:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668807999; x=
        1668894399; bh=m0qim5xloUqSWCBLe4PKp9y/XJvQoCDrt2G9AYpaGa8=; b=p
        vQtOjvp0f4uVWQ650FLODz+Gchx4RTWFrmCorFUs3dg/qF1gR1GReNAOvbbDfj05
        RLwzicAWmcn8mGNWcF3IAvcG5gW9LYpPqHENDYbnMbklMCg9hXlPB07IShrVMIcX
        qC7s5++ppkM7TXGOiLqX+KV6BvmK/Hroty8SKb28aiPCpVOyDl74w9mW7ewvdd2r
        Vw10DJMI23PS/hxi6FugyCWCt9ME9jVw7uMof2mx28V7jH+WEiiBxHs9XjCkga6J
        o6rGfCN2BHTJFe9ipcfRsR4FGQJ1cMEn4hw7F28f3jzxL/DJmycnDxOMjoBGrH22
        bIG3ymvM9l7kaTbHKlQPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668807999; x=1668894399; bh=m0qim5xloUqSWCBLe4PKp9y/XJvQ
        oCDrt2G9AYpaGa8=; b=L2OjdpMEGbpYn5RluyOLgAEawWRJnDxcYx09A1H0V3vG
        UVaNQojhYS6LC/+PuhmaXch59rbf6FjYJ7jVNQAPA74IHXP2nPD7qB7RzQCUrS+C
        d70ucOla/rdJ+hz/SB5uxohfTGMD4vuHfWC01frMuTFsu2/GUEU5qr4gtTK88Lzf
        qiPwZ1G95xVVAqey4X+ZkaKSWS8q/Iex2YywB1s3SOFs0pD9pTBADlx/e/Rxngfh
        FUqpuRvwHBH5PlTTGjbS/2vGFKQjdllSlRS1ezGpImRXeOwDoQRT4nuMKks1MdYn
        zHA/rcTIbE3Lhps863FnqszHU8wSv2PZ5X99AMS7FA==
X-ME-Sender: <xms:Pv13Y2BSVW7FH2Dd-O5P3KMtPxNXHCirpVY40CKB6SZ-elgpiIGK-A>
    <xme:Pv13YwhvzBrq5W8pQRmdzoa9L7YI9va2F3vECYPbCPCk66ZGpyioE6NMAQN8GjuJ2
    WwiHjJOmVdNiw>
X-ME-Received: <xmr:Pv13Y5nOjFdBd47nFs7geRsHUOEqE51wnLKmaFXWAuA7WK4gB6NJ-syQWb_m_-2Ejf9eaTwoUmj5Bu-b8mQ487PKMwH9oql_EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepueek
    teetgefggfekudehteegieeljeejieeihfejgeevhfetgffgteeuteetueetnecuffhomh
    grihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhm
X-ME-Proxy: <xmx:Pv13Y0zZgDAzIvV9kP25qNbzIqAIVD4P3LHbtRde5xkUSs1_uTldAg>
    <xmx:Pv13Y7SRauCLnSXdbtmWYVm1VNplMzubcAINVCqgDI538NasB2RmhA>
    <xmx:Pv13Y_ZdHjesRLy7pFixTt52MxbmjRRQG64zyRA5yBaRUYgfRQ6hYA>
    <xmx:P_13Y5NKSqvqRzVCNTa0n6wrQSqWVltzkWQ_EwuIQ1QVOrBZeRbnIQ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 16:46:37 -0500 (EST)
Date:   Fri, 18 Nov 2022 22:46:34 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <Y3f9O0S8kVXZ+py+@mail-itl>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qQdthczOYgb16K95"
Content-Disposition: inline
In-Reply-To: <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qQdthczOYgb16K95
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 22:46:34 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <jbeulich@suse.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled

On Fri, Nov 18, 2022 at 03:46:47PM -0500, Jason Andryuk wrote:
> On Fri, Nov 18, 2022 at 10:50 AM Marek Marczykowski-G=C3=B3recki
> <marmarek@invisiblethingslab.com> wrote:
> >
> > Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> > the table is filled. Then it disables INTx just before clearing MASKALL
> > bit. Currently this approach is rejected by xen-pciback.
> > According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> > enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).
> >
> > Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
> > applies to three places:
> >  - checking currently enabled interrupts type,
> >  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
> >  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
> >    enabled, as device should consider INTx disabled anyway in that case
> >
> > Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL=
 too")
> > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblething=
slab.com>
> > ---
> > Changes in v3:
> >  - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
> >    with enabling MSI/MSI-X
> > Changes in v2:
> >  - restructure the patch to consider not only MASKALL bit, but enabling
> >    MSI/MSI-X generally, without explicitly disabling INTx first
> > ---
>=20
> I was trying to test your xen-pciback v3 patch, and I am having
> assignment fail consistently now.  It is actually failing to
> quarantine to domIO in the first place, which matches the failure from
> the other day (when I more carefully read through the logs).  It now
> consistently fails to quarantine on every boot unlike the other day
> where it happened once.

Does this include the very first assignment too, or only after domain
reboot? If the latter, maybe some cleanup missed clearing MASKALL?

FWIW, the patch applied to Qubes
(https://github.com/QubesOS/qubes-linux-kernel/pull/680) seems to work
fine (the full test run is still in progress, but I see some green marks
already).

> I added some printks and it 's getting -EBUSY from pdev_msix_assign()
> which means pci_reset_msix_state() is failing:
>     if ( pci_conf_read16(pdev->sbdf, msix_control_reg(pos)) &
>          PCI_MSIX_FLAGS_MASKALL )
>         return -EBUSY;
>=20
> # lspci -vv -s 14.3
> ...
>     Capabilities: [80] MSI-X: Enable- Count=3D16 Masked+
>         Vector table: BAR=3D0 offset=3D00002000
>         PBA: BAR=3D0 offset=3D00003000
>=20
> So it looks like MASKALL is set and prevents assignment.
>=20
> setpci -s 00:14.3 82.W=3Df
> cleared that out for me and I could assign the device.
>=20
> My dom0 boots, it runs flask-label-pci for a set of PCI devices
> (including iwlwifi), then xl pci-assignable-add for all PCI devices
> which will be passed through, then a little later it boots the
> associated domains.  Dom0 does not have a driver for iwlwifi.
>=20
> I'll have to investigate more to see how MASKALL is getting set.  This
> had not been an issue before your recent patches.

I guess before the patches nothing set anything in MSI-X capability,
because it was hidden...

Anyway, to support my cleanup hypothesis, I tried to destroy a
PCI-having domain, and it left MSI-X enabled (at least according to the
config space). MASKALL was _not_ set, but I haven't checked masking of
individual vectors. TBH, I'm not sure what should be responsible for the
MSI-X cleanup after guest destroy. Should it be Xen? Qemu? Pciback?
Pciback calls PHYSDEVOP_{prepare,release}_msix only when
binding/unbinding from the device (so - xl pci-assignable-{add,remove}),
so this isn't the right place.
Should that be in Xen, in deassign_device() (part of
DOMCTL_deassign_device)?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--qQdthczOYgb16K95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmN3/TsACgkQ24/THMrX
1ywkSQf/aTohVS7nA2ExCmuvEVfy/hGZ6deH7uoh3uApGTOhNEmD+ImNzRDDwDW9
vK7MAeJnE9zBQq4zklTd/DiktxefRu6X8HGTklrI8sZ8qjq92NYZF4Vul/g7/+l6
4XGi6dNdvN5P7e7TUTHI49rtBrvfA51DCuW9SLJTvI5RAXXRbLan8luGij51/TWH
TsxfNPJ+fX0pWr/G9ynnSeBUJzw+BcBAwj4FaMPkWaOvl0wDK98lspRTrXIJ7Usw
nzbgnNqwkAbQ+E/s1eSDnw1BQxDXcFxM6orO6fP/ntFSIpIbHmLesV3erYumLYLf
/O8lcstVWu7jFOXtQMBMoc2sYJh92A==
=m44E
-----END PGP SIGNATURE-----

--qQdthczOYgb16K95--
