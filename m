Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E8727548
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjFHCvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjFHCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:51:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E31BDF;
        Wed,  7 Jun 2023 19:51:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AD50832007BE;
        Wed,  7 Jun 2023 22:51:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Jun 2023 22:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686192675; x=1686279075; bh=fe
        G13tHn2eFFa/kfOQnMAGH3Yu0x2pEJQhtv4nEbQgY=; b=oGSi83rhDGLe3v8JDu
        hvAZ6SSI/Rj1lort7dp9CaDIuwuJOtfd4sM1idvqDee/bvTgpHUm76q5wKliAay5
        14+rkSI8xc8mof0elbKdBA12/yNFSUuxEKGRAhzmeTzxqxrnce+Rao3hI9j7rlH2
        nxQACgTw2T1vwa0pFrY8iw+VRjlAOoKjXQan4c77avGk+siJYBat3R8E6c0qj3s1
        RFHKhFmznH20qgGAWwBpNhpCBl8r7GnvePwDYIySSHXfhGJo/XT4yiquyuXMEQ9g
        AgTebApTlFcMm6/0izRFoX8gB21MZqwWvVn7/XPIJags0ku+5EbTFBdngb1KBewl
        HEsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686192675; x=1686279075; bh=feG13tHn2eFFa
        /kfOQnMAGH3Yu0x2pEJQhtv4nEbQgY=; b=EoIgrdkOh/4UTUBOd/IsLvhFDhfNz
        PqlxYPnmzEffPTME77d205NcE28ebANJ2uw1usiQv76+Inv4T8BtaS+MOdH3q6i/
        8hEyfGm1Tbs+XSWhJt99+xvKVxtgb2A+qT6wT4gGpLXtDqNX5k3/kZ5pCH0q9gNv
        GHs65Nnc4VJTgI7vbdLkN1xVKWdjmzTLogSZ3SmrI05dnWoZeCWZyaIDZXXV5ED5
        bikx6+1YFsPNMTYS/LmtWJIQp8lnP4nmX6kL4T80pjolnVhIsrIirGl02ylWKzua
        k8m5rSW8KuT5Loqpuv+StmP0t1j36JuKyOtcDbsPjFkVSKzmRv+1b9beA==
X-ME-Sender: <xms:I0KBZPYUwZUi_jJc2AlClMK4xWOkuzPaeJQ6l8iFxqqlQk1sM-R1sA>
    <xme:I0KBZOYMySpr2kyYK_mX3MVx4Dv97HlZNZIt_eocZbIgW6TgOwNP_v3pXQ5SCi2b5
    o6tTMNscLbHunAw6WQ>
X-ME-Received: <xmr:I0KBZB96mSiPonHl8Mgk7gOhOOvHuEugtykpubXHvN_57Li6ALO1KOkqnkFn5Sg1HppcN-HaNFSHyTQS60LXhtaQ04hEka2LQAJO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedthedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeefgfejvefgudfhfeevudekueegtdeutdejhffhhfdv
    keejhfehheefgfehteejffenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvght
    vghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:I0KBZFpFiOh9JY8VoFEgngsxAix05PFdCk1qvSLxIg7NcGhmBzhHHQ>
    <xmx:I0KBZKonkKce1iWDK9ii14ds5jWX8NwOlXAQ7Por3FMO3k8waRaGjQ>
    <xmx:I0KBZLQ7olkUZQApq3fNcSyHR68Kk7qnliE_cf4A_E0Rrb77SQ_Edg>
    <xmx:I0KBZKKcx3nGlpxkBKL6HtWkyzmOcNtA1MqkLdpc9MQCuudEZSBZJg>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 22:51:12 -0400 (EDT)
Date:   Thu, 8 Jun 2023 12:51:06 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@joshua-dickens.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: wacom: Use ktime_t rather than int when dealing
 with timestamps
Message-ID: <20230608025106.GA4142460@quokka>
References: <20230607214102.2113-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607214102.2113-1-jason.gerecke@wacom.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:41:02PM -0700, Jason Gerecke wrote:
> Code which interacts with timestamps needs to use the ktime_t type
> returned by functions like ktime_get. The int type does not offer
> enough space to store these values, and attempting to use it is a
> recipe for problems. In this particular case, overflows would occur
> when calculating/storing timestamps leading to incorrect values being
> reported to userspace. In some cases these bad timestamps cause input
> handling in userspace to appear hung.
> 
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/901
> Fixes: 17d793f3ed53 ("HID: wacom: insert timestamp to packed Bluetooth (BT) events")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter

> ---
>  drivers/hid/wacom_wac.c | 4 ++--
>  drivers/hid/wacom_wac.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 2ccf83837134..2f16e47e4b69 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1314,7 +1314,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
>  	struct input_dev *pen_input = wacom->pen_input;
>  	unsigned char *data = wacom->data;
>  	int number_of_valid_frames = 0;
> -	int time_interval = 15000000;
> +	ktime_t time_interval = 15000000;
>  	ktime_t time_packet_received = ktime_get();
>  	int i;
>  
> @@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
>  		bool range = frame[0] & 0x20;
>  		bool invert = frame[0] & 0x10;
>  		int frames_number_reversed = number_of_valid_frames - i - 1;
> -		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
> +		ktime_t event_timestamp = time_packet_received - frames_number_reversed * time_interval;
>  
>  		if (!valid)
>  			continue;
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 1a40bb8c5810..ee21bb260f22 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -324,7 +324,7 @@ struct hid_data {
>  	int ps_connected;
>  	bool pad_input_event_flag;
>  	unsigned short sequence_number;
> -	int time_delayed;
> +	ktime_t time_delayed;
>  };
>  
>  struct wacom_remote_data {
> -- 
> 2.41.0
> 
