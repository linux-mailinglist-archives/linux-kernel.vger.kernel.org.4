Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B77358ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFSNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFSNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:49:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80136BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:49:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b5251e5774so14247835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687182567; x=1689774567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfV234ipEV2m8xogB7Wi+sWBOiJ7SNMV0abfD7C/wG8=;
        b=Ine5LS6c9y6jwgvPYxtPmp3P+gEHDDJp7KHx59PjhUElufW0f4UcBZlKvqAr5XwPbp
         bJfOVz1sMMhPSh4Rzv0AmURNRc6WUw70Rxd/uQFxsilFi0rmyC7lEVHPgIcyM0ZpNHnd
         1Y1ae7fYj506xRLLJ5Ufm+mc48XziVNB6C0hwZ3Ewa+2qht6XzRA1//Rd/BxMaJYO+4U
         alelOTV8aAV/oGz9ADJLrI+K7TpffXNJsbDvw3FjB6+Yr9Tr4UVyZjCR3QSmhQpTG1di
         43u/OS0ZP+9Hh25z4PQY5yHKju2EkENsCbEYCmKlfEue3H2ex+ThpX7iZqFha70LRy2F
         7Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687182567; x=1689774567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfV234ipEV2m8xogB7Wi+sWBOiJ7SNMV0abfD7C/wG8=;
        b=C/jv59Ws/EkHGz1PnpQEYFUaVv6beJ5JJpznzQnHDPW1XZhcdaSLEl06w2WAdu5cIJ
         JxTaygd471ngNUAdp5b7bdgtDxByKgLOWgnJl8c7qhPzGsO1e++/qRceB9JOQS1C2OWv
         e6tu93MPDdremcoVnvzsdS2m2UMYgUEtpDhk8U3CrVUYFwbzBNaKdR1zBhJhwTeCU7MS
         pE+FBDluEsHl55VdkUoFvDwKM7y9VvNbWVeNr061yLQduqFqp37UEWB52IpgKgNxzhf/
         fZUulEQ7SeQpHQdqxLZuFijj6mFkwTj9mDpcAPbCYcv4YR/l3o7BwZ3W+nKfNX/rpd59
         /btA==
X-Gm-Message-State: AC+VfDxeqppe75Ad078isyv+thx/kJJBqBsc/rap2+VGLs0DG6i/fY4j
        uCqlfiFnSmL2iGF/4pxM/vw=
X-Google-Smtp-Source: ACHHUZ6UkYGnyShtmIsx+2AzmKB5WwOodXTLV9pRDEnnIp+I/qSpQYiXcWw+0WYZsdbPX0yEYlgbVA==
X-Received: by 2002:a17:903:22c4:b0:1b0:6e1:4b9f with SMTP id y4-20020a17090322c400b001b006e14b9fmr876665plg.43.1687182566817;
        Mon, 19 Jun 2023 06:49:26 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902a71000b001b061dcdb6bsm20501435plq.28.2023.06.19.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:49:26 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:19:21 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: Re: [PATCH v3 0/4] Trivial code cleanup patches
Message-ID: <ZJBc4bok1krfjqWf@zephyrusG14>
References: <cover.1687092111.git.yogi.kernel@gmail.com>
 <e80d385d-5515-ed42-e5dd-f9c977f7d4d1@gmail.com>
 <2023061938-unbounded-unbent-e706@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061938-unbounded-unbent-e706@gregkh>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 
On Mon, Jun 19, 2023 at 02:57:56PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jun 18, 2023 at 10:26:37PM +0200, Philipp Hortmann wrote:
> > This patch series alone is fine. But when my patch series ([PATCH 0/9]
> > staging: rtl8192e: Remove unsupported modes a and 5G) is applied before it
> > fails as we change same lines. Will see what happens.
> 
> Yes, none of these apply :(
> 
> Yogesh, can you rebase this on my staging-next branch and resend?
Sure, will rebase and resend. Did you mean staging-testing branch instead of 
staging-next branch ? 

The patch series is rebased to commit "f99bbb4412ce axis-fifo: remove the 
unnecessary dev_info()" which is the HEAD of staging-next.
Latest changes by Philipp are merged into staging-testing branch. 
Let me know if you still want to rebase it to staging-next branch. 

Regards 
Yogesh 
