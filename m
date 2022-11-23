Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B20635CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbiKWM3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiKWM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:29:08 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BA60681
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:28:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id B660F2B06EDC;
        Wed, 23 Nov 2022 07:27:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 23 Nov 2022 07:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1669206479; x=1669213679; bh=hWxSuDzkXU
        94CSgCXRAInpkm/Y6uoZJPFOxa7mXYCLA=; b=YxjMG+Lk8R7fhJSUhiaa+uVEYF
        PZ6y66z1GmJXbelo6/aDKRoHlsg4mcb1zadMKQz/mPAmZHuETFPLtTrguoM+tFrL
        0JbRu5KHVrB4gUbvf2XlK/mPHQvKmjHYjUc4EG5DzZ90xrH/Aa3jmMeu+ZJCHs/R
        oi30RUezh7t+6IPPNQ7eHZa5tYspljdvWxVB7024I/5a3I5O/SJBW/viu2D5gruy
        PYzu+n6W7SWEnhd327CyuCt61kyfuRjAO1I5C3lPoDIUtfNSfwtVyOlFlbNrgg/4
        LC6DOQLGEzgKVPOgOpdQ3A7G0ETurNRobRv4FnI92WPBmvB8vcYk0LMmV9og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669206479; x=1669213679; bh=hWxSuDzkXU94CSgCXRAInpkm/Y6u
        oZJPFOxa7mXYCLA=; b=KZteqiB2a092niXyef3Ric2K+9aO8n+LDGIwXaQVRIdW
        gARKfCFfO3/LoTYEOmZyAhH0ybmO+2VHAwtmxlhJbJkfpHxsuZXtbg2jQyIEvyxq
        kVXrecw6qzXgj5Q36CRzCrtZ6yUIxaosm7YPOAyIsiMWZ538n17JV9wdipkITBip
        efyA5r0DWN5FIbM+kZtLX1mGE/sdg6oo9dCDIWRd3Q5j94QxYwGDejdcvhGWx+ni
        Wm12Ixj/4vLbDITbZYfxAE/RKK6AtKXBjgPsVSSeNesPOjmuLyT7Cy0ZvPtGwRgK
        HxncrWxNzda0u5FAHJLOXhj+1Ulf2G1+WyomKiBesQ==
X-ME-Sender: <xms:zhF-Y5JGbkdz6L-msj0OMNBFt43FP_9QHd1_ndEFMbyrmgdO96i2Bg>
    <xme:zhF-Y1JU6W-RJC6l0XpVpma4WicV6KGBBqLQd1px3Jx9vaA9uPUjcdEtqURT9cSP6
    T_0TsPBNkawTQ5iw9w>
X-ME-Received: <xmr:zhF-YxvrEhfIhEFlxws7_cC6hndYQNd1WToMQCPF_E4Xz12KmbT9JM0ElImDYn5DOil7OjPmkBgjn-mYbsFt-wFpKJBvQO5cxlg_1cNQZQ1WrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffejieeg
    teejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zhF-Y6bIDz4lxegyCNxrttRcdC6il_0_AfQSkGp_Pz-Y6hygAXgMFg>
    <xmx:zhF-YwZXScQs3lQppN5S6PqJsQD-tDQKrLK_79B-OtG3NncnFGPU5g>
    <xmx:zhF-Y-AN2GWUGPiwQnMZu0sX43lsiQOBBrRTt5MVPd8-JrjsMOVrYQ>
    <xmx:zxF-Yw0saa-ajt8PhpwUH5bIOMFT-PZB5cr6K7XJB6UTu-GFghWNF1ky-Js>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 07:27:57 -0500 (EST)
Date:   Wed, 23 Nov 2022 13:27:55 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
Message-ID: <20221123122755.5vngtza6rvkjkpoi@houat>
References: <20221119204435.97113-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qmepqrty2tbnehtf"
Content-Disposition: inline
In-Reply-To: <20221119204435.97113-1-ogabbay@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qmepqrty2tbnehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 19, 2022 at 10:44:31PM +0200, Oded Gabbay wrote:
> This is the fourth (and hopefully last) version of the patch-set to add t=
he
> new subsystem for compute accelerators. I removed the RFC headline as
> I believe it is now ready for merging.
>=20
> Compare to v3, this patch-set contains one additional patch that adds
> documentation regarding the accel subsystem. I hope it's good enough for
> this stage. In addition, there were few very minor fixes according to
> comments received on v3.
>=20
> The patches are in the following repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=
=3Daccel_v4

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--qmepqrty2tbnehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY34RygAKCRDj7w1vZxhR
xT32AQCX8A7T5hn2/y1J6pSNNAl7PLmN9ffQOtgxNcox+FQ4RgEAuEilhHbdK3X1
doXHfzoxbP+t/U6mbPUDVNl0CjvnlAE=
=1YV8
-----END PGP SIGNATURE-----

--qmepqrty2tbnehtf--
