Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD59369977D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:32:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948794B532
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:32:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4D4FB82849
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9EEC433D2;
        Thu, 16 Feb 2023 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676557918;
        bh=RUTZEaMXXSTE1GT36fjGbfFAAaOaFr35Mks+H/aGDfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oahkp9pPF91gXoqeFN9aUQrixT4Uf9JJrri3jwp0wpOW2OQh6rLKgVY3B2g8CBeod
         QIuVZABpVfsdyLFH01kP1La+H5RopAQxIdHcqCiH8jpuxZC35R/g5JC+AI0PClnNOe
         +6mvIVR76tYzE0fJR6sGZJQStPYcaiDXTdxZHIuQZ+kepo0n57E+YjXQGEGdF3ZleN
         oTq08p0GvPx4J7vYqKmZosBtzLxHyCHBzfpLkzgpRMO0Qhur3bZE5yki02E4RLdSk4
         U8G1npYRjITXl5YWkCEmloPLC3/rNVHgVgCpb4ilHXQm4yfrAyYTf69u+vYfyaXRpo
         99rVJNNrqvOdg==
Date:   Thu, 16 Feb 2023 14:31:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Frieder Schrempf <frieder@fris.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 4/6] regulator: Add operation to let drivers select vsel
 register
Message-ID: <Y+4+W1vqP+9DJfOY@sirena.org.uk>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-5-frieder@fris.de>
 <Y+v31bkMWxPEVqrT@sirena.org.uk>
 <e2dd81dc-d146-d7b3-1f59-a80606517e1a@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zq0zQGjCg+m9ShoP"
Content-Disposition: inline
In-Reply-To: <e2dd81dc-d146-d7b3-1f59-a80606517e1a@kontron.de>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zq0zQGjCg+m9ShoP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2023 at 10:05:49AM +0100, Frieder Schrempf wrote:

> Just to be sure: you are suggesting to to leave the core untouched, use
> the existing [get/set]_voltage() ops in the driver and reimplement the
> logic of regulator_[get/set]_voltage_sel_regmap() there, right?

Yes, exactly.  If we get a lot of drivers doing this we can
always factor out later but it feels premature right now.

--zq0zQGjCg+m9ShoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuPloACgkQJNaLcl1U
h9CG1wf/TlkZzHFnohsUQT9/jn6taLmpwSpxo2zFAFflRm8kpwEpEL1Q84cFiaFn
hLlO740komrW3DhgK7aGxO8NV00xQR3wUTiDCtEKWr1K2oUow/24OiyK8zdRAwBI
WsaWJqQc9Rrf04PJcHEKgoPGhhzHX6B2JpSS+G0TPewdO0VmtpqFJRVoWbGWanIr
/T0FCPR3/+LcZFR5DAjC+aJDbHZnkD8k+qC4ROZlwnD3jjgVyLu+SXnPXg/7hkfE
6bkPqWGUYJZxBirSo5W0ue7sXZuAkygBthnF9t2aEjc3gVp1wDTx8DbN++RF6Brm
p6DddlTx/kPozN3krCU7Vd/y3ayiFQ==
=Sl3c
-----END PGP SIGNATURE-----

--zq0zQGjCg+m9ShoP--
