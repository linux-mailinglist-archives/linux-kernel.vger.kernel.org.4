Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE273028F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbjFNO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245239AbjFNO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:58:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBA1FC2;
        Wed, 14 Jun 2023 07:58:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so6443375e9.1;
        Wed, 14 Jun 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686754723; x=1689346723;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cwHOEAiF9KfcpBV2FsuQGv04SjS1N5o4UGAs/GJkRIM=;
        b=HrgN3iTZqEJnZ+cWUam2y0hNTwU7zJQIh+PO2OOD1V0dKK6Day4ODu61szESSCbcVg
         8nECpsSl57fgDUiNVhyWExWfwOKMrDojt4Mw2EyAgDm4RLWeRScrIYMlERBFgZySiuMy
         VDg6BE6FvUSGBzdoOT0k7Wqa+gHrrXVM8hMTARr4fL7mY9IDKASQrP+ub1K5Z2OBGKtp
         4k4F3SzICfcZg1djHXBtey23xFNDUyAmIaTa9P/ssQe7DlCGSz8nsJl1mUnGYyIyBJ+N
         /yFNP9kWASak6rO6lZ/d5e+a7Js7yLeG685kqdZnQpSz3zMP7SPknRbe426IrgA9UEPa
         cZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754723; x=1689346723;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwHOEAiF9KfcpBV2FsuQGv04SjS1N5o4UGAs/GJkRIM=;
        b=lBeh4DM6ydGyxlaol739nMQtQFEGXyoP9toWo3g6Kuy2LjDSK4H69RHhbAfA4NRfdD
         NVCp3S96qgb9zKrFqHmrbqeo6noq95qs14S+OburfM4gMQ+rGu/pBOoHOOWDnN5aFKQe
         W0E//gFJSJ7k6JrJydS5kB/vUMlXqSR6BtCQyZaJKT7O3Lir7G1gvLhA87P7Edgjagc8
         fsfO7tYSbDQdK6diY+px26K6Mjk12IXr11UrbUA+gxMSu37EISeoYP8fsxoXiomJZ1XI
         kIB4/pCP/W8K+ppzLIKh1rrjdIhvmiap55I3bWbUWVZq129iY6yZ8rN4GtvpD6Iy5Ubw
         ywxQ==
X-Gm-Message-State: AC+VfDxzVDMV62aTwsy1LlIxiTXk9OxPlUcO3X9Owu7N6yHz9V+fcwSO
        5tqN7iIq2grDiWhJ/vbGenE=
X-Google-Smtp-Source: ACHHUZ42J+w43AeCv+jIRznzv9mpK6x3YnnHigR05cUDdfxwPzyO8LQJ2mQRRGGDh7MzUrt4gXUKKQ==
X-Received: by 2002:a1c:6a18:0:b0:3f6:a966:ee8d with SMTP id f24-20020a1c6a18000000b003f6a966ee8dmr9847496wmc.26.1686754722830;
        Wed, 14 Jun 2023 07:58:42 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003f733c1129fsm17703302wmc.33.2023.06.14.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:58:42 -0700 (PDT)
Message-ID: <6489d5a2.1c0a0220.c53b2.acb0@mx.google.com>
X-Google-Original-Message-ID: <ZIl3zACHBZmrk/8o@Ansuel-xps.>
Date:   Wed, 14 Jun 2023 10:18:20 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>, stable@vger.kernel.org
Subject: Re: [net PATCH] net: ethernet: stmicro: stmmac: fix possible memory
 leak in __stmmac_open
References: <20230614073241.6382-1-ansuelsmth@gmail.com>
 <ZInUzhOZ/3TGSQl9@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZInUzhOZ/3TGSQl9@corigine.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:55:10PM +0200, Simon Horman wrote:
> On Wed, Jun 14, 2023 at 09:32:41AM +0200, Christian Marangi wrote:
> > Fix a possible memory leak in __stmmac_open when stmmac_init_phy fails.
> > It's also needed to free everything allocated by stmmac_setup_dma_desc
> > and not just the dma_conf struct.
> > 
> > Correctly call free_dma_desc_resources on the new dma_conf passed to
> > __stmmac_open on error.
> > 
> > Reported-by: Jose Abreu <Jose.Abreu@synopsys.com>
> > Fixes: ba39b344e924 ("net: ethernet: stmicro: stmmac: generate stmmac dma conf before open")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index fa07b0d50b46..0966ab86fde2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3877,10 +3877,10 @@ static int __stmmac_open(struct net_device *dev,
> >  
> >  	stmmac_hw_teardown(dev);
> >  init_error:
> > -	free_dma_desc_resources(priv, &priv->dma_conf);
> >  	phylink_disconnect_phy(priv->phylink);
> >  init_phy_error:
> >  	pm_runtime_put(priv->device);
> > +	free_dma_desc_resources(priv, dma_conf);
> 
> Hi Christian,
> 
> Are these resources allocated by the caller?
> If so, perhaps it would be clearer if a symmetric approach
> was taken and the caller handled freeing them on error.
>

Yes, they are. Handling in the caller would require some additional
delta to this and some duplicated code but if preferred I can implement
it. I can provide a v2 shortly if it's ok and you prefer this
implementation.

> >  	return ret;
> >  }
> >  
> > -- 
> > 2.40.1
> > 
> > 

-- 
	Ansuel
