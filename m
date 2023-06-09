Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37E729352
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbjFIIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjFIIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:36:00 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2082D7B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:35:50 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686299749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbW8ZoZ2WB+MPqoT2K0NHTY8agi13RkO8PWvk4ESQ5I=;
        b=MiZF8mozKCuY0AYxkBXCaeIBcDih40mUniQud+BCbXNvCqLwYFzPUxrbp+K1Rl4UH01F4N
        3v40wUTTY73njfCmYRyqV2+uvZRD6q6KjJegCoALbcjme6X3KjF43luNwlZs4TsrJnFKvQ
        Yq1pAZKpcldeVKAy27UGQzdzJpzifO2cseGcgpvNcBMVVKEpZlncoP4Z2X3ZB19sLBRljE
        /hF0n1NzTAkSxvWlxzhnt1m+v7O0HrUrjbRHskRD+gpAL7rDQCVab9bevetDBdEzsMBW3n
        mbvm+TA79iccWbUsvUppEFiaSyNjFxYVUN5znimCsDWVqbc26B+wPkFviBgPjw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D47966000D;
        Fri,  9 Jun 2023 08:35:46 +0000 (UTC)
Date:   Fri, 9 Jun 2023 10:35:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
Message-ID: <20230609103544.0f00f799@xps-13>
In-Reply-To: <4ab08e3e-3be4-8b8b-6eb8-03a62337f46f@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-11-william.zhang@broadcom.com>
        <20230607102232.17c4a27b@xps-13>
        <7b393f47-4053-a8c7-f32e-3881d8130d80@broadcom.com>
        <20230608081821.1de5a50b@xps-13>
        <4ab08e3e-3be4-8b8b-6eb8-03a62337f46f@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Thu, 8 Jun 2023 12:10:06 -0700:

