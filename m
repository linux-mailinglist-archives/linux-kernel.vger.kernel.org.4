Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3645EC192
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiI0Lgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiI0Lgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:36:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7512D1438E6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:36:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 30so12790086edw.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bfnlfMH2qv7WqV/DohbyJR0+KCA0Bxzz3Ju/20TTuck=;
        b=KM7+7YtJEU2Jt+VczH+FOJJOGb2IQecJ5Qp1owYwAeXYYw7n4YJnvJGlvsAu0sIYva
         d1jLfvg8N7/Bur0LJzRfEOo/Qyqv1Syt77BJzLLwLKVVrrVXrvXN4RRQNehUnTHqwYPh
         5H2lHSKo79omxG4lLqBfM0Bsyzjx2Hr/gchEWLz18n0SYiFmD7u/45x+usEs01hzNU36
         oPzPjr7SrqfuMmnEv1fnPxtmGjseJw2CQE455Po685QQVFgQ27BpmDPlwScRqXyNePpO
         rSiwOKLPiVeJDcA6ztX1QOrpSf57DGLMLyZOa9X6GDUFXgkWeZCbAJsHDZc/kL/f9Thq
         nKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bfnlfMH2qv7WqV/DohbyJR0+KCA0Bxzz3Ju/20TTuck=;
        b=S0YoLQPRGim6+/D+7dbm8XFE/ASaVA3Y30ebP48nnJjgud6HuF1izAa9TtiZcbPv5P
         wBxovlN4+7mO37p4LuK8EcdmG+w8xAk6JM7529kCjgj6vOO8OKjrFKnV50uaXZhNCG7F
         miJQTv/Bu4oX+TjG16rItz0ddNH6ypWJEAyFKBKhghS34Nws6RLjZ7JAyhim0vsK32gl
         1xlqSRxjm/JBN5Ssf9cvjOuFnP6U9AF62vISdsfUi1DA8QngSFNxcd97uytECoiizHgu
         esoJZVTRndj0pAJBOSZPnDxFZVI1YSPw+cw3GMtElCpxzUzp5n25Gqp7uFTzIro/Owtg
         ug3w==
X-Gm-Message-State: ACrzQf0nnkV1+ha+8lh1wKXXlZD5FZyLTZxbHt7PirC/p9+6VKmnt2xu
        Kg4ngkQ0RFHD4vKZHOebX8o=
X-Google-Smtp-Source: AMsMyM67I24tsHpRlol/3ysQkUh+uaBFlDqnjfAw2LpK6jbhg/uMMY3S0UKgNq5+9B6bZ4OfH4iWzw==
X-Received: by 2002:a05:6402:51c6:b0:451:6379:81cb with SMTP id r6-20020a05640251c600b00451637981cbmr27022708edd.372.1664278603621;
        Tue, 27 Sep 2022 04:36:43 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090616d700b0077b523d309asm648689ejd.185.2022.09.27.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:36:43 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:36:37 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        philipp.g.hortmann@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] staging: vt6655: change vnt_receive_frame return
 type to void
Message-ID: <20220927113637.GA10468@nam-dell>
References: <cover.1663273218.git.namcaov@gmail.com>
 <f727ea04703858920f6da694676ec323469e7b97.1663273218.git.namcaov@gmail.com>
 <Yyg6J/u23jcB2v+n@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyg6J/u23jcB2v+n@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 12:45:11PM +0300, Dan Carpenter wrote:
> On Thu, Sep 15, 2022 at 10:29:33PM +0200, Nam Cao wrote:
> > -bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
> > +void vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
> >  {
> >  	struct vnt_rd_info *rd_info = curr_rd->rd_info;
> >  	struct sk_buff *skb;
> > @@ -133,13 +133,13 @@ bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
> >  		/* Frame Size error drop this packet.*/
> >  		dev_dbg(&priv->pcid->dev, "Wrong frame size %d\n", frame_size);
> >  		dev_kfree_skb_irq(skb);
> > -		return true;
> > +		return;
> >  	}
> >  
> >  	if (vnt_rx_data(priv, skb, frame_size))
> > -		return true;
> > +		return;
> >  
> >  	dev_kfree_skb_irq(skb);
> >  
> > -	return true;
> > +	return;
> 
> Just delete this last return (it's pointless now).

Will be changed, thanks.

Best regards,
Nam
