Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2A715F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjE3M00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjE3M0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:26:12 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7CC9;
        Tue, 30 May 2023 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M9A0vcVF8IA1gHsjyEyXBJrCT9Za4gxMa+ZTE7U7qVE=;
  b=S8e5VGyaP6g2R9mOEPLhyj18/8JGVlYxb98B1EIH4hYpbvfXw/pAAmyo
   xRTI1+QWbryrP7oH9mhubm2Wze5aLoWbch/0xeyA9LOTj/20Ou1xB076V
   UctW7tJw7+bKXPZHBOJ0G8soZFesMwdQaUjGaHS4ZzgQ6ZkekMLFppMcm
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="110279814"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:26:08 +0200
Date:   Tue, 30 May 2023 14:26:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Claudiu Beznea <claudiu.beznea@microchip.com>, cocci@inria.fr,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [cocci] [PATCH] Coccinelle: kmerr: increase check list
In-Reply-To: <f16a66f7-460e-3577-ec5c-e4ccf00065f2@web.de>
Message-ID: <7f63dd13-f69a-8171-90f7-5a4f46ed5790@inria.fr>
References: <20230530074044.1603426-1-claudiu.beznea@microchip.com> <f16a66f7-460e-3577-ec5c-e4ccf00065f2@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1892626257-1685449569=:3727"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1892626257-1685449569=:3727
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 30 May 2023, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/null/kmerr.cocci
> …
> > @@ -51,7 +51,7 @@ position any withtest.p;
> >  identifier f;
> >  @@
> >
> > -x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
> > +x@p1 = \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|devm_kasprintf\|kstrdup\|kstrdup_const\)(...);
> >  ...
> >  x1@p = f@p2(...);
> >  if (!x1) S
>
> Can it be nicer to specify desired function names on multiple lines
> for such a SmPL disjunction?
>
> Would you sort them according to their call probability?

Please don't follow either of these suggestions.

julia
--8323329-1892626257-1685449569=:3727--
