Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888FD710F30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbjEYPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjEYPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:10:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB04E73
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:09:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af316b4515so7110341fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685027322; x=1687619322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5XsRCnJXw5agxTtSv8CFfkB96RGLAZ6espWkPg/3a0=;
        b=kXPXhsYN7hQ2LhUGrPQ20GTon06sJ6QF0mLkvgipiXYB3oiK4KciklEkWoEIWZ3rSl
         ynZBVV84FFY62lveh0ggZ3XRUNXdudxVdS1IpFHtKq+82MVjq7cOePQrQIrP12eKwK4z
         RLJoIq7js+cnUfZI5o/oNwHA/MF40yxk1PB2LhlHh09P0qig8knvonMrC6tXdj0V+k/w
         EK9dVRj4yZ56f71b8iHlqEyF5p3W4AcnkLjJdkuVrVQYps3d/d8Sj0M8mCUdtfbbXxOe
         RfXMN+0HPm8EL9hlWwamXb+7/cpeyO0Dn2t6VVHZG6nVX6XW9PqZjo7306VPIhpjGrc1
         9DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027322; x=1687619322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5XsRCnJXw5agxTtSv8CFfkB96RGLAZ6espWkPg/3a0=;
        b=DUVcD7mBhwb5lEYAguajQ5sUUTND77ncH+U+MKSV4EKkSCJSkPktER0maMaymJmLsV
         38wE2jHNkjdMA4lI8SlUJdYXLSeWufXM3i98BswF4rqCEQSj3Oi18Ch7ssPhqTPRup7f
         1hd02Y3m4Xa3FQilHEvqOkQKP7fc+xPhXd2uMcVLR+RqkwksLojS/6ZKAFnhVUM8hboM
         ZVlBPQBQNTmy7SBpscZct6LI2EXYGBgStqWKaiQFLtUf8lBMMhzvqjsmcVFPXfJVjc8j
         Bx+7iiU1rF1c3QfHgcHfk3z9eNVaE5BXGpR4ZvTsE161Z9a0EWWSJ2Hz9vSjXnbfZNk8
         Va5g==
X-Gm-Message-State: AC+VfDxBrcoXrAu90k1zt4boLY3JSyVKVXpjPcP0Hu4GQrfGeLRc7756
        sSAzkke8jkuWRG8M/BAJf6ChIA==
X-Google-Smtp-Source: ACHHUZ7o0OPFdjXoRrgjAnOYax+ZckVAwO/nALq8VnwdY7JZQ7NKMlB4OsXq9uuL1GVNuH5ZvmUORg==
X-Received: by 2002:a2e:9d42:0:b0:2af:1c0a:20e1 with SMTP id y2-20020a2e9d42000000b002af1c0a20e1mr1013262ljj.52.1685027322146;
        Thu, 25 May 2023 08:08:42 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002ac7978f0a6sm271812ljj.100.2023.05.25.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:08:41 -0700 (PDT)
Date:   Thu, 25 May 2023 17:08:39 +0200
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
Message-ID: <ZG9599nfDnkcw8er@debian>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=unavailable autolearn_force=no version=3.4.6
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

Nitpick, I think this block comment can be reduced to:
/* The following block deviates from AN1699 which states that a values
 * should be written back, even if unmodified.
 * Which is not necessary, so it's safe to use phy_modify_mmd here.*/

 The comment I added was intended to describe why I was doing weird
 things, but now I think it's more interesting to describe why we're
 deviating from the AN.

 Or the block comment could be dropped all togheter, I'm guessing no one
 is going to consult the AN if things 'just work'

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
> +		if (err)
>  			return err;
>  	}
>  
> -- 
> 2.34.1
> 
