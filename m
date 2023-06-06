Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA472384D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjFFHAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjFFHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:00:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F627E47
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:00:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso6796699276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686034812; x=1688626812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6krfoSoQjTpFvkG7ZcY0HfON8j6W/nkh7AT07JFmkg=;
        b=nGSgqPLkoQciFs4BZ5O4mr1x9wRaW1BstrOY+15MJEVWvGynfQIbrlSG5OS26+mBGX
         g0mIH50cG/Bh6UcjokMdumG1X+2nx9y45ndW9FQ8j02O2hRTFJVGt8W0MVeT84EHiYep
         SWXSChBKKXY2ab//NmNiJRBaHUcpnSeAtS/r9y0i/hYOrQdXJ8zAktnAngL6jasdPKcz
         Dfp4Ar1+sn3nB2SFtvZpsShWNLdH/RFIzuycUii4wEk4EVlRYgqUva4UKfvw29czsinZ
         g6+kTtCmZRzGhzd3mGYENBE5R/84oBD6UWvMHiGqbGigfYjDQq5x0c4GtP3uliCfoaVx
         9L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034812; x=1688626812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6krfoSoQjTpFvkG7ZcY0HfON8j6W/nkh7AT07JFmkg=;
        b=UJVjgZ1fU9FDXrs0HdMbelVT12qRTxnx/DxpTQL9xt5JRzNSP0a9EkGQZRjjWYeycI
         Xtom2a1ynHQWF4ccVopaLdfyC06wAk3/xPRVUlspY1/ACa5yxITVduDCPQTTxp16uXms
         usc/jsCkdwKvnS3EKOpZUk/barKNj/cM+cUxlexVfsotQOzoQqDkA4HaXmuLzJthGBlW
         vZ4+6Fa4mwG+vc9zoZn0rys5PMqyxJNwG8x4MGlZ8/pcLTaXggrQFoO+1ycJUbfNk/Pv
         wAGDkKYuYMPT8ZGZxZGiBTf6qM5X9VU1/J0dK+52XzYrT5nBkpfsR2X/3j05n4CDmqFw
         5cDA==
X-Gm-Message-State: AC+VfDw+OdraZ9TYEvFoFho2g7tiG6m1audf3/0Nnf0tdMO4kpb5xP58
        eg3YuHFAnBYw5mWCPS6NhPE=
X-Google-Smtp-Source: ACHHUZ4pCsppfoVAVE+SgARQERFw3rPS8vxaDGGVfMwwReNlBOMumKEhWEc4h1wEk4/LHuUdnl2jzQ==
X-Received: by 2002:a25:3243:0:b0:b92:57df:c80e with SMTP id y64-20020a253243000000b00b9257dfc80emr1139022yby.2.1686034811701;
        Tue, 06 Jun 2023 00:00:11 -0700 (PDT)
Received: from pc ([2405:201:2003:b135:89cf:b185:51e1:ed4b])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001aaffe15f39sm7719909plk.30.2023.06.06.00.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:00:11 -0700 (PDT)
Date:   Tue, 6 Jun 2023 12:30:07 +0530
From:   Raag Jadav <raagjadav@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <20230606070007.GA4691@pc>
References: <20230605104830.68552-1-raagjadav@gmail.com>
 <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
 <20230605143103.GA3068@pc>
 <545d3463-ce56-41d5-9d95-55764c448c09@sirena.org.uk>
 <20230605161614.GA6548@pc>
 <42423085-2c9c-47f6-9588-3e2260da7cfa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42423085-2c9c-47f6-9588-3e2260da7cfa@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 05:30:36PM +0100, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 09:46:14PM +0530, Raag Jadav wrote:
> > On Mon, Jun 05, 2023 at 03:44:37PM +0100, Mark Brown wrote:
> 
> > > It's also removing a cache so we need to talk to the hardware more often
> > > which doesn't seem like a win.  If there's a bootstapping problem then
> > > shouldn't we just read once at startup?  If there's no problem what's
> > > the advantage?
> 
> > Well, there could be cases of access which are done
> > outside of driver context or hardware failure,
> > which are not really ideal but I've faced such problems
> > a while back, so just decided to share it.
> 
> If we have those then we've got a bigger problem, for example we might
> switch to a lower power mode which can't support the load we're trying
> to get the consumer to run.

Yes, but in such cases it will atleast report whatever mode currently
set in the hardware and not the incorrect one stored locally in the memory,
and this way I think we have a better chance of finding out that
there indeed is a problem.

Cheers,
Raag
