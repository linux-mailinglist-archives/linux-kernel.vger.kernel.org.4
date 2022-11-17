Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0C62DE26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiKQOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbiKQOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:32:09 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC0E7723E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:32:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 50CE532010D8;
        Thu, 17 Nov 2022 09:32:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 17 Nov 2022 09:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668695524; x=
        1668781924; bh=VDHNMVouOnbd2BIm6kQ/z4TnyWsucBlyWGHOxBu8DFc=; b=E
        xXLDel3Fni8lmKAgawxSh3Z/oU3G+BKkylnFPFTNvljw2oJj5RzS1q8bnkZsyGBI
        QJaAfOorKyEC8U7vaBpmiZtXTF2Q0sC1Ngb9HSZObf7SkqYxiclVjQnFjQqOx0fp
        DWxCiOjd/3grLfgNnJDJ2H2ZQwWaicyUT/ZGv0Q5IhNijwhqoSqifVMHU9LTSCku
        1qGRPP0r1vGy102p/gelD15r232vUMXF/zBsARjAWpGp/aTkBDncBIheWZ+fNgZv
        dQzgAAMJt4mq54SR/fvqAvwpy8aUMC5rCYVTBg3Ps7Gn4uKOraU01pLOH5hbVOXs
        smx6OxgeaxDU71cFLFhDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668695524; x=1668781924; bh=VDHNMVouOnbd2BIm6kQ/z4TnyWsu
        cBlyWGHOxBu8DFc=; b=lyK9mBhvya9ZvHyklUFqMDr5JZTcBk3uqUDidtaFZDnZ
        hqzLy5dnc9xJUQrmsni0UNCUo5k5E6jr6DTtq0nSD98qlP+r3LCiHD23uIoykxbo
        jD/0Dp4/jj5Zfs7aL+xfpuMwHPFf7CEuFOTgxzCv1pNPyvbqUGcctrI4NNZrjcqs
        hiA0WQ2rt0oQbXXkhoXj7rvuKs56gLLLYA+VG/LL6NIDQ4QL2b09pirYcrTYQ0lg
        EbDAJ/LnRQoC6gp3mz961h5+XWOhn54bDSJLtVjko0DNBVRi1OykYmRyCf/HIWEj
        POxo1vlvnmIrKie2ZeL+c8vLglcduSppGxcKCKkp7Q==
X-ME-Sender: <xms:5EV2Y_2QZ__lBIFZs3aiIHAqfpu8yIQzRK1k_GFd3wMgja91lqwJlA>
    <xme:5EV2Y-EljiKyauXwpfx020n7bggFDq3Bi_-slkl6lRizV27cLIMoWRxFQfjLx1dAl
    k7TpqApYTv4CQ>
X-ME-Received: <xmr:5EV2Y_6eWm2sLvsL_0TFoXLmEdMKv4p0mjjyFRVYfJAsAXDN7VXvnSXmIlNuQX3zl6BlmBYd30GvGt5GRsUopOjG4cr3gpVMtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:5EV2Y01SeRU-3CoF6SUIfeCBRgTT9XoIVVt_d5mauVV7QGDFM8Pulw>
    <xmx:5EV2YyH92AUcSkJIkSUCud9HsGVLkEIdljZxhDwd9FhiXSdvP_DD3Q>
    <xmx:5EV2Y18JIuon_7ETKB21Y-XkRu26GxPouP0Yia4LLNMLHVfvsHi_3Q>
    <xmx:5EV2Y-g9Gb9xQNHpnSCRTW45FMe4QeKpx4eEJzNDh6t4q1WDVFYsmA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 09:32:03 -0500 (EST)
Date:   Thu, 17 Nov 2022 15:32:00 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, David Vrabel <dvrabel@cantab.net>
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL
 bit is cleared
Message-ID: <Y3ZF4EcD/c7Q5yHb@mail-itl>
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
 <0afe3f35-1b25-d1c6-89bb-8dae7a4070e9@cantab.net>
 <Y3YzY0aUc42cQGk/@mail-itl>
 <a84234d8-9f48-4b8f-e171-599c34840581@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hsWQDkJqLvEsIMcB"
