Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515D870D7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjEWIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjEWIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:48:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4095;
        Tue, 23 May 2023 01:48:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so1799527f8f.1;
        Tue, 23 May 2023 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684831706; x=1687423706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUOnFkk6LZeuoWYNMWkpPibztQzTwtUuTD5TmD26Q3A=;
        b=h804rVfO2Bsw5yhvUVlzXRHpaSQ0tIzGlkCXl2QpTqpfPKOWXefSJJdMry1Codj2bW
         0+Kxg284GAfF6b7SIFtTDOYfPLII2b6IXKQowkZVzm7+hH5sIXc4MpzkCVO9C5yaO6sL
         VP9jgWUCj5E86UpvFDee1+T0kPOQCgdyAiFY7pN4shnhTv+Fcau1okhmgcky0fVsmss4
         ZCTG3Tto+avFMlXwACVWVlQd6tjkH3aRB3GUprw9UFrWYYu+3vyUlC+J6JX4kfP4J4D4
         3PMPp25Q4z7/Ag0r7AaIkj20f4GY8S2nmv726qI9FE852+JonpFbdsUPzu9/f5bNCxHn
         WOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684831706; x=1687423706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUOnFkk6LZeuoWYNMWkpPibztQzTwtUuTD5TmD26Q3A=;
        b=gLVop/rVekoMAx25RLhQ18R/I0MJtV4x5ebZiRHyjFn9Qg3V+7BAKmDTii+XQNI3/C
         dYoL+nsemTVNrhfxAAEJAK/qNulrfIhTGkjj2KXUsFZVs9mKWYDwZ2GpIUvC+wVsDkhE
         gXECbAV0kDVxe0gW31OTXMne3qC2QIycNGTokTDaQH0ZjNN1tXQaCyvA+gopQDoPfFQp
         tpk7OByc5rIKeV1GkMUi+UfGp7sxGOpFeiTeEinuz+uliSWlSGJM/xLFtmErZ8fN/FD8
         caseURYiawQnOR3SAWgby2Tz76AxWmZDjffFv5XHdnMTVtdTUxPFYl4IPcqGeULTETxS
         1bJA==
X-Gm-Message-State: AC+VfDx9bUuilAJfXqMRCJRdQTpC35EYBwd0AxkKUjo3pRk0H7tghoPi
        52ssMf+Wzq3sAsfZYtB8JHA5EuwYxw==
X-Google-Smtp-Source: ACHHUZ4+dENExOL9ouxNlmnW9prFjF7QxPlaiGXyX8HYFXVjVXScfjlBVc09WRvxH5knU3Zfiyi42Q==
X-Received: by 2002:a5d:63c2:0:b0:306:2d81:341d with SMTP id c2-20020a5d63c2000000b003062d81341dmr11028951wrw.24.1684831705923;
        Tue, 23 May 2023 01:48:25 -0700 (PDT)
Received: from p183 ([46.53.250.221])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003f4283f5c1bsm2344856wmq.2.2023.05.23.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:48:25 -0700 (PDT)
Date:   Tue, 23 May 2023 11:48:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: + fix-mult_frac-multiple-argument-evaluation-bug.patch added to
 mm-nonmm-unstable branch
Message-ID: <6e6b2dc1-1fab-4506-bbad-41edaafd7231@p183>
References: <20230522211514.E0037C4339C@smtp.kernel.org>
 <87ttw4udzv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttw4udzv.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 01:45:40AM +0200, Thomas Gleixner wrote:
> On Mon, May 22 2023 at 14:15, Andrew Morton wrote:
> > ------------------------------------------------------
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Subject: include/linux/math.h: fix mult_frac() multiple argument evaluation bug
> > Date: Sat, 20 May 2023 21:25:19 +0300
> >
> > mult_frac() evaluates _all_ arguments multiple times in the body.
> 
> I'm not opposed to the patch, but to the description.
> 
> Multiple evaluation is not a bug per se.

It is kind of a bug if a macro pretends to be a function and is spelled in
lowercase.

> Unless there is a reasonable explanation for the alleged bug this is
> just a cosmetic exercise.

Most usages looks OK, and compiler tend to merge loads so even more
usages are OK. But formally this is not OK:

	static inline unsigned long vfs_pressure_ratio(unsigned long val)
	{
	        return mult_frac(val, sysctl_vfs_cache_pressure, 100);
	}

> Changelogs have to be self explanatory and if the shortlog, aka
> $subject, claims "bug" then there has to be a reasonable explanation
> what the actual bug is.
> 
> Seriously.
> 
> All this is documented, but obviously documention for changelogs and the
> acceptance of patches is just there to be ignored, right?

I don't want to return to kindergarten and document problem which every
C programmer learns exploring MIN(a, b).
