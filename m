Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA245710F99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbjEYPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjEYPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:30:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B06195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:30:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so2699715e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685028630; x=1687620630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPuHDfJlTRWNIDrZeM6vHqKJY4YBArQHuXDU3A0RTxY=;
        b=e95BZHYjsevbDtuVfvlMCj6/qmG1HwycR6hbBsDLmF0/KLwzcsgqMvBpnd6UG6Hb07
         O415mDXB5o1G6ZZojfFi580zgcZOUyQhOMmLF6BeaFjKV9hrfrh1DVLTMre+X7kNH5a1
         cl/EM/gLS34U5waMjbAUk+VgxAyvqWg5IPzS5l30O+0UFFr3DVSNwcT6Jo+vfZ1cEakg
         Tg4NigvGYo3LKoalvpHHH3ELSnkbbjEmJ7v24sU6OXCXXBe6TlJ9lRZnBFIETRyp9Z9J
         b0u/19EayOabR8Pzw3qAf4cdQu/dPtbczFcmdDQWCtWeETbOi5ikRga0kD/Q2TvSrNy/
         9nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685028630; x=1687620630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPuHDfJlTRWNIDrZeM6vHqKJY4YBArQHuXDU3A0RTxY=;
        b=Tr3lqpYqx0MOwQBrc1bsTBlOxD8Qvdw9CMxHxUSJHJjgqsji3OK5Lgg76FVPwO4RQJ
         sr66UajMdpxagHw2dIX7ySZI+vL06rLkuDZkr1MEj0Zmt3etlSOmQG5GV5IiDeqkSE7D
         WWttokXJ17/QibJW6w3dD2YeIQBS49hYK4uuzpoYPnPK5YP1wZ4D+32POAWThSqwa8Cu
         X/ZIF101t3am78b7oqWDmsVDzTi+mZ5WilmZJ2ocaTeayBax25Q+fVA7Xk7Ag32o5YGU
         35BglxWnuT1/eoiIBh/pkEbAKuXBAzCA4pxEd0N4SjITIRk37gMoqJSpJDAs+vWJ7JZK
         L6Qg==
X-Gm-Message-State: AC+VfDzXUccui868zyhtTGHYP4hMc5r4wTMRgJpkuPsOlFBTrDJ+kkL8
        aU9Xa7+/bTVYdMfml8ieShnkRQ==
X-Google-Smtp-Source: ACHHUZ6+eTGaEzLm5tVgzKM9SOm9NZRq7IEmz6ZCXHASpgaSQIu5To4mGi7Omlo6uwChYXfastmoxA==
X-Received: by 2002:ac2:5585:0:b0:4ef:ec94:9674 with SMTP id v5-20020ac25585000000b004efec949674mr6609883lfg.32.1685028630326;
        Thu, 25 May 2023 08:30:30 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004edc485f86bsm244080lfl.239.2023.05.25.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:30:29 -0700 (PDT)
Date:   Thu, 25 May 2023 17:30:27 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 2/6] net: phy: microchip_t1s: replace
 read-modify-write code with phy_modify_mmd
Message-ID: <ZG9/E8Am2ICEHIbr@debian>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:15:35PM +0530, Parthiban Veerasooran wrote:
> Replace read-modify-write code in the lan867x_config_init function to
> avoid handling data type mismatch and to simplify the code.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/phy/microchip_t1s.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index a42a6bb6e3bd..b5b5a95fa6e7 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c
> @@ -31,19 +31,19 @@
>   * W   0x1F 0x0099 0x7F80 ------
>   */
>  
> -static const int lan867x_fixup_registers[12] = {
> +static const u32 lan867x_fixup_registers[12] = {
>  	0x00D0, 0x00D1, 0x0084, 0x0085,
>  	0x008A, 0x0087, 0x0088, 0x008B,
>  	0x0080, 0x00F1, 0x0096, 0x0099,
>  };
>  
> -static const int lan867x_fixup_values[12] = {
> +static const u16 lan867x_fixup_values[12] = {
>  	0x0002, 0x0000, 0x3380, 0x0006,
>  	0xC000, 0x801C, 0x033F, 0x0404,
>  	0x0600, 0x2400, 0x2000, 0x7F80,
>  };
>  
> -static const int lan867x_fixup_masks[12] = {
> +static const u16 lan867x_fixup_masks[12] = {
>  	0x0E03, 0x0300, 0xFFC0, 0x000F,
>  	0xF800, 0x801C, 0x1FFF, 0xFFFF,
>  	0x0600, 0x7F00, 0x2000, 0xFFFF,
> @@ -63,23 +63,22 @@ static int lan867x_config_init(struct phy_device *phydev)
>  	 * used, which might then write the same value back as read + modified.
>  	 */
>  
> -	int reg_value;
>  	int err;
> -	int reg;
>  
>  	/* Read-Modified Write Pseudocode (from AN1699)
>  	 * current_val = read_register(mmd, addr) // Read current register value
>  	 * new_val = current_val AND (NOT mask) // Clear bit fields to be written
>  	 * new_val = new_val OR value // Set bits
> -	 * write_register(mmd, addr, new_val) // Write back updated register value
> +	 * write_register(mmd, addr, new_val) // Write back updated register value.
> +	 * Although AN1699 says Read, Modify, Write, the write is not required if
> +	 * the register already has the required value.
>  	 */
>  	for (int i = 0; i < ARRAY_SIZE(lan867x_fixup_registers); i++) {
> -		reg = lan867x_fixup_registers[i];
> -		reg_value = phy_read_mmd(phydev, MDIO_MMD_VEND2, reg);
> -		reg_value &= ~lan867x_fixup_masks[i];
> -		reg_value |= lan867x_fixup_values[i];
> -		err = phy_write_mmd(phydev, MDIO_MMD_VEND2, reg, reg_value);
> -		if (err != 0)
> +		err = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				     lan867x_fixup_registers[i],
> +				     lan867x_fixup_masks[i],
> +				     lan867x_fixup_values[i]);

This change answers an uncertainty in the block comment in the top of
this func, pasted here for your convenience

	/* HW quirk: Microchip states in the application note (AN1699) for the phy
	 * that a set of read-modify-write (rmw) operations has to be performed
	 * on a set of seemingly magic registers.
	 * The result of these operations is just described as 'optimal performance'
	 * Microchip gives no explanation as to what these mmd regs do,
	 * in fact they are marked as reserved in the datasheet.
	 * It is unclear if phy_modify_mmd would be safe to use or if a write
	 * really has to happen to each register.
	 * In order to exactly conform to what is stated in the AN phy_write_mmd is
	 * used, which might then write the same value back as read + modified.
	 */

This change also invalidates most of the comment. I think this should be
reduced to something along the lines of:
	/* HW quirk: Microchip states in the application note (AN1699) for the phy
	 * that a set of read-modify-write (rmw) operations has to be performed
	 * on a set of seemingly magic registers.
	 * The result of these operations is just described as 'optimal performance'
	 * Microchip gives no explanation as to what these mmd regs do,
	 * in fact they are marked as reserved in the datasheet.*/

Additionally I don't mind it if you change the tone of the comment. This was brought
up in the sitdown we had, where it was explained from Microchip that
documenting what the reg operations actually does would expose to much
of the internal workings of the chip.

Possibly this comment should move down to where the fixup reg operations
are performed, and replace the comment about the 'read write modify'
stuff all togheter.
In my opinion I kind of loose context about what the func does when it
first explains the fixup stuff, then actually does something with the
STS2 regs, and finally actually does the fixup.
> +		if (err)
>  			return err;
>  	}
>  
> -- 
> 2.34.1
> 
