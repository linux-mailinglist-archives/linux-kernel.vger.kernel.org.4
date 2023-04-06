Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01926D98F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjDFOGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDFOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:06:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3B93D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:05:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D5515C008E;
        Thu,  6 Apr 2023 10:05:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 10:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1680789936; x=
        1680876336; bh=DAcmnY1Q1z8EU+4I4aVFUF/Azk8umAnJTEKhofKGfzM=; b=z
        nIKK2kQEolnsPtyMuEMiZcbDaNdp7g3x1rXcOaanfH0X0991cZIHv/07q7QfPtcT
        BFcJ5LFeAO5Vc7O0RkfpDBl2RSjPCnNv8DZwaJvpMW0XsiOKwBNGi3eiVN3OM/KM
        DPqN4nR4zQtuRFEbdcijvf4GRVGqyyIfrxFbR2J5qtY6WmHYPjzQ39XC7Y5TmSfi
        KYZgiY5EAmgnPUwJhrD/QAEU/ajfPvHTodk3CwhTOTbevhndpmNPKhskYlobV7QZ
        HOZHqxTavpfOtnvB3Mm7NVn9+H8QvYFovsZYT6+KDFTY7at6O9Sp4mS5pkLWxIpu
        x4mBDBpqipjFoWKQKunoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680789936; x=1680876336; bh=DAcmnY1Q1z8EU
        +4I4aVFUF/Azk8umAnJTEKhofKGfzM=; b=EdqRSNNQ75i6Dwcnq3z36VsH6XXk1
        26oawqdRmVlnEkH0U89u02cg9lMJm9Zj0d22tZnrtgNuo8h4MQXgb6ENa5Lq1/dJ
        g/SN/h3xIaCqbHk0+5lmCFHhGQJSG2ZgSkjKXd38/2TnN9n/Mmhva5tmd0IIjMkL
        q4/1tp6YgaRfQZdVAZqxZOfS1MHIbEhXffFAg7lJiuudr1ZjZ1oR+HEzQgj8Wu/z
        N5zd3Z8FiIOgjycnwiOiU0fkxoOSUmHpqLxFRaV/bl6EjcP4II7/4NNoJKcsUfJ5
        60y1j349abkNa1uK7OoMmgeU9M0gK9+vsOvEDfT5TQHM9eTAE7MX37zUw==
X-ME-Sender: <xms:rtEuZJGLdJkxbLbuYRce6TQReIldoxwl07PJ6v1bk200yOVK82Iseg>
    <xme:rtEuZOXOpbtE5ljmWsWDIXi9RZUmROAxE6dqj21qQEBwcDNjIgf5sGFMh9VLtdb7w
    uK213Fptp4TEehmQyw>
X-ME-Received: <xmr:rtEuZLIt9yV6ZxBnIbzobzUUn0aexNUctoCZy2rxvldmNNkpdtsr9RKRS1UkvFcHRfXzG8NUCfrcn9c3Y11RBJQkbl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:rtEuZPHMR_7NCFUD9Gq7g3tT0FAlyWzTG0bRhCgeqF67CXZj8Qdj1g>
    <xmx:rtEuZPWMIu98-FsNyJK_-3i-IcfmRftwPTmGPnPnsgl1wvaK7zQ7nw>
    <xmx:rtEuZKO-HMXeXKnreKd9xL4Zlz6w4846ca_1zHoktJQMxTNAE1Lj7A>
    <xmx:sNEuZLrmdD4zAdFm3MDKbezWW_sn2lPC84a6YL6_fmI6oIGvnYN-Og>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 10:05:32 -0400 (EDT)
Date:   Thu, 6 Apr 2023 23:05:29 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Xu Biang <xubiang@hust.edu.cn>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dzm91@hust.edu.cn,
        error27@gmail.com, hust-os-kernel-patches@googlegroups.com,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire-tascam: add missing unwind goto in
 snd_tscm_stream_start_duplex()
Message-ID: <20230406140529.GA159563@workstation>
Mail-Followup-To: Xu Biang <xubiang@hust.edu.cn>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        dzm91@hust.edu.cn, error27@gmail.com,
        hust-os-kernel-patches@googlegroups.com,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230406132801.105108-1-xubiang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406132801.105108-1-xubiang@hust.edu.cn>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 06, 2023 at 06:28:01AM -0700, Xu Biang wrote:
> Smatch Warns:
> sound/firewire/tascam/tascam-stream.c:493 snd_tscm_stream_start_duplex()
> warn: missing unwind goto?
> 
> The direct return will cause the stream list of "&tscm->domain" unemptied
> and the session in "tscm" unfinished if amdtp_domain_start() returns with
> an error.
> 
> Fix this by changing the direct return to a goto which will empty the
> stream list of "&tscm->domain" and finish the session in "tscm".
> 
> The snd_tscm_stream_start_duplex() function is called in the prepare
> callback of PCM. According to "ALSA Kernel API Documentation", the prepare
> callback of PCM will be called many times at each setup. So, if the
> "&d->streams" list is not emptied, when the prepare callback is called
> next time, snd_tscm_stream_start_duplex() will receive -EBUSY from
> amdtp_domain_add_stream() that tries to add an existing stream to the
> domain. The error handling code after the "error" label will be executed
> in this case, and the "&d->streams" list will be emptied. So not emptying
> the "&d->streams" list will not cause an issue. But it is more efficient
> and readable to empty it on the first error by changing the direct return
> to a goto statement.
> 
> The session in "tscm" has been begun before amdtp_domain_start(), so it
> needs to be finished when amdtp_domain_start() fails.
> 
> Fixes: c281d46a51e3 ("ALSA: firewire-tascam: support AMDTP domain")
> Signed-off-by: Xu Biang <xubiang@hust.edu.cn>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> ---
> Note that this finding is from static analysis and not tested.
> 
>  sound/firewire/tascam/tascam-stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Indeed. I overlooked it when posting the patch. The bug exists Linux
kernel v5.4 or later and the fix should be forward to stable kernels.

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
> index 53e094cc411f..dfe783d01d7d 100644
> --- a/sound/firewire/tascam/tascam-stream.c
> +++ b/sound/firewire/tascam/tascam-stream.c
> @@ -490,7 +490,7 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
>  		// packet is important for media clock recovery.
>  		err = amdtp_domain_start(&tscm->domain, tx_init_skip_cycles, true, true);
>  		if (err < 0)
> -			return err;
> +			goto error;
>  
>  		if (!amdtp_domain_wait_ready(&tscm->domain, READY_TIMEOUT_MS)) {
>  			err = -ETIMEDOUT;
> -- 
> 2.17.1


Thanks

Takashi Sakamoto
