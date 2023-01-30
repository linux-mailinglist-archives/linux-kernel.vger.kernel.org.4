Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE2681FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjA3XcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjA3XcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:32:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4E2D15E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:31:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6164C61299
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB6DC433D2;
        Mon, 30 Jan 2023 23:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675121501;
        bh=kQdyhhnp1NGKhPRfqFs6D+X8Ra0io1rlsLTX9E03Q+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/138daDBT3ln1dyOBImUCW/coBz/GMt6xZUS2s/3F12DdMcXOZjAlmDd3Ou7uBcT
         yHXr5Sca68TemuXGd2WPO8I5OgVUkeNyewfQOkElkkrf3+SenoakDDp+8a47MmuhEj
         YLwJqtcQoDe0T94T0NM5yNvB4fVq3G3eNRRGwckpLIBgfPDSFMXq5p/lvIlAp/12HH
         MVeQzez4UbhZUNY1hobVDpRn8vGd4QFDOTOaqkWwKBu2LIESBg1jV89Fd8AjXQB2Uu
         pdZ1vXeyPq7v5Ud3mJHrFo1MixtXj5aQtZoH7z9Xj0SGArXlULJpGsBjmQqpcV7uI1
         vEkmXvX4o4WDg==
Date:   Mon, 30 Jan 2023 23:31:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v3 1/4] RISC-V: Change suspend_save_csrs and
 suspend_restore_csrs to public function
Message-ID: <Y9hTWRaShrsjm2gP@spud>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-2-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GSvx5mJI3gnKODba"
Content-Disposition: inline
In-Reply-To: <20230127091051.1465278-2-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GSvx5mJI3gnKODba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2023 at 05:10:48PM +0800, Sia Jee Heng wrote:
> Currently suspend_save_csrs() and suspend_restore_csrs() functions are
> statically defined in the suspend.c. Change the function's attribute
> to public so that the functions can be used by hibernation as well.

Seems reasonable to me!
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--GSvx5mJI3gnKODba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9hTWQAKCRB4tDGHoIJi
0ks5AQCmPLLnyZYHe0vRc8cRkhKi7oBHkrZ7GAaSvqW9fdoLRQD/WzdFRThaXYfL
njcQg8Tdt2SyukvBwDzhBd1G8JjEEAw=
=0h76
-----END PGP SIGNATURE-----

--GSvx5mJI3gnKODba--
