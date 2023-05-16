Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5E704274
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjEPAwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjEPAwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C891FC8;
        Mon, 15 May 2023 17:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8F9632F4;
        Tue, 16 May 2023 00:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBFCC433D2;
        Tue, 16 May 2023 00:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684198318;
        bh=p//zJfvUfJYrwr1AEqnxk2yq8WlkN6Ya6C57zZNboA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+HTY9mPGr0XkSxPkHoI37scNHW2kR2iCyOKBDiQjpatdIzHnS5iWSmAcGqBDYjBu
         H1J7PJK8EbL3o6xiskxEYJHyXnBY7etBN9PDeDrZUJrRTuFnHn4aZpSrz9ORYs+TTx
         TF2pOPJbExegK5MSuX9ZBorOhCeBEYjh5Hd71q4eMW8mxWrhttGhYY+r747iOC7eXD
         ZbSOc9x+FIuaC0xTCJxLTiwjWRtM8Q9m+Be9Kxmv3bbQCfTHFMO5jR127aTdQA6Y3t
         jBg0AS4QQVifVhKFlO8ACKtJi2/2lRrjLAuAtdf8IgX4SgxUJK/jo1Uktp9sFVBzcb
         tdVgvSlBKFszg==
Date:   Tue, 16 May 2023 09:51:55 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator:
 qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
Message-ID: <ZGLTq02Uq5mPJvxE@finisterre.sirena.org.uk>
References: <20230515145323.1693044-1-amit.pundir@linaro.org>
 <20230515160026.ynqsgu4wvsqxnj2h@ripper>
 <CAMi1Hd2-sZ9xFwq0-neoN+G93pv9Qgc94L71cwoimmpnVOkf6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6aFpGRiv9dr80kZy"
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2-sZ9xFwq0-neoN+G93pv9Qgc94L71cwoimmpnVOkf6g@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6aFpGRiv9dr80kZy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 11:01:31PM +0530, Amit Pundir wrote:
> On Mon, 15 May 2023 at 21:26, Bjorn Andersson <andersson@kernel.org> wrote:

> > PS. this is a patch in the regulator code, but I don't see Mark in the
> > recipients list...

> Sorry about that. I thought I had Mark copied over from the other
> thread, after-all he was the one who suggested this patch, but I
> didn't :facepalm:

Please resend a copy of the patch to me and...

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--6aFpGRiv9dr80kZy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRi06gACgkQJNaLcl1U
h9Czogf9FGswNTVFIGQovUwnYsAJe3ZAzQKigRM+1Yy8Wzq2FMqJw59xxViKtofW
5ik3SZrE94ru39Pt1QGAaeBbro8kF/NHIOjqVl3RZ5Q1GReSjeQDBQB8/mL6krvM
p64abQZ5DIT3dy7haSZviFkeGURViaoInlcmg3JOXeATBvvx6ep2nAJumNrwQmJV
L0iO2OVBD1Usr9NGf/QxKrTWUIp0hkLEWrUVRk6Ksc/6KsNFw2CiQxVqkad3dDiQ
CKswzVZJBm5OXe/87xEFdveH0Y91EdDqDF5ZoukCLTDaASbp52tXLzHw/JPB5cQB
wJylw46kgkS1Cf6q7ggyj3SioWUumw==
=yMMa
-----END PGP SIGNATURE-----

--6aFpGRiv9dr80kZy--
