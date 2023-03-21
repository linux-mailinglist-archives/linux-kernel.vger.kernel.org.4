Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7566C2E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCUJzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCUJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:55:33 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385811ACCF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TLkPoEW3xbL/AvfHyfQMFwLNXlunH/Yalpug/Q4is8c=;
  b=TBnk1jDoYc/2U9X2FNzUPh4uDN6fpYgvZXpECm3HZjfZdWoeG+SA/kRg
   zFEA04tXCeaomMhqfc8WViAMlllNjaPOKZwLbqmHYvKf79mVl5487O/1I
   Y2nOsiwmq4elzZT1m+w+j+jFTMuckc1tdWIMEvyqIJhV3qb6s6R2wiIM3
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,278,1673910000"; 
   d="scan'208";a="50784837"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 10:55:24 +0100
Date:   Tue, 21 Mar 2023 10:55:23 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Deepak R Varma <drv@mailo.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        alison.schofield@intel.com, linuxstaging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: sm750: Rename sm750_hw_cursor_* functions
 to snake_case
In-Reply-To: <ZBlnrWywCfDftf0+@debian.me>
Message-ID: <5fcfed41-6cef-405b-775-66a5cbfbd15@inria.fr>
References: <ZBfpbgvYguJnzIOx@CloudiRingWorld> <ZBiEnFxlHb/OES0B@ubun2204.myguest.virtualbox.org> <ZBlnrWywCfDftf0+@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2023, Bagas Sanjaya wrote:

> On Mon, Mar 20, 2023 at 09:36:52PM +0530, Deepak R Varma wrote:
> > Hello,
> > Looks like you missed some maintainer list recipients in your to/cc of this
> > patch. How are you extracting the maintainer list?
>
> The easiest way to copy the list is by passing `--norolestats
> --separator , ` to get_maintainer.pl.

There should be a suggested command line in th tutorial.

julia

>
> --
> An old man doll... just what I always wanted! - Clara
>
