Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7995BE7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiITN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiITN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:58:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F610B9;
        Tue, 20 Sep 2022 06:58:35 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1278a61bd57so4290368fac.7;
        Tue, 20 Sep 2022 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MMxpBTkSlUl1RA0jT5K/9AdRypOJK9Ht+4jVkjeqBbk=;
        b=Vi8G3iJOeOsqJlPNZPzd3jDDo08I1P1VPY868WrCaUf401yJ/EL6xDJnP2YaoIo+X1
         AsYEjUFJ0rYoTyHZt2pklclhO+/hGD5RoEpogffQ7wJRNndzzb2yNRu+S2jQNuTEZaF/
         7zsZI8hPGcApRR3YA4WaQrGldEEjhJ2Bsvuy+Iu/WB8awkdmkV6gD9C1CDiEGN8QC4Ui
         ygpxg5c/0ciO6Mcm/qA75+Ww8c9EniZ48Fenu4umBULUfGDUUG13yq66M3BQt5R9nPH4
         rNftqgu1G0Y8bk9HdIzIi16bKzgOndRh/H3RWpFfnJSrOmXIFuFcKZFg04Dpvb5LXl6F
         Vapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MMxpBTkSlUl1RA0jT5K/9AdRypOJK9Ht+4jVkjeqBbk=;
        b=qddsHHbO6Y90l31I9wjfB+k/x/wqRHNx/ckx0HsSLCxOPb+vZX6GtOYxQbnx5kj/E4
         SG/6QD7XCeuCsU2ra3kK3VCQRI52Jt76AruVyKHWfQw0z/xX2coYFHa6sgQMGiM+ptvx
         XdItwAgryUbI8W2PmMF/5bNQgEjufb7j+eOMgSDm9ofR5Cwarmmo8dB8No8QK2TDfaDq
         46SCPGxVZCR1GXi0BFnA42oNEH5q37MPU7RawhEiMZMbt7HiuEWeBWI5i84PhMlNOR2W
         8oqtxMUDZAiX+dyzpJOXyP6mVKmEcAzbg/5TM06bbfGuiWnYACNtUFt7Tkwb8GGQ5GJL
         ol1w==
X-Gm-Message-State: ACrzQf3UYzAWuITkevTkXeTv7xelp2zOIWPCc9YeY54qN46jaz0Hbqkk
        T/E4Nn6OwO6yL7JQgEiP96xbWHqSndFq9w==
X-Google-Smtp-Source: AMsMyM7yzg82yFPVwblMHXlYp/Kg/jUBQH6qxFg09k3rCcm9y3KY9ADGvQLh8vslYjfChgR0to7jag==
X-Received: by 2002:a05:6870:9618:b0:12d:70f7:bb6f with SMTP id d24-20020a056870961800b0012d70f7bb6fmr372799oaq.239.1663682314688;
        Tue, 20 Sep 2022 06:58:34 -0700 (PDT)
Received: from macondo ([2804:431:e7cc:3499:63b7:66da:c087:3355])
        by smtp.gmail.com with ESMTPSA id u4-20020a4aae84000000b004762a830156sm113713oon.32.2022.09.20.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 06:58:34 -0700 (PDT)
Date:   Tue, 20 Sep 2022 10:58:30 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Message-ID: <YynHBkbTw6bTgYNq@macondo>
References: <20220919023247.731106-1-rafaelmendsr@gmail.com>
 <Yym/QDURAtn1LX8i@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yym/QDURAtn1LX8i@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:25:20PM +0200, Paul Kocialkowski wrote:
> Hi Rafael,
> 
> On Sun 18 Sep 22, 23:32, Rafael Mendonca wrote:
> > The V4L2 fwnode data structure doesn't get freed on unbind, which leads to
> > a memleak.
> 
> Thanks for this patch, good catch!
> 
> I agree with Jacopo, you shouldn't add a newline before the call.

Thanks for the review, I'll send a v2. As the code for the ov5648 is
similar to the ov8865, and in the 8865 there is this blank line before
the v4l2_fwnode_endpoint_free() call, I thought it might be good to keep
the same style here, that's why this empty line ended up appearing here.

> Feel free to send a v2 with that fixed and include my:
> 
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Cheers,
> 
> Paul
> 
> > Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor")
> > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > ---
> >  drivers/media/i2c/ov5648.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
> > index dfcd33e9ee13..95850f06112b 100644
> > --- a/drivers/media/i2c/ov5648.c
> > +++ b/drivers/media/i2c/ov5648.c
> > @@ -2598,6 +2598,8 @@ static int ov5648_remove(struct i2c_client *client)
> >  	mutex_destroy(&sensor->mutex);
> >  	media_entity_cleanup(&subdev->entity);
> >  
> > +	v4l2_fwnode_endpoint_free(&sensor->endpoint);
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com


