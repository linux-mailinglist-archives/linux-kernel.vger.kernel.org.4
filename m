Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4BD6CA192
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjC0Kka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjC0Kk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:40:29 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345193A94
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:40:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D7EA240007;
        Mon, 27 Mar 2023 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679913625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpY9DCD1mIaNAsPVXMMa+YinIpx3N0fqEpjuBj6oEgU=;
        b=haaZrui7oihw9UxnD9hWxKhhodZldU8nVgUk/o79O2xruhBzUpYSFboH3DBRS0CyahwMy/
        WAi/T/WcjNKw2MGa5Su6mZ4ODfaVfdIeaqJXbSy+CrpVGHbv0hz6pvN9MEvknGROezkFNn
        DF98wpGGvAI+10e5HBF8FDv7GiZYUAWzb1VOdfNmDI3eL7VVSAAzj7PrK2IYiMRR1NTClY
        TPDlzydssppIUJRlOZkDMPtUrtKfMBQ1fx27DF3DQtTr4oYIHomad1psshvFqiHii4cmpi
        q/3DPPOxo632nbi8TIIFZgzHBHvmPq+x7DjIEf+ibJNxVif6AiokjI9YKRPirQ==
Date:   Mon, 27 Mar 2023 12:40:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/2] mtd: rawnand: stm32_fmc2: do not support EDO
 mode
Message-ID: <20230327124022.4bb32839@xps-13>
In-Reply-To: <a17cd888-ef4d-ced0-adba-c6a6abdba51a@linaro.org>
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
        <20230327094742.38856-2-christophe.kerello@foss.st.com>
        <a17cd888-ef4d-ced0-adba-c6a6abdba51a@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

tudor.ambarus@linaro.org wrote on Mon, 27 Mar 2023 11:29:56 +0100:

> Hi,
>=20
> On 3/27/23 10:47, Christophe Kerello wrote:
> > FMC2 controller does not support EDO mode (timings mode 4 and 5).
> >  =20
>=20
> commit subject and message should be in imperative mood, so I would
> change the commit subject to "mtd: rawnand: stm32_fmc2: Remove
> unsupported EDO mode" and the message to something like "Remove the EDO
> mode support from as the FMC2 controller does not support the feature."
> Extra points if you describe what happened when you used timings mode 4
> and 5 with the current version of the driver.
>=20
> Miquel, could you add Cc to stable when applying?
> Cc: stable@vger.kernel.org

Yes, absolutely.

>=20
> > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> > Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND fla=
sh controller driver") =20
>=20
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>=20
> > ---
> >  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/=
raw/stm32_fmc2_nand.c
> > index 5d627048c420..3abb63d00a0b 100644
> > --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> > +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> > @@ -1531,6 +1531,9 @@ static int stm32_fmc2_nfc_setup_interface(struct =
nand_chip *chip, int chipnr,
> >  	if (IS_ERR(sdrt))
> >  		return PTR_ERR(sdrt);
> > =20
> > +	if (sdrt->tRC_min < 30000)
> > +		return -EOPNOTSUPP;
> > +
> >  	if (chipnr =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> >  		return 0;
> >   =20


Thanks,
Miqu=C3=A8l
