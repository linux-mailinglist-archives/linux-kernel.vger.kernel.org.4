Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96B6D27A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjCaSO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjCaSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:14:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7281C1DB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87D75CE308D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 18:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD67C433D2;
        Fri, 31 Mar 2023 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680286490;
        bh=7zKHrajfr7gy6oyR1bURpy4CGEFaBjYjosorDn9FQvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmhVzS+vqvjXPY+U3xFrEWUwpmXdJg6jp6Zn8/eONV1bGUPeeYwH3qu8uRYdDbPEN
         3T/tMc4nXpDKtIgkfdZYSXyT5rBEmTzEl1k/9oLx9+X3aUJFuwePamPduoAPayuQIp
         Dc1DkAXLzSQwhMmxrgB/tHOyVKFU0k5lyjr407jhmLc8+ZvGlPrnKAAYOiCiN9EMDS
         lkhfdO7q6qAYVYzW26VNe2TJyb1dTYNKrLD3meECdtm6y6oRhhfdAXHOVnlUSDkvS/
         j2yXG4u+hvECZZ39t50N/OZ6m0BTdSk2yzpg8vlwSXIRkWlH5qPk7UzhXTQDoagSm6
         PMQ7mnCGKKFdw==
Date:   Fri, 31 Mar 2023 19:14:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mailbox,soc: mpfs: add support for fallible services (was [PATCH
 v3 0/8] Hey Jassi, all,)
Message-ID: <e8cfa8d8-cb73-4074-9041-ce37ce782630@spud>
References: <20230307202257.1762151-1-conor@kernel.org>
 <d7c3ec51-8493-444a-bdec-2a30b0a15bdc@spud>
 <09cdec20-c3c8-4eb1-9a74-87f429543d3c@spud>
 <CABb+yY0ocpdB5RWyxncM7VJzJde6G-WscTKbT2=GMt3uJAccVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yCL3c8eMFvjAz1bT"
Content-Disposition: inline
In-Reply-To: <CABb+yY0ocpdB5RWyxncM7VJzJde6G-WscTKbT2=GMt3uJAccVA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yCL3c8eMFvjAz1bT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 31, 2023 at 10:03:08AM -0500, Jassi Brar wrote:

> I am okay. Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Great, thanks Jassi!

--yCL3c8eMFvjAz1bT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCcjFwAKCRB4tDGHoIJi
0qg/AQDuSvlQrNZ8rvZajl11EJrl7aid8BAibS7rnLR45V8HYAD/cqjXzSjLJabN
acDicLE0LimgxE2yNOD/oF4R+9sgtAg=
=OzIv
-----END PGP SIGNATURE-----

--yCL3c8eMFvjAz1bT--
