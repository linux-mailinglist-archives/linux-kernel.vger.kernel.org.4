Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE163B935
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiK2Ewq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiK2Ewn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:52:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190582DEB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:52:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d3so7308544plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1+5tfRuqWTVsOgukn5eT735qWcREEDtuwFhVAis2ns=;
        b=SKhJ7IFWPCWvn97G1esf5ryu41DTYHaQj+LN784zZSyaN8xddxJJHH2hp55QSaWwbW
         6WVRTSGesO+2DOHanQ/NhXFZ4VG5cxnq3la4UF/tDAd7qyRIk4y5oIsD84tdxuHKWDE4
         rSuYvy8AUA50rd8nCdR7YK41k8KKijalrVoQy9+Bt1iU+UaIRv42ZQqVTTbhSzTDec7/
         xV1hPpkBOdG4xmiVUrVGPiJhpMVDbLsCnvdmsvbHL5ZD3DxSGbqTEtHE48sbuTkP1vei
         NzEMgl3B7EJiKC2M0/2SbvMO9DZwvjJqcwFVSWJWDrJRnQBZbMkvrOZBjAoswqUPwcrW
         aGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1+5tfRuqWTVsOgukn5eT735qWcREEDtuwFhVAis2ns=;
        b=dB/P/kp01dLStL6lSDFOOq2bieFC/b/B4wHbnKOaD97CoVL0Ng778v1lhhSjVOHlDq
         VUqB4QVzN1zvaFk9OW1tUXOD9dVNl4+eaHmDm9ufaf7fppwWsmyifp3/DWlcsrbtJnF/
         Fud3k2Aq1caBFeXOGmHg5f5ZPcTHqxE1/kv2Umtb5O1tNmXRPr3n8UFIiEuOkUOmXWB4
         uWdNUgioEsAZBvHo5kmKzv1NswSamMUIpOMki7kCPppC/Rb1DcIm0r+1kT0DdbC/mVXo
         GSVJbJioh+fm3Hc46dJJScIgCggXouwKYH9oplLu/rEnvHRxDvVs3oLFHqQsM9weJRO3
         eqlw==
X-Gm-Message-State: ANoB5pl+bc06IvUGFciFGHxzi7mSdNBT/WzqcmZ49DSY3SEi3TML2QRq
        2KZgx+5g8JGVU8oDWPZDnk8=
X-Google-Smtp-Source: AA0mqf5c+p5dL6zUqx5qZ25QlpNx4UfNiAV/8qXIhTXchmw0FVcF6a6gE72GedLWPA1IiVJNVj4HsQ==
X-Received: by 2002:a17:902:db0c:b0:189:1963:d0d7 with SMTP id m12-20020a170902db0c00b001891963d0d7mr36119934plx.100.1669697558416;
        Mon, 28 Nov 2022 20:52:38 -0800 (PST)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001895d87225csm9584719plx.182.2022.11.28.20.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 20:52:37 -0800 (PST)
Message-ID: <7b191ded-068f-0dc7-25fa-e35cd1ac5bcf@gmail.com>
Date:   Tue, 29 Nov 2022 13:52:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mtd: spi-nor: spansion: add clear sr fixup for s25fl-l
 family
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, yaliang.wang@windriver.com,
        pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, Takahiro.Kuwano@infineon.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221018095732.251299-1-yaliang.wang@windriver.com>
 <58b39090-d26f-271f-4832-8fb41c624a9c@microchip.com>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <58b39090-d26f-271f-4832-8fb41c624a9c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yaliang and Tudor,

