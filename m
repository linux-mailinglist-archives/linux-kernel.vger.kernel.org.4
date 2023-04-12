Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C86DF653
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDLNBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:01:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E5C0;
        Wed, 12 Apr 2023 06:01:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E33366030B1;
        Wed, 12 Apr 2023 14:01:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681304468;
        bh=iIJWC0PpoBdIL2KCUMVFcxehEUMOudNP2xpeQX4uSbA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A9OrN0FXZAck4zUr14WYJAL/6w2S1G6idqEmPR5vFg0IpuLWohOf/Lm9oUDnZMK2/
         mZxfn0FnQk8CmsJZ1OToTh9ozGtsM+Bd+diZG2B5WHRgzWXMSdWR3iJ2WZMOxKUiGG
         gTYp7Edy2XhkEbJLGljKXIsjyRnzZfwWgp/elO5FvSWr7CSXMKYdKOGke0sjvC96Uf
         8zH8Bgda0Pa5uxYrcg7tDjooCZI5ndVzVHINQ0Y7fG7hfn8Cg2VviItawMw9gI407/
         gY4Pp8dH983d9VYzoEydV1MC4P2nqdov/jnjawJex3puMrwE7EGpJV/O460mcwzeeq
         0BpuMLVUI52lw==
Message-ID: <26778589-ea88-abfb-0b84-71b3479a38bc@collabora.com>
Date:   Wed, 12 Apr 2023 15:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 6/6] soc: mediatek: pwrap: Add support for MT6795 Helio
 X10
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        flora.fu@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com>
 <20230324094205.33266-7-angelogioacchino.delregno@collabora.com>
 <CAFGrd9pR+8MVNcXyb2JPoL3wzksNdY08kUGPtH+NmawTW8uU1w@mail.gmail.com>
 <66d4155c-8b71-1904-e0d4-99da7d0b6ea2@gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <66d4155c-8b71-1904-e0d4-99da7d0b6ea2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 14:55, Matthias Brugger ha scritto:
