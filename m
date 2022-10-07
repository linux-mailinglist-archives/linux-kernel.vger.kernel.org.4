Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8D5F7696
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJGKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJGKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:00:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1A20343;
        Fri,  7 Oct 2022 03:00:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F86D5C00C2;
        Fri,  7 Oct 2022 06:00:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 06:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rieck.me; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1665136821; x=
        1665223221; bh=J9zgWuMPYAdhzYBzU+Ahl2DS+oFgcxYbCg1umcBCcnw=; b=C
        EurqxC8sjhNAs6EcM/4Pp4q+Q8dRH+cWbRN2ZaZpWQFf3wRa9mg8qSu/jstYefxw
        tF7IwaCoRfj16iioOZz+59wVfebiKb4V04+OvD0DUMRKFbrEMckjEt3cdDGc5B5n
        PwU5Ph0nUVdxx9OUGK2yPe2wGIAjuBYhc8j+OH5anX1gJTk9RjcUblqJZS4RQf65
        j/Xs35P4opcNTwSXyB2D8ZmXh65CcVuUfLL8b7TJ8WJsV85kgHWmZao5ZEed/Mly
        gTq7WlY2SCvm7zPHXmWvmmoSzQEaY91Q65XYkzUsbGX6kFmsrWSG4rpf0NPohJQN
        C+jpDJT3A9L++y0Jkzlpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665136821; x=
        1665223221; bh=J9zgWuMPYAdhzYBzU+Ahl2DS+oFgcxYbCg1umcBCcnw=; b=S
        CljbVAi2Z+nNap5gC27y43OkoFuzS35RGKRmGyqZUq5reD7kkEN/K9buzZ9xpFJh
        X8k/2IJ9IJ3K9j2+z2nrJw72mT/urIgLINjSW1hd8iCmNHuKJANb/Py3AYQ/0TfX
        mZCfTsvqSH8Y5dhA0s9WmZzG7gJibHrDEOxtUaPjQo0CzV5QfDcEOQBAvSGB17iQ
        3NJ7a8bgGMdIcB4X1NPjYXQz/qwcYX2ndwQyppDh58mm9j72cQ3DEa3Y1iwwKCta
        JdlqzOfTHPy0EEIpP6LUCVLgk3xP2tyB8fKEpdFmHhJ6DBfmP0twXw/7tVSzDfTD
        skDZdq38Ey/Y9dpLVoWOA==
X-ME-Sender: <xms:tPg_Y8fb23HvPWlz1k9p7VKFi-DO1lnSf7YPkpuTgK3NJ0KaQA_9DA>
    <xme:tPg_Y-N5e3eUbsDcBnCaBeuPx6iJu1Dj-PBjZ55cbBiG9OINyXEw1eBwUajihY-92
    6Rrv0icOoSszqJv>
X-ME-Received: <xmr:tPg_Y9gvuf1LCas58KPAOeh1UUVL3CVGAjrggoHVZZC7W0trION3rLgoqEZ0N4OWWSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepuegrshht
    ihgrnhcutfhivggtkhcuoegsrghsthhirghnsehrihgvtghkrdhmvgeqnecuggftrfgrth
    htvghrnhepkeetfeehjedvhfeuleejgeejiedtfffggeeileffieefiedugffgvefhjeej
    udefnecuffhomhgrihhnpehsphhinhhitghsrdhnvghtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrshhtihgrnhesrhhivggtkhdrmhgv
X-ME-Proxy: <xmx:tPg_Yx_b2BjvuihiEfHH8TeaFJ4wn1XiHLCOrqQriBcK4J3a506E1A>
    <xmx:tPg_Y4vqCoggqtaLONjPv6xLLQSesCTPDCy1vrw-IE8sIfqVl_zvhg>
    <xmx:tPg_Y4Fbaf7bgmJnM2X2PqJas8m-CfCIpOYEMRBvosDuoS6Q2z-NNQ>
    <xmx:tfg_Y5GwGeMcpTQy36DaUeWag1eDL4MLtQibSRHfgBQSUybuniE5XQ>
