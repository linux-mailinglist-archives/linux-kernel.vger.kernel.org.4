Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534736BE9B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCQMzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCQMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:55:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EAB2541
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C4BCB825AA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87F2C43443;
        Fri, 17 Mar 2023 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679057706;
        bh=k18uy8OPPsrShBwobjjGrG9H0/Rc4JOaj+IDtGpfrus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb6gwMJUCTUq8Si0Ca56dSiOVKyEAY6yYKIvhop1uDGamZIZ/W0lGmNdFCWdMH8WO
         0IEG/4qHRQgT5iEGAISO+zV2IXpqg1fUPSf0kotnOirK9gwXMtC3cCIJRi9cfOAmyQ
         J5q4zmXqmAOZf24DphJoOsOhz/C/8FLStDcvIuOtiVCeXz+xzC1ONsLBjTS1Pif4fz
         NqfRGi8zyJNV+JtM0BRtCJnY8iapk8MlUtnvn49xcBey5KyyrrWR9I6rpGzZatHHIs
         V6fVlkhObq9quBVv5FfXLhLYT+KAVycJvF1lM017ecdOqCc7AjJp8yeiHqy2i/AAPj
         XNkPVVpCBK+pA==
Date:   Fri, 17 Mar 2023 12:55:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dongxu Sun <sundongxu3@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH 2/4] arm64/signal: Alloc tpidr2 sigframe after checking
 system_supports_tpidr2()
Message-ID: <ae917789-3562-44d9-9860-db86b07953ba@sirena.org.uk>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
 <20230317124915.1263-3-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="366TaKwbCSC6iYPr"
Content-Disposition: inline
In-Reply-To: <20230317124915.1263-3-sundongxu3@huawei.com>
X-Cookie: Life is like an analogy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--366TaKwbCSC6iYPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 08:49:13PM +0800, Dongxu Sun wrote:
> Move tpidr2 sigframe allocation from under the checking of
> system_supports_sme() to the checking of system_supports_tpidr2().

Reviewed-by: Mark Brown <broonie@kernel.org>

I didn't check the context enough to confirm if this may reorder things
in the sigframe but given that we don't have shipping hardware yet and
the layout is generally subject to change I think that's fine.

--366TaKwbCSC6iYPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQUYyQACgkQJNaLcl1U
h9Aa7wf/VEksKAWpYjcDcTusEJlRBQNpfjGhGjx8/OPckRfBRkqeiyWblcQX1BOL
GWr4j5tOK4bl7dF5ItV/AKnVjgqENNTeIWSkM9Hj4OMvVIOKNlE4W3UlRFnVgpjH
ns0/6fBSHT5UGYpHE4CssDUwLTRkDhjUasXDUqmGK1N9aluKizFZMENkwtAuxx6f
wpYawzcaxrcw7iPjqzm/PlSMTHTLiYfwGT5comW8ZidyOa0ukkgu1m94rydlSiwi
BL5ShRr46Ln7Var8v5gyQgW0CLWK58IfMgNuxZc+8aFDJk7uW8/zouNZNsBUzNwo
2hJgKw7pL/6lhNpsT9C9BtR8xEsxPA==
=RNRN
-----END PGP SIGNATURE-----

--366TaKwbCSC6iYPr--
