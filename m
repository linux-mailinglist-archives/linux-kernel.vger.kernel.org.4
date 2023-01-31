Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E21682A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAaKTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAaKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:19:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847625254
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:19:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qw12so24227294ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPDdf1qrNAjlZtBbt78Pvd00imRPAVW7UAXdnhzcHqo=;
        b=T2Owrg+IFJ6wwxZqWzH/UBtrYUoq3muNx8xzfdIJjAt4aPzO2H2PZoFDP2rpPYr09c
         WpE+gbSBWxDOiR0BKaeQb06HaegAivsE2z6wkwNEfIwgNMT0MH/kNeC6ZgWmkqKzar6J
         LwAuJNHP2QIeZNozA2vo4IxymXvvju+CqPLSFzxSjj71GzGBMJ6JLzfeDWClbmUbuJ7t
         fTBrvi6TBjuRqsuY7/2Ekgix51i7XwvZ5vPFM7K9M2PAGgVLYazBR0vZCd4RBq0ZSHt6
         PE4GSP6bJNllzpUjodNg2aFYF19KHu/q71LVH0BYKWQTdfwvQhfEnKwZ0Wx5icwv42di
         pI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPDdf1qrNAjlZtBbt78Pvd00imRPAVW7UAXdnhzcHqo=;
        b=GUBD+xMvSn2rmNaoR8j7Im4Gxzbvma7te/Ko4D7Sg1xCC1FZl2/M5bnS6ZgrYCO2/l
         z9E4+K/ZynM1zZ4x/U/HO7Fhtfw/tpwBNkc7DnKR9Ntr7X1yhukewRpOfFhNS0WAZsCF
         sTvv1V0NMhsULbZF7O+9wnQ25yopDsIsXrTvNqDUpqEQrQIelHBgsemp2CtlMtJiVNOw
         mOFd72p82RF3dZjgkMz6KvceVpZg+0oAVC9kMN9Q1FyKiEADxrkBzttl6oYDr4oQDW5y
         ON4aKxnfDPvcS6wSQTzaqpGfZqPnsOxoev9XHSKw3C016yiynonewJqF5GE0pkedNKMX
         3h0g==
X-Gm-Message-State: AO0yUKW6hR+39ghdKLaTaTuu2QnfnbeKb/+WsjdAjWrVhRTZfJgTxye0
        XQKEF3RSb8gZxvgwOoLHTqQ4Xlzo00k=
X-Google-Smtp-Source: AK7set8gk5eKHR0vWEV+d9z7aduMfrGqEJ8cf50lpaBDLW2Bh4w8lCcihdCi0u5PZjqfMu27Tv5V8Q==
X-Received: by 2002:a17:906:7105:b0:887:3c7e:5df with SMTP id x5-20020a170906710500b008873c7e05dfmr9863063ejj.73.1675160378996;
        Tue, 31 Jan 2023 02:19:38 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id ci22-20020a170906c35600b0087bcda2b07bsm6868771ejb.202.2023.01.31.02.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:19:38 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:19:36 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ilj812USHrSXe+@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 06:22:23AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 31, 2023 at 03:11:38AM +0100, Guru Mehar Rachaputi wrote:
> > (struct pi433_tx_cfg)->bit_rate is modified from u16 to u32 to
> > support bit rates up to 300kbps per the spec
> 
> What spec?
> 
> And how can changing the size of a variable that crosses the user/kernel
> boundry like this change the bit rate max?
>
Honestly, I followed the TODO file suggestion.
> > 
> > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > ---
> >  drivers/staging/pi433/pi433_if.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> > index 25ee0b77a32c..1f8ffaf02d99 100644
> > --- a/drivers/staging/pi433/pi433_if.h
> > +++ b/drivers/staging/pi433/pi433_if.h
> > @@ -51,7 +51,7 @@ enum option_on_off {
> >  #define PI433_TX_CFG_IOCTL_NR	0
> >  struct pi433_tx_cfg {
> >  	__u32			frequency;
> > -	__u16			bit_rate;
> > +	__u32			bit_rate;
> >  	__u32			dev_frequency;
> >  	enum modulation		modulation;
> >  	enum mod_shaping	mod_shaping;
> 
> And didn't you just break existing userspace code?  If not, how?  If so,
> how did you test this?
>
My apologies, I did not study code. While testing, the probe function of
pi433 driver didn't appear in the lsmod operation. I suspected my
testing was wrong.

> thanks,
> 
> greg k-h
