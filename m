Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3A60293D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJRKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJRKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:21:25 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11612126B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OTNfub20XKiblrmAKXf7vUMGbiYJAhN4mTRLxCxGmnw=;
  b=GoANrRpyMMbx/C0xU7QgqK/I2KJeUpmv4fdV+RD1dk9DS3Ns/BZuDuB5
   yYCDfckMv1HhBB9zTROEREUd3HQXsO3hA8FIePls2kUCvhD6KwSIjrKjJ
   DKEU+uaMqiAK1moInxN3Q8om252HWMPpV+cEiYh3/xh3ERpVnah3koE8E
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="65704101"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 12:21:19 +0200
Date:   Tue, 18 Oct 2022 12:21:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] [PATCH] staging: rts5208: merge unnecessary split line
In-Reply-To: <CAHJEyKWpeyBpGy74cLe55v1xfCkn4WBB6tkn+N6eXcn3G3LXaQ@mail.gmail.com>
Message-ID: <f26a5887-bf7d-1988-c11c-10844872add3@inria.fr>
References: <Y0550VcHI8NzFzzf@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net> <3f65f367-e07f-5b71-ea7c-4f13c23eca8d@inria.fr> <CAHJEyKWpeyBpGy74cLe55v1xfCkn4WBB6tkn+N6eXcn3G3LXaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1467809331-1666088479=:3791"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1467809331-1666088479=:3791
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 18 Oct 2022, Tanju Brunostar wrote:

> Got it. 

Don't top post.  Reply to comments underneath the comment you are replying
to.

julia

>
> On Tue, Oct 18, 2022, 11:11 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>       On Tue, 18 Oct 2022, Tanjuate Brunostar wrote:
>
>       > Fix checkpatch warning by merging unnecessary split line in order to
>       > avoid ending a line of code with a "(". The resulting code does
>       > not affect readability and is well within the code-style guidelines
>
>       Thanks for the patch.
>
>       You don't need the extra [PATCH] in the subject line.
>
>       Actually, you don't need the parentheses at all, but that might be a
>       matter of personal taste.
>
>       julia
>
>       >
>       > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
>       > ---
>       >  drivers/staging/rts5208/sd.c | 3 +--
>       >  1 file changed, 1 insertion(+), 2 deletions(-)
>       >
>       > diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
>       > index d1fafd530c80..4643127a87ca 100644
>       > --- a/drivers/staging/rts5208/sd.c
>       > +++ b/drivers/staging/rts5208/sd.c
>       > @@ -4501,8 +4501,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>       >                       sd_card->sd_lock_notify = 1;
>       >                       if (sd_lock_state &&
>       >                           (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
>       > -                             sd_card->sd_lock_status |= (
>       > -                                     SD_UNLOCK_POW_ON | SD_SDR_RST);
>       > +                             sd_card->sd_lock_status |= (SD_UNLOCK_POW_ON | SD_SDR_RST);
>       >                               if (CHK_SD(sd_card)) {
>       >                                       retval = reset_sd(chip);
>       >                                       if (retval != STATUS_SUCCESS) {
>       > --
>       > 2.34.1
>       >
>       >
>       >
>
>
>
--8323329-1467809331-1666088479=:3791--
