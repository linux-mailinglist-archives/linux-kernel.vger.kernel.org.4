Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC60730A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjFNWV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFNWVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A591FE8;
        Wed, 14 Jun 2023 15:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F5162AAA;
        Wed, 14 Jun 2023 22:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251AAC433C0;
        Wed, 14 Jun 2023 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686781283;
        bh=Z1Izk9iRbMfyIGsY6yELiTVpEMZy0QyWjkNZevLJDA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtTPK2aVABZzaaqJlTNYOJ8CODqst+93UsKpeMB6ALuyWcs4Eo1t+lJ0GC4w+obtE
         jTRpcMXA7UDMVWo2nMdtTNvF8s9UUT6s1Jl4mJkkfI7VdDgRxg/KiwnEzdLjq7+zQA
         5KCxrbeZz425UJs5kVqzFyTvUoe51MFhcjBn3NISg066Ah2rU0bVYBC8onvpUlKgvg
         XEmf7uUvcuiapKIcuE8NUKHApzo9E2Sry1qIVowfN9CsmvKNxfcmiauU7cQkD3Ne1y
         c6oL98bA4xfadPnvE47La/DcE/NStPbKeiEnTDgo1TAQiRUiLNNIkJ9blMFFNscaob
         COT11XqjCWvgg==
Date:   Wed, 14 Jun 2023 23:21:16 +0100
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
Message-ID: <74e31bff-81ed-44f5-9b38-8ee40822e833@sirena.org.uk>
References: <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
 <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk>
 <CAMi1Hd2BLB6H3QRLB5svRTkGoXaUeEsakNsmfCOjbDBcCEeqkA@mail.gmail.com>
 <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com>
 <CAMi1Hd12S+bKyp=CHwoioYoojtFzaA1tey19BqAFi+4DeJR__w@mail.gmail.com>
 <CAD=FV=XxWWxWB2zZwUdnRQkiiMbuC=Bx=ibRWG92nFzbXgHWHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WHuzyuxq/wIZTUS7"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XxWWxWB2zZwUdnRQkiiMbuC=Bx=ibRWG92nFzbXgHWHw@mail.gmail.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WHuzyuxq/wIZTUS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:35:08PM -0700, Doug Anderson wrote:

> Super weird. I was hoping that something would jump out, but nothing
> does. :( I don't understand how lvs1 / lvs2 could have any impact on
> ldo12. :(

Does a device connected to some combination of these regulators have
power sequencing issues?

--WHuzyuxq/wIZTUS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSKPVsACgkQJNaLcl1U
h9B6Lgf/ZNqbIjEys8PeLhB/GEA05dO69hv0sLGe+/59+8xLHeXuEg9kKe4t0eUi
EhYbTwQAveGWuYxcpntZkE9ai4lo4mh5LIXXRQ79NfTDLdfVaD4a52IeiBdkO7SL
Fpi2ulM6KZVIQDW0fdR79h9aO1+86mUvWzEXimZFpjsCBOBHReSafTImdL5H7MCj
D9erusqVu7ypX3rsIlT+KnqtUocSy9fIDnwI5S57yADGHQh/Dm50zxY1/L/bkZt5
Du88glWqtBk0wbn0gQFUv6KKyUp3lcU6naPZgm0QcHNT7oWzI1iKi4Yp/b1pLk7P
1tkozTEcC7GWrE6dr0/QE7oY5CE0Sg==
=ZUpv
-----END PGP SIGNATURE-----

--WHuzyuxq/wIZTUS7--
