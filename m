Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6D6E4039
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDQG4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDQGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:55:59 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015089B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681714553; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P5TA3vNdUMsuzevccSXfTnl4fC6v+MDL0dE6uZjCYY4xOWN2IrHHUVtNlzoFKazGzL
    cz0p73X5CUiyZwNhjQIBdSJSCVXKZhtKK8TfjHDHk7KuoJcyQkfXlDhR8zsyX3FZLAGS
    yJU2shb5wmxSNTt4NGf847k9fZ95G6Af9KMB6zP3ATNeT3fvnir4F68vqzFFCUez+plD
    9aGbrOq2/CQTJ+WpS+yu9/7jO28M/HvyVvWwvyi7JrkEc31VEW8SZDk4ZWkFYqq87NlF
    C32l6I90kDEezhmDNMsR3zWSXMMWN3hWlTixVwe77ZIa9SoKxTI7cQckoclPMlvg7deP
    1cDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1681714553;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xcCeKYOa0MHGI98dKHHahLnFxggYEtvrjNiDEqIX4+M=;
    b=K0D+ov924lOA2MtnZ1HO+z17L4ppJA8usr2LKzR5bTgFfwazxYnytIP9+mzO+3LeYc
    QvAhzNObfM40nZqCloDQsnxkUZcRB3nMg7o6bpUJTNp+3FGXCkYQMCXzAX36KhcM5cID
    ddW5kBiBFdQQV2e9fGKA8lbop//T+c8qUQP9OJ6MB97s7nbpMIB+B289OJDrbMyHy/on
    S7mLldJP7JbnIx2/tueaB009UAUlouqBWnyayY0bXrNoDmn67eFT+Ndr172Y9sY5XHYh
    qUZm6yJKG2mcSyfJfR5BOJoh2+FOXjjiUOJ9w9hEihTwqQHlRIzwarcAmZUZyTp4mls7
    Ck8Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1681714553;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xcCeKYOa0MHGI98dKHHahLnFxggYEtvrjNiDEqIX4+M=;
    b=kAYexSHiBs4aMdie84oslKxBucZdbrS/eWCEBEvWBTyWvOtz4mI0j0T1ir/d3SEIcj
    KvuP12OHVOZO6Y4TrFJ7QEBLjlow0k6DeNEio09uG+xHQ2AUdU8/jq+t32PolCwlSUZz
    rjfwwm7+MHmH7p8CeEaOJM+47uqhTWVsnb2NXsuNTBWX/JNdemM0+s/PV2+BBw98tb0Z
    BC55IuVyZ/hoHQK6SQH63eVcLyH3+nekJ+HBAenC/uCa7bBrbBXUTP3XEDKC0UFDvi8q
    c9lhhjY6c0sA3BHXO34xkPvYmyJa1ovWZOivNC++Cewhz6B5s0R9bYB8TpoQlUlUMPJ2
    V+Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1681714553;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xcCeKYOa0MHGI98dKHHahLnFxggYEtvrjNiDEqIX4+M=;
    b=XmOcnTYfGsJZvU6ZPE2pXSKnGb/tXzX5IpofqN1KLLF1yP+3DShdLFTvZUTnYFlrQZ
    x5HT+hx+xzOtrQEouuCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az3H6tqb7Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Apr 2023 08:55:52 +0200 (CEST)
Date:   Mon, 17 Apr 2023 08:55:45 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     jbreva@nayarsystems.com
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: wwan: Expose secondary AT port on DATA1
Message-ID: <ZDztcQ0NPz8L60UZ@gerhold.net>
References: <20230414-rpmsg-wwan-secondary-at-port-v2-1-9a92ee5fdce2@nayarsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414-rpmsg-wwan-secondary-at-port-v2-1-9a92ee5fdce2@nayarsystems.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:07:24AM +0200, Jaime Breva via B4 Relay wrote:
> From: Jaime Breva <jbreva@nayarsystems.com>
> 
> Our use-case needs two AT ports available:
> One for running a ppp daemon, and another one for management
> 
> This patch enables a second AT port on DATA1
> 
> Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>

For future patch resubmissions please pick up already given review tags
when you resend new versions (b4 trailers can help you with this).

Acked-by: Stephan Gerhold <stephan@gerhold.net>

Thanks,
Stephan

> ---
> Changes in v2:
> - Modified subject prefix to be netdev list compliant
> - Link to v1: https://lore.kernel.org/r/20230414-rpmsg-wwan-secondary-at-port-v1-1-6d7307527911@nayarsystems.com
> ---
>  drivers/net/wwan/rpmsg_wwan_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> index 31c24420ab2e..e964bdeea2b3 100644
> --- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
> +++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> @@ -149,6 +149,7 @@ static const struct rpmsg_device_id rpmsg_wwan_ctrl_id_table[] = {
>  	/* RPMSG channels for Qualcomm SoCs with integrated modem */
>  	{ .name = "DATA5_CNTL", .driver_data = WWAN_PORT_QMI },
>  	{ .name = "DATA4", .driver_data = WWAN_PORT_AT },
> +	{ .name = "DATA1", .driver_data = WWAN_PORT_AT },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(rpmsg, rpmsg_wwan_ctrl_id_table);
> 
> ---
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> change-id: 20230414-rpmsg-wwan-secondary-at-port-db72a66ce74a
> 
> Best regards,
> -- 
> Jaime Breva <jbreva@nayarsystems.com>
> 
