Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478F973A578
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjFVP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjFVP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:57:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE18BC;
        Thu, 22 Jun 2023 08:57:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id EA96E3200392;
        Thu, 22 Jun 2023 11:57:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 11:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687449477; x=1687535877; bh=Sw
        WTzuTjlgQGVQR+2YmginMJTPMuluTbAtrwpUP0wfo=; b=z7WijLKX4mWQ20kxya
        fP5mjgLJYkoAAtf5A+yuY2kiC2I0TNyz8Gaas9gXfxooHjCQgW+BM7X51d2o7C0p
        AnUCyOJ2q9VvmA353KFSAHst6JqMHsnLvQ3gIYnsMcbnlIlnXAbrlL+Hbi7xntwg
        hZzZFfBqiaU4K0eKdFSksPhc4pcHW29roRhMMUQQKWf3kRvxLtP07pBg8zSNRPYU
        YJc7O8bFx5LBHARQ/UeSTTspqw+vK67xNEk938CI4aYas3fX2+D36JdWfBLngTsl
        /n+Msb5275QxmStpvoH6dPCkTapxN5ksXFirDfWx6nUpuiwpBCT1fFHHk9fDyhl3
        DHiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687449477; x=1687535877; bh=SwWTzuTjlgQGV
        QR+2YmginMJTPMuluTbAtrwpUP0wfo=; b=JBsD8nlKZ1C/MCx5MeyjOivYet3sO
        Vjzv5dtZhLCDbya4bu+BUFevRMrXbmxsA8SbrfDVSFOUF8Q/LA5+TtYWj7l7YNmn
        XW4yap0yACnl1jNuRjKAZfMsofma7XJIBxw24kI6TcoHlenabieRkz1A5iVYHVq9
        yqe7V0+taAmaBaGwux/UWwTgZuahKzD0COB34UmNF59CZWzI6k7X55c96Uph4LRW
        pgDWz/tbkxzW8LQ+pDEy51FqZqOwkpHdOP/NZCZcND4j9BFwxATD3qVz1BacBB3G
        P+VsG3YjQhtVgjutN1ShSSBLOBR5bKBKMnde4Qxv29/z3QtYJzM0KWxMQ==
X-ME-Sender: <xms:hW-UZFVv30jGSQpwIjkSJjtwhzVhqRsvpKQ345Q2F7m2A3Mb5-NluQ>
    <xme:hW-UZFnhemXm5OG3u73MDH-I9U-gpqzbLHoNjTEjw7tPLQFkanhGjGGObxKRF-mXh
    AMxzQm3bMoD9us_jPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hW-UZBZBNH9MaszN3wEgUkUV2aFbzvt8GASqsKtlUR9Ln4mkH2eovw>
    <xmx:hW-UZIXm5HQ8gBuENtfG5qUf9-sbAtE2BivmOM0y_rLyeXEzppTYlA>
    <xmx:hW-UZPlocYEFPEpgevh2F5csFZ0AvsErCRP0qDOBpQH7TxBTc30V2g>
    <xmx:hW-UZKugy9k9pVem3w0cnoD-1069dv5-8fjdhPvYotwHkN-bw2sP9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3710DB60089; Thu, 22 Jun 2023 11:57:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <227ff023-a0fb-476d-ae5c-0733cc6223eb@app.fastmail.com>
In-Reply-To: <9c52ce87-f69c-e69c-ec43-6b2cc3b37c4a@linaro.org>
References: <20230622101813.3453772-1-arnd@kernel.org>
 <286cf2d8-2da8-7203-ee53-bf08332fa519@linaro.org>
 <f28f78fc-84ce-4990-9126-4075f3d88e01@app.fastmail.com>
 <9c52ce87-f69c-e69c-ec43-6b2cc3b37c4a@linaro.org>
Date:   Thu, 22 Jun 2023 17:57:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Bjorn Andersson" <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_DRM dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 17:39, Neil Armstrong wrote:
> On 22/06/2023 13:24, Arnd Bergmann wrote:
>> On Thu, Jun 22, 2023, at 12:39, Neil Armstrong wrote:
>>>>    
>>>>    config TYPEC_MUX_NB7VPQ904M
>>>>    	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>>>> -	depends on I2C
>>>> +	depends on I2C && DRM
>>>>    	select REGMAP_I2C
>>>>    	help
>>>>    	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
>>>
>>> I think it could be :
>>>
>>> +	depends on DRM || DRM=n
>>> +	select DRM_PANEL_BRIDGE if DRM
>> 
>> As far as I can tell, this would only avoid the link error
>> against devm_drm_of_get_bridge(), but not the one against
>> devm_drm_bridge_add(), which is defined in drm.ko through
>> drivers/gpu/drm/drm_bridge.c.
>
> I'm trying to reproduce such situation, but so fail I fail.
>
> In the driver there's a guard to avoid calling into DRM functions
> when disabled:
> #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)

Ah, you are right. I got confused because the check is in
header file for devm_drm_of_get_bridge(), but not for
devm_drm_bridge_add(), which has the check in the source
file as you point out.

> so I wonder which kind on config leaded to that since
> CONFIG_DRM_PANEL_BRIDGE is only enabled when DRM_PANEL and DRM are.

I only saw the original issue with

CONFIG_DRM=m
CONFIG_DRM_PANEL=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_TYPEC_MUX_NB7VPQ904M=y

and since CONFIG_DRM_PANEL_BRIDGE already depends on CONFIG_DRM,
I think that is the only one that can go wrong, so your
suggestion of

   depends on DRM || DRM=n

should be sufficient. I see that DRM_PANEL, DRM_BRIDGE and
DRM_PANEL_BRIDGE are now always =y whenever DRM is enabled,
so I don't think the 'select CONFIG_DRM_PANEL_BRIDGE' serves
any purpose any more, but it's also harmless if you think it
helps for clarification.

Can you send the updated patch, or should I?


     Arnd
