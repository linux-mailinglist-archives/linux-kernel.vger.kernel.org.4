Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C10615CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKBHFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKBHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:05:36 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2F1DDF7;
        Wed,  2 Nov 2022 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+ff4znqwIZoXohUvIKNT0EbfCtlyW/3kc/qOs3Vln9I=;
  b=XYoxH/inCwePyGL2wNXhyAEmag8/xhSQk/q0P4Wl3tioL/4QAedmERoK
   /p3jv/QLcgU5uVQWRM+1pjQNlRFvBY1X2JB0pxF9UpuDaeW1T/77Td9wE
   7wFnIKqEeaO1Qe3YFtSC/gKXiVMxQFCybQOx4oBodmkshr7+qmrz53ElI
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,232,1661810400"; 
   d="scan'208";a="72566726"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:05:32 +0100
Date:   Wed, 2 Nov 2022 08:05:32 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
In-Reply-To: <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
Message-ID: <alpine.DEB.2.22.394.2211020804180.3225@hadrien>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr> <20221102064747.GA8903@lst.de> <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1625700783-1667372732=:3225"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1625700783-1667372732=:3225
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 2 Nov 2022, Christophe JAILLET wrote:

> Le 02/11/2022 à 07:47, Christoph Hellwig a écrit :
> > What are th other 29 patches doing in this series?  Due to the lack of
> > context individual patches from series have to through /dev/null here,
> > sorry.
> >
>
> Hi,
>
> in each patch, in order to give some context, I wrote:
>    ---
>    This patch is part of a serie that axes all usages of strtobool().
>    Each patch can be applied independently from the other ones.
>
>    The last patch of the serie removes the definition of strtobool().
>
>    You may not be in copy of the cover letter. So, if needed, it is
>    available at [1].
>
>    [1]:
> https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
>
>
> What is the best strategy for sending such patches?

I send the cover letter to everyone.  The problem with sending individual
unconnected patches is that people who are looking at the patches on
generic mailing lists can't easily see that they should just skip over all
of them at once.  But it is hard to please everyone for this issue...

julia

>
> Should I send only individual patches?
> Should everybody be in copy of all patches? Or at least of the cover letter?
>
>
> Some patches have already been Acked or even applied. So I'll wait a bit so
> that things stabilize before resending what is remaining.
>
> CJ
>
--8323329-1625700783-1667372732=:3225--
