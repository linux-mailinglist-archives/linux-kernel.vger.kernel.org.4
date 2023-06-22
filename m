Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAFB73A136
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFVMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjFVMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:49:50 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 05:49:49 PDT
Received: from smtpweb147.aruba.it (smtpweb147.aruba.it [62.149.158.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F3193
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:49:49 -0700 (PDT)
Received: from [172.25.4.220] ([212.103.203.10])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CJjyq23NPMemtCJjyqk33G; Thu, 22 Jun 2023 14:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1687438126; bh=OAGWq4P0iLWKK7POQSy2mIY+DvkEOnVeuEtcmCvffRs=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=NIgtXs5fpTXh7WlHIavDkkKSrIis8rwsmdI/aGO7l82zVPFgNtY1H7HrnWwuR6VKq
         vY4XFCcGh9yeR8f1RVnh9Znco3a0OeeP7QHl+neUl/4gsfQj0d7eeN1YLwerxlumWj
         I/rEHIb+x0HD3/7fkMBMv83f89BAKEsnoPPmtppebN/uMdD1xVWNgCtcjnXBgTk8Rr
         sIMFiP/n0qCSpx80MbwJpWsajF15StC8Y9O6WFEDLm01OlmgGfvO/uRDne044WPLOD
         +5IMqjQLQwjTsaAt8SvnymXvckoIF++jeElDrkJdsowTKWgSfqADbWfqV7qwK5HIRw
         1G1SfIgOG6ajQ==
Message-ID: <12d3d3e7-da90-cc73-57e6-1aa7859dce90@benettiengineering.com>
Date:   Thu, 22 Jun 2023 14:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net: phy: broadcom: drop brcm_phy_setbits() and use
 phy_set_bits() instead
Content-Language: en-US, it
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622123737.8649-1-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20230622123737.8649-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLJhKBVdCUUxsuCjp/CY3LttGD3fW8mXkVVzBjCREiW7Q4F+vWSIw+1uGY0JJURNY/CIy7gXayAAg8DeR5aUxcM+voz/cYKXl/g5xgl/ZpHXRdCJctK2
 z4ketBj1sGjVUr5nb25IgKKEcDcKX37F+cmiVU4FpAFyurdXSeVxT/WQNX5ZdnVy/9xWE34273XWaaXOA46ipeimPQymIBrY1PPjU1XhTXktyW1do9lxNO5M
 OPQsAUS+LFo2VPb2OQR70RZqGRY3VSlI1mqiZlUsGim9YpEbb0y82Y+Zuxu7tAmb4D6jHtntcuTANVZyXY1N7ZuNfW3Ms4s9X+Z/W66a1LR/E9ACElzbmUK5
 rvI1iQKMVJEXKAnBLkvvxOI81YFrIIm9rYbayDCiyWJQinRzrO0RDnrZ1D363FQJIS1qoHtf2mHJ+w69MQ0mhwcdtMYJQlPOM3Nd+SVQAK4go/aJMYCvdqS1
 +DZDpKdvr7dtfN38lxmyZK3QIsk6OwJNDjR6/NlDzTLdIFaXlr209wbKSw23C6S5vBdhj38Y0X+8sjYq
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon,

On 22/06/23 14:37, Giulio Benetti wrote:
> Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
> use phy_set_bits() in its place.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   drivers/net/phy/broadcom.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index ad71c88c87e7..d684c5be529a 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -608,17 +608,6 @@ static int bcm54616s_read_status(struct phy_device *phydev)
>   	return err;
>   }
>   
> -static int brcm_phy_setbits(struct phy_device *phydev, int reg, int set)
> -{
> -	int val;
> -
> -	val = phy_read(phydev, reg);
> -	if (val < 0)
> -		return val;
> -
> -	return phy_write(phydev, reg, val | set);
> -}
> -
>   static int brcm_fet_config_init(struct phy_device *phydev)
>   {
>   	int reg, err, err2, brcmtest;
> @@ -689,14 +678,14 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>   		goto done;
>   
>   	/* Enable auto MDIX */
> -	err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
> +	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
>   				       MII_BRCM_FET_SHDW_MC_FAME);

I've missed to checkpatch.pl and there is a style error ^^^

>   	if (err < 0)
>   		goto done;
>   
>   	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
>   		/* Enable auto power down */
> -		err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
> +		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
>   					       MII_BRCM_FET_SHDW_AS2_APDE);

                                       and here ^^^

I wait some time for any feedback and then I send a V2.

Best regards
-- 
CEO/CTO@Benetti Engineering sas

>   	}
>   

