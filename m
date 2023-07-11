Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA874F9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGKVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGKVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:37:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC4C171F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:37:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b89cfb4571so46509875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689111442; x=1691703442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKp/iJWUOzi9KMXmJKLevJSI+NVSsqJRkj/8g2JsU8E=;
        b=cu5+S530R/eq040xxEUPFXyShpV5poEU7JpztU9iDouEAMhHEha6D+VLWsTLjREscx
         H14PqMpBkBneS79SqcJ6ebnD+bjqC+dRgWJw4dWUEcc7MGNlb5l2NOAESlsgHjaz/x+8
         MBys/t8lXi8vfZxpoR9aN14q9zVmOEdHxSNwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111442; x=1691703442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKp/iJWUOzi9KMXmJKLevJSI+NVSsqJRkj/8g2JsU8E=;
        b=ZtlwRSIHOpkr8Z6oqIsG3Jtkhv1bxuVstwC4dinKOTJJNN9SO8MgpWsCRIkXb11bIv
         Jq/C4H0RYsH41qHkobVIbm0AkHsScU5XWoJcyund1MLNrD9N9nudY+8mdIj9pMRdSm9r
         v4cp5vowBg6rMB4CuKGN9KalqJD9zKTgu8AOrP06uFzxQYvXp1oGk52Ng1yDCDoaraWH
         3zSaZdlra/OaPsKXJugobiQThpvR2XDrzbtJMPaIGikiL8Q3OvUx1ZDVBuZv+n09OYnC
         /ehu/8qo/NoKeQo1Y7B2XY6n9ybmwO82zAjFRj7reDXavflqt/c9tt4DRprsTRh8jW+h
         /3Lg==
X-Gm-Message-State: ABy/qLYlHiohgIUs9LMVJQ7p1F6wS7lkA028f/ItQCnZYsUsMI7DRTe0
        u+fwn9ROds/MfFYGHVM79VjFkw==
X-Google-Smtp-Source: APBJJlFHw1J61BjsIKrEI1HNcYSK6FCsFONXV06oHSAjIGr/JI8k4AmvLLm/LB4JHwss+ywUCREizA==
X-Received: by 2002:a17:902:b711:b0:1b7:fd82:973c with SMTP id d17-20020a170902b71100b001b7fd82973cmr16407025pls.39.1689111441812;
        Tue, 11 Jul 2023 14:37:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001b8b73da7b1sm2382979pli.227.2023.07.11.14.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:37:21 -0700 (PDT)
Date:   Tue, 11 Jul 2023 14:37:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xfs WARNING on v6.5-rc1 kernel
Message-ID: <202307111435.1C23ECE259@keescook>
References: <17881cf776b2c19dcd5a6d628fdfb54dae0eb4f8.camel@kernel.org>
 <20230710170243.GF11456@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710170243.GF11456@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:02:43AM -0700, Darrick J. Wong wrote:
> On Mon, Jul 10, 2023 at 12:29:29PM -0400, Jeff Layton wrote:
> > I hit this this morning while running generic/013 (fsstress), with a
> > kernel based on v6.5-rc1. The main changes on top of this are timestamp
> > related, so I doubt they're a factor here.
> > 
> > Is this some of the flexarray hardening?
> 
> Yes.
> 
> https://lore.kernel.org/linux-xfs/ZI+3QXDHiohgv%2FPb@dread.disaster.area/
> https://lore.kernel.org/linux-xfs/bug-217522-201763-D34HpuP9xe@https.bugzilla.kernel.org%2F/
> https://lore.kernel.org/linux-xfs/Y9xiYmVLRIKdpJcC@work/

It looks like these just need struct tweaks to avoid using legacy array
definitions. It can be done without changes to the size of the structs,
etc.

I'll send a patch...

-- 
Kees Cook
