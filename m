Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9836BB9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjCOQ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCOQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2BD32CFC;
        Wed, 15 Mar 2023 09:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65C4861DFC;
        Wed, 15 Mar 2023 16:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF974C433EF;
        Wed, 15 Mar 2023 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678897783;
        bh=jjn5cdVupJ0A22hzLeqblsWGnn86f9oIpQTR3zJXyMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrGZE6Sk04Pizzg1tuzcS8CHPA2fWPGLs4KeZnsayQbgSEQA4cnJK0Pfeq0SJeJBK
         k3vxt0IAld+aKoIhiC1zd5okC/+vL8oWVyyuI6ZfWamyvj388DwIwIYix0jC3bwxmi
         DkeIXcnQUWjdJXHT/9ZFLPb9Mobk2cNyIzLuPwIw5rsLql0YKamZVRUoXUYTdyODoV
         Qvri59v7Ipro4ikDj/8KVduqsAhq0rRHgWmjSR1HC0SJWkOuQY5nxeUuemo7vvLdpn
         GcuwDkUNsFs3zlki+Ro5SvcGO6afswtXZknOUs/tFssFYs5ilBEfvwFoULnPAv3CIu
         EL6OIvNSFjCYw==
Date:   Wed, 15 Mar 2023 16:29:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v3 00/28] Introduce QC USB SND audio offloading support
Message-ID: <e270cffa-d27b-40e0-aed5-104514e4ba94@sirena.org.uk>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <4f8a66c0-398f-5655-3aa7-a59bc9ba56cc@linux.intel.com>
 <8b2f3ce7-3e0c-bdf0-8d9f-9aeabba09a15@quicinc.com>
 <a211f26d-a045-0729-871f-248d5fce3f3f@linux.intel.com>
 <684daf86-6c3f-7310-eebf-4ebfc3c480ca@quicinc.com>
 <8a37ccd3-f19e-b30d-d736-04e81b49f3a0@linux.intel.com>
 <0810f951-f4a6-a51d-97e3-43691b05f702@quicinc.com>
 <b671e263-5cb8-18e5-dc28-648ab1133c6c@linux.intel.com>
 <14d726a7-6ffc-705c-b012-0c08d7dd7b9b@quicinc.com>
 <6b811766-cd2a-54c0-d090-640812686a45@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z0fuEYQGMv0a0e38"
Content-Disposition: inline
In-Reply-To: <6b811766-cd2a-54c0-d090-640812686a45@linux.intel.com>
X-Cookie: "Speed is subsittute fo accurancy."
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z0fuEYQGMv0a0e38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2023 at 09:30:58AM -0500, Pierre-Louis Bossart wrote:

> That's probably ok then, am I getting this right that the the DSP card
> would not expose any USB-related kcontrols then, i.e. the ONLY path to
> change volumes, etc.,  would through the regular USB card kcontrols?

> That would limit the changes in the platform sound card to the addition
> of a PCM USB device.

I'd guess that there might be some volume control in the DSP as part of
the generic routing to the port (eg, if all ports have some output
control) but I'm not sure that's an issue, could even be useful for
normalising the output of DSP algorithms compared to direct PCM
playback.

--Z0fuEYQGMv0a0e38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQR8m8ACgkQJNaLcl1U
h9Cp3Af/fp7qmzx3dIqaYfXDA3inZKGAJxlBPLnKX7FXrObh2rhSDh/htyeF/xtx
6tpnHQ1zB2RqEeffKTwu9lobnS2+x/SYkDG2vw5ONFKl3U7L3L87l76a67mR5Hk8
d7nCQBAdHetX8yl/6H4iVbQztzwFNbuAfT61GYm+zxd98Psps6JucWS8IXwH8lfd
XGRC/kENH9CPClFzhOCLGnlc+lMRkIGPDH38CN/IGl1GqHr5GgpWlRf6U5dFxpYC
gAAATPlnhXUSp3o2+qT0bmqjEDpeWXUbeAQuayhdQ3fS0TzGBgoynfR7OyKEHPyl
X3poldFU1Joz448CW+mSRjG2W9VTpw==
=+zSv
-----END PGP SIGNATURE-----

--Z0fuEYQGMv0a0e38--
