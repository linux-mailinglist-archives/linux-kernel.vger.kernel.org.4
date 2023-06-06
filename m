Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3F724A89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbjFFRta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjFFRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600910F4;
        Tue,  6 Jun 2023 10:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5DB6306F;
        Tue,  6 Jun 2023 17:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EAEC433EF;
        Tue,  6 Jun 2023 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686073766;
        bh=pgWxxc2pXaOIXxZHnc21uLoXRzmI3gMVWZH7Ahht6W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6CkLvGT6/u2gYsz2ZI9hsYNyI3961g9ByfPqZHHlddzADAlS4V7qRk/yYmkgO3SP
         Ns4wZs1+t/vQI10WhNoIFVCMMalJiGq57xVqDsF1un74bOLtavajk/clxqYjx6Ppeg
         faNiRttu1ryG+NxJHpAt0n3zClE/z8wkCsFVyj7buTX16ffEbiTcNoDpaUQZJbHnfS
         8WuyB3/mk8DKVRcJuUClaXfoKxy8jFiVHYGdFKxyC/74go0DR5ehdHstQytcCdJW2/
         DrtcJE4IcMvrDKUb/tEfIr5yxJx98dJ994HnlEZhu1+UYXUuFQGWf10HLGHvBJAz2k
         CpPpcuuqYNI8g==
Date:   Tue, 6 Jun 2023 18:49:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Subject: Re: [PATCH v2 0/2] spi-geni-qcom: Add new interfaces and utilise
 them to do map/unmap in framework for SE DMA
Message-ID: <bffedd6c-acc2-4c89-9e4d-82aa70249b57@sirena.org.uk>
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AcBOIuEM4L/yvJax"
Content-Disposition: inline
In-Reply-To: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AcBOIuEM4L/yvJax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 17, 2023 at 05:48:12PM +0530, Vijaya Krishna Nivarthi wrote:
> A "known issue" during implementation of SE DMA for spi geni driver was
> that it does DMA map/unmap internally instead of in spi framework.
> Current patches remove this hiccup and also clean up code a bit.

Given Konrad's review I'll go ahead and apply these on a branch
(assuming my CI is happy), if there's a need to merge them into the qcom
tree I can sign a pull request (or revert the commits).  Hopefully
that's OK with everyone.

--AcBOIuEM4L/yvJax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/cZ8ACgkQJNaLcl1U
h9C1MAf/b+Cz+UhbCvp93H9oihETiPDy+5bjUooM27kl60urEm1j+ViCXUDFJwE4
ZoctmMVAUSWKbZs9Ad1iaukoiVJ52HjcmPUXu1V7KTnNNCMBUSRGA12Rt4e38G0b
2kg8YqAo7QhHaCBmIWNoUgZfCCiezuDBX/4Y3kRUIqUZT48ymfUwMUdIMwstDfWd
ehx+XCQkFm/qfXf735N+fg98AVVGpbdLakgSdK3BtA6eh2Et60xtckdzl32oJTYj
RSgoM8R7nS0R0YQmf5bPpkMt4x+xcCH9/sw/wT1sPi5Dif7lH5w0DoOTwcp3x7/2
IhFRytVhDnNzUZ3H92Phh47EoS5nnw==
=VF1y
-----END PGP SIGNATURE-----

--AcBOIuEM4L/yvJax--
