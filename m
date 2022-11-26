Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0976393C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKZDwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZDv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:51:59 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B2B31DF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 19:51:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BB46A5C0091;
        Fri, 25 Nov 2022 22:51:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 22:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1669434717; x=1669521117; bh=3u
        jM8UHyuDfcDioa+M62k3cGA6eq9x6NleABe6i0rIo=; b=OSXff/yKbOzqJ4VjHo
        0AzQXoY/Cgm4kAoHpuLf3fmnM6oyR8zYe9LO5z3xIgeUHaJO7pYfONYaJ37Quaiu
        yL7ZY7AYIH92j5FwD3OJhRBr1PvueYjG5quQ2AsPToz+m628jzCRNrWE6yiXlk2Z
        kLEzYjWW367DSzSIKHHCk4THmDEfCAEae7/KsV3ou81/oXL6EabW14NYO5BFCWzQ
        ARgmcq/K7JC2+CQKULxhMXkfO97Ic+nW5n4F8UZoeVS5/LIPsYiveK1SlWolQ3ja
        xWM4VcIHXYcMhemjB+KgvVXCV8emf3ixyDurACUBWAxK/0BJas0Ro0E039mRywuW
        T6tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669434717; x=1669521117; bh=3ujM8UHyuDfcDioa+M62k3cGA6eq
        9x6NleABe6i0rIo=; b=kSskeQjjXBH/+cGyNinWVFjlldEqh7D1TzIv8XgWJ6yE
        wogW5pD2MT48iw5DvYq1tlZ2EeA8eCqYGMQUJMABVqn7eA5w4Z4DwzFUCRr4zS/r
        L7u+QpucUIpoq/Uqg7f7Y/cqZ+gn2651ziwd6VG4cXxgg1wsp/aUfbYcAzK+bdbM
        vTME9luoi/FgWHsxWLRXFXXZeHQQNtZ/aAyq6mUXpni1zdCOyE7YMgOcEcpSDZmb
        kXE5usXncVt1qXR1dEamQyfZTHzdfIiTXiZnKhTZtLprQCl1kDYm8IxsYB3kiJRO
        LlkGnERwGPGSKQl9KgOgHuQS8TMTB3dfNGtG6pNrpw==
X-ME-Sender: <xms:XY2BY7IVPdOILlT--EWAGBcAlkAOvFWqPuJYUhlx2q9pqHZe95bjnQ>
    <xme:XY2BY_JEjnZUURzaGLT69tstknT6bxDpaL8XAWlgYQAnCBAyiv74oyymwCWopWKvT
    bk1Onj1-quU0VGXJKU>
X-ME-Received: <xmr:XY2BYzsf_a5u1Q8YfxSDxcAT5YU-So-gYG7H5NSUmsux3Qy6OyVkkmlP6xsFA-mDxZjOtvLqCFKTlVoQZ9dX0GOzIMNlFyB_8KMv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeei
    leejheejuedvgefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:XY2BY0a6HCU64g7q4YPnU5DVrwIM-PepyyTXEdwxhHFB5W5h_QDnKQ>
    <xmx:XY2BYyb4YUWDAFwUSIDX1MDk6SNf9Nxvsg7XOmIeGjvNtwzaYd4WFA>
    <xmx:XY2BY4Bol8csEH1Rj6gTRhgkirHM-mXqk0mA8k1ozqmKhJbZ1vcN_w>
    <xmx:XY2BYxmkCf9kLuNaVgN1kAlXgBTPSrkUrYL-99y7SpCL5bkM7Bh-kQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 22:51:56 -0500 (EST)
Date:   Sat, 26 Nov 2022 12:51:53 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: pcm: fix tracing reason in hw_ptr_error
Message-ID: <Y4GNWYcQBUKn3KSa@workstation>
Mail-Followup-To: John Keeping <john@metanate.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20221125162327.297440-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125162327.297440-1-john@metanate.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 25, 2022 at 04:23:26PM +0000, John Keeping wrote:
> Strings need to be specially marked in trace events to ensure the
> content is captured, othewise the trace just shows the value of the
> pointer.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  sound/core/pcm_trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
 
Thanks for the patch, while I have a slight concern about the intension
of change.

Let's see message in below commit to add 'trace_safe_str()' in
'kernel/trace/trace.c':
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a6944fee68

"The proper way to handle displaying any string that is not guaranteed to be
in the kernel core rodata section, is to copy it into the ring buffer via
the __string(), __assign_str() and __get_str() helper macros."

Additionally, the macros looks to be alias to __dynamic_array() or so.

In our case, the pointer of 'why' argument should points to two
hardcoded strings; "hw_ptr skipping" and "Unexpected hw_ptr". As long as
I know, they are put into any of .rodata section.

```
$ objdump -s sound/core/snd-pcm.ko -j .rodata.str1.1
```
 0830 74757265 20436861 6e6e656c 204d6170  ture Channel Map
 0840 00585255 4e3a2025 730a0055 6e657870  .XRUN: %s..Unexp
 0850 65637465 64206877 5f707472 0068775f  ected hw_ptr.hw_
 0860 70747220 736b6970 70696e67 004c6f73  ptr skipping.Los
 0870 7420696e 74657272 75707473 3f00756e  t interrupts?.un
```

I think current implementation is enough safe.

Nevertheless, explicit usage of the macros are developer friendly in my
opinion since string buffer in C language tends to bring problems and
the usage of macro would reduce careless future mistakes. In the case,
when probing the event, the string is copied to memory for event
structure, thus it adds slight overhead than current implementation. I
leave the decision to maintainer.

To maintainer, if you apply the patch to your tree, feel free to add my
review tag.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/core/pcm_trace.h b/sound/core/pcm_trace.h
> index f18da2050772..350b40b906ca 100644
> --- a/sound/core/pcm_trace.h
> +++ b/sound/core/pcm_trace.h
> @@ -88,19 +88,19 @@ TRACE_EVENT(hw_ptr_error,
>  		__field( unsigned int, device )
>  		__field( unsigned int, number )
>  		__field( unsigned int, stream )
> -		__field( const char *, reason )
> +		__string( reason, why )
>  	),
>  	TP_fast_assign(
>  		__entry->card = (substream)->pcm->card->number;
>  		__entry->device = (substream)->pcm->device;
>  		__entry->number = (substream)->number;
>  		__entry->stream = (substream)->stream;
> -		__entry->reason = (why);
> +		__assign_str(reason, why);
>  	),
>  	TP_printk("pcmC%dD%d%s/sub%d: ERROR: %s",
>  		  __entry->card, __entry->device,
>  		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? "p" : "c",
> -		  __entry->number, __entry->reason)
> +		  __entry->number, __get_str(reason))
>  );
>  
>  TRACE_EVENT(applptr,
> -- 
> 2.38.1


Regards

Takashi Sakamoto
