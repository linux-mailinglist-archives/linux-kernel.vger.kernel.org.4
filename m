Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A393D6C0C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCTIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCTIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:53:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DBDD305
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:53:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so43626461ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679302401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSur2724Mrb+t2O165F/BN6jWN51XTSV+JAwdxRyZN0=;
        b=HtN7OaOaVn8D25XKoV7oyiJWUZl790qSN5SbGGws1TIykkdNweRUTVRhIB1VmtUHbG
         X3rrND9fEoKsd/V7KKgqV6RcENuMAsQr73/zK/LBj8GIm4HoXflUn23Ai61cybHckB+w
         0qr5VHUA9vmZt8PzmV6iprXrXFKSAcLdec1MYeMZ48JmItqa6MgoXhf3zULptmQ1Cw54
         7l7Q6KISU3yCkbwMJ9yt1yDP2uAx0zK+1gCnuH8dN1gdXsB7Votre8aOzJb9O51w4iPg
         03GR5VaLw1HMmHyS+EtWTfGV2aCDLonOuX57risk7aoDMYJVomfhlwgMdaMt6AV8SEM+
         F0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679302401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSur2724Mrb+t2O165F/BN6jWN51XTSV+JAwdxRyZN0=;
        b=xbgQygUqI1p6b1Njj3OF3fPRvVBxI7Fk+HkaCFzWlDr8ZZlkrDz2x9lqee2WuLgU15
         rk/0GH1OJocLbWN7smvp0J1wBkbjhXJQU15AmUmrgFc/ygV6rHRBey7cAAC/h4NsxTS2
         Ed4Mf1w3V0YHZDLw3d8natvZ67iLeD3fFWHlwSlsrLLvVw6R2McmPadapE8wOA9M5j9Y
         bKystZ2maq8TW9546+I6graVSB1IQLEqVmIqr3U+wJ0YlKxwpHn/QKJXVGKdjvxtdk1O
         6uNcm++V0fHR0AwFsKtkYmC49YZLvMXAF82cgWrjAVfN0MGfw741LW+KAlifxMqBq/z0
         04Qg==
X-Gm-Message-State: AO0yUKVSAlbW2ONqqR4e4Tv4w2qrjLBmssM3X5JYMyYGN48UAqx4zcwU
        Q9niBOPHrOGCw07CIDOfPI9ZVAFCq4wp7h9PMrI=
X-Google-Smtp-Source: AK7set9pXllFdkoHzA8sdpIZJzcBcpJTv8PFDi87umJRA+YksZIIVd0ezRSV46JAJnTPD1fWINCqjQ==
X-Received: by 2002:aa7:c049:0:b0:4fd:21a6:a649 with SMTP id k9-20020aa7c049000000b004fd21a6a649mr11200682edo.40.1679302400922;
        Mon, 20 Mar 2023 01:53:20 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id j30-20020a508a9e000000b004af5968cb3bsm4474230edj.17.2023.03.20.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:53:20 -0700 (PDT)
Date:   Mon, 20 Mar 2023 13:53:18 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
Message-ID: <ZBge/v/K/BOVkl2V@khadija-virtual-machine>
References: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
 <640e75cfd8fc_229a89294a3@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <640e75cfd8fc_229a89294a3@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 06:01:03PM -0700, Ira Weiny wrote:
> Khadija Kamran wrote:
> > In file drivers/staging/greybus/arche-platform.c,
> > - Length of line 181 exceeds 100 columns, fix by removing tabs from the
> >   line.
> > - If condition and spin_unlock_...() call is split into two lines, join
> > them to form a single line.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> 
> Fundamentally the problem with arche_platform_wd_irq() is that the
> indentation is too great.
> 
> "... if you need more than 3 levels of indentation, you’re screwed anyway,
> and should fix your program."
> 
> 	-- https://www.kernel.org/doc/html/v4.10/process/coding-style.html#indentation
> 
> I think a better solution would be to refactor the entire function.  This
> would make the logic of the function more clear as well IMHO.
> 
> Here is another tip to help:
> 
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#centralized-exiting-of-functions
> 
> Do you think you could try that?

Hey Ira!

Sorry about the late reply. Thank you for your feedback. I have looked
into the above link. Are you referring to the use of goto statements in
arche_platform_wd_irq() call?

Thank you!

Regards,
Khadija


> Ira
> 
> > ---
> > Changes in v2:
> >  - Change the subject and log message
> >  - Merge if condition and spin_unlock...() from two lines to one 
> >  drivers/staging/greybus/arche-platform.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > index fcbd5f71eff2..00ed5dfd7915 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> >  				 * Check we are not in middle of irq thread
> >  				 * already
> >  				 */
> > -				if (arche_pdata->wake_detect_state !=
> > -						WD_STATE_COLDBOOT_START) {
> > +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> >  					arche_platform_set_wake_detect_state(arche_pdata,
> > -									     WD_STATE_COLDBOOT_TRIG);
> > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > -							       flags);
> > +						WD_STATE_COLDBOOT_TRIG);
> > +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> >  					return IRQ_WAKE_THREAD;
> >  				}
> >  			}
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
