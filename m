Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34325646F52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLHMMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHMMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:12:09 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6A865B7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:12:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 268B42B059E0;
        Thu,  8 Dec 2022 07:12:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Dec 2022 07:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1670501524; x=1670508724; bh=PCPZ2sCbVm
        PKZmwwzBAyDxUGgQ8T8EgQ1fPLSzt4qfM=; b=b9B38pzwEQ6SeLpwI3DH3lg2Qg
        8U1wQcg+Vd3PZ3eUwnerYEYg+H+q3BOnwWWmjnmnI0Nfgu1q0NiWnvpXW87PXFnc
        /qzreEld6IlKFHfOcRASYQQM6kBfbzoFq8f5kis4HY2AdP2AiiPLyLRzT5Vmymop
        XUJGIQtbciiDP2+U1yq4uXjta76/s5zqcfYUmnmIOEsaeSBH9VW5LRz6NhWjAYKd
        4Ht5At+P0+sJShGVIXzYZtRzcLX0UUuNY8UsJ4R0hmVPHLsGRhnt7yzAelPAcpYw
        6i6Ap2MnjKGzQlNiLZS6iiwpkGuIaNUxBxi+mqSDwYw3HoIwCkATAAW6fvmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670501524; x=1670508724; bh=PCPZ2sCbVmPKZmwwzBAyDxUGgQ8T
        8EgQ1fPLSzt4qfM=; b=TnoIOg5Z9LUywgqUOm6kSjpnAOiUkJo7xy18iMWXXscy
        VPuDbvbUNoti4hbtzwrFXy/Ba/z5hvMS7PwC7jTL9jnPSFo/TfCHP1HBb+ui9mC1
        lORjAqArjjRVRIq0XBRwo/vpRNxrToAHPLfihrf2vrKOxQkLxPGshRJ8jtDsQ353
        cPpcd5iENHKDsu6YXLIz9ZzfFBNScayCsaET4k213afqG9RoZhsoorK+tFmXry1z
        +j5A1W0M8BtwOH/wYrX6cpwDU1ZdgIPhxdLEXmOdL+gcmeY/fyQoXVYME0FSRMeM
        6HsOZaJ8O6ly7+A90wIKtzc1aRufH5R2NZyNNnZlLQ==
X-ME-Sender: <xms:lNSRY-RLBbZXiHj6cwR2ywe6xgM5ouv0aiA8pNHxhUeFnWelTCVp_Q>
    <xme:lNSRYzxEljjStSdUfbgv8BxKDLCsHaSF8dHWEsaPaJMijAOsyJrG1IjSJr_4chUos
    S09zozjZXPDhPzPj_I>
X-ME-Received: <xmr:lNSRY71N-f_YSGa0vQGSHbFwhHQCJaXb3xvZCF1K2py7ScVqYcN-xiSWt60HiAq-ppdCQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfegudff
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lNSRY6BTHc7uZP5ujn6ClgkfB8sRLrHLJkBQB6NozKJ343jcN0H0zg>
    <xmx:lNSRY3gfYi-Xzv_n_IhJecKs2pIBApT5229b_M37QkSXFQjjivsikQ>
    <xmx:lNSRY2rSk-hVAFsEpsOpNOuopE7BUnEs-6qwo5mweG2m-Dr44Dya9Q>
    <xmx:lNSRY9NBdg-0xlE1JTgtU_xVEdrYo8t0lDltRIjXClhFvyBg2lRhChna54o>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 07:12:03 -0500 (EST)
Date:   Thu, 8 Dec 2022 13:12:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Melissa Wen <mwen@igalia.com>,
        =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Wambui Karuga <wambui@karuga.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH v3 1/6] drm/debugfs: create device-centered debugfs
 functions
Message-ID: <20221208121202.2zeh7yxvjins5wxk@houat>
References: <20221207132325.140393-1-mcanal@igalia.com>
 <20221207132325.140393-2-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqane2ilmqf6olgm"
Content-Disposition: inline
In-Reply-To: <20221207132325.140393-2-mcanal@igalia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqane2ilmqf6olgm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 10:23:20AM -0300, Ma=EDra Canal wrote:
> Introduce the ability to track requests for the addition of DRM debugfs
> files at any time and have them added all at once during
> drm_dev_register().
>=20
> Drivers can add DRM debugfs files to a device-managed list and, during
> drm_dev_register(), all added files will be created at once.
>=20
> Now, the drivers can use the functions drm_debugfs_add_file() and
> drm_debugfs_add_files() to create DRM debugfs files instead of using the
> drm_debugfs_create_files() function.
>=20
> Co-developed-by: Wambui Karuga <wambui.karugax@gmail.com>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> Signed-off-by: Ma=EDra Canal <mcanal@igalia.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--lqane2ilmqf6olgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY5HUkgAKCRDj7w1vZxhR
xQ0vAP0XRN6HyMEBaYjEZL6zrB3JIsD2G6W0qkCmtkPaWQASZwEAwVwKC17E8WOz
CLh+/BpwGz1n0HBo0O83gimrlxqzwQU=
=nJlm
-----END PGP SIGNATURE-----

--lqane2ilmqf6olgm--
