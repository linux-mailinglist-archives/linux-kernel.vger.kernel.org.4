Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8162872FD43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjFNLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbjFNLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329E713E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A72BA63F8D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B74C433C0;
        Wed, 14 Jun 2023 11:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686743097;
        bh=mRsaznmzGXzIczeOSX2uDAlpUQy8Pf4c2JwPzc7rmyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrIDsfUU/VJJjis2yLEIsgWlj/vUF75EjKf0N7ofz0lq3vOjwV1QwnzU9NTiK3GiN
         A6U5Jgf2Ne79UBVvx2tFlfZydbExg9zv+cKs33zWxuARkIr3t6ABPvy9lAbITgQ5QT
         uPU/I/HrUE9+Arwlhdk1QTlZoaZMGBeqAdkZ3fdhpMrLtSvQukO8owvxTvg1dugImZ
         a5u5ejYPxvASPFhSkzKPYOPJUMK4oqZ35quzngKkRUrmieNkyPurPLIC1TyIpXY15b
         l/bXjwXuLeg8ugGqYuUoKeUOOb63+/X2RG1i00sTnVE3tgtKJVd1uF2EjnETJU0V1e
         phCK5NHbX0xfQ==
Date:   Wed, 14 Jun 2023 12:44:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 13/14] arm64/sysreg: Convert TRBTRG_EL1 register to
 automatic generation
Message-ID: <597c2ca1-7de3-4c61-8e3a-e918b5787bbd@sirena.org.uk>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
 <20230614065949.146187-14-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GL5ZVFDswGNHVu88"
Content-Disposition: inline
In-Reply-To: <20230614065949.146187-14-anshuman.khandual@arm.com>
X-Cookie: At participating locations only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GL5ZVFDswGNHVu88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:29:48PM +0530, Anshuman Khandual wrote:
> This converts TRBTRG_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

--GL5ZVFDswGNHVu88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJqDIACgkQJNaLcl1U
h9B8/Qf/TJvr4BW8fgH5waCN3aQS2fHWR+qjYQDgXTV1sU2q5oRdK39We/HZZ4Nq
6szqWzPgy8BRur3SMQubEntbc2NF6TnvLhc2YDCzKTzIg3NXO5KOM8kqkogwS4aU
Y7CQh67fG6fTcYtbNYWebcbpzHycVgFB2vTvRvivvHhneii+RKgQU8ol9VWPQn8g
wh1M6LmVexQAneG7np7p6+MT9mdV7+BNi5NYR4qa52z96EzVxzDqXD/GjWVCBv89
iE3aGcYRXIHz23mvDkZT1owrJQAqvDfRkdxE/eWfe9OFWUTNy8QvRp1TmsbTVKQs
63ZVBc/UccucXX7WviipHbaQ9E/zHA==
=+QZP
-----END PGP SIGNATURE-----

--GL5ZVFDswGNHVu88--