Feedback-ID: ie53945e4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Oct 2022 06:00:18 -0400 (EDT)
From:   Bastian Rieck <bastian@rieck.me>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        grzegorz.alibozek@gmail.com, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: Re: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Date:   Fri, 07 Oct 2022 12:00:16 +0200
Message-ID: <11781567.uqkIggiGGz@nimue>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAABGdBTUEAALGPC/xhBQAAAAFz UkdCAK7OHOkAAAAVUExURdnY2d3d3vDDp8KYgoJnXK3K7i8gH0swGw4AAAH1SURBVDjLZVTNcpsw EJbopGfAk3uRPD4z2g1njDY6J2nVB0hUvf8jdFcIDO36Z8R+/n5WCCt1qLbt9uJLLe+WP52WegDl t+XF7fbAYIWV40bmdHoHpK2Vboy19ijVCqNVjXHGOFB6Z2hxV8pIAcCBUfpNASzAvWYurhtBKKM+ xVXOVApWk9r/VhkWsQY+Ab1ozSeGKPX9IFJj9y+wuuO8xlonX4GhAPf/pIbCoHtbclUA9jlo1sdU gOiNQY8FODB8ttlZwinRrFqZpAIZAHNGgACj2hicyn7hd/q8hQkDEah2l1qsN+7zthg7EYWitQJ2 4rzLlb8shSPDlLh2kTmC3EWt6x5a01/MFYcBKLnivgIXyydhsK5nqTTyIdgYjWUhgyAeNGoxqXMI I+UkQJIJOr0B4G6UyRkkkvPU7nfQ8dRAxKmEsKdigLhCcEhqO7V1e/11uExXj/PaPwB82MBWQO1S Cr44F6CneXsuNpMkDAbCvD5Le2X2NSFRSGdzxYHAZk6W3tSppuQxFGA+A5hTyIkov8ZT/wlClj6F eAbiB+8SJYbOwFNcQDaF8DXGg3uM0VuheM/L+Gi/x/hTjichxAdSlr+8PLKAL+WqqEUh/I58W4F3 Kz7H0nhjW1mGP9HwX4B9EVXpvKuyiinmuWl+rA7CeP4L2hiGKBFny1gAAAAASUVORK5CYII=
In-Reply-To: <YyRUF5cFGpe2xf+m@kuha.fi.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com> <YxrbtWDR7XI4s+Q+@kuha.fi.intel.com> <YyRUF5cFGpe2xf+m@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Heikki, dear all,

I am still unable to reproduce the previous error messages I=20
mentioned. In the meantime, the UCSI issues disappeared with 5.19.9=20
for me (!). I think this is related to a revert by Takashi Iwai  [1]=20
in 5.19.8.

Given these data, would it be useful to test your patch against=20
5.19.9 or a more recent version?

Thanks for all your efforts in supporting us here!

All the best,
 Bastian

[1] https://www.spinics.net/lists/linux-usb/msg230368.html

On Friday, September 16, 2022 12:46:47 PM CEST Heikki Krogerus=20
wrote:
> Hi Bastian,
>=20
> On Fri, Sep 09, 2022 at 09:22:50AM +0300, Heikki Krogerus wrote:
> > On Thu, Sep 08, 2022 at 07:01:34AM +0200, Bastian Rieck wrote:
> > > Dear Heikki,
> > >=20
> > > > I'm sending these as an RFC first because I'm not done
> > > > testing.
> > > >=20
> > > > I made a small modification to my original proposal (in the
> > > > bug
> > > > report). Now also connection during suspend should be
> > > > covered.
> > > >=20
> > > > I would appreciate if you guys could test these again. If
> > > > everything works, and the bug is fixed, let me know, and
> > > > I'll add
> > > > your Tested-by tags to the patches.
> > >=20
> > > Thanks so much for these changes=E2=80=94that's awesome! I have just
> > > finished testing this against 5.19.7 (Arch Linux) with a
> > > Lenovo X1 (Gen 9).
> > >=20
> > > I am very happy to see that, as far as I can tell, the issue
> > > disappeared completely!
> > >=20
> > > However, I am receiving additional warnings via `journalctl`
> > > that I did not receive before; I have attached this trace as
> > > an additional log file. Nothing in there seems critical and I
> > > can confirm that the system continues to operate normally. I
> > > merely wanted to provide you with this additional information
> > > in case it is of relevance.
> > >=20
> > > Please let me know if there's anything else I can do here; I
> > > really appreciate the time you spent on this!
> >=20
> > Thank you for the report. That warning certainly needs to be
> > sorted out before I send the final versions. I'll try to
> > reproduce that.
> I'm not getting anywhere with this one. Could you provide me with
> the trace output from both module and ucsi events?
>=20
> To enable those events - assuming debugfs is mounted to
> /sys/kernel/debug:
>=20
>         % echo 1 > /sys/kernel/debug/tracing/events/ucsi/enable
>         % echo 1 > /sys/kernel/debug/tracing/events/module/enable
>=20
> Run the suspend resume cycle, and then dump the trace output to a
> file:
>=20
>         % cat /sys/kernel/debug/tracing/trace > ucsi_trace
>=20
> thanks,




