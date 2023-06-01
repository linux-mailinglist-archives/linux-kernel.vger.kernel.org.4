Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1367719AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjFAL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjFAL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A55123;
        Thu,  1 Jun 2023 04:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 535DC643D2;
        Thu,  1 Jun 2023 11:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A217CC433EF;
        Thu,  1 Jun 2023 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685618968;
        bh=YRpFV9EHccLiEr00ihV1MVHY1R0+dLRW9dyu9NplvMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSWlNENd8xqQprpGuF8Mhh0IbIukZI5MPrw5orokNRPf8E+42PK1wiHIOYFSNEf7w
         644oct61rq004fmUbO7GU84F7lBCfbxqX+h+0hi2qsfira7vhjzDXfc0FaIh6Q5l0d
         8MuUwpPPSMlP4/bk6jA3hdxGZkxMsjAQ/a3Pbv1tX1BFmNpNkG3LYqlA3dGOT572AV
         T0dgJxIx+ACORWzL0Gispcl3WTq52rqE7kAzSZRgNv801uENOqemHGhLdzJm+e3/BW
         NBkDychAbx9brsohEl9IFmkZWLcDQgIJIxVBH1iidKntxmZ815jjDVLMyl8wdbtix5
         l6VMQctt3QhdQ==
Date:   Thu, 1 Jun 2023 12:29:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, amergnat@baylibre.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: add
 NAU8825 support
Message-ID: <df12a113-109a-438c-9a6f-ece021550b69@sirena.org.uk>
References: <20230526093150.22923-1-trevor.wu@mediatek.com>
 <20230526093150.22923-8-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JmksfPfyy4Bj0Tfi"
Content-Disposition: inline
In-Reply-To: <20230526093150.22923-8-trevor.wu@mediatek.com>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JmksfPfyy4Bj0Tfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2023 at 05:31:50PM +0800, Trevor Wu wrote:

> +      dai-format:
> +        description: audio format.
> +        items:
> +          enum:
> +            - i2s
> +            - right_j
> +            - left_j
> +            - dsp_a
> +            - dsp_b

Why is this a DT property - why not just pick one in the driver given
that it's for a machine with a specific CODEC?

--JmksfPfyy4Bj0Tfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR4gREACgkQJNaLcl1U
h9AxeAf/ehUGBygKINW6H+yy1gZ0HlpXhYS4swWucFmZqVQIaksZAUR2ly+8bPzD
Puhp4M5k+HV/+H+VLnmi1MGn803l5bD1q3Y4Ecy5mMz8cSzQx3tNEwL+htYaUeg6
pchi7gBYaiBd3nVWeEWelIsBx+1UYRURJ3r+YoCXRVAHaYCsbJynauBKCOAizCfG
W7MItpvce9g75QWSuifAPhQOEggg5eo6eGlq7omEVkvzUrExfGSM5L8bCMdGar90
dqHOrZSq0B0q2w6yGGG9KFvcqvSbnErkngpBeI33DBTDfCIhHuytcB+M3pLhFOnc
nKhBAj+1yD+OMbQC+HYc94d+bsXErQ==
=Zpw4
-----END PGP SIGNATURE-----

--JmksfPfyy4Bj0Tfi--
