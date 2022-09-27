Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1A5EC1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiI0Lyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiI0Lyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:54:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A322188
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:54:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd10so20190545ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iQSg98bKZou7iOEHRXVJ6yfM/g7cHdR+S7GJ5NNyeVg=;
        b=PTGOkhw5Q0RHA0RubfHuXl5h9YAKDl/zJUiqyThDrXttrQspIpfm36H/re1sO954Sf
         phAOWr1f/jAgK/QnUU4p6kNzDQ8qLfJxi3lNapt7MV3Fi/tWax//H8398psrjZG/3QyP
         YegjDXJCGnpiv8Fl+wt2+W31bSFSrvj88D6h7mSBQlGRQwCpZcR/y75re/G7/zH9zDP7
         OXjVueU01gAlPiYw55nok2wxfYShUJluT3MytShRLg5VjGxATgmjMLGccgfkkBEm7Hbu
         cDy9LggbOV2837I7uwfgNfVfqVfmABO91ZxTZZLAYu/2vwUV/YCtGSzgraLj4TUsMQ6/
         GKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iQSg98bKZou7iOEHRXVJ6yfM/g7cHdR+S7GJ5NNyeVg=;
        b=1hDMCWtQ9XL6dTMo7wah8frhHIXXFdpfrbo9SSlKJhTRIZo829PjrgeTC5gzNuqVXP
         6zdNAhY04asm25WbAquz/mPwV2pComT7DqzJZxRu+JJHMiCU0W+xhS3hnYhu1ofSZ68v
         RJCQMIbcytw5bQR09bRcOAYF2sEwuIAjI8cvJ9RUTzUm1T3H4K68i4lkPhjbLwjDMUtf
         7RUH3fpEQ8di+1QR1VSSD14bNSqgzR3XLcNccT88EYp81swDdHeNYRzAxWihlQfvcCYv
         rCobyWZvd9oh9LLJPMk9CpXFP0DFASzW40npw36W1YfRb6HRprPR6tK77djksGxq/gVi
         oblg==
X-Gm-Message-State: ACrzQf0zOtc+jTDgVo4cuXKlQl060O9iIjYUcWJN0fPEzx++xomPqnDR
        Vv/c8dNPlZffxk61ZYFUUQqgiL601YI=
X-Google-Smtp-Source: AMsMyM4oGuPJDzq86wEPW1opYmEFKE9c9MUAYBJ8yIm63lgdzL+P/uxXvFd9OY0nUuLsnTm6oB3wfw==
X-Received: by 2002:a17:907:a48:b0:77c:51b0:5aeb with SMTP id be8-20020a1709070a4800b0077c51b05aebmr22757261ejc.61.1664279669534;
        Tue, 27 Sep 2022 04:54:29 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b00741383c1c5bsm678853ejt.196.2022.09.27.04.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:54:29 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:54:27 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        philipp.g.hortmann@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] staging: vt6655: implement allocation failure
 handling
Message-ID: <20220927115427.GC10468@nam-dell>
References: <cover.1663273218.git.namcaov@gmail.com>
 <dd63998765f1ea1bf507a94c2d49317b36b5f32c.1663273218.git.namcaov@gmail.com>
 <YyhAhiUlclk7HxE3@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyhAhiUlclk7HxE3@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:12:22PM +0300, Dan Carpenter wrote:
> On Thu, Sep 15, 2022 at 10:29:36PM +0200, Nam Cao wrote:
> > The function device_rx_srv does not handle allocation failure very well.
> > Currently, it performs these steps:
> >         - Unmap DMA buffer and hand over the buffer to mac80211
> 
> Does the unmapping happens in vnt_receive_frame();?

Yes.

> 
> >         - Allocate and dma-map new buffer
> 
> Is the new buffer for the next frame?  So in your patch if we don't
> have space for the next frame then we do not process the current frame?
> (Rhetorical questions are a bad idea on development lists.  I genuinely
> don't know the answers to these questions).

Almost correct: if we don't have space for next frame, we _drop_ the
current frame. Note that this is also how it is implemented in similar
drivers, such as:
  - adm8211_interrupt_rci() in drivers/net/wireless/admtek/adm8211.c
  - rtl8180_handle_rx() in drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c

> 
> >         - If allocation fails, abort
> > 
> > The problem is that, it aborts while still marking the buffer as
> > OWNED_BY_HOST. So when this function is called again in the future, it
> > incorrectly perceives the same buffer as valid and dma-unmap and hand
> > over this buffer to mac80211 again.
> 
> Where is it supposed to get marked as OWNED_BY_HOST?

By the device/hardware.

The basic idea how this driver works is that: the cpu allocates buffers
and marks them as OWNED_BY_NIC, basically telling the device that "here
are some buffers that you can use". When there is new frame, the device
looks for buffer marked with OWNED_BY_NIC and write data in there; then
it marks the buffer as OWNED_BY_HOST, basically saying "there is some
valid data in this buffer, you should read it".

> 
> > 
> > Re-implement this function to do things in a different order:
> >         - Allocate and dma-map new buffer
> >         - If allocation fails, abort and give up the ownership of the
> >           buffer (so that the device can re-use this buffer)
> >         - If allocation does not fail: unmap dma buffer and hand over
> >           the buffer to mac80211
> > 
> > Thus, when the driver cannot allocate new buffer, it simply discards the
> > received data and re-use the current buffer.
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  drivers/staging/vt6655/device_main.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> > index ca6c4266f010..8ae4ecca2ee3 100644
> > --- a/drivers/staging/vt6655/device_main.c
> > +++ b/drivers/staging/vt6655/device_main.c
> > @@ -826,6 +826,7 @@ static void device_free_td1_ring(struct vnt_private *priv)
> >  static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
> >  {
> >  	struct vnt_rx_desc *rd;
> > +	struct vnt_rd_info new_info;
> >  	int works = 0;
> >  
> >  	for (rd = priv->pCurrRD[idx];
> > @@ -837,16 +838,18 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
> >  		if (!rd->rd_info->skb)
> >  			break;
> >  
> > -		vnt_receive_frame(priv, rd);
> > -
> > -		if (!device_alloc_rx_buf(priv, rd->rd_info)) {
> > +		if (!device_alloc_rx_buf(priv, &new_info)) {
> >  			dev_err(&priv->pcid->dev,
> >  				"can not allocate rx buf\n");
> > +			rd->rd0.owner = OWNED_BY_NIC;
> >  			break;
> > -		} else {
> > -			device_init_rx_desc(priv, rd);
> >  		}
> >  
> > +		vnt_receive_frame(priv, rd);
> > +
> > +		memcpy(rd->rd_info, &new_info, sizeof(new_info));
> > +		device_init_rx_desc(priv, rd);
> > +
> >  		rd->rd0.owner = OWNED_BY_NIC;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The device_init_rx_desc() function sets it to OWNED_BY_NIC so this line
> can be deleted.

Noted. Thanks.

Best regards,
Nam
