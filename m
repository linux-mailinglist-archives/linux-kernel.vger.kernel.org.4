Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3C6B5994
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCKI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCKI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:56:10 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F31F4024
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uFD3cgMWkcIJ2NqVC1pnXMQq6rewZDYCcFM5WgVsshE=;
  b=Dr7UHQjtiFWWiss9BeBq04BcEoxxACp5atGLpCd5in7SBLaKAGu9h4ks
   dLOsWnnrPEpwNhSBxJKVfH+8fVfMzYRj8P3zthhFUbtoEfMjZJdyMGSxJ
   xf67IhyAfu/VWCUOOaeedW5rVKqCfFnXal/KC/P/eLOqpEqtpFci2kYbm
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="96627995"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 09:56:07 +0100
Date:   Sat, 11 Mar 2023 09:56:06 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
In-Reply-To: <ZAtUVBbyMw7ine2e@khadija-virtual-machine>
Message-ID: <alpine.DEB.2.22.394.2303110954590.2802@hadrien>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine> <alpine.DEB.2.22.394.2303062202500.3050@hadrien> <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com> <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr> <CACcTnM4OHFiGrEez6dMzd4jO4YuQZzqpUK86UBMzhd+nFDWezA@mail.gmail.com>
 <e06f57e6-2a3a-7fde-742d-9d5dd8dd49b0@inria.fr> <ZAtUVBbyMw7ine2e@khadija-virtual-machine>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Mar 2023, Khadija Kamran wrote:

> On Tue, Mar 07, 2023 at 09:13:49AM +0100, Julia Lawall wrote:
> > There are actually two similar issues in axis-fifo.c.  You could fix them
> > both at once.
>
> Hey Julia!
> I have a question. Should I send the two fixes as a patchset of two
> patches, and should I send it as [PATCH v2]?
> Thank you.

The two issues in axis-fifo.c are very similar.  They could be in a single
patch.  And that patch could be the v2 of your previous patch.  Just note
that you have fixed another instance of the same problem in the message
under the ---.

julia
