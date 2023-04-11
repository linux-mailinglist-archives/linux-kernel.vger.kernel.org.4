Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F46DE5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDKUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93E359F;
        Tue, 11 Apr 2023 13:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AA0C62867;
        Tue, 11 Apr 2023 20:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C98C4339B;
        Tue, 11 Apr 2023 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681244640;
        bh=xPsY5dfTyjl/Ph3+X6+TNrIslcb3LVfftfhr5ZNow5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6/tbFetZuowtge2bXgNZhkWI6w0/O7evrnU/Oc/rE3CmHgdyFrgMeiQYyGqPYG16
         bHGg0hASwSEPg8lkbPlSrm3INNvVi8MuGWWw1JfvaKf1wRWXck65k3JGRON0DNc7d9
         wvNTZ5GLnBb05+HZVoBB0S6rfkT6Vb2FNzVafEeewpqX4ExY0pKB5WTbkvHNYAHJrc
         RB2E9aJwuXPgJKc0EoD8R/ROtBEw6aEO3zTFGCGS4hiVvLYNJURK6dLpwHedN0N4QX
         b2xdOoYDnr/1Ac9aRgewiJS//qBqub35aEszyF+toErk5jDJTbi1rR223iLuiqKUBg
         RnHs6cbgIdD8w==
Date:   Tue, 11 Apr 2023 21:23:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Message-ID: <571b4df1-91ea-481c-9797-842974dfa922@sirena.org.uk>
References: <cover.1679323449.git.william.gray@linaro.org>
 <ca710d14a710fee44f7911f2a84b6a55570561ee.1679323449.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="POxhOpVcNhhh+QMh"
Content-Disposition: inline
In-Reply-To: <ca710d14a710fee44f7911f2a84b6a55570561ee.1679323449.git.william.gray@linaro.org>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--POxhOpVcNhhh+QMh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2023 at 10:50:15AM -0400, William Breathitt Gray wrote:
> A private data structure struct dio48e_gpio is introduced to facilitate
> passage of the regmap and IRQ mask state for the device to the callback
> dio48e_handle_mask_sync(). This is in preparation for the removal of the
> handle_mask_sync() map parameter in a subsequent patch.

What's the story with this patch?

--POxhOpVcNhhh+QMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1wdsACgkQJNaLcl1U
h9DaAQf+OGSSIefSDt1Dhu1zbTxoz4HFHfQgYeMDFq+MqqQmJZXk0HtI2dAxFhMM
lqI1hcOyOFAKcKWnj8lKhNclZWRTp0TQx50FAnIEtm3DvZQUnkNXNbYuKzkISGw4
Kd0nZKOdgjJdW/amn+W1FvnzSlVnQYf2Ro8YuWnSatEIsgt81lQaNgWq4q4aAe6+
3Mx4JNM/9yztYsNsgURYNRqMpL5HnsNk0dq3+2FsER8Ubo/wtoQ4vtyhdddyJjQR
erJazML5WlcavNPmyMOoRZOAbEsgNenmUVgSljazogU8tocf9y17N0c1lhBgMPfL
ApACbynlb6DkbADxVMjz6HoMZYpe7w==
=yeuj
-----END PGP SIGNATURE-----

--POxhOpVcNhhh+QMh--
