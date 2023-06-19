Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13D4735DED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjFSTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjFSTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:42:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6D118
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:42:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35JJgGng028862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 15:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687203739; bh=vPMi+7KO21XyZ0qnD0pDNPiOfUhhFZ7sZOqlW0yLHoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lwIGgdc/Wm4AAFS1JaBSskUg0GyRkC5aU4sicyBEnrBlDFEcSiPZxUco+wp4TtMnn
         HuM/Iw2Vi8sCn1MX5edcZXssJahHn6jpxwSYPGOkd1e4Mxm5uVU3jhQXso8iQ5ih4y
         d1yz3h8tH1j+hvqyHenVUP8PiPenQcr9fXWPoCpgaDvtbG4k6fsynCZ0+B5pyKoMcE
         XII5VlFlXsR/USg/DSLs/Et0Zu4mqJR9X5EH/PfJjNCGByOrLQf4BVVkzYZlRNC8D2
         RZYDKITkdxq+WZfDb2UuIQfrtyxkHZglJwSi1FB2P13Fg5mxw/BUUoZ3GkrATdnnPn
         E05+7B7jW+F5g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B62D015C0266; Mon, 19 Jun 2023 15:42:16 -0400 (EDT)
Date:   Mon, 19 Jun 2023 15:42:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <20230619194216.GB286961@mit.edu>
References: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> The Linux Contribution Maturity Model methodology is notionally based on
> the Open source Maturity Model (OMM) which was in turn based on the
> Capability Maturity Model Integration (CMMI).

So from a historical/factual basis, this is not true.  It was *not*
based on the Open Source Maturity Model; in fact, as the principal
author of this document, I wasn't even aware of the OMM when I wrote
it.  The general framework of Maturity Models[1] is a very long one, and
goes back well beyond Dececmber 2022, which is when the folks in the
banking sector launched the OMM[2].

[1] https://en.wikipedia.org/wiki/Maturity_model
[2] https://www.finos.org/blog/open-source-maturity-model-launch

The reason why the language in the Linux Contribution Maturity Model
(LCMM) focused on companies was that was where the problem was
perceived to be.  That is, the *vast* majority of Linux Kernel
contributors work at companies, and because of many companys' focus on
reducing costs and increasing profits of their products which are part
of the Linux kernel ecosystem, some of them enagage in anti-patterns
which are not healthy either for their own role in the Linux Kernel
ecosystem, and for the Linux Kernel ecosystem at large.

For example, if you look at the 6.3 contribution report[3], you'll see
that by changesets (git commits), 85.4% of the contributions came from
companies, 6.6% were unknown, 4.8% were "None" (e.g.,
hobbists/students), and 1.1% were from the Linux Foundation.

[3] https://lwn.net/Articles/929582/

In actual practice, we get *very* few commits from non-profit
organizations such as, say, the Mozilla Foundation, the Eclipse
Foundation, or even community distributions such as Debian or Arch.
And so the concerns around software engineers not getting the
permission and encourage they need so they can contribute to the Linux
kernel community at large, is primarily coming from companies.  The
only non-profit organization that even shows up at the contribution
reports is the Linux Foundation, and I'm pretty confident in how
enlightened the LF management vis-a-vis kernel contribution.  :-)

As far as individuals are concerned, things like performance reviews,
the ability for overly paranoid corporate Corporate General Counsel
not allowing their engineers from contributing to Open Source (in
general) and the Linux Kernel (in particular), yes, those things
aren't really applicable.  But again, there is a specific problem that
we are trying to solve, and it's not with individual contriduals.

> This patch addresses this bias as it could hinder collaboration with
> not-for-profit organisations and individuals, which would be a loss to
> any stakeholder.

I'm not sure how this document would "hinder collaboration" with
non-profit organizations and individuals.  Could you say more about
your concern regarding how this undesireable outcome would happen in
practice?

I'm not against making using wording which is more general, such as
perhaps "companies and organizations" instead of "companies", but it's
important that we don't dilute the message the primary audience ---
which is pointed-haired management types, who are familiar with the
Maturity Model framework, who are *primarily* working at for-profit
companies, and who could make it easier for those Linux developers
whose day job involves Linux kernel development.

Cheers,

						- Ted
