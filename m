Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910487260FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjFGNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjFGNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCF95;
        Wed,  7 Jun 2023 06:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9A9636FA;
        Wed,  7 Jun 2023 13:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E97FC433EF;
        Wed,  7 Jun 2023 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686143923;
        bh=WxgZIQptIHBdnIK+DpPdQfEiZujBDHMavZ3LhSAH/2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhOWWFcTf7P8IX7QxZBfqQccHuh6fNLU5S05ejB0LiB4yF3C/UzSEtc7awEzLKKWT
         9bJYHonMToJTWiwzzC6D8h0H3ui3qa/914ySoAt4aUCoJbIelqkZwMqS6x8RzrsVGx
         NwexJdFEr4pX8DcomVdDAIVlQuLjx/XxuYZLVsHU5U+YVYIKKvuUYi4DDKpBBv7NhS
         MkrsoZPtFIIwwNZHF5bX0ZIUUW6A8xoK7noGXouR7IBAjcRq5hQXocEkqfFFGIDM6P
         Li6HkjIbQQiBfIjyLxDCHmjwAjQ56ZEWMSTkvmFXbOVYHm8pCZSX5SCBYgdA11fEcA
         MU/eiBldHhd4Q==
Date:   Wed, 7 Jun 2023 14:18:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Message-ID: <bb5c828a-b8c5-40a0-9b67-44e73abcbef0@sirena.org.uk>
References: <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
 <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk>
 <CAMi1Hd2BLB6H3QRLB5svRTkGoXaUeEsakNsmfCOjbDBcCEeqkA@mail.gmail.com>
 <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcn5b//ImkBj2WYw"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com>
X-Cookie: Keep away from edge.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kcn5b//ImkBj2WYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2023 at 04:29:29PM -0700, Doug Anderson wrote:

> 2. Try adding some delays to some of the regulators with
> "regulator-enable-ramp-delay" and/or "regulator-settling-time-us".
> Without a scope, it'll be tricky to figure out exactly which
> regulators might need delays, but you could at least confirm if the
> "overkill" approach of having all the regulators have some delay
> helps... I guess you could also try putting a big delay for "ldo26".
> If that works, you could try moving it up (again using a bisect style
> approach) to see where the delay matters?

This is information which should be in the datasheets for the part.

> Currently, I guess my mental model of what might be going wrong is
> that regulators are all turning on / adjusting really quickly. Maybe
> they aren't switching into "high power mode" quickly enough, maybe
> they are busy ramping up or down, or maybe there's simply some other
> issue, but I suppose that something happening could be causing the
> voltage to droop down (or be too high) and then that's making RPMH
> upset. Changing the order could be helping avoid this droop, but the
> more proper fix would be to actually account for it with regulator
> constraints.

There could potentially be inrush issues, though I'd not expect
reordering to help much there.

--kcn5b//ImkBj2WYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSAg6wACgkQJNaLcl1U
h9CQHAf/VzWxsU8jJFk5nll4BbFm2/zPEsihLJHPsWxVf8BUdxaVsWLetMpRFV+y
JCriXoPBaKl+brdPEkvAJ5WuXzKNNKBW8tnIQILHv8LDYAVXVvl9fFoflfzmMoHI
gFdkA76h9ZcNNj3jjQyTte4RMCRBKmll+uTjPOcmJJBx2fmEqTyhX963yxzxqTlM
PTTdSaaqBotdP2VKO9188MPPMBpEMlwsKRwaneYbU2FIXNniliyLrcOGkiU7Djfe
MMKxbUFZgST8MX+o4Pv8upqDvNtiMZDyNNpqrGEG7s/pVYwG6E69iCed4fmWN63V
4rHhXlm3Mi7lq988USh5UEVaH3D6PQ==
=YKW8
-----END PGP SIGNATURE-----

--kcn5b//ImkBj2WYw--
