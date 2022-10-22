Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0E608F50
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJVTpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVTpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:45:00 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EB329351;
        Sat, 22 Oct 2022 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666467891; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKG8yyO0OUzw5i6dz7sE84w3Ric4+ES8JoUPSd0r/9E=;
        b=3wTQBitGlBfE0dZ6dg2p95KRlpS3hLVFIcvp3md/n8YQzBOUAMeyw8cI1VUJCpd0XnPIbg
        BDkyIAbiYwiIR1mdONGl+7F+S1jkGyQsmQCexhnFOC2PAFgjonBJc6rummtvXKDJ86aIK/
        4V1y/Ohb3LUHZcWj5BoRu8uXMyyYpMw=
Date:   Sat, 22 Oct 2022 20:44:40 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 0/9] ASoC: cleanups and improvements for jz4740-i2s
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <GU66KR.0W1UC5ES8HSL1@crapouillou.net>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le sam. 22 oct. 2022 =E0 20:12:59 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This series is a preparatory cleanup of the jz4740-i2s driver before
> adding support for a new SoC. The two improvements are lifting
> unnecessary restrictions on sample rates and formats -- the existing
> ones appear to be derived from the limitations of the JZ4740's=20
> internal
> codec and don't reflect the actual capabilities of the I2S controller.
>=20
> I'm unable to test the series on any JZ47xx SoCs, but I have tested
> on an X1000 (which is the SoC I'll be adding in a followup series).
>=20
> Changes in v5:
>=20
> * Drop 'mem' resource removal patch already upstream.
> * Update FIFO flush bits fix to address Paul's review comments.
> * Drop PLL clock name patch, that needs a different approach.
>=20
> Link for v4: URLHERE

Forgot something? ;)

-Paul

>=20
> Aidan MacDonald (9):
>   ASoC: jz4740-i2s: Handle independent FIFO flush bits
>   ASoC: jz4740-i2s: Convert to regmap API
>   ASoC: jz4740-i2s: Simplify using regmap fields
>   ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
>   ASoC: jz4740-i2s: Align macro values and sort includes
>   ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
>   ASoC: jz4740-i2s: Support continuous sample rate
>   ASoC: jz4740-i2s: Move component functions near the component driver
>   ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops
>=20
>  sound/soc/jz4740/Kconfig      |   1 +
>  sound/soc/jz4740/jz4740-i2s.c | 455=20
> ++++++++++++++++++----------------
>  2 files changed, 243 insertions(+), 213 deletions(-)
>=20
> --
> 2.38.1
>=20


