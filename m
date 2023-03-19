Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390E56BFF38
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 04:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCSD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCSD3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 23:29:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0712BE3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 20:28:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C3895C00AD;
        Sat, 18 Mar 2023 23:28:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 18 Mar 2023 23:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679196537; x=1679282937; bh=yb
        43XnCzfmY5w8Ey4NgZVvKQTRQXTHa6Ivrvr4trbyw=; b=BiIp/CeP8sPbjRjOdZ
        KoJRnfSHc4nd3L+QLojhbTPIx+wOp7vVHLjJABBC89XAPqi+vedtuhywlFgQwXlC
        iFWuEKtLJhyvuecKcNE+zBggxMWkiLdg6YRf/LYiNGiBpYbgK1KOZBd3zBYiG1fU
        Scy0+ClGBkFmtoFcDOGF7UQYK2HOVmXD85hWbgCEEGv0CFEasSpqVgKWQKz3bJm4
        JkUsdjXY37ZW+/oKIhy3jzNQrTzplrOePfydqk4jt20F5EYI2lhd5QcTD5Jf6IBz
        lp07l/ZjhCuT+Dg9NIPDxNA9SVUblsWacotENYLo5QqSRTcx5/1kGc9jZKD9VZH2
        veAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679196537; x=1679282937; bh=yb43XnCzfmY5w
        8Ey4NgZVvKQTRQXTHa6Ivrvr4trbyw=; b=iz9AP39ARsL/vJOLBpOeKNbJp7fKQ
        QGxn3VUtvcUh/Sf8/u6Kh0AXpzG2Xnr5H6zg0DienitRJGMWmEpZWBa860Qazc1R
        JBtjf5hnhvCfVh+WIW4FhvbTmogdw+nAoysEjQ7wdbXZLaKseTYM97RBQeRQv/3d
        235D1ZUr1f+IPkJSWNqWw0Gf4PMx+TU4Zhnj4yQGhDjgYm/25nU03r+TV4cfYNoN
        WTAqrMOEzBwNZH8oQUXB8aJr29HJ30kjTCALAhorLARrrCkPJfUi6qf2Rmir27qn
        fsh08BVe3t/q2tYyHGPWzsGhkmgzfTNRgE+GYoraKYPRcEkn8DGwKfVTA==
X-ME-Sender: <xms:eYEWZOn2A7vqwrrV1sSHWH7EHbXkHxpCvUtBsI3nVeaRUahfEwW6bg>
    <xme:eYEWZF2TRyVkBt0cNpUcFU4g-pU4FW4F6nSPLcVN-O2lPZ4V_VAsPBqs5xr0KbxIz
    m87alHT4hVYmpwzOfY>
X-ME-Received: <xmr:eYEWZMqk-6R4Dv9TyB4aO-mb5V160FB2QsVh6PyLkS4LC_39feqJtPoK_lW1MRlFmwdQMdFU_mlG2TCj-ccPGk3hTlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefhedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeegjeefheevfefgvdfgtdfftdevgeetieffieefudei
    udduleegveehiedtffekheenucffohhmrghinhepudegrdhinhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghk
    rghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:eYEWZCkSTrDg2Vazbj7DMm_ck1p1HL6GKu8rAKWxTD-UYrmcr_wFeA>
    <xmx:eYEWZM1Vnr2Sai-oqktG44JXtLTMRWtaynjfKlmaWvgXaxWzcaPEbQ>
    <xmx:eYEWZJtSY10JF09IgcDVMn-ESsfwXamf64RI6Y5xc8secakpC4SRcw>
    <xmx:eYEWZKBvHz8GPpkRH5Zu5GDGRlIAVdVOM2oBHO40nm8rgjwL_ogMnw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Mar 2023 23:28:55 -0400 (EDT)
Date:   Sun, 19 Mar 2023 12:28:53 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     John Keeping <john@metanate.com>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
Message-ID: <20230319032853.GA99783@workstation>
Mail-Followup-To: John Keeping <john@metanate.com>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230317195128.3911155-1-john@metanate.com>
 <20230318002005.GA84781@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318002005.GA84781@workstation>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 18, 2023 at 09:20:05AM +0900, Takashi Sakamoto wrote:
> On Fri, Mar 17, 2023 at 07:51:27PM +0000, John Keeping wrote:
> > snd_usb_queue_pending_output_urbs() may be called from
> > snd_pcm_ops::ack() which means the PCM stream is locked.
> > 
> > For the normal case where the call back into the PCM core is via
> > prepare_output_urb() the "_under_stream_lock" variant of
> > snd_pcm_period_elapsed() is called, but when an error occurs and the
> > stream is stopped as XRUN then snd_pcm_xrun() tries to recursively lock
> > the stream which results in deadlock.
> > 
> > Follow the example of snd_pcm_period_elapsed() by adding
> > snd_pcm_xrun_under_stream_lock() and use this when the PCM substream
> > lock is already held.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >  include/sound/pcm.h     |  1 +
> >  sound/core/pcm_native.c | 28 ++++++++++++++++++++++++----
> >  sound/usb/endpoint.c    | 18 +++++++++++-------
> >  3 files changed, 36 insertions(+), 11 deletions(-)
>  
> The name of added kernel API implies me that you refer to existent
> 'snd_pcm_period_elapsed_under_stream_lock()' which I added to Linux
> v5.14.
> 
> In my opinion, unlike the version of period elapsed API, the version of
> XRUN API seems not to be necessarily required to ALSA PCM core, since PCM
> device drivers can implement .pointer callback in the part of PCM operation.
> When the callback returns SNDRV_PCM_POS_XRUN, ALSA PCM application get
> occurence of XRUN as a result of any operation relevant to hwptr movement
> (e.g. SNDRV_PCM_IOCTL_HWSYNC).
> 
> Therefore I think it possible to fix the issue without the proposed
> kernel API. I can assume some scenario:
> 
> 1. Failure at tasklet for URB completion
> 
> It is softIRQ context. The stream lock is not acquired. It doesn't
> matter to call current XRUN API.
> 
> 2. Failure at PCM operation called by ALSA PCM application
> 
> It is process context. The stream lock is acquired before calling driver
> code. When detecting any type of failure, driver code stores the state.
> Then .pointer callback should return SNDRV_PCM_POS_XRUNrefering to
> the state.

