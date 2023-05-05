Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57FE6F841C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjEENdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjEENdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81820769;
        Fri,  5 May 2023 06:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272DC61035;
        Fri,  5 May 2023 13:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33AAC4339B;
        Fri,  5 May 2023 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683293616;
        bh=mwqoQO38w+V3pgb84DrA2oJJEX0u9T37WvU9ldSdV+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ng+1e5M4ix9INnlBoq6xpRPfZvWJDO4lyD6unpuFRTO61mNkFnTfR7GgVKYj/gZ9G
         /iEjTDtPIFg4DSy9QbK3mq50jCN2SO+ZXmeM7qIKIlabmJCzfvFckjphLcpjW4bEpm
         lsNPNlFjxbW8cZqcpMhfsaohGmg+qIRbdnw2RWa+Xi4BGtX3UFMJE/Ciz+3hKPv/vs
         3OviYPVgb7llrDfukvAi3348mZLVVw45hdcsUy1HoPWWBB1z7ak0Dk8amj62E4PuGT
         X/YxKUrghpijwJlqSAP+1wTJXzMcghIMRWI12FxLNWfWWhZwey6/IvswSk5+FedVqi
         6dQ8Q3OcfAZzg==
Date:   Fri, 5 May 2023 22:33:33 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        oder_chiou@realtek.com
Subject: Re: [PATCH] ASoC: dt-bindings: rt1016: Convert to dtschema
Message-ID: <ZFUFrWqOHVmzE+ut@finisterre.sirena.org.uk>
References: <ZFUFAmBJXvkQAG7m@yoga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AyRtPdmLQG54+4Aa"
Content-Disposition: inline
In-Reply-To: <ZFUFAmBJXvkQAG7m@yoga>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AyRtPdmLQG54+4Aa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 05, 2023 at 07:00:42PM +0530, Anup Sharma wrote:

> +maintainers:
> +  - oder_chiou@realtek.com

If you're nominating someone as the maintainer for a binding it's
probably best to copy them on the patch so they're aware...

--AyRtPdmLQG54+4Aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRVBawACgkQJNaLcl1U
h9AGbgf+PTsUzX2cym2JdhTl5yFGJj8rbfOCKPIS4ks0o52lfBdwu+gqXf1DiYie
LcNNgDPmZZBoPTDDo/86bdVpIZDgBpkul4xNjDAxnIOi9Td4QmwNZ/dPW8yJa76S
NltJATrzlEGS+eJyI+s2HDT8RrBV2Fi3kLBLEZ4m2wsqz5d3dGwMlqX1GPLytO1w
cREcovpaCDnIc5mPxHRuOB8zPB1zqSJ9bY1xLjSKbM6k0Q8NhvZNtpDE44QrlYPi
bO4Ip2mdkL9qCfThdtSiWpvRFdA14nXgeL5RRTTf5YaHw5xFxp9QdER1Q19aegLs
WtItwmcXeMeowfbVSnathYByRMtl+w==
=Puba
-----END PGP SIGNATURE-----

--AyRtPdmLQG54+4Aa--
