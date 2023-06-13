Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9772EC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjFMUAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFMUAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:00:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D14173C;
        Tue, 13 Jun 2023 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ctNb/7yUvrT2D51cOWDJeRoN3fAPETOIpuMJ8jKqL9k=;
        t=1686686438; x=1687896038; b=tkXibWwoOL8XFJTc963eEBeP3bKAiUTeTq+awI651jSzTRC
        V1gH14pGgzpQddQHi7kNhJ8NCwlz8MuBUtW0Rq1yV4Smi/4L25aoTUxpCXA8hEQcR5vZNUmsd9fZa
        rJ2c9gRnTeKT127GfCD3SJyIRtpMgGGNhfh4hfCcu5I1c3n2rYx5mdjd0H6iaEKrUA2bnzkxD+HpC
        O5RRFHfRtmzdii4RYXGXo4d8+G3iWf3sbjQ4TVUhtw1VNYpBhP94Wp2PZ61aM+iTEH3GF81SVEsCJ
        xlM5F9z/pWAbvCcnUUxiEsdAT3ptb/LfEIpE+EbFuLq0+pPR970LtdgDqqKWwlBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9ABw-005CKc-2j;
        Tue, 13 Jun 2023 22:00:36 +0200
Message-ID: <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
Subject: Re: Closing down the wireless trees for a summer break?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Date:   Tue, 13 Jun 2023 22:00:35 +0200
In-Reply-To: <20230613112834.7df36e95@kernel.org>
References: <87y1kncuh4.fsf@kernel.org> <871qifxm9b.fsf@toke.dk>
         <20230613112834.7df36e95@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Tue, 2023-06-13 at 11:28 -0700, Jakub Kicinski wrote:
> On Tue, 13 Jun 2023 20:14:40 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > I think this sounds reasonable, and I applaud the effort to take some
> > time off during the summer :)
> >=20
> > One question that comes to mind is how would this work for patchwork?
> > Would we keep using the wireless patchwork instance for the patches
> > going to -net in that period, or will there be some other process for
> > this? I realise the setup we have for ath9k is a bit special in this
> > regard with the ack-on-list+delegation, so I'm obviously mostly
> > interested in what to do about that... :)
>=20
> Whatever's easiest :) It's probably a good idea for Kalle to write
> down all the local rules and customs and share those with us.
>=20

While that's probably a good idea regardless, I'd think that patchwork
doesn't really matter that much - we'll have some catching up to do
anyway after the vacations, so looking through patchwork etc. would be
perfectly acceptable. Worst case we'd notice when a patch doesn't apply,
right? :)

Wrt. ath9k patches I guess "delegate in patchwork" won't work anymore,
but "resend to netdev" or something perhaps?

johannes
