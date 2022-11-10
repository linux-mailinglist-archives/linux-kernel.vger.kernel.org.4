Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812566248A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKJRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiKJRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:52:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45EC3C6E8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:52:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2EF61A0D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADDEC433D7;
        Thu, 10 Nov 2022 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668102756;
        bh=ZcPykWIpk5s9e2vrwgKLdGAbKNXsc6ph7Iki+uGNScI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX5VHpfKEkecT9GuAts45R9ncQL9B5R5WATKgbSybrNpCdXfgDTBsI6bpwMa8qVhs
         sOrW2sVJnZQPbMWxs2YEbPQsLKOXBuRHTDneNJWvUH3pKErpwdTSGYQ2KPNzNZ03bK
         XF6dmFjPm+BqNs0jRRdxe9yKZOVKAuYP30s/yHmPYtcN0VJ9kIe9+4BmqCDjd6km12
         H6JAl+T9Led3/vmfvLwOETztJk2hBVE4BBl/zlA+dVEW6Ck1cc+s5ZCqa4OhoOM8g0
         5j3RhlPwjWKgg3qIKY/eK3l4IY/c7ZHRS3ZOYxrnCH+DjUGhnRynLnb2PS+7r9OG2M
         6GOLkufX7Ahuw==
Date:   Thu, 10 Nov 2022 17:52:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH v2] ASoC: SOF: remove duplicated included sof-audio.h
Message-ID: <Y206Xxh6EzMtsjy5@sirena.org.uk>
References: <202211092130548796460@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OHRMaM+i9JxFzi/y"
Content-Disposition: inline
In-Reply-To: <202211092130548796460@zte.com.cn>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OHRMaM+i9JxFzi/y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2022 at 09:30:54PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>=20
> The sof-audio.h is included more than once.

This doesn't apply against current code, please check and resend:

Applying: ASoC: SOF: remove duplicated included sof-audio.h
error: corrupt patch at line 21
error: could not build fake ancestor
Patch failed at 0005 ASoC: SOF: remove duplicated included sof-audio.h


--OHRMaM+i9JxFzi/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNtOl4ACgkQJNaLcl1U
h9ALFgf9FR0vOAT5WQ7DCtUvqLitOITfGWOYrwq7eWwF9PK4fpF1seAXZHZ+ffMK
iQbp0DjxvkmVHhZE1KyCOnbbOQlcEcLKH0ogA1xLM78ZMa6kikhl+WtUU+D7wpOJ
SRC/Ln6au0SLTrnQxCJpm/M+8fb2mRkVAS5EW1PWXORKJZUE1YlPcfHDE/KV1FT9
tqvYnUJko3psg+uOl2EqIIQok7EB1x5IlgniiyaNz92w5dlJuo0gUBkYGRn1s+LT
A/CikTl4u5IwmK9Ev7U8+Y8QV9EQKhXi9h3ooIPSNbYMmrJEFh5xBQVmRvr47+v9
2/Vsd96qer2Wf8xYnsZsQs1DM53DvA==
=aTqP
-----END PGP SIGNATURE-----

--OHRMaM+i9JxFzi/y--
