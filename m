Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1869A73C6DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFXFGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:06:35 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDC26B5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:06:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D63A5C0106;
        Sat, 24 Jun 2023 01:06:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 24 Jun 2023 01:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1687583189; x=
        1687669589; bh=xTcWi/yTV0WLNStYdY7FlgidHW53zi+FN5b13oc+uQI=; b=j
        qD63SzeN9KcFZhsMDI2oCJJh03y5H/RC1W1a9hW6wcTQnncmewu+wfDBAOyAor4j
        VKLLedvkDMfZdSTtSqX/Jc65PqjTMars4TKgFtRKsuJl8GNM0uUTQklSNr3uI8VE
        ms/cIDXTEHA3XW6CWalgQsGJCMLz0TLSYSDHO5PVLe8diGqgoBfdkJukKiLt0L0O
        DF5cmC7YYST0r/aNS9/x9HYyo5fYJ8GDAPFdRNIXBZQb8L3uT4XnIInb1MSLUOuq
        BCPogYK/2MbhTFFaFmwjddFrLxZxBPcacN151vpm38eJ4acxvuJ3DUj4HEJ3pKzP
        7Mfrmk8Z3QYrdsJKodX4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687583189; x=1687669589; bh=xTcWi/yTV0WLN
        StYdY7FlgidHW53zi+FN5b13oc+uQI=; b=lzwSf25m+C3fCcgRPjJ+fgE501fSU
        6oSDFVsBwBhKWj1/9Y2SIwg3L1vkR1UUBmQb0jgGTaRpTCZgJs1kWD9iljaJda/o
        SxaAJ8nR34InHM8XQotNDnTfGNXi6RsnNJZ+Os5I9DmzgJ5UtdknKZdYEVESX545
        W7Ut4BX3Mon9IgHql9tnYL+Emp3LccbK5DDrfujB2De872X0m+r8K2eYl6GFRs4Y
        bEowQ5WVPbhCLl64xw6NPeiXsxjs9IrX4eWSTTosefiz2Qks9Ui6q0xiO+mOIMhJ
        Wwy2Gsth8eJHVCcZoRf5p3eUXOFBCxrbuxt3+r4yyRU7Z5ZDfKE+N1ZPA==
X-ME-Sender: <xms:1HmWZOGUWTOWGCcSI-pflhPD7pR6qNdkkNH-GUnyadc4S6gYo2fJuA>
    <xme:1HmWZPWlSP7VkMtXFDXx824eFxZr1Tl0ZDvEcjT2PnG8td0LqYnmvGE4VSy9QpOVX
    VXkfF11TkMocb08Clg>
X-ME-Received: <xmr:1HmWZIIfRfXnNJaRGDO_eMRur1OpkrU6lwel8remsY4kN8bXKuOE_qUYDRyyv9euPku5snKEBrKK5pJ4hNb0ZqQ7G1daHds4_ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:1HmWZIGieJX2F-fexYnPeY4FnFHwZMsaZTsuXYlUePNcwOYoRw5ykA>
    <xmx:1HmWZEXbjO9sSWX1I4CXIoa244hU-zTEasQ37mbTltzJ9z0hoIsryQ>
    <xmx:1HmWZLP2ewb_m-BgDOwGywwfH1ARYAqYnEfbqg1INbMOrL71PtTrqQ>
    <xmx:1XmWZPccd-jSOxzyIzo7VXji_mKAB498LzdyoxSPMxZvXKQ9-mg5IA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jun 2023 01:06:27 -0400 (EDT)
Date:   Sat, 24 Jun 2023 14:06:24 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: net: fix use after free in
 fwnet_finish_incoming_packet()
Message-ID: <20230624050624.GA231724@workstation.local>
Mail-Followup-To: Zhang Shurong <zhang_shurong@foxmail.com>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the fix.

On Fri, Jun 23, 2023 at 01:39:35PM +0800, Zhang Shurong wrote:
> The netif_rx() function frees the skb so we can't dereference it to
> save the skb->len.
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/firewire/net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
> index 538bd677c254..7a4d1a478e33 100644
> --- a/drivers/firewire/net.c
> +++ b/drivers/firewire/net.c
> @@ -479,7 +479,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
>  					struct sk_buff *skb, u16 source_node_id,
>  					bool is_broadcast, u16 ether_type)
>  {
> -	int status;
> +	int status, len;
>  
>  	switch (ether_type) {
>  	case ETH_P_ARP:
> @@ -533,13 +533,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
>  		}
>  		skb->protocol = protocol;
>  	}
> +
> +	len = skb->len;
>  	status = netif_rx(skb);
>  	if (status == NET_RX_DROP) {
>  		net->stats.rx_errors++;
>  		net->stats.rx_dropped++;
>  	} else {
>  		net->stats.rx_packets++;
> -		net->stats.rx_bytes += skb->len;
> +		net->stats.rx_bytes += len;
>  	}
>  
>  	return 0;

I'm not good at network subsystem, but as long as reading network core,
I think it better not to access members of sk_buff structure after the
call of netif_rx() since the ownership is already delegated from
firewire-net to the network core to dispatch network protocol. The patch
looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

The most of code in firewire-net comes from old driver
(drivers/ieee1394/eth1394.c), thus the most of linux kernel which
supports ieee1394/firewire subsystem affects the issue, however the
potential issue has never appeared since the skb is released enough later
in the different context. I applied the patch to linux-next branch for
v6.5-rc1.


Thanks

Takashi Sakamoto
