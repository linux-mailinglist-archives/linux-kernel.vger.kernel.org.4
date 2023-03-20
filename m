Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACD66C0A50
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCTGA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:00:53 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240261CF69
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ChQuj5XgbW/Q++WrTFqVuLgTS8TSwYzUGTH9f/cJkuI=;
  b=at6cAreItfpo0w52sLooj7bGxHT7k5o3TKK7M8h5lSp3lAO6w2QtC28L
   iRz7wWkLz7OZAlTeeGExABoLWEpS341xLUs01Zs9enD4VH01db5uQaY3k
   VPwjdzl5tP68KrkDqLMtfX4ckL6UYKVBvU/L7RguZ99zvc0VCwkkCtDZ0
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="97979748"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 07:00:47 +0100
Date:   Mon, 20 Mar 2023 07:00:48 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: use inline function for macros
In-Reply-To: <8e9724a0-226d-eb81-69c3-d59889e37e1f@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303200659280.2940@hadrien>
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com> <alpine.DEB.2.22.394.2303192121170.2867@hadrien> <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com> <alpine.DEB.2.22.394.2303192151330.2867@hadrien> <402ffcbe-bb29-7035-68f4-2741532a6d67@gmail.com>
 <alpine.DEB.2.22.394.2303192225590.2867@hadrien> <649afe06-e069-e046-21ec-0d86243a4bfa@gmail.com> <alpine.DEB.2.22.394.2303192303130.2867@hadrien> <8e9724a0-226d-eb81-69c3-d59889e37e1f@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > and version that I have submitted, should I do anything about it as you
> > > said
> > > it is wrong solution?
> > My concern was the blank line after each of the structure definitions,
> > which is not in Greg's tree, so he can't apply the patch.  Other than
> > that, if the code compiles it is at least going in the right direction.
> >
> > Please fix the newlines issue, and then send the patch again.
> >
> > julia
>
>
> Okay I will fix it, but will send it as a new patch not v3, right?

Why as a new patch?  The change is the same as in v2, and sending v3 makes
it clear that v2 should be ignored.

julia
