Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78F6FF3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbjEKOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbjEKOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:18:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139811BFF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:18:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24e4e23f378so6023307a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683814708; x=1686406708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZJOUXZJ2eCAjaNz00XUp42dWxxFQ/eDmJ9k4vXyg78=;
        b=P2rPFmJGKzWvt3PXPRWlld6P6GFHQWdIFnoPJtcDQDuiWcYdxvhNhRH9p7m9tJRfYw
         VteVGhj8SCzEgP6yWM3s6EWoSDuJKu/IvtooQCgbD7aTRpaxkK9dzwkgMO2bbqswRip7
         A0PKGvu/4M715sa0y7XxVQoIqZLQGSq2yzwEoo4zGyPzneFNb8w6el8/yZus3AT4BFIM
         bnaH4DofuJnScbpvmbSu0rPcOr/f33HzkgZS4AIcjF3fryuODtiD8cJeWgoOY6qmmCBb
         ESy/Ojsh1iyN+xKhhaWGmjyoLpHrv8i1kByviYjRBccivHXC1FFQ9eV3XbPmvBMCPjOk
         KeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814708; x=1686406708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZJOUXZJ2eCAjaNz00XUp42dWxxFQ/eDmJ9k4vXyg78=;
        b=WkASZGO14mNZNQ5F9L3uwk3KjXeTBft6nH79HLui85vRZzFdWniZJb7393mLNWGsgw
         Z8vNSb9+qUyDDShietcha37zprUgmm5IxhD3mVGt48zxD3w4fXFswyff/PJkYNMgmUGr
         YMC3MfTjoS0b+Sd9UjOWBOcBseDQTfUX9fz0YXZx82RGN5Q8lduP/dVcHhlB7dE3vY7r
         1rwLDLYaSW+nlyCDVXdhqhbjaVd0M21uFmv2iDcMvOJ+I+03CXu2HvTdQ47JMN5bruZR
         rwnoKF1qDFhW+ouuYzbNHnCSs6Y6l3wvM+6qKXHIzi/AGmzAP/8Ql4yMJerauKGzMRWl
         52RA==
X-Gm-Message-State: AC+VfDz6N4OSbcKULIBZjQfQLjk8KkaA8SEobCeJluLrRWKfBa7wAHh8
        1XaMIbAXbvV64RwRxETxX0w=
X-Google-Smtp-Source: ACHHUZ6lPXcBfjNjgg/y4qZ2dzq6XtovI1TWHqyerTp7GzA+GFRkXRT4YVt0w1ceB5Lebr1Y8gJu1g==
X-Received: by 2002:a17:90a:b292:b0:24d:fb21:3d7c with SMTP id c18-20020a17090ab29200b0024dfb213d7cmr21350328pjr.30.1683814707993;
        Thu, 11 May 2023 07:18:27 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ad24300b00246be20e216sm15258205pjw.34.2023.05.11.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:18:27 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:23 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8192e: Rename tmpRegA and TempCCk
Message-ID: <ZFz5Lxc/gUTKkLNX@pop-os.localdomain>
References: <cover.1683730854.git.yogi.kernel@gmail.com>
 <c9c67f832db3a776c04f26e0afb083ae3ba99c07.1683730854.git.yogi.kernel@gmail.com>
 <290473de-5946-49d4-9309-6bebf7cc9873@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290473de-5946-49d4-9309-6bebf7cc9873@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 07:56:29PM +0300, Dan Carpenter wrote:
> On Wed, May 10, 2023 at 08:39:07PM +0530, Yogesh Hegde wrote:
> > @@ -680,17 +680,17 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
> >  		return;
> >  	}
> >  
> > -	tmpRegA = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
> > -	if (tmpRegA < 3 || tmpRegA > 13)
> > +	tmp_reg = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
> > +	if (tmp_reg < 3 || tmp_reg > 13)
> >  		return;
> > -	if (tmpRegA >= 12)
> > -		tmpRegA = 12;
> > +	if (tmp_reg >= 12)
> > +		tmp_reg = 12;
> 
> Not related to your patch (which is fine) but this if statement can be
> deleted.
> 
> >  	priv->thermal_meter[0] = ThermalMeterVal;
> >  	priv->thermal_meter[1] = ThermalMeterVal;
> >  
> > -	if (priv->thermal_meter[0] >= (u8)tmpRegA) {
> > +	if (priv->thermal_meter[0] >= (u8)tmp_reg) {
> 
> And casting tmp_reg to u8 is nonsense so that casting can be deleted too.
> 2 separate patches:
> patch 1: delete unecessary if statement
> patch 2: delete unecessary casting

Thank you for taking the time to review my patch and provide your
feedback. Your suggestions are duly noted, and I appreciate your 
guidance.

I will make them into separate patches and submit it. 

Thank you for your time and valuable input.

Regards 
Yogesh
