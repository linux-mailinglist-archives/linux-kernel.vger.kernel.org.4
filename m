Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3A73A729
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFVRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjFVRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D86195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F7296189F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A05C433C8;
        Thu, 22 Jun 2023 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687454681;
        bh=peGmVPowJipNJQIy5eFE+8/1j762NisvMXMysKsQirg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=emNWI80aveU4MMQYLu6bh6YNOJ4RvcibldjrVm0aKqk9j74umkrktA0nPRt2EowtG
         8QzaZY7gOma7IqFVcaeJZRBecy/9ob8gBGP3c6HvbRjphwnLxLpoERZNf17hlpp1nE
         U3TmgjbFDbXNTwBBKIGNeqZ9vp7ESqPh6I3USotgddg+nnRYKHhAHRYGykOENWwVii
         KBKjGgAISKesc+vJv1mCHWqGlOG5TsrnSQ5Q4AAzSBaLI0VK4jeKgLudWwCk+n3lm3
         pKxonCtumBoGl7Lj5yUHLeFif8+5ysme83P6/KsI1/fC7ywRvmRx4K2dj/lH2lhib4
         2GoIC2GDi+z0w==
Date:   Thu, 22 Jun 2023 10:24:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set
 function
Message-ID: <20230622102440.60d18020@kernel.org>
In-Reply-To: <20230621191302.1405623-2-paweldembicki@gmail.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
        <20230621191302.1405623-2-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 21:12:58 +0200 Pawel Dembicki wrote:
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 30b1f0a36566..1552a9ca06ff 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -15,6 +15,7 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	u8				forward_map[8];
>  };

kdoc missing here:

> drivers/net/dsa/vitesse-vsc73xx.h:20: warning: Function parameter or member 'forward_map' not described in 'vsc73xx'
-- 
pw-bot: cr