> 
> 
> On 30/03/2023 01:07, Alexandre Mergnat wrote:
>> " or
>>
>> Le ven. 24 mars 2023 à 10:42, AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> a écrit :
>>>
>>> Add the necessary bits to support the MT6795 Helio X10 smartphone SoC:
>>> this is always paired with a MT6331 PMIC, with MT6332 companion.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 131 ++++++++++++++++++++++++++-
>>>   1 file changed, 130 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> index ceeac43f7bd1..20d32328382a 100644
>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> @@ -639,6 +639,91 @@ static int mt6779_regs[] = {
>>>          [PWRAP_WACS2_VLDCLR] =          0xC28,
>>>   };
>>>
>>> +static int mt6795_regs[] = {
>>> +       [PWRAP_MUX_SEL] =               0x0,
>>> +       [PWRAP_WRAP_EN] =               0x4,
>>> +       [PWRAP_DIO_EN] =                0x8,
>>> +       [PWRAP_SIDLY] =                 0xc,
>>> +       [PWRAP_RDDMY] =                 0x10,
>>> +       [PWRAP_SI_CK_CON] =             0x14,
>>> +       [PWRAP_CSHEXT_WRITE] =          0x18,
>>> +       [PWRAP_CSHEXT_READ] =           0x1c,
>>> +       [PWRAP_CSLEXT_START] =          0x20,
>>> +       [PWRAP_CSLEXT_END] =            0x24,
>>> +       [PWRAP_STAUPD_PRD] =            0x28,
>>> +       [PWRAP_STAUPD_GRPEN] =          0x2c,
>>> +       [PWRAP_EINT_STA0_ADR] =         0x30,
>>> +       [PWRAP_EINT_STA1_ADR] =         0x34,
>>> +       [PWRAP_STAUPD_MAN_TRIG] =       0x40,
>>> +       [PWRAP_STAUPD_STA] =            0x44,
>>> +       [PWRAP_WRAP_STA] =              0x48,
>>> +       [PWRAP_HARB_INIT] =             0x4c,
>>> +       [PWRAP_HARB_HPRIO] =            0x50,
>>> +       [PWRAP_HIPRIO_ARB_EN] =         0x54,
>>> +       [PWRAP_HARB_STA0] =             0x58,
>>> +       [PWRAP_HARB_STA1] =             0x5c,
>>> +       [PWRAP_MAN_EN] =                0x60,
>>> +       [PWRAP_MAN_CMD] =               0x64,
>>> +       [PWRAP_MAN_RDATA] =             0x68,
>>> +       [PWRAP_MAN_VLDCLR] =            0x6c,
>>> +       [PWRAP_WACS0_EN] =              0x70,
>>> +       [PWRAP_INIT_DONE0] =            0x74,
>>> +       [PWRAP_WACS0_CMD] =             0x78,
>>> +       [PWRAP_WACS0_RDATA] =           0x7c,
>>> +       [PWRAP_WACS0_VLDCLR] =          0x80,
>>> +       [PWRAP_WACS1_EN] =              0x84,
>>> +       [PWRAP_INIT_DONE1] =            0x88,
>>> +       [PWRAP_WACS1_CMD] =             0x8c,
>>> +       [PWRAP_WACS1_RDATA] =           0x90,
>>> +       [PWRAP_WACS1_VLDCLR] =          0x94,
>>> +       [PWRAP_WACS2_EN] =              0x98,
>>> +       [PWRAP_INIT_DONE2] =            0x9c,
>>> +       [PWRAP_WACS2_CMD] =             0xa0,
>>> +       [PWRAP_WACS2_RDATA] =           0xa4,
>>> +       [PWRAP_WACS2_VLDCLR] =          0xa8,
>>> +       [PWRAP_INT_EN] =                0xac,
>>> +       [PWRAP_INT_FLG_RAW] =           0xb0,
>>> +       [PWRAP_INT_FLG] =               0xb4,
>>> +       [PWRAP_INT_CLR] =               0xb8,
>>> +       [PWRAP_SIG_ADR] =               0xbc,
>>> +       [PWRAP_SIG_MODE] =              0xc0,
>>> +       [PWRAP_SIG_VALUE] =             0xc4,
>>> +       [PWRAP_SIG_ERRVAL] =            0xc8,
>>> +       [PWRAP_CRC_EN] =                0xcc,
>>> +       [PWRAP_TIMER_EN] =              0xd0,
>>> +       [PWRAP_TIMER_STA] =             0xd4,
>>> +       [PWRAP_WDT_UNIT] =              0xd8,
>>> +       [PWRAP_WDT_SRC_EN] =            0xdc,
>>> +       [PWRAP_WDT_FLG] =               0xe0,
>>> +       [PWRAP_DEBUG_INT_SEL] =         0xe4,
>>> +       [PWRAP_DVFS_ADR0] =             0xe8,
>>> +       [PWRAP_DVFS_WDATA0] =           0xec,
>>> +       [PWRAP_DVFS_ADR1] =             0xf0,
>>> +       [PWRAP_DVFS_WDATA1] =           0xf4,
>>> +       [PWRAP_DVFS_ADR2] =             0xf8,
>>> +       [PWRAP_DVFS_WDATA2] =           0xfc,
>>> +       [PWRAP_DVFS_ADR3] =             0x100,
>>> +       [PWRAP_DVFS_WDATA3] =           0x104,
>>> +       [PWRAP_DVFS_ADR4] =             0x108,
>>> +       [PWRAP_DVFS_WDATA4] =           0x10c,
>>> +       [PWRAP_DVFS_ADR5] =             0x110,
>>> +       [PWRAP_DVFS_WDATA5] =           0x114,
>>> +       [PWRAP_DVFS_ADR6] =             0x118,
>>> +       [PWRAP_DVFS_WDATA6] =           0x11c,
>>> +       [PWRAP_DVFS_ADR7] =             0x120,
>>> +       [PWRAP_DVFS_WDATA7] =           0x124,
>>> +       [PWRAP_SPMINF_STA] =            0x128,
>>> +       [PWRAP_CIPHER_KEY_SEL] =        0x12c,
>>> +       [PWRAP_CIPHER_IV_SEL] =         0x130,
>>> +       [PWRAP_CIPHER_EN] =             0x134,
>>> +       [PWRAP_CIPHER_RDY] =            0x138,
>>> +       [PWRAP_CIPHER_MODE] =           0x13c,
>>> +       [PWRAP_CIPHER_SWRST] =          0x140,
>>> +       [PWRAP_DCM_EN] =                0x144,
>>> +       [PWRAP_DCM_DBC_PRD] =           0x148,
>>> +       [PWRAP_EXT_CK] =                0x14c,
>>> +};
>>> +
>>>   static int mt6797_regs[] = {
>>>          [PWRAP_MUX_SEL] =               0x0,
>>>          [PWRAP_WRAP_EN] =               0x4,
>>> @@ -1230,6 +1315,7 @@ enum pwrap_type {
>>>          PWRAP_MT2701,
>>>          PWRAP_MT6765,
>>>          PWRAP_MT6779,
>>> +       PWRAP_MT6795,
>>>          PWRAP_MT6797,
>>>          PWRAP_MT6873,
>>>          PWRAP_MT7622,
>>> @@ -1650,6 +1736,20 @@ static void pwrap_init_chip_select_ext(struct 
>>> pmic_wrapper *wrp, u8 hext_write,
>>>   static int pwrap_common_init_reg_clock(struct pmic_wrapper *wrp)
>>>   {
>>>          switch (wrp->master->type) {
>>> +       case PWRAP_MT6795:
>>> +               if (wrp->slave->type == PMIC_MT6331) {
>>> +                       const u32 *dew_regs = wrp->slave->dew_regs;
>>> +
>>> +                       pwrap_write(wrp, dew_regs[PWRAP_DEW_RDDMY_NO], 0x8);
>>> +
>>> +                       if (wrp->slave->comp_type == PMIC_MT6332) {
>>> +                               dew_regs = wrp->slave->comp_dew_regs;
>>> +                               pwrap_write(wrp, dew_regs[PWRAP_DEW_RDDMY_NO], 
>>> 0x8);
>>> +                       }
>>> +               }
>>> +               pwrap_writel(wrp, 0x88, PWRAP_RDDMY);
>>> +               pwrap_init_chip_select_ext(wrp, 15, 15, 15, 15);
>>> +               break;
>>>          case PWRAP_MT8173:
>>>                  pwrap_init_chip_select_ext(wrp, 0, 4, 2, 2);
>>>                  break;
>>> @@ -1744,6 +1844,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>>>          case PWRAP_MT2701:
>>>          case PWRAP_MT6765:
>>>          case PWRAP_MT6779:
>>> +       case PWRAP_MT6795:
>>>          case PWRAP_MT6797:
>>>          case PWRAP_MT8173:
>>>          case PWRAP_MT8186:
>>> @@ -1914,6 +2015,19 @@ static int pwrap_mt2701_init_soc_specific(struct 
>>> pmic_wrapper *wrp)
>>>          return 0;
>>>   }
>>>
>>> +static int pwrap_mt6795_init_soc_specific(struct pmic_wrapper *wrp)
>>> +{
>>> +       pwrap_writel(wrp, 0xf, PWRAP_STAUPD_GRPEN);
>>> +
>>> +       if (wrp->slave->type == PMIC_MT6331)
>>> +               pwrap_writel(wrp, 0x1b4, PWRAP_EINT_STA0_ADR);
>>> +
>>> +       if (wrp->slave->comp_type == PMIC_MT6332)
>>> +               pwrap_writel(wrp, 0x8112, PWRAP_EINT_STA1_ADR);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   static int pwrap_mt7622_init_soc_specific(struct pmic_wrapper *wrp)
>>>   {
>>>          pwrap_writel(wrp, 0, PWRAP_STAUPD_PRD);
>>> @@ -1949,7 +2063,8 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>>>          if (wrp->rstc_bridge)
>>>                  reset_control_reset(wrp->rstc_bridge);
>>>
>>> -       if (wrp->master->type == PWRAP_MT8173) {
>>> +       if (wrp->master->type == PWRAP_MT8173 ||
>>> +           wrp->master->type == PWRAP_MT6795) {
>>
>> I would prefer to put a switch case like it's done in
>> "pwrap_common_init_reg_clock" or
>> "pwrap_init_cipher".
>>
> 
> I agree, a switch would be better here.

Doing that in a jiffy :-)

Cheers,
Angelo

> 
> Regards,
> Matthias
> 
>> My second choice (which isn't aligned with the current
>> implementation), is to add boolean
>> capabilities in the "struct pmic_wrapper_type".
>>
>>>                  /* Enable DCM */
>>>                  pwrap_writel(wrp, 3, PWRAP_DCM_EN);
>>>                  pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
>>> @@ -2185,6 +2300,19 @@ static const struct pmic_wrapper_type pwrap_mt6779 = {
>>>          .init_soc_specific = NULL,
>>>   };
>>>
>>> +static const struct pmic_wrapper_type pwrap_mt6795 = {
>>> +       .regs = mt6795_regs,
>>> +       .type = PWRAP_MT6795,
>>> +       .arb_en_all = 0x3f,
>>> +       .int_en_all = ~(u32)(BIT(31) | BIT(2) | BIT(1)),
>>> +       .int1_en_all = 0,
>>> +       .spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>>> +       .wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
>>> +       .caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>>> +       .init_reg_clock = pwrap_common_init_reg_clock,
>>> +       .init_soc_specific = pwrap_mt6795_init_soc_specific,
>>
>> TBH, I don't know if variables should be reordered in alphabetic order
>> or keep the order of other structures.
>> it's just to notify.
>>
>>> +};
>>> +
>>>   static const struct pmic_wrapper_type pwrap_mt6797 = {
>>>          .regs = mt6797_regs,
>>>          .type = PWRAP_MT6797,
>>> @@ -2318,6 +2446,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>>>          { .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
>>>          { .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
>>>          { .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
>>> +       { .compatible = "mediatek,mt6795-pwrap", .data = &pwrap_mt6795 },
>>>          { .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
>>>          { .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
>>>          { .compatible = "mediatek,mt7622-pwrap", .data = &pwrap_mt7622 },
>>> -- 
>>> 2.40.0
>>>
>>
>> Regards,
>> Alex
> 

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

