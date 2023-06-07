Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176CF7257A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbjFGI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbjFGI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:28:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B3F1B5;
        Wed,  7 Jun 2023 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Hg9joOitzyrlswtLr/eslIOSFjCc+Bk2gMqM/S9yDPw=;
        t=1686126503; x=1687336103; b=dAo85xRu7FJnjyGyxWa0Iu4I6MEDjHQ/AMvRXNeRu7y108g
        E6zNGVDjqwvWlbWijx7F1X96RZIVmTs/z9s7x872E9pARg5i/gBw5Baos9Xe3UtIbrNbRBDiQ11bF
        h4sz+I3yY3TkbDmtyNpNe4Ig55PEAixgjuMyVum8euWy56u7y6fZ5/VBbNZ0kffYAumL9Lu0YZ0Sg
        Irx69vknRHHF933HiVjvCKUXPXsuTKkbBVGwLrg2t18XmmXBNsoZ+CcIV/7VwrF+3fnMOUqgQ9Pp0
        Ukccr0TaSsJqHZjSJ8+OQbrYlqR9s09WYkYUyglBb8+aZuRubyBZ+k1WqTq/WYHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6oWa-00GTQu-27;
        Wed, 07 Jun 2023 10:28:12 +0200
Message-ID: <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
Subject: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH v2]
 uml: Replace strlcpy with strscpy)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Date:   Wed, 07 Jun 2023 10:28:11 +0200
In-Reply-To: <20230607042340.GA941@sol.localdomain>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
         <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
         <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
         <20230607042340.GA941@sol.localdomain>
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

On Tue, 2023-06-06 at 21:23 -0700, Eric Biggers wrote:
>=20
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@int=
el.com/
> > >=20
> > > Are you sure Reported-by and Closes make sense?
> > > AFAIK the report was only on your first patch and nothing against ups=
tream.
> > > So stating this in the updated patch is in vain.
> >=20
> > I left the metadata in only for the sake of posterity. If it's not
> > helpful, I'm ok with removing it.
> >=20
>=20
> IMO using Reported-by in cases like this is harmful, as it makes commits =
seem
> like bug fixes when they are not.

I've yet to see anyone disagree with that, and yet, the robot actively
asks for such tags to be included in patch resubmissions.

On the one hand, I can understand their desire to be recognised for
their efforts. At this point then we might suggest that we introduce a
different tag, say "Improved-by:" or "Issues-found-by:" or something.

On the other hand, I don't feel like we should give a robot more
recognition than we give _people_ reviewing, and we currently really
only recognise them by a Reviewed-by tag. Then again, that doesn't work
with the robot - it is pretty much looking at each patch and only
comments on a small fraction. We also really don't want it to comment on
each and every patch ...


So it seems we should ask the robot maintainers to just stop suggesting
those tags?

johannes
