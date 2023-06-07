Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FF7259E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjFGJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjFGJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:18:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9383;
        Wed,  7 Jun 2023 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/N4iQQzhKXwMLpsqAX/ldRXHvjdWxI/sMibJLHmuUyE=;
        t=1686129485; x=1687339085; b=tlLst//G60B0SndknUo2dNgUlP09MA53Vi92vpoCI+t2IgE
        aGN87YSPykv3sH7mOv0WHHpnRALVFit/DkxQsm54BnUHh/0Sn/ACv3uifCJOUOS+TgvvQcBaPmGAc
        RLH69C6n4cikB4Q78iLkzbUzd7aoE5cam6+7RJPAACYuuUTQj+x28ARU8DswpwWtccU479q5yFChW
        qiBbMJ1XveJXcD/+5QrFdX2elKEhHxi9iK7GzaGfS+w5i50Zsq7kiOjna0P80O53yNsEWajKt1PvB
        OPi5se5qgLzD5FzkyToGh5+19BPWCrGCNtMom8bvfxTnPGKJWrdlO77UjQtY+/5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6pIh-00GUej-1M;
        Wed, 07 Jun 2023 11:17:55 +0200
Message-ID: <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Philip Li <philip.li@intel.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Date:   Wed, 07 Jun 2023 11:17:54 +0200
In-Reply-To: <ZIBJadzmheKWCErq@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
         <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
         <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
         <20230607042340.GA941@sol.localdomain>
         <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
         <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
         <ZIBJadzmheKWCErq@rli9-mobl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-07 at 17:10 +0800, Philip Li wrote:
> > > So it seems we should ask the robot maintainers to just stop suggesti=
ng
> > > those tags?
> >=20
> > Agreed.
>=20
> Thanks all for the feedback. We will carefully consider how to present th=
e
> suggestion clearly.
>=20
> For now, because the bot covers both upstream and developer repos, there
> can be various situations, such as the bug is found in upstream.=C2=A0

Ah yes, that was actually in my mind, but I forgot to write about it,
sorry.

I agree completely, in case that you find a bug in an already committed
tree, and there will be a separate commit to fix it, it's completely
reasonable and useful to have those tags.

> So the bot
> tries to let author decide how to apply the tags in appropriate way that
> they feel comfortable.

Right. It just seems that many authors aren't really all that familiar
with the processes yet, and take the suggestion at face value.

> In the report, we now uses phrases like below
>=20
> 	If you fix the issue, kindly add following tag where applicable
> 	| Reported-by: kernel test robot <lkp@intel.com>
> 	| Closes: https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lk=
p@intel.com/
>=20
> But this may be not clear enough or not the best way to suggest. We will
> consider whether we can detect some situations (like RFC patch) which is
> no need for such tags to avoid confusion.
>=20

Right. Maybe the only thing really needed would be to say something like

"If you fix the issue in a separate patch/commit (i.e. not just a new
version of the same patch/commit), kindly add ..."

or even just

"If you fix the issue in a separate commit, kindly add ..."

so it's clear that if you're changing the commit, it's not really
something that should be done? In which case probably even a Fixes tag
should be there, but I wouldn't want to recommend adding that since the
commits may still change etc.

I don't know all the processes behind it, but I'm thinking that even if
the bot picked up a patch from the list, it could get committed before
and then fixed in a separate commit.

johannes