Content-Disposition: inline
In-Reply-To: <a84234d8-9f48-4b8f-e171-599c34840581@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hsWQDkJqLvEsIMcB
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Nov 2022 15:32:00 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>,
	David Vrabel <dvrabel@cantab.net>
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL
 bit is cleared

On Thu, Nov 17, 2022 at 02:33:16PM +0100, Jan Beulich wrote:
> On 17.11.2022 14:13, Marek Marczykowski-G=C3=B3recki wrote:
> > On Thu, Nov 17, 2022 at 12:54:51PM +0000, David Vrabel wrote:
> >> On 17/11/2022 11:41, Marek Marczykowski-G=C3=B3recki wrote:
> >>> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked unt=
il
> >>> the table is filled. Then it disables INTx just before clearing MASKA=
LL
> >>> bit. Currently this approach is rejected by xen-pciback.
> >>> Allow setting PCI_MSIX_FLAGS_ENABLE while INTx is still enabled as lo=
ng
> >>> as PCI_MSIX_FLAGS_MASKALL is set too.
> >>
> >> The use of MSI-X interrupts is conditional on only the MSI-X Enable bi=
t.
> >> Setting MSI-X Enable effectively overrides the Interrupt Disable bit i=
n the
> >> Command register.
> >=20
> > That means the second chunk of the patch may even drop the '(new_value &
> > PCI_MSIX_FLAGS_MASKALL)' part, right?=20
> >=20
> >> PCIe 6.0.1 section 7.7.2.2. "MSI-X Enable ... is prohibited from using=
 INTx
> >> interrupts (if implemented)." And there is similar wording for MSI Ena=
ble.
> >=20
> > And this would mean the 'field_config->int_type =3D=3D INTERRUPT_TYPE_M=
SIX'
> > part isn't necessary either.
> >=20
> > Jan in another thread pointed out that disabling INTx explicitly is
> > still a useful workaround for a flawed hardware. But if that isn't
> > mandated by the spec, maybe it doesn't need to be enforced by pciback
> > either?
>=20
> Well, allowing a device to go into a mode exhibiting undefined behavior
> is what we ought to prevent when it comes to a DomU doing so vs overall
> host safety.

If the spec prohibits using INTx if MSI/MSI-X is enabled (regardless of
PCI_COMMAND_INTX_DISABLE bit), then well-behaving device should be fine
(we aren't hitting undefined behavior). As for buggy device, it wouldn't
be much different from a device ignoring PCI_COMMAND_INTX_DISABLE
completely, no (besides the latter being probably much less probable
bug)?
If the above is assumption is correct, it seems such device may not
function correctly without extra workarounds (which are in the driver
interest to apply), but should not affect overall host safety (as in:
beyond the guest having that device assigned). I think pciback should
only enforce what's necessary to prevent one guest hurting others (or
the hypervisor), but it doesn't need to prevent guest hurting itself.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--hsWQDkJqLvEsIMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmN2ReEACgkQ24/THMrX
1yzzUQf/fRtFToxRDSo67Ei2SnzYd3QNLi4bA/SAL/6aFptPOlDlc9x5/3vcxPdP
9XXxKSV8XCpz1Ujxbq8jc2F04SBoQOblw8gOvxXzxLx8OF7r0wslheBBKCnd9p4L
K75QUIBMp7FPdG5zZNlE0uEeDZXfZQEQWUe3ZkI3DwQEA0pNge2TQcFboJYCgo7u
jFKA2HUoGKdIHXyOrq32dQA3MIQHGbKuOlh7amutgfjSGVHhf7mKWlicmrac1Xvg
J51tmZU6hTUm/XXN9/NHqVCcPpC+umlxfAWi6wDcsUrS4upTT36fh3XWD3PO6twk
XYA18LE0FTW2NIsUbImeFTak0mp2tw==
=ahAp
-----END PGP SIGNATURE-----

--hsWQDkJqLvEsIMcB--
