Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27492743F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjF3PzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjF3Pyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FCD3C22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98266178E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D24C433C8;
        Fri, 30 Jun 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688140486;
        bh=znGCPupWQFYQBD7vDLixPFDgA/zyCTswlUzLFo6LN0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUJyhaD77kes7pGmCciwOF0ExXAtfsYln9338xKaVOnMe8lc+LFQs/4+FKA/lSq/H
         gRt/z8nco3KXa8qu/EKIvYNhLlS/i90M4JBKrHgCaJpRxCCa6f4DxVH69Pv8zmPn2w
         zOOMRMoa0Y2ExguoMY5oewSgkdmhyAzjI/0Uqsyjpi0XYyGgeUIhr9cD3LNXRlLCl2
         TF4g41EBl6FdR3O3QW3ZsQFqOCP/hb9qlJ3TCQ8nTT9NoB2xX7rHF2jDuu6Ld4v5zH
         dQJk7vcLKrMSskBLwVAQY3knIoOwP5vG+/YZqfZgNKT8LNABExX3glEs1K5yohnqn4
         uocXy0i59RtvQ==
Date:   Fri, 30 Jun 2023 16:54:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: codecs: wcd938x: use dev_printk() for
 impedance logging
Message-ID: <1bf122cb-2d6b-46d9-8c4c-addbf2791c23@sirena.org.uk>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
 <20230630142717.5314-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hSt2JuKKCbATmO2M"
Content-Disposition: inline
In-Reply-To: <20230630142717.5314-4-johan+linaro@kernel.org>
X-Cookie: Old mail has arrived.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hSt2JuKKCbATmO2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2023 at 04:27:15PM +0200, Johan Hovold wrote:
> Pass the component structure also to the
> wcd938x_mbhc_get_result_params() helper so that the component device can
> be used for logging consistently.

Ah, in fact here we are.

--hSt2JuKKCbATmO2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSe+sEACgkQJNaLcl1U
h9CtfAf/RMS/usFSZCmHcxanmIbzDtqHU77xROkqioT1SFXvd0zaQnAQLbRKrAdw
fFNE3POk2vZhchx05N/qyHouo0tDCf1QfUCcT2YcCdO+R1yXqcJ7uBffZcpuuGiw
8nH5n1N2iVL+Z8G02wtTBHwxUgbUvCQ7iSQtOLZflfoJDbbsm2jZQB/4sK75Tsjf
WI/T19SlzuaWY3vgix03aQTaqhH/PB23idQEsd4vmedV4QlrLBS7JSrXj4NF6dO4
nda4/sUqk7oZDodrjqljIeSMSLMMgTqk0G6xz9n6lchhSSdyVs7jZSnOpf2XX0BC
Whg8eGzEDs3Y8av9N1AZbcEzVKWguw==
=bCg9
-----END PGP SIGNATURE-----

--hSt2JuKKCbATmO2M--