On 11/22/2022 7:28 PM, Tudor.Ambarus@microchip.com wrote:
> + Takahiro
> 
> Hi, Takahiro,
> 
> Would you please review/test this spansion patch?
> 
> Thanks,
> ta
> 
> On 10/18/22 12:57, yaliang.wang@windriver.com wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> From: Yaliang Wang <Yaliang.Wang@windriver.com>
>>
>> Spansion S25FL-L family flashes s25fl064l/s25fl128l/s25fl256l can't
>> automatically recover from programming/erase errors, the Status Register
>> error bits inflecting the errors will not change until a Clear Status
>> Register command be executed.
>>
>> Same thing also happens on other Spansion flash families, they've
>> properly handled it, USE_CLSR manufacturer flag was introduced for this
>> purpose, but S25FL-L cannot simply reuse their work, because S25FL-L has
>> the different error bit settings. S25FL-L defines programming/erase
>> error bits in Status Register 2, whereas the other families define the
>> same error bits in Status Register 1, causing S25FL-L needs a different
>> method to handle this problem.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 0074a8f3b303 ("mtd: spi-nor: Add support for s25fl128l and s25fl256l")
>> Fixes: d8b494a32889 ("mtd: spi-nor: Add support for Spansion S25FL064L")
>> Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
>> ---
>>  drivers/mtd/spi-nor/spansion.c | 119 ++++++++++++++++++++++++++-------
>>  1 file changed, 93 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
>> index 0150049007be..8f353ddda5f5 100644
>> --- a/drivers/mtd/spi-nor/spansion.c
>> +++ b/drivers/mtd/spi-nor/spansion.c
>> @@ -14,6 +14,7 @@
>>  #define SPINOR_OP_CLSR         0x30    /* Clear status register 1 */
>>  #define SPINOR_OP_RD_ANY_REG                   0x65    /* Read any register */
>>  #define SPINOR_OP_WR_ANY_REG                   0x71    /* Write any register */
>> +#define SPINOR_REG_CYPRESS_SR2V                        0x00800001
>>  #define SPINOR_REG_CYPRESS_CFR1V               0x00800002
>>  #define SPINOR_REG_CYPRESS_CFR1V_QUAD_EN       BIT(1)  /* Quad Enable */
>>  #define SPINOR_REG_CYPRESS_CFR2V               0x00800003
>> @@ -25,6 +26,10 @@
>>  #define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS    0
>>  #define SPINOR_OP_CYPRESS_RD_FAST              0xee
>>
>> +/* s25fl-l family specific */
>> +#define S25FL_L_SR2V_P_ERR                     BIT(5)  /* Programming Error Occurred */
>> +#define S25FL_L_SR2V_E_ERR                     BIT(6)  /* Erase Error Occurred */
>> +
>>  /* Cypress SPI NOR flash operations. */
>>  #define CYPRESS_NOR_WR_ANY_REG_OP(naddr, addr, ndata, buf)             \
>>         SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 0),             \
>> @@ -44,6 +49,29 @@
>>                    SPI_MEM_OP_NO_DUMMY,                                 \
>>                    SPI_MEM_OP_NO_DATA)
>>
>> +/**
>> + * spansion_nor_clear_sr() - Clear the Status Register.
>> + * @nor:       pointer to 'struct spi_nor'.
>> + */
>> +static void spansion_nor_clear_sr(struct spi_nor *nor)
>> +{
>> +       int ret;
>> +
>> +       if (nor->spimem) {
>> +               struct spi_mem_op op = SPANSION_CLSR_OP;
>> +
>> +               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
>> +
>> +               ret = spi_mem_exec_op(nor->spimem, &op);
>> +       } else {
>> +               ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
>> +                                                      NULL, 0);
>> +       }
>> +
>> +       if (ret)
>> +               dev_dbg(nor->dev, "error %d clearing SR\n", ret);
>> +}
>> +
>>  static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
>>  {
>>         struct spi_mem_op op;
>> @@ -342,6 +370,65 @@ static const struct spi_nor_fixups s25fs_s_nor_fixups = {
>>         .post_bfpt = s25fs_s_nor_post_bfpt_fixups,
>>  };
>>
>> +/**
>> + * s25fl_l_sr_ready_and_clear() - S25FL_L family flashes need to query
>> + * Status Register 1 to check if the flash is ready and clear it if
>> + * there are Programming/Erase errors in Status Register 2.
>> + * @nor:       pointer to 'struct spi_nor'.
>> + *
>> + * Return: 1 if ready, 0 if not ready, -errno on errors.
>> + */
>> +static int s25fl_l_sr_ready_and_clear(struct spi_nor *nor)
>> +{
>> +       int ret;
>> +       u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
>> +       struct spi_mem_op op =
>> +               CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
>> +                                         SPINOR_REG_CYPRESS_SR2V,
>> +                                         &nor->bouncebuf[1]);
>> +
RDAR in S25FL-L family requires 8 dummy cycles by default. This is one of
discrepancies in Spansion/Cypress/Infineon SPI NOR families.

In S25FL-L and S25FS-S families, number of dummy cycles in RDAR is same
as read ops (Fast read, Quad output read, etc) latency regardless of
register type, volatile or non-volatile. It is 8 by default.

In SEMPER family (S25HL/HS-T and S28HL/HS-T), number of dummy cycles in
RDAR for Non-volatile registers is same as read ops latency. For volatile
registers, it depends on CFR3[7:6] and is 0 by default.

So, we may want to let CYPRESS_NOR_RD_ANY_REG_OP macro take 'ndummy' param
to handle this...

>> +       /* Read Status Register 1 */
>> +       ret = spi_nor_read_sr(nor, nor->bouncebuf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* RDSR2 command isn't available in QPI mode, use RDAR instead  */
Or use RDSR2 instead. QPI (4-4-4) mode is not supported in this driver.

>> +       ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (nor->bouncebuf[1] & (S25FL_L_SR2V_P_ERR | S25FL_L_SR2V_E_ERR)) {
>> +               if (nor->bouncebuf[1] & S25FL_L_SR2V_E_ERR)
>> +                       dev_err(nor->dev, "Erase Error occurred\n");
>> +               else
>> +                       dev_err(nor->dev, "Programming Error occurred\n");
>> +
>> +               spansion_nor_clear_sr(nor);
>> +
>> +               /*
>> +                * WEL bit remains set to one when an erase or page program
>> +                * error occurs. Issue a Write Disable command to protect
>> +                * against inadvertent writes that can possibly corrupt the
>> +                * contents of the memory.
>> +                */
>> +               ret = spi_nor_write_disable(nor);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               return -EIO;
>> +       }
>> +
>> +       return !(nor->bouncebuf[0] & SR_WIP);
>> +}
>> +
>> +static void s25fl_l_late_init(struct spi_nor *nor)
>> +{
>> +       nor->params->ready = s25fl_l_sr_ready_and_clear;
>> +}
>> +
>> +static const struct spi_nor_fixups s25fl_l_fixups = {
>> +       .late_init = s25fl_l_late_init,
>> +};
>>  static const struct flash_info spansion_nor_parts[] = {
>>         /* Spansion/Cypress -- single (large) sector size only, at least
>>          * for the chips listed here (without boot sectors).
>> @@ -428,13 +515,16 @@ static const struct flash_info spansion_nor_parts[] = {
>>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
>>         { "s25fl064l",  INFO(0x016017,      0,  64 * 1024, 128)
>>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>> -               FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>> +               FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>> +               .fixups = &s25fl_l_fixups },
>>         { "s25fl128l",  INFO(0x016018,      0,  64 * 1024, 256)
>>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>> -               FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>> +               FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>> +               .fixups = &s25fl_l_fixups },
>>         { "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512)
>>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>> -               FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>> +               FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>> +               .fixups = &s25fl_l_fixups },
How about merging SR2V check into existing spansion_nor_sr_ready_and_clear()?

Introduce new MFR flag like USE_SR2V then

MFR_FLAGS(USE_CLSR|USE_SR2V)

static int spansion_nor_sr_ready_and_clear(struct spi_nor *nor)
{
	int ret;

	ret = spi_nor_read_sr(nor, nor->bouncebuf);
	if (ret)
		return ret;

	if (nor->info->mfr_flags & USE_SR2V) {
		/* check SR2V */
	} else {
		/* check SR */
	}

	...
}

This is just my preference. What do you think?

>>         { "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 256 * 1024, 256)
>>                 PARSE_SFDP
>>                 MFR_FLAGS(USE_CLSR)
>> @@ -460,29 +550,6 @@ static const struct flash_info spansion_nor_parts[] = {
>>         },
>>  };
>>
>> -/**
>> - * spansion_nor_clear_sr() - Clear the Status Register.
>> - * @nor:       pointer to 'struct spi_nor'.
>> - */
>> -static void spansion_nor_clear_sr(struct spi_nor *nor)
>> -{
>> -       int ret;
>> -
>> -       if (nor->spimem) {
>> -               struct spi_mem_op op = SPANSION_CLSR_OP;
>> -
>> -               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
>> -
>> -               ret = spi_mem_exec_op(nor->spimem, &op);
>> -       } else {
>> -               ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
>> -                                                      NULL, 0);
>> -       }
>> -
>> -       if (ret)
>> -               dev_dbg(nor->dev, "error %d clearing SR\n", ret);
>> -}
>> -
>>  /**
>>   * spansion_nor_sr_ready_and_clear() - Query the Status Register to see if the
>>   * flash is ready for new commands and clear it if there are any errors.
>> --
>> 2.34.1
>>
> 

Thanks,
Takahiro