Although being inexperienced to hack driver for USB audio device class,
I attempt to post the patch to fix the issue of recursive stream lock.
I apologies in advance since the patch is not tested yet...

The 'in_xrun' member is newly added to 'struct snd_usb_substream'. When
detecting any failure, false is assigned to the member. The assignment
is expected to be done in both softIRQ context, and process context with
stream lock, thus no need to take care of cocurrent access (e.g. by usage
of WRITE_ONCE/READ_ONCE).

Typical ALSA PCM application periodically calls PCM operation which calls
.pointer in driver code. As I described, returning SNDRV_PCM_POS_XRUN
takes ALSA PCM core to handle XRUN state of PCM substream in the timing.

The negative point of the patch is the delay of XRUN notification to user
space application. In the point, I think the new kernel API introduced by
your patch has advantage.

The in_xrun member can be replaced with a kind of EP_STATE_
enumerations; i.e. EP_STATE_XRUN. In the case, we need some care so that
the state should be referred from pcm.c.

For your information.

```
---
 sound/usb/card.h     |  1 +
 sound/usb/endpoint.c | 18 +++++++++++-------
 sound/usb/pcm.c      |  3 ++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 6ec95b2edf86..cb07d5eb09ad 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -172,6 +172,7 @@ struct snd_usb_substream {
 	unsigned int hwptr_done;	/* processed byte position in the buffer */
 	unsigned int transfer_done;	/* processed frames since last period update */
 	unsigned int frame_limit;	/* limits number of packets in URB */
+	bool in_xrun;
 
 	/* data and sync endpoints for this stream */
 	unsigned int ep_num;		/* the endpoint number */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 1e0af1179ca8..41266c169404 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -400,13 +400,17 @@ static int prepare_inbound_urb(struct snd_usb_endpoint *ep,
 }
 
 /* notify an error as XRUN to the assigned PCM data substream */
-static void notify_xrun(struct snd_usb_endpoint *ep)
+static void notify_xrun(struct snd_usb_endpoint *ep, bool in_stream_lock)
 {
 	struct snd_usb_substream *data_subs;
 
 	data_subs = READ_ONCE(ep->data_subs);
-	if (data_subs && data_subs->pcm_substream)
-		snd_pcm_stop_xrun(data_subs->pcm_substream);
+	if (data_subs && data_subs->pcm_substream && !data_subs->in_xrun) {
+		if (in_stream_lock)
+			data_subs->in_xrun = true;
+		else
+			snd_pcm_stop_xrun(data_subs->pcm_substream);
+	}
 }
 
 static struct snd_usb_packet_info *
@@ -498,7 +502,7 @@ void snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 			if (err == -EAGAIN)
 				push_back_to_ready_list(ep, ctx);
 			else
-				notify_xrun(ep);
+				notify_xrun(ep, in_stream_lock);
 			return;
 		}
 
@@ -507,7 +511,7 @@ void snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 			usb_audio_err(ep->chip,
 				      "Unable to submit urb #%d: %d at %s\n",
 				      ctx->index, err, __func__);
-			notify_xrun(ep);
+			notify_xrun(ep, in_stream_lock);
 			return;
 		}
 
@@ -574,7 +578,7 @@ static void snd_complete_urb(struct urb *urb)
 		return;
 
 	usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
-	notify_xrun(ep);
+	notify_xrun(ep, false);
 
 exit_clear:
 	clear_bit(ctx->index, &ep->active_mask);
@@ -1762,7 +1766,7 @@ static void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 			usb_audio_err(ep->chip,
 				      "next package FIFO overflow EP 0x%x\n",
 				      ep->ep_num);
-			notify_xrun(ep);
+			notify_xrun(ep, false);
 			return;
 		}
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d959da7a1afb..8889c81297db 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -75,7 +75,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 	struct snd_usb_substream *subs = runtime->private_data;
 	unsigned int hwptr_done;
 
-	if (atomic_read(&subs->stream->chip->shutdown))
+	if (atomic_read(&subs->stream->chip->shutdown) || subs->in_xrun)
 		return SNDRV_PCM_POS_XRUN;
 	spin_lock(&subs->lock);
 	hwptr_done = subs->hwptr_done;
@@ -671,6 +671,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->transfer_done = 0;
 	subs->last_frame_number = 0;
 	subs->period_elapsed_pending = 0;
+	subs->in_xrun = false;
 	runtime->delay = 0;
 
 	subs->lowlatency_playback = lowlatency_playback_available(runtime, subs);
```


Takashi Sakamoto
