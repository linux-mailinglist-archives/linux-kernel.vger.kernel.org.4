Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E36AC5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCFPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCFPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:44:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631629169;
        Mon,  6 Mar 2023 07:44:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3978C61007;
        Mon,  6 Mar 2023 15:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72517C433EF;
        Mon,  6 Mar 2023 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678117466;
        bh=Y/COJMV555nCCQenbT3ey1M4VPyf33xQgwNmG1ZwQFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YavORBuYHkKxe5naUomSULHwHbfKbDqI0ABgcMlLotGAFOhs+oWPPBm80rUujAhKw
         6pRUslqE/+QbfyzKhmAQBA29E3h9hhmdIpc8MUb+ZDlzw3S7UaXHJEjtzUV0TddsHH
         wMprD0aYI+4lMjuEQeCjXcYbru9t6A8F0vMPxFfMhfkacOP4/M1BjhXw+PO0a87FvP
         SBXbFN28kllnBIhE2OsBh9BQ1e7+6QOlQNfHsVKjn0vUCyU+c8JehtR0rE0wLEVII8
         LTyVktgTXwuLHZnaihY9zBInTlMTehj7YCCcQUqwjx/d4tNBV5O0W1H9wUtiXSStWK
         ItNjlgDnK0Khw==
Date:   Mon, 6 Mar 2023 15:44:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_sjaganat@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 2/5] spi: qup: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <9ca4c6a5-3d1a-4a66-9a5f-43f6f41ed7a1@sirena.org.uk>
References: <20230306144404.15517-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+iMhURA0px+4jxu2"
Content-Disposition: inline
In-Reply-To: <20230306144404.15517-1-quic_mdalam@quicinc.com>
X-Cookie: teamwork, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+iMhURA0px+4jxu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 06, 2023 at 08:14:04PM +0530, Md Sadre Alam wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--+iMhURA0px+4jxu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQGClQACgkQJNaLcl1U
h9DeUgf+I7TkDa9+pExZ7PF0RjD1DSGHUq6nFVQMYqV5ezQ0fPeJYUIy9M4ybjSZ
6BQ52rPYOrT02b/IefjOOjVq9uHhIFaeVgC6CpIk4ddEN04trz9VgTipm2sWRazD
GaMarbOtHN1oPO+yKgVYkaMuRcp6zqEcgYXdPqE4PBJYXX1zguz/wTTjM4BDxg9s
OTVaK6HyIc28j0QpufJT1fbmKLfhGg5eXX+h299o/rv6ijCZ2KrHk9WiB67JBMCG
rr5X5gfNYYvovPIjxc5gSl4We6wgASXa/LQhiHNdidK06gJ4bgip8JQliUzYijZX
2TosnptR/OxSG/THTopOdeR8Kgg6fg==
=TfgZ
-----END PGP SIGNATURE-----

--+iMhURA0px+4jxu2--
