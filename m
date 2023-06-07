Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F254172687A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjFGSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFGSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D7270C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 161A064295
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C28AC433EF;
        Wed,  7 Jun 2023 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686162051;
        bh=DqA67JB43to8SBm7T5FMFcbc2V3CfG3wKCfu4Gu0B/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXxIDDefKwxQvlxmkEh6QcbqVbPxQ89WGLx/8Ry7Z3dJqtIvGy/UOVXEUudfbCvpJ
         /7DxrGRAE7bnS5Rnz7E63EWCHPVwogn22kjKDqg3f7Mpk099VJBmzmwUaFiiPCioJ3
         yuf/YdnZT1uViAF7yd/mSHTGZC2ybOCDBD3oE63+oDUkU3rxr0IZWs+w+PO8pUVUDR
         dtDeQ2DnM0RvUNlMBKgy9b02WPaRP61NTWgUim2MCkEvZaM/QAdAo/fzqhkM4X8Ac+
         +FjoxiHf8oVOJ+aO7FRiRUoJFueIJ1Ri3YH2fU7fTD1D06wk7u8QI5ziGXhcWCsRF/
         VmX8ZHjUafdgg==
Date:   Wed, 7 Jun 2023 19:20:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 -next 0/2] RISC-V ACPI: Assorted fixes
Message-ID: <20230607-badly-onyx-2a9013c3549b@spud>
References: <20230607112417.782085-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b1QUWVR6g+yF5Z0v"
Content-Disposition: inline
In-Reply-To: <20230607112417.782085-1-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b1QUWVR6g+yF5Z0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2023 at 04:54:15PM +0530, Sunil V L wrote:

> Changes since v1:
> 	1) Added "Fixes:" tag
> 	2) Added RB tag from Conor

b4 is usually capable of picking up Fixes: tags without having to resend
the series!


--b1QUWVR6g+yF5Z0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDKfgAKCRB4tDGHoIJi
0gFGAQCFFB4aSpkhFmogKOTvVIErQ/Q6Kwr/jNWKW4HBU8EAUAD/XA8FEWYRpRAP
Vyg684+nNORfbZlq+EkwJdS+8HP/wwY=
=p7Fk
-----END PGP SIGNATURE-----

--b1QUWVR6g+yF5Z0v--
