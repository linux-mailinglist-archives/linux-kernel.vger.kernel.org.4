Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB64B6B5B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCKMMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCKMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:12:33 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F081ABC2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=32bL0mYWtM+3ID3jj1jtKti6IGliY5pwZ9oi3Yv3bSQ=;
  b=RACmxyM+m4LMNfuXauexo38mZw9CPTu2TuJ1RO7FaihRjR1x53sT5Lgy
   aX5YF7817W8EeYnuimglODVoziAYUnTWIaCRnrFztT4EQFSSa1mlvLstN
   Xmsi7I/PVDip/RasaQ4mQbN7j8bjstb/mTn97KmAHuEOd0586vLNQYhQx
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="96640125"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 13:12:28 +0100
Date:   Sat, 11 Mar 2023 13:12:28 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumitra Sharma <sumitraartsy@gmail.com>
cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Change bit_rate type from u16 to u32
In-Reply-To: <20230311115904.GA21529@ubuntu>
Message-ID: <alpine.DEB.2.22.394.2303111312070.2802@hadrien>
References: <20230311115904.GA21529@ubuntu>
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



On Sat, 11 Mar 2023, Sumitra Sharma wrote:

> Hi julia,
>
> I forgot to Cc the maintainers of the code of the above patch. I have Cc
> in this mail. Do let me know if there is a need of recreating the patch.

You need to send the patch to all of the relevant people/mailing lists.

julia
