Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAC67BFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjAYWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjAYWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:10:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A45649A;
        Wed, 25 Jan 2023 14:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=qrA4WDuiycfQq8e9UdqLL+UdvaBCIEeofG2czzLroEo=; b=oHTVbQkdmcbX9vIIVzr9T10S9b
        oXS2EMq9Tvb75lN+Uzq/qnwEqAuYEoCy3kj/+k3jBAPtWMPnd2C2os5q1TsirQhdTAwwP7siojP8K
        6R6Yznnm9cj42l6Sntmu43FgvYEEEKUsHAwqt1K2N5kr7ZWrJynkGwWpPHJgZPKnoiPmzRMgifbt7
        lsKphQs9c7uRIi8jyt/DZXP6hnX2ZPhVS2CiUoAP1hdCNlpnWZdRwPwNkK7JuKwYaxPiCAtMqw94b
        7vUwUP9JwdVQHiL7GfD/5ndzx9NH2yJ03VW+EuoyhjQFoJ6AWAB5A4csYpWX6taq4YInipYi1VWwD
        DOcUcGFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKnyI-008x2C-Fn; Wed, 25 Jan 2023 22:10:22 +0000
Date:   Wed, 25 Jan 2023 14:10:22 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Martin Wilck <mwilck@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the modules tree
Message-ID: <Y9GoziGJmwDN/YZV@bombadil.infradead.org>
References: <20230125152212.51164f0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230125152212.51164f0e@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:22:12PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>=20
>   7ea5b24deb65 ("module: Don't wait for GOING modules")
>=20
> This is commit
>=20
>   0254127ab977 ("module: Don't wait for GOING modules")
>=20
> In Linus' tree.

I've fixed this and dropped the patch merged on Linus' tree, thanks.

  Luis
