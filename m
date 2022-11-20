Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CED63127C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 05:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKTEsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 23:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTEsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 23:48:51 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E6A7C13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 20:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=bZq18OZnRSfbpXSB+XefMRP4B9OmZ7ohS2Dn73Tozw8=;
  b=ROSwRFbx6KBuIxnVdORuvNwaL0ftVdgQOuRARixsdmIxvACnGkaf9jlJ
   tFBxZG6SKOupcAo+06jnKs2MmbApl8nAsiYcn1EID/8Yjvmrk9jsd+ezO
   NUPBDVw6Vc3VT2ehmyJgKKzYQ5JzlDNI3NNYGZ8MeCcs1wLplXXPTytL4
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; spf=None smtp.helo=postmaster@zcs-store9.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of julia.lawall@inria.fr is inclined to not designate
  128.93.142.36 as permitted sender) identity=mailfrom;
  client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="julia.lawall@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs-store9.inria.fr) identity=helo;
  client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="postmaster@zcs-store9.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,178,1665439200"; 
   d="scan'208";a="79101348"
X-MGA-submission: =?us-ascii?q?MDEBq3kCWwLsQ/DvWFieT+YfNMxabmJVHTKfDp?=
 =?us-ascii?q?mFY2Xt1vOGvwKlBjZCizhctC5m2r+7+eS0foD0ulVC9HfDu2v03/OQs2?=
 =?us-ascii?q?eWzbvkQTWHxF4zEFv3HNBHAxLiJ83/Bv1Tzf7vFgxEDXr6SDPgmqg9Yt?=
 =?us-ascii?q?s4C434ZbdtZKItUtxGimpjzg=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 05:48:46 +0100
Date:   Sun, 20 Nov 2022 05:48:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     cocci <cocci@inria.fr>, gregkh@linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        nicolas palix <nicolas.palix@imag.fr>
Message-ID: <1149742048.11906171.1668919725846.JavaMail.zimbra@inria.fr>
In-Reply-To: <44c42da0-aa89-41ec-d539-8bc5ee168ddc@loongson.cn>
References: <alpine.DEB.2.22.394.2209212125590.2783@hadrien> <44c42da0-aa89-41ec-d539-8bc5ee168ddc@loongson.cn>
Subject: Re: [cocci] [PATCH] scripts: coccicheck: use "grep -E" instead of
 "egrep"
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.2.7.122]
X-Mailer: Zimbra 8.8.15_GA_4464 (ZimbraWebClient - FF106 (Linux)/8.8.15_GA_4468)
Thread-Topic: scripts: coccicheck: use "grep -E" instead of "egrep"
Thread-Index: /wvYSdZmgka+dfRQqzNi/gIC6kJo4Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Hi,
> 
> This patch can not be found in the torvalds/linux.git or
> next/linux-next.git tree, please take a look, thank you.

I missed the last merge window.  It is in my tree on kernel.org, though.

julia
