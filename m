Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560FF62DC64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiKQNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiKQNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:13:19 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7F6D495
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:13:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ACC613200B37;
        Thu, 17 Nov 2022 08:13:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 17 Nov 2022 08:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668690792; x=
        1668777192; bh=nEhR7pMCw3FhT/lMNgCiEBfKk2fj+LcGrS37oNxSJro=; b=t
        YiS7Q2KpFt+zCX59+TZBrjYf3nUm7hq3hXo+1j8FQ3xm6WoiMN9V5Dfag6tBG9hn
        UoF3q4WD1QIUOZgkKYQB82uYsUKm037Sie+6sg8Lsv39PBoSZxAKvlc8A2O7j0ft
        gIfmdu+SQvPDO57ZMVcBDQY9UaV0m+iGPHFb7tEFC7ohunegdyD07fncHQlzMlEl
        O8SNj+va7/zco4xudc4RNh1lB2H1jLABhjSDs2Peo0XTwehLaC/Ngm2oKVhHftrQ
        Z7gds+bUnWfD0Kaq9VhgV51hz3Flg6zMUoHnFUDnQlgbI85DU/3/Z0srylLXVjPm
        xqiKIHan8hS4dvGmOuzCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668690792; x=1668777192; bh=nEhR7pMCw3FhT/lMNgCiEBfKk2fj
        +LcGrS37oNxSJro=; b=XWumqYaEWqMNBnVsg/ykzRMnmY/VHi7Ba6GO8ga97YO9
        6oIJn3AKEiB5l/hoiCUjLqbMus7TQE2TePOAoIJgPrD6D7hkbHeLnWq54hSJXqhx
        7O54uKBSwJCJABBAWQGkFDwBGozq5C0RHt5oRq9iIIUQ0InWVLP6FbYKgvEWoRc2
        uluFz+l4vAFpNURNtQjDlQf8u40cjJo2DEHnWSDj0yUwjat3rgReHGYhf04itPMK
        MkCDwczeWfw03FCDhyF+IxUaCGIenmbKTjNjGU388uWPd6G2aDCeULaDPhpUmILT
        bo02ylNhpgjGHu9d5odBcU59EhoO5ADQ1TB6AkerTA==
X-ME-Sender: <xms:ZzN2Y2opGdz6R_hTc_7f-Dg3TFLY2jPYFAurcua68Pw6wS5-VFtDTA>
    <xme:ZzN2Y0r6mbP6QXU9Ys5D1t4FjN6nUuhG6L6rJ8FbCJkKEUBoxy1py1oTDzamDCnS7
    CMHO-jJDCmlFw>
X-ME-Received: <xmr:ZzN2Y7NlBq-95DfIqHcJ952ie0-6tcQS0WJDFE3zK_EXsY2bEr_DL3diVDmU7zFYKwmgmv7MzLHFsETVBz8VUGVCGrjCQEkKdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:ZzN2Y16L_4QjBYieEgjjvB7g0WOSN_UFFotPUwuSWb6ZSLeXfHvwLg>
    <xmx:ZzN2Y16P8HITgnPaK5whWpM72mqI17Gf0B1TMT-zMnC-W2bHDTFfZA>
    <xmx:ZzN2Y1gbykADqoZhfnq5kNlLbspZLnVjCElPR0OC6xKOBVSs0Oxm5A>
    <xmx:aDN2Y41WBfKL2Lv9zQqLXIJ25-uFH8kxqFA8j98rqadyYVVMEDyBrA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 08:13:10 -0500 (EST)
Date:   Thu, 17 Nov 2022 14:13:04 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     David Vrabel <dvrabel@cantab.net>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL
 bit is cleared
Message-ID: <Y3YzY0aUc42cQGk/@mail-itl>
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
 <0afe3f35-1b25-d1c6-89bb-8dae7a4070e9@cantab.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QOL0n3NG2/pM9Yw2"
Content-Disposition: inline
In-Reply-To: <0afe3f35-1b25-d1c6-89bb-8dae7a4070e9@cantab.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QOL0n3NG2/pM9Yw2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Nov 2022 14:13:04 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: David Vrabel <dvrabel@cantab.net>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <jbeulich@suse.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL
 bit is cleared

On Thu, Nov 17, 2022 at 12:54:51PM +0000, David Vrabel wrote:
> On 17/11/2022 11:41, Marek Marczykowski-G=C3=B3recki wrote:
> > Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> > the table is filled. Then it disables INTx just before clearing MASKALL
> > bit. Currently this approach is rejected by xen-pciback.
> > Allow setting PCI_MSIX_FLAGS_ENABLE while INTx is still enabled as long
> > as PCI_MSIX_FLAGS_MASKALL is set too.
>=20
> The use of MSI-X interrupts is conditional on only the MSI-X Enable bit.
> Setting MSI-X Enable effectively overrides the Interrupt Disable bit in t=
he
> Command register.

That means the second chunk of the patch may even drop the '(new_value &
PCI_MSIX_FLAGS_MASKALL)' part, right?=20

> PCIe 6.0.1 section 7.7.2.2. "MSI-X Enable ... is prohibited from using IN=
Tx
> interrupts (if implemented)." And there is similar wording for MSI Enable.

And this would mean the 'field_config->int_type =3D=3D INTERRUPT_TYPE_MSIX'
part isn't necessary either.

Jan in another thread pointed out that disabling INTx explicitly is
still a useful workaround for a flawed hardware. But if that isn't
mandated by the spec, maybe it doesn't need to be enforced by pciback
either?

> I think you need to shuffle the checks for MSI/MSI-X in
> xen_pcibk_get_interrupt_type() so they are _before_ the check of the
> Interrupt Disable bit in the Command register.

Note the xen_pcibk_get_interrupt_type() returns a bitmask of enabled
types. It seems it should consider INTx only if both MSI and MSI-X are
disabled. I'll make the adjustment. But this alone, won't cover enabling
part, as INTx is the only one active at the time.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--QOL0n3NG2/pM9Yw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmN2M2MACgkQ24/THMrX
1yy7Xgf/VXm1tljAkL14zb63jld+ZWk8SJp3bJmR29my72LkJSDRptt56K2JKUo7
Morpduk3y63d4eOWbR1QQ+Ms3fXXn6anDTweGWq3wChZZu1v4ZwWcUD1tZNBpIk2
b1dDJOIJyYBYaVN084X874y6Lt1sh8OKzbwzCB0smNtsTNSxFMUKEwTqAOLpYOxg
2QYhy3zzvrDEQPgMzCSMJV5kcJSXl8+Tkpt2RYVBu6y9VuatGYnlOSI66p/bH4t7
0i/QrAUZc7FgYWkH8gzr3M6kcOzRfHy44Ye1IS78/7Z387M3qwyLnLnS8dcuMxuX
mTpZ640102hfSbQzQAT9HMY8E7PN7Q==
=2Ltr
-----END PGP SIGNATURE-----

--QOL0n3NG2/pM9Yw2--
