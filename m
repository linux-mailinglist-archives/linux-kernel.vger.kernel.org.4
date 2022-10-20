Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E2605C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJTKTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiJTKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:18:50 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D681DC4FB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tPk2PsviksQC7IaOLsrQ48UgmDuuHY0n0hcjzx4nQSM=;
  b=RKjFcLKO9hwqGuN2ghiU94H4oEjnMxA2ICrN4UUxOj3isjrMVYwpMfcq
   h0prEM3A4TJbekw9Zifu6weBYr96EsM4T9ALF7k9bCP42lzvOQzHANPUe
   IjuNlr/Alic9Ah4hvQsJ38g/aAkkNWUI+fFHeV/hNMfaydm4ZsOUVnwhH
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66149190"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:18:12 +0200
Date:   Thu, 20 Oct 2022 12:18:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
cc:     Nam Cao <namcaov@gmail.com>, greg@kroah.com,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: vt6655: Fix Lines should not end with a
 '('
In-Reply-To: <CAHJEyKUsZ-V0waEwBEy67g+MNMR29MGJbBx3qCA4axKyPk9RGQ@mail.gmail.com>
Message-ID: <814aa14-25b-d579-e2d4-5c61ddb749b1@inria.fr>
References: <Y1BN6wPMrpxPB3qP@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net> <20221019223446.GA154747@nam-dell> <CAHJEyKUsZ-V0waEwBEy67g+MNMR29MGJbBx3qCA4axKyPk9RGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Oct 2022, Tanju Brunostar wrote:

> On Wed, Oct 19, 2022 at 11:35 PM Nam Cao <namcaov@gmail.com> wrote:
> >
> > On Wed, Oct 19, 2022 at 07:20:11PM +0000, Tanjuate Brunostar wrote:
> > > Code style warnings reported by checkpatch.
> > > Improve the layout of a function header:
> > > Put the first parameter immediately after the '(' and align the other
> > > parameters underneath it.
> > >
> > > Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> > >
> > > ---
> > > v2: put static and void on the same line and adjusted the indentation as
> > > suggested by Greg KH
> >
> > I think he meant putting "static" and "void" and also function name on
> > the same line.
> >
> Oh I will do this now. thanks
>
> > Additionally, I think your patch introduces new checkpatch problems. Did
> > you run checkpatch.pl on your patch?
> >
> > Best regards,
> > Nam
> >
> Yes I did. the checkpatch says this:
> Alignment should match open parenthesis
> #89: FILE: drivers/staging/vt6655/rxtx.c:89:
> +static void s_vFillRTSHead(struct vnt_private *pDevice,
> +               unsigned char byPktType,
>
> The only way to resolve this would be to add white space which would
> generate another checkpatch problem. how do i fix this please?

You mean that the ( is not at a point that is a precise multiple of the
tab size?  You can put as many tabs as possible and then use spaces
afterwards.

julia