> On 06/07/2023 11:18 PM, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Wed, 7 Jun 2023 13:24:23 -0700:
> >  =20
> >> Hi Miquel,
> >>
> >> On 06/07/2023 01:22 AM, Miquel Raynal wrote: =20
> >>> Hi William,
> >>>
> >>> william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:50 -0700: =
=20
> >>>    >>>> The BCMBCA broadband SoC integrates the NAND controller diffe=
rently than =20
> >>>> STB, iProc and other SoCs.  It has different endianness for NAND cac=
he
> >>>> data and ONFI parameter data.
> >>>>
> >>>> Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
> >>>> and performance improvement using the optimized memcpy function on N=
AND
> >>>> cache memory.
> >>>>
> >>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >>>> ---
> >>>>
> >>>>    drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 36 +++++++++++++++++
> >>>>    drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 44 ++++++++++++++--=
-----
> >>>>    drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  2 +
> >>>>    3 files changed, 68 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/m=
td/nand/raw/brcmnand/bcmbca_nand.c
> >>>> index 7e48b6a0bfa2..899103a62c98 100644
> >>>> --- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
> >>>> +++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
> >>>> @@ -26,6 +26,18 @@ enum {
> >>>>    	BCMBCA_CTLRDY		=3D BIT(4),
> >>>>    }; =20
> >>>>    >> +#if defined(CONFIG_ARM64) =20
> >>>> +#define ALIGN_REQ		8
> >>>> +#else
> >>>> +#define ALIGN_REQ		4
> >>>> +#endif
> >>>> +
> >>>> +static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  v=
oid *buffer)
> >>>> +{
> >>>> +	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
> >>>> +				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
> >>>> +}
> >>>> +
> >>>>    static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
> >>>>    {
> >>>>    	struct bcmbca_nand_soc *priv =3D
> >>>> @@ -56,6 +68,29 @@ static void bcmbca_nand_intc_set(struct brcmnand_=
soc *soc, bool en)
> >>>>    	brcmnand_writel(val, mmio);
> >>>>    } =20
> >>>>    >> +static void bcmbca_read_data_bus(struct brcmnand_soc *soc, =20
> >>>> +				 void __iomem *flash_cache,  u32 *buffer,
> >>>> +				 int fc_words, bool is_param)
> >>>> +{
> >>>> +	int i;
> >>>> +
> >>>> +	if (!is_param) {
> >>>> +		/*
> >>>> +		 * memcpy can do unaligned aligned access depending on source
> >>>> +		 * and dest address, which is incompatible with nand cache. Fallb=
ack
> >>>> +		 * to the memcpy for io version
> >>>> +		 */
> >>>> +		if (bcmbca_nand_is_buf_aligned(flash_cache, buffer))
> >>>> +			memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
> >>>> +		else
> >>>> +			memcpy_fromio((void *)buffer, (void *)flash_cache, fc_words * 4);
> >>>> +	} else {
> >>>> +		/* Flash cache has same endian as the host for parameter pages */
> >>>> +		for (i =3D 0; i < fc_words; i++, buffer++)
> >>>> +			*buffer =3D __raw_readl(flash_cache + i * 4);
> >>>> +	}
> >>>> +}
> >>>> +
> >>>>    static int bcmbca_nand_probe(struct platform_device *pdev)
> >>>>    {
> >>>>    	struct device *dev =3D &pdev->dev;
> >>>> @@ -75,6 +110,7 @@ static int bcmbca_nand_probe(struct platform_devi=
ce *pdev) =20
> >>>>    >>   	soc->ctlrdy_ack =3D bcmbca_nand_intc_ack; =20
> >>>>    	soc->ctlrdy_set_enabled =3D bcmbca_nand_intc_set;
> >>>> +	soc->read_data_bus =3D bcmbca_read_data_bus; =20
> >>>>    >>   	return brcmnand_probe(pdev, soc); =20
> >>>>    }
> >>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/=
nand/raw/brcmnand/brcmnand.c
> >>>> index d920e88c7f5b..656be4d73016 100644
> >>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >>>> @@ -814,6 +814,30 @@ static inline u32 edu_readl(struct brcmnand_con=
troller *ctrl,
> >>>>    	return brcmnand_readl(ctrl->edu_base + offs);
> >>>>    } =20
> >>>>    >> +static inline void brcmnand_read_data_bus(struct brcmnand_con=
troller *ctrl, =20
> >>>> +					   void __iomem *flash_cache, u32 *buffer,
> >>>> +					   int fc_words, bool is_param)
> >>>> +{
> >>>> +	struct brcmnand_soc *soc =3D ctrl->soc;
> >>>> +	int i;
> >>>> +
> >>>> +	if (soc->read_data_bus) {
> >>>> +		soc->read_data_bus(soc, flash_cache, buffer, fc_words, is_param);
> >>>> +	} else {
> >>>> +		if (!is_param) {
> >>>> +			for (i =3D 0; i < fc_words; i++, buffer++)
> >>>> +				*buffer =3D brcmnand_read_fc(ctrl, i);
> >>>> +		} else {
> >>>> +			for (i =3D 0; i < fc_words; i++)
> >>>> +				/*
> >>>> +				 * Flash cache is big endian for parameter pages, at
> >>>> +				 * least on STB SoCs
> >>>> +				 */
> >>>> +				buffer[i] =3D be32_to_cpu(brcmnand_read_fc(ctrl, i));
> >>>> +		}
> >>>> +	} =20
> >>>
> >>> Perhaps we could have a single function that is statically assigned at
> >>> probe time instead of a first helper with two conditions which calls =
in
> >>> one case another hook... This can be simplified I guess. =20
> >>>    >> Well this will need to be done at the SoC specific implementati=
on level (bcm<xxx>_nand.c) and each SoC will need to have either general da=
ta bus read func with is_param option or data_bus_read_page, data_bus_read_=
param. =20
> >=20
> > You told me in case we would use exec_op we could avoid the param
> > cache. If that's true then the whole support can be simplified.
> >  =20
> Correct we may possibly unified the parameter data read but exec_op is lo=
ng shot and we are not fully ready for that yet. It also depends on if the =
low level data register has endianess difference for the parameter data bet=
ween difference SoCs.
>=20
> So I would like to push the current implementation and we can explore the=
 exec_op option late which will be a much big and complete different implem=
entation.

I am sorry but this series is totally backwards, you're trying to guess
what comes next with the 'is_param' thing, it's exactly what we are
fighting against since 2017. There are plenty of ->exec_op()
conversions out there, I don't believe this one will be harder. You
need to convert the driver to this new API and get rid of this whole
endianness non-sense to simplify a lot the driver.

>=20
> >>   Not sure how much this can be simplified... Or we have default
> >> implementation in brcmnand.c but then there is one condition check
> >> too. Page read is done at 512 bytes burst. One or two conditions
> >> check outside of the per 512 bytes read loop does not sounds too bad
> >> if performance is concern. =20
> >=20
> > It is unreadable. That is my main concern.
> >  =20
> >> =20
> >>>> +}
> >>>> +
> >>>>    static void brcmnand_clear_ecc_addr(struct brcmnand_controller *c=
trl)
> >>>>    { =20
> >>>>    >> @@ -1811,20 +1835,11 @@ static void brcmnand_cmdfunc(struct na=
nd_chip *chip, unsigned command, =20
> >>>>    			native_cmd =3D=3D CMD_PARAMETER_CHANGE_COL) {
> >>>>    		/* Copy flash cache word-wise */
> >>>>    		u32 *flash_cache =3D (u32 *)ctrl->flash_cache;
> >>>> -		int i; =20
> >>>>    >>   		brcmnand_soc_data_bus_prepare(ctrl->soc, true);
> >>>>    >> -		/* =20
> >>>> -		 * Must cache the FLASH_CACHE now, since changes in
> >>>> -		 * SECTOR_SIZE_1K may invalidate it
> >>>> -		 */
> >>>> -		for (i =3D 0; i < FC_WORDS; i++)
> >>>> -			/*
> >>>> -			 * Flash cache is big endian for parameter pages, at
> >>>> -			 * least on STB SoCs
> >>>> -			 */
> >>>> -			flash_cache[i] =3D be32_to_cpu(brcmnand_read_fc(ctrl, i));
> >>>> +		brcmnand_read_data_bus(ctrl, ctrl->nand_fc, flash_cache,
> >>>> +				   FC_WORDS, true); =20
> >>>>    >>   		brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
> >>>>    >> @@ -2137,7 +2152,7 @@ static int brcmnand_read_by_pio(struct m=
td_info *mtd, struct nand_chip *chip, =20
> >>>>    {
> >>>>    	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> >>>>    	struct brcmnand_controller *ctrl =3D host->ctrl;
> >>>> -	int i, j, ret =3D 0;
> >>>> +	int i, ret =3D 0; =20
> >>>>    >>   	brcmnand_clear_ecc_addr(ctrl);
> >>>>    >> @@ -2150,8 +2165,9 @@ static int brcmnand_read_by_pio(struct m=
td_info *mtd, struct nand_chip *chip, =20
> >>>>    		if (likely(buf)) {
> >>>>    			brcmnand_soc_data_bus_prepare(ctrl->soc, false); =20
> >>>>    >> -			for (j =3D 0; j < FC_WORDS; j++, buf++) =20
> >>>> -				*buf =3D brcmnand_read_fc(ctrl, j);
> >>>> +			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf,
> >>>> +					FC_WORDS, false);
> >>>> +			buf +=3D FC_WORDS; =20
> >>>>    >>   			brcmnand_soc_data_bus_unprepare(ctrl->soc, false); =20
> >>>>    		}
> >>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/=
nand/raw/brcmnand/brcmnand.h
> >>>> index f1f93d85f50d..88819bc395f8 100644
> >>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> >>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> >>>> @@ -24,6 +24,8 @@ struct brcmnand_soc {
> >>>>    	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
> >>>>    	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
> >>>>    				 bool is_param);
> >>>> +	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flas=
h_cache,
> >>>> +				 u32 *buffer, int fc_words, bool is_param);
> >>>>    	const struct brcmnand_io_ops *ops;
> >>>>    }; =20
> >>>>    > > =20
> >>> Thanks,
> >>> Miqu=C3=A8l =20
> >>>    > >  =20
> > Thanks,
> > Miqu=C3=A8l
> >  =20


Thanks,
Miqu=C3=A8l
