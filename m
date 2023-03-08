Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99496B06BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCHMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCHMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:16:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906109B9BB;
        Wed,  8 Mar 2023 04:16:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03F01B81C1D;
        Wed,  8 Mar 2023 12:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE39C433EF;
        Wed,  8 Mar 2023 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678277770;
        bh=KC0YZnqkegel0Wd6R/Ib4E4uhNPmn4gGoPHHei7FQxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbTK22huv0wHgNWNeCYqqQVnHVHB7wxpMyfBYfftws4HUcIVBdiGfhfNsEZSKxLOB
         tOAf/xfwpC2jOciGE9+eyGtAFDsJmPEL+hze8mLigH5vN/1iNRqLLaX1x8ipzu1N3r
         3e1vcZcSJhu1Z+9l51F56BMwerB5g56HSvSJhIgLhRfwyseU/pAw3VeeUS3yiEMzIS
         2RVIzCC7DUunSI/LBDH5DqtTtTTazO5YuFm/dFTZIQbobsL80e8b6//4vOVM3N+9Xu
         H6eHC0jMPONfPpciMmk4x8RAYZt6ZkOIDIWRwD3gLy4x7upKcQoppfPTo0JyLeMHzA
         ozyqh8tauY1Sg==
Date:   Wed, 8 Mar 2023 13:16:03 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        niklas.soderlund@ragnatech.se, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] thermal/hwmon: Use devm_platform_ioremap_resource()
Message-ID: <ZAh8g6vJ+U7fjeMW@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yang Li <yang.lee@linux.alibaba.com>, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308060357.45647-1-yang.lee@linux.alibaba.com>
 <CAMuHMdUSpSBriV8i=zSbSqeDTxnf_QuXO+u1Cx+jXshBaSbiZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rXc4PBbO1szPSvrm"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUSpSBriV8i=zSbSqeDTxnf_QuXO+u1Cx+jXshBaSbiZg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rXc4PBbO1szPSvrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Note that there is a second opportunity for conversion in the same
> function, a few lines below.

This should be fixed in a V2, then, not in an incremental patch, please.


--rXc4PBbO1szPSvrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmQIfIAACgkQFA3kzBSg
KbaEYw/+KPXroivCh/OMjqZM3XxhrjQk7ape9bPe2+sf+CKwBKqLcrzAvY0mqiSy
g9MV26CszagIXIwbXi1mSSxdNCdtDpyXpaiSu222yrrkrmSwkU/YshtewvgYIW73
1EVxDErI3jZaWrLdnepCLZLwyIc2Q00VjoFqeAtk1kRaxWt5iDTnlVUbAQLThuD4
D+psJ2z0KnNgchE3dGUREnjMY0LYjmieVVjkOR9koEcUs1uiveatrh07inlTSxBk
ZLq/vW8ZYI70AOYf/C46U154QKJNB9BbFI3e9D2guxR53cLkWZFhYDEsuKiAOysW
GyEZRdG6XnJRVoM7z4jZ/4TED8G1zQCHWE5kWZtF9avOtDyB+Fd/J8zPDsyhtnmj
hczGLykRyCQMpS0OcP1ZOC+yo3Hzp07vwkDWtyKoClCHWqTxsQTAuzlsisYhhZdv
QtaZ475akaN6woY8iRYBen8TQpJjC4/Qp4e6RB+hGAtuiM6z/oVZKLLt5wsvNCA8
S25wwy7XlfUFu1gBSqNVSUmUTkIB+ztf4VFR2t5uAXfadd1LIdZDzFgnZUpPPTk8
f4uSQaq5/d5FYjypN0RloePmjNrL67TehSfivcHOAry1MtrQ6SFh3UHkRRW+Hth4
bU6f0RiwhpzyBLqh24jVJleFZaC0yIv/TpsCKNywUozL2e/VT0A=
=irML
-----END PGP SIGNATURE-----

--rXc4PBbO1szPSvrm--
