Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C55EC1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiI0LjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiI0LjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:39:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C214DAFC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:39:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so12794085edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uRa4L6FmBGoQ/fuxMcQ0fTqu+OtJ5tEYafCVS3oKorQ=;
        b=a4xKEE+x4j+cTFBo21aXzrZsi8+dEKUl70dA0eKPOMKyICUQDGsN4uN5i9zBWIQffP
         sMvH3Dql9CvcEen+wLDCoo/RDc7dWyoz+hYVrKO5+SRRI0CYt+7E9IW4PvAa8Wb2VzBa
         2wSEpxzHa0zDZAInxCVBfzpPo7WnPsQoykDi/WjDeeU7qKZM/rZr7aG6OR8r98X+cjfJ
         nE8+tp6jYy7u8GqHIC5q/YI6RObkiMUqiL+dUQ9d9CG1e/cHIA7a58os8JgoLOdfkiQZ
         2ZZT2+7MpOII5FuOP1V9Y796hCCWZ/l/ieyePlZrncMIH3EEunAJTuc2t6agC7LZRes2
         pCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uRa4L6FmBGoQ/fuxMcQ0fTqu+OtJ5tEYafCVS3oKorQ=;
        b=MOueFxe9o6dTjv4bZP0p42UzPTXEyVuXrDomL9t0FMwZ9CSffy1BTXZNJRLJZ4ThFG
         vJ9N9/2K8tEFxSBsmPmFMuCtFw0ypdRtcA1MbP+E5IWirwe5AczhpqzndjHSFh/Wp4nJ
         fOeMAcS7PWA7usqh8lTEIjOqCyPk1QIvbeGb1LI53sOeFfNYYSDTUdNbtUl7S6QS2AOQ
         hHryUYmXYSV3jJFqeZTl7v66WnA666ksumncd6QC1UZEYCL6VsM2trF8nZRJP53uYRwS
         8frc6sFWs9w22P3SY5KudtnRtro0dcNF25KQnL34qp73Te0lp2Ya1gipee2WfDK5elPg
         s27A==
X-Gm-Message-State: ACrzQf2oM9yYwjjgeAiquRFMuj4ZLOyLeJT7M789ceZGO0+4ZMKHfdPT
        JoAiWI/ChH89QzwE+Qg4Zpk=
X-Google-Smtp-Source: AMsMyM6Ailo1WcZmnPwYNhoFtQjNWQc7xJ+gf018zHGLr/5yc/3AOrxlGTXzMjGoqwHVE019lUr2gw==
X-Received: by 2002:a05:6402:1d54:b0:44e:a683:d041 with SMTP id dz20-20020a0564021d5400b0044ea683d041mr27301171edb.411.1664278755079;
        Tue, 27 Sep 2022 04:39:15 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906769700b0073ddff7e432sm676787ejm.14.2022.09.27.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:39:14 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:39:13 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        philipp.g.hortmann@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] staging: vt6655: split device_alloc_rx_buf
Message-ID: <20220927113913.GB10468@nam-dell>
References: <cover.1663273218.git.namcaov@gmail.com>
 <311eaa7dabe12d0baeb0af6f85c2b43b20b230a3.1663273218.git.namcaov@gmail.com>
 <Yyg4BTymed1fEzQx@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyg4BTymed1fEzQx@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 12:36:05PM +0300, Dan Carpenter wrote:
> On Thu, Sep 15, 2022 at 10:29:34PM +0200, Nam Cao wrote:
> > The function device_alloc_rx_buf does 2 things: allocating rx buffer
> > and initializing the rx descriptor's values. Split this function into
> > two, with each does one job.
> > 
> > This split is preparation for implementing correct out-of-memory error
> > handling.
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  drivers/staging/vt6655/device_main.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> > index 79325a693857..27fe28156257 100644
> > --- a/drivers/staging/vt6655/device_main.c
> > +++ b/drivers/staging/vt6655/device_main.c
> > @@ -133,6 +133,7 @@ static int device_init_td1_ring(struct vnt_private *priv);
> >  static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
> >  static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
> >  static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
> > +static void device_init_rx_desc(struct vnt_private *priv, struct vnt_rx_desc *rd);
> >  static void device_free_rx_buf(struct vnt_private *priv,
> >  			       struct vnt_rx_desc *rd);
> >  static void device_init_registers(struct vnt_private *priv);
> > @@ -615,6 +616,8 @@ static int device_init_rd0_ring(struct vnt_private *priv)
> >  			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
> >  			ret = -ENOMEM;
> >  			goto err_free_rd;
> > +		} else {
> > +			device_init_rx_desc(priv, desc);
> >  		}
> 
> None of these else statements make sense.  It should be:
> 
> 		ret = -ENOMEM;
> 		goto err_free_rd;
> 	}
> 
> 	device_init_rx_desc(priv, desc);
> 	desc->next = &priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0];

That does look better, will be changed.

> I haven't reviewed the patch totally.  I don't understand why it's doing
> this here instead of at the end.  But then I don't understand why it
> needs to be in a separate function at all.
> 
> This patch does not make sense.  The commit description says that this
> is a "preparation" patch.  Maybe fold it in with patch 5?  The rule is
> "one thing per patch" not "half a thing per patch".

I thought splitting it like this would make it easier to review. But if
these preparation patches are not welcomed, I will squash them and
resend.

Thank you for spending time reviewing the patches.

Best regards,
Nam
