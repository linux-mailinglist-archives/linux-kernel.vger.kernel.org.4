Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC5608BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJVKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJVKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:34:30 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C731728B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AW9YOnXXwqRJMmUiyr1Fh6rDHqdahVqrAovQWDd7HJM=;
  b=Ua6f+53Q/9yGkPyRnTZME4Lg4qEqjuSPcKfrbcn+/vROPJOgncJxxlJ2
   Ch5fKsqOqBvPL/Sma1v9U7sx4oTAdaHWTWiVSBWkyj5rJECR4ngDpWPXu
   MlaENRB3CuxCZvdHODW97CDsg0ioQZ1A12s2RnY5/5l++M1raAUeTi21e
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="67853078"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 10:13:42 +0200
Date:   Sat, 22 Oct 2022 10:13:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: request for assistance
In-Reply-To: <CAHJEyKVi=Bw1=-cH8dbJratKw3Lk3ubh_9bcBB=iKPm5H7P1Yw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210221013071.2700@hadrien>
References: <CAHJEyKVi=Bw1=-cH8dbJratKw3Lk3ubh_9bcBB=iKPm5H7P1Yw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Oct 2022, Tanju Brunostar wrote:

> There is a portion of the Outreachy first patch wiki I would like to
> edit. How do I go about doing this?
> - Should I just go on and edit it? or
> - Do I have to make a proposition addressed to someone or somewhere,
> stating what it is I want to change and why?
> I would appreciate your help.

It would be good to post your proposed changes to the mailing list, if it
is something more substantial than fixing a spelling mistake.

julia
