Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04D96C6A98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCWOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCWOSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F77ABD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 923D1B82149
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D0C433D2;
        Thu, 23 Mar 2023 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679581114;
        bh=HqrpakKe5lJcHsgFvPpYXNpcDu87zy3AKYG7fAHjv9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVC5Br2NhxQscX10B1smeT8zYIWtnkT/j2QfugtZISLy4Zhqi7Am8rHWdfDmNZbCV
         l7XGBw1Kq9dujwW0pbUoStRK7Pwl6F6sWMpZmYKjou1jjFOFzT8CRwZzreztp5gtno
         iCMmpqUsaTqTF3TGCAZxu+qX8fn58I5J6DNMqvmEaU2HiLMScVkV2hYOq/agR8d0VP
         47lK5OJ5nvFJb9rk4A/8k6ydYCgIH3YuFS+cBm3RQ1eLzcoYNBhaoJeBo7dMlDUooI
         +9M+HkdP/lkeMWubk78U+VtTgoRcGGAVlyk37R526lDJiPoUK+AYRGpzbuxuug7qNp
         ZGCLgAm0cUpJA==
Date:   Thu, 23 Mar 2023 14:18:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: Re: [PATCH 01/20] ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP
 used in LunarLake
Message-ID: <0254bc37-5cb5-4200-b483-de3e3677a468@sirena.org.uk>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
 <20230323054452.1543233-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qAA6JU3CumurpAhC"
Content-Disposition: inline
In-Reply-To: <20230323054452.1543233-2-yung-chuan.liao@linux.intel.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qAA6JU3CumurpAhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 01:44:33PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> Add the new enum needed for SoundWire IP selection. The LunarLake PCI
> descriptors and DSP parts will be added at a later time.

Acked-by: Mark Brown <broonie@kernel.org>

--qAA6JU3CumurpAhC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcX7QACgkQJNaLcl1U
h9DepAf/XSQrsI1JBnl6eDTHtPGEsBtDT/1R90Y3mMDWZxfGkI+F1lupoWdETNdm
cAjF6dJEG9Zho1zVhVmrH37+kRNOG4qaaG5vAAmXNwnJoX6jB94ul7OANJ3Z7pcw
J9yP5z1ZCuPY8T4jfgec3TvDvuFOhgOHUFT5Pqb/hPdhZ9AUI21mK7BIwo4GM4qg
jDFxb6u8XKAkdoWeDVwExq/SJOfqfmcV+pPpvHo1MTMOl/5I773/KTOOs//aLyXX
8gct4XgEFVHr2Cnu5YusJcpRZp6iX4z6UUgMrVW2HA87JhiU337ydW9vB7rNmQi+
xzi6qVZSAY6vmN2m/y3sLhIeYkb3PQ==
=DR0C
-----END PGP SIGNATURE-----

--qAA6JU3CumurpAhC--
