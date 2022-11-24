Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95B637DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKXQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:54:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E560341
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633F86207E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B110BC433C1;
        Thu, 24 Nov 2022 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669308842;
        bh=303mkhP0F5n4Oehc+EkVCKrbxxDChcE8m6IcM5IE9qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6PkNRdHyrEIua7+ZE/AQh1piITHrmDYNE319D06xlp4bYKpJjH4HJdDDeBAyxFLk
         sL1syRPg2qvW48D5VuEC6Qrj4OuYf5qhgjnstdR9Q2Y/7Q+L2FXMHXb8vNwiVfz+2b
         DEhHkDVz3FDiNFwWwZCgobyRbImH8dvioDs+vqSp7oY3Zzg6vedu8UX+Me+b+3Sguj
         lTUEwiRDyhi8DruQ4whZT6NU/k400VqocN89y7zJfC3dVzlXEDcX5RJzvmeRfSlUtY
         oLVmv7nitDYWIRXg4hd5XPNoSesf4GQ+j/8Fi0OFDDIJNE8QH+B+tGxS2Zw9YRumHS
         aikoSyjKro3sA==
Date:   Thu, 24 Nov 2022 16:53:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] regulator: da9211: Use irq handler when ready
Message-ID: <Y3+hpgjQVK+8Ut9s@sirena.org.uk>
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
 <20221124-da9211-v1-1-a54549aa6d3b@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saoWTSIAaLk5P9G4"
Content-Disposition: inline
In-Reply-To: <20221124-da9211-v1-1-a54549aa6d3b@chromium.org>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saoWTSIAaLk5P9G4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2022 at 05:45:31PM +0100, Ricardo Ribalda wrote:

> [    1.141839] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
> [    1.144475] tpm_i2c_infineon 3-0020: 1.2 TPM (device-id 0x1A)
> [    1.150883] Mem abort info:
> [    1.150884]   ESR = 0x96000005
> [    1.150887]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.167749]   SET = 0, FnV = 0
> [    1.170794]   EA = 0, S1PTW = 0

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--saoWTSIAaLk5P9G4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/oaUACgkQJNaLcl1U
h9AHAgf/T/PSf2rVb8O3aSOU7c7oKbEcR+5Jkn08V/UuHcL3fDC2fZ/dWMp9VwHa
HqczsfNaqwAaES7WkbgYBI9c8/HKOKCCyMamvyrTIhbHonoDOFwhx08S+C+ckxz6
sYbQDrdPyPCPuqUDyXUWslQRh0lM5ilE5jdnnvdidGW+lpHztuZNMQzvnA+xHW9h
leWmOLrkVUtk1z60ADDd+jRbWYg9fVxnUR2eZ+VxvpcJmdaTvOM3Y381nsMH1gYa
XdbldcKCDIWyRRyiGEpmMRjn8cDujcHlKmFCYQOZDWBq3/aXuVUqmZ+Mnwf1nmAD
HG4YT86t7LOiCfXaVx534o2PQfXdKg==
=Kmu0
-----END PGP SIGNATURE-----

--saoWTSIAaLk5P9G4--
