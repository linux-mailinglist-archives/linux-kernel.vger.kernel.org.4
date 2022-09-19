Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF45BC481
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiISIle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiISIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:41:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2821E34;
        Mon, 19 Sep 2022 01:41:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9DB313200413;
        Mon, 19 Sep 2022 04:41:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Sep 2022 04:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1663576883; x=1663663283; bh=uMIdq0TND+
        kc29m5EHoDFRT0UopIzhGO4GH+pei3Ly0=; b=rGxG22Us/5Rkmr5lJiL6v7GWvk
        n3JmyY+YsMq2zuhlCtsVJF6hHd4dCPfWMK7nFupXTHr3xKar3ptzFEGP9cq0ntmV
        Tn/OicgfgulRY98szMeVAnDkqnLwevSjGSilVcjilJcpy31Kml+SU1Ia7t+5sUwv
        DMdHYO64DJ+XVegXQTCyIWC66rqq4ukYYiA0+fTIIFNK0JhM+AgFdksbxo2p886I
        +uAX1wkSOfWoDZ9+Imvrp/IDbstPqgWJfxfFeI74bnBUxnARNfm4QPeWYws2UiIc
        G8CDRYt1kSr7Jw3ruuU1rwDW4hFKEOTv6fpap2aFWr2f/5+mbevkQtajEeaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663576883; x=1663663283; bh=uMIdq0TND+kc29m5EHoDFRT0UopI
        zhGO4GH+pei3Ly0=; b=pknDFZPFFp6q2/ECHNDPrW8xFM1dCZSPmDIaE5mClqI4
        p5oAw4RCl2rlb+YpOYIKo4Z+ieUuc2xm1Ock8qEhvLCg4SZgBtd8NnjIBsU85rya
        VLxQNpHsm4l4C8EWj4vWcg2v6/bua1J6mKyln6bleb5DifNEOeXafix1uqMTHJ7w
        q0t0Ddmib1dCkBfH85KT2/UoodmsiaFI9+U2YcYeXg49NcSClZYykOIuZMD5M5Br
        FFFVZGAeof9UQXZ0PJGvebwrfHyX0twYoXDtNwbL3m70lXd7q0/ClVqM+TTvuEuN
        79dF3hLw+5gW+Hkgch68aFMPOtReQzYWzacj6N1pDQ==
X-ME-Sender: <xms:MisoY2TqpH0jzlra-AGkolaM4JnKo5WTYWOx4J4Sm017KpsgzP2Bug>
    <xme:MisoY7zA870Ocu863wENdSFL4c3xPfI-vO_L0JAIoPtAFmObvR10BSmOGq7LxxQvq
    RTbHevUiCbwGw>
X-ME-Received: <xmr:MisoYz1QoowlEtPJ9yAnOueuCrZcIN38aPDyGbFe6KrdUlZwDBiX3xGj_p2J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ortddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeejhfelffejkeejheetgfeigeekueeuuddvveekjeekue
    eggfdvhfefteelgefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:MisoYyBkUtjz1lnZ9jgL2SbQ1C6ZDIP7c3ORkv45OAXbGIiPSDSkfA>
    <xmx:MisoY_glzWpghW-h2b4ND1_4SrNOoD9mP94QfiN9JAUkqf8_b__mfQ>
    <xmx:MisoY-qW_Fru_x45Uga8eMQaz2Fqti2hJ1GR1ZKI893O9y89BpreDQ>
    <xmx:MysoY0YmKX2ucppTOHZgvkWEjCGoF-SyCu0GqGPhY3-BHLj9SbnPGQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Sep 2022 04:41:22 -0400 (EDT)
Date:   Mon, 19 Sep 2022 10:41:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        alcooperx@gmail.com
Subject: Re: [PATCH v1] drivers/tty/serial/8250: check the return value of
 clk_set_rate()
Message-ID: <YygrTldNcRSVFacX@kroah.com>
References: <20220919081523.1579904-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919081523.1579904-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:15:23AM -0700, Li Zhong wrote:
> Check the return of clk_set_rate() which could fail if there is error
> setting the rate.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_bcm7271.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index 8efdc271eb75..9014853d6e35 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -671,7 +671,9 @@ static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
>  			priv->real_rates[x] = clk_get_rate(priv->baud_mux_clk);
>  		}
>  	}
> -	clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
> +	rc = clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
> +	if (rc)
> +		dev_err(dev, "Error restoring default BAUD MUX clock\n");

What does this actually help with?  Shouldn't you recover properly from
an error instead of telling the user something bad went wrong and
nothing can be done?

This is not a correct fix at all, sorry.

thanks,

greg k-h
