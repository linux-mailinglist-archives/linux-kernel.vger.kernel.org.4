Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E462F430
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiKRMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbiKRMGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:06:50 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9136E54B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:06:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 259B53200BD7;
        Fri, 18 Nov 2022 07:06:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 18 Nov 2022 07:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668773205; x=
        1668859605; bh=ydnYLE9kWkKbVKA7VcOBz6ftKnIEHWq5ebRsQGBa77M=; b=v
        CXzY4V9EBhmPlwF255kCUVOdVBfGYtP6jGCEJofaskheLLC8AQcjPnzLQksZv6my
        6prA2+iVgl8Wa52DU+GLeiTQ5VdgS8eDWuYDul7caz86h7wXAOa7RNyDCVqVs1TN
        qvcAWercASnX7Fxc+tu0712obxhZjorL4vbHYPrYTcSbP6PKm+8tSj084nwT52B8
        3fbOigkpcq7XTwk6zumDgN14UHY7PhyfG54ya0LpR3YSKIpcMQnDtPc7+GNq2b9Z
        C80YuFHcaO6qtdmMUSHQvXb7qj2js6i+jDn/shGwH1sYr1WZUSgl31DeXb2GFHQC
        hBZ+Zxrw73VvFCPJeVV/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668773205; x=1668859605; bh=ydnYLE9kWkKbVKA7VcOBz6ftKnIE
        HWq5ebRsQGBa77M=; b=XBjbxJ6SY3MISmD6rxxEY+iF90CsE999B97YS6oIiBNs
        s5G2aJiv2PXhi7SIQUTRPkOMsW6Lf7rCFtWHX4foagzvr+4EAAeNOPJlEREJv9O4
        cTyFtDaOkndbQS1TA8bW9WMmGbL38aMr7+4yWXXU8qnIIh3gG46h6Ep7xgdD8CPt
        q5nit12IflT/UIKH9704rmLgu+FIuP/iwXNZBCU83SD9PmoZY7P+VrCX1XCyhlol
        54MKNoia5RBaK9iL1hfeocNpXPA24/6Fm/zG0KDJBtu5lI4f2cpk7+ZnP/seZIcu
        wbxwNmsMPrel4Tr1Fb8Sw/JCwB9xx0Q+VCuZQjfAfg==
X-ME-Sender: <xms:VXV3Y0k2NoR-c8h6kwAbDlWHv7K3OnfRyhcRNTHUaWuwlpUD54J25g>
    <xme:VXV3Yz3PHKHfBodY3r_LmoWNDBiz9xcSuvxqYqLohU2lrspxacZWNzpLLGQXlKSmE
    qK01um7ZE-nBA>
X-ME-Received: <xmr:VXV3YypjEWXrnTG0wDRAf3qZoG4OXNffyxZXpZs0nMIKF3C5jt0eV6uWmF4FufAgrjiCnFNxi3hXX4mPp32qKQap8g8AA-eG5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:VXV3YwlhGsOVeZXvOtaHzDL-hJhVhk_jVH5RAV-Dhjzh3vrRUZbigQ>
    <xmx:VXV3Yy0r-UPphK1hweQ1dd7tBcDcatOiSC5v3lm_XRcpZigzPzIIrg>
    <xmx:VXV3Y3tsRCKzcYYdVGCiQxCOYpwpUXAjvN3b_RK0kZIbk4ucfUM5hQ>
    <xmx:VXV3Y3zGoeK9tEdFnj7CuUJB4hypXCu0REHbDZjLMOhYOArMygNoFg>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 07:06:44 -0500 (EST)
Date:   Fri, 18 Nov 2022 13:06:41 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <Y3d1UeCuDIMxmzTA@mail-itl>
References: <20221118023535.1903459-1-marmarek@invisiblethingslab.com>
 <93b6385c-63c8-1b5a-13c0-838f7c03ccce@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JWeX+CTKflPH5119"
Content-Disposition: inline
In-Reply-To: <93b6385c-63c8-1b5a-13c0-838f7c03ccce@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWeX+CTKflPH5119
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 13:06:41 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled

On Fri, Nov 18, 2022 at 08:36:14AM +0100, Jan Beulich wrote:
> On 18.11.2022 03:35, Marek Marczykowski-G=C3=B3recki wrote:
> > Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> > the table is filled. Then it disables INTx just before clearing MASKALL
> > bit. Currently this approach is rejected by xen-pciback.
> > According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> > enabled.
>=20
> Similarly the spec doesn't allow using MSI and MSI-X at the same time.
> Before your change xen_pcibk_get_interrupt_type() is consistent for all
> three forms of interrupt delivery; imo it also wants to be consistent
> after your change. This effectively would mean setting only one bit at
> a time (or using an enum right away), but then the question is what
> order you do the checks in. IOW I think the change to the function is
> wrong.

IIUC the difference is that enabling MSI or MSI-X implicitly disables
INTx, while enabling both MSI and MSI-X is UB. This means that MSI
active and PCI_COMMAND_INTX_DISABLE bit not set means "only MSI is
active" - which the function now properly reports.
Both MSI and MSI-X active at the same time means a bug somewhere else
and the current code allows only to disable one of them in such case. I
could replace this with BUG_ON, or simply assume such bug doesn't exist
and ignore this case, if you prefer.

> Furthermore it looks to me as if you're making msi_msix_flags_write()
> inconsistent with command_write() - you'd now want to also permit
> clearing "INTx disable" when MSI or MSI-X are enabled. Which, I think,
> would simply mean allowing the domain unconditional control of the bit
> (as long as allow_interrupt_control is set of course).

I think your are correct.

> Especially with these further changes I'm afraid at least for now I
> view this as moving in the wrong direction. My view might change in
> particular if the description made more clear what was wrong with the
> original change (476878e4b2be ["xen-pciback: optionally allow interrupt
> enable flag writes"]), or perhaps the discussion having led to the form
> which was committed in the end.

I'm afraid I don't understand why you think it's the wrong direction.
Can you clarify?=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--JWeX+CTKflPH5119
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmN3dVEACgkQ24/THMrX
1yyy8gf9HRwcAZpH1zguX0WqxWEGwW9uPdCzHaQ7diDesElifkVgwuOwz5hYHqm/
j+xXskWFao2c3a5AFnAiW34jAXSEOtTZ/eciJeBZdoXZ/IeN5zKF26h2jAHTdnOw
HWMTRMkM9VGdtVACLtdDFXCPPKK8k9xLcwz5JI6jHbcqT6r2jFbPn1RdciFzV6iu
SygWCBxRpjUzVmNY/HZPlPSAIYhWwlf1VwwICGivvW2HKhswNEqygpZwEY3qoDgt
13jhh794GUzq/2NDO5Nunz+maILbYRY3kfa/d1ImOEnvoIo+3nekvY2sG9CE/gJO
diXfejb4cPwYCw+i3UZOSMSM8T6I/A==
=xexH
-----END PGP SIGNATURE-----

--JWeX+CTKflPH5119--
