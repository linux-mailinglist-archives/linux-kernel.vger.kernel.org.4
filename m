Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9E7355E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFSLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:33:05 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2DBF;
        Mon, 19 Jun 2023 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687174373;
        bh=zMoAd1INwZDS2apf3X9h/nweHdcswKoOiEd7Um0Mpas=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:From;
        b=jG4JZDlGqPln7P729neCaqXEtsoQ44Mqfbz1/iHCwT6N64F4tSlVF41lRhEo597eS
         ckAok2PDoo80hDgejjbSlBJ368Walt1AbkuhLPQHP0x5VE1m4OwLk06Nv7z8f/L8Hp
         G9klX+5Ggu4tS8oc5p8mnSvsL5tgI3th52GOFEXU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C2601128603A;
        Mon, 19 Jun 2023 07:32:53 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Hj0QRTet-pRa; Mon, 19 Jun 2023 07:32:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687174373;
        bh=zMoAd1INwZDS2apf3X9h/nweHdcswKoOiEd7Um0Mpas=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:From;
        b=jG4JZDlGqPln7P729neCaqXEtsoQ44Mqfbz1/iHCwT6N64F4tSlVF41lRhEo597eS
         ckAok2PDoo80hDgejjbSlBJ368Walt1AbkuhLPQHP0x5VE1m4OwLk06Nv7z8f/L8Hp
         G9klX+5Ggu4tS8oc5p8mnSvsL5tgI3th52GOFEXU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BF7951286035;
        Mon, 19 Jun 2023 07:32:52 -0400 (EDT)
Message-ID: <e78eef83a50a558aae765baafcf9c571788a02a5.camel@HansenPartnership.com>
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     fthain@linux-m68k.org
Cc:     corbet@lwn.net, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org, tytso@mit.edu
Date:   Mon, 19 Jun 2023 07:32:50 -0400
In-Reply-To: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> The Linux Contribution Maturity Model methodology is notionally based
> on the Open source Maturity Model (OMM) which was in turn based on
> the Capability Maturity Model Integration (CMMI).
> 
> According to Petrinja et al., the goal of the OMM was to extend the
> CMMI so as to be useful both for companies and for communities
> [1][2].  However, the Linux Contribution Maturity Model considers
> only companies and businesses.

That's not a correct characterization.  The model is designed to
measure and be useful to businesses, but it definitely considers the
community because it's progress is built around being more useful to
and working more effectively with the community.

> This patch addresses this bias as it could hinder collaboration with
> not-for-profit organisations and individuals, which would be a loss
> to any stakeholder.

I don't really think changing 'Businesses' to 'Organizations' entirely
addresses what you claim is the bias because individuals would still be
excluded from the term 'Organizations'.  I also don't really think it
matters.  Part of the reason this whole thing doesn't matter is that
sometimes people do know who a contributor they work with works for,
but most of the time they don't.  If you really want this to be
inclusive, you could change it to 'other contributors' but I'm still
not sure it's worth it.

> 
> Level 5 is amended to remove the invitation to exercise the same bias
> i.e. employees rewarded indirectly by other companies.

I also wouldn't remove the bit about seeking upstream feedback on
employees; I know from personal experience it happens a lot.

Regards,

James


