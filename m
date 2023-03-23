Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC86C6929
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCWNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCWNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:09:44 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4CA245
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D+3lRLnaMyX/RPlCniu19UlLbKxJeIyEDcWKOk5xtsA=;
  b=qNYpw8H8yHltISDNH8qWxyzJKg2xcYd6qz1GaNTweDyyUWU3P+Zf0iPj
   mhg+F+mTwGVgRnqt/GuGHCAZH3P/aea+Ypb1AMCCdM3Mrc/LbfXtRMbZb
   9IRJzPTyFbXMszmX5o5NWqR6dRUDB1gqH108cvLjtJMEEAAtG+TT6Hx7+
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,283,1673910000"; 
   d="scan'208";a="51038228"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 14:09:00 +0100
Date:   Thu, 23 Mar 2023 14:08:58 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
In-Reply-To: <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
Message-ID: <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com> <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Mar 2023, Julia Lawall wrote:

>
>
> On Thu, 23 Mar 2023, Khadija Kamran wrote:
>
> > Fix several cleanup issues reported by checkpatch.pl in module
> > staging/rtl8192e in file rtllib_rx.c
>
> Why is it resent?

OK, I see, sorry for the noise.

julia

>
> julia
>
> >
> > Khadija Kamran (4):
> >   staging: rtl8192e: remove extra blank lines
> >   staging: rtl8192e: add blank lines after declarations
> >   staging: rtl8192e: add spaces around binary operators
> >   staging: rtl8192e: remove blank lines after '{'
> >
> >  drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
> >  1 file changed, 29 insertions(+), 44 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
> >
>
