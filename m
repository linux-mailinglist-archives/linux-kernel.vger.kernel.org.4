Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2D5FCB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJLTPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJLTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:15:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112BD8EC3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jGmC/2MAYYtmSyVe30S3h6KQzNlgS5MeuQtns9Ly5YI=;
        t=1665602150; x=1666811750; b=iu+DxLA4qCrXaNp573ek9WMUQTfHvR73Ii8SzuZvSuhVJjK
        XDPXylaB6E6zVyty1S9b4dqWHp4FolatEAEQsogDLaWcq0yA6y7oCgezpbIO6fYhs43YO1iW2Upjv
        0tMfn/gGw+KoajI/9bzs7YSUJ1QR6F27+pl87D5r29W5/UgBe87yPSbkgLRHdrGPg/7FT5tSPaZs5
        d71oOawK9nyk9XIqP5ssZ4wLmXKpvCSKG2DGB5oUMeACT6KboOybsNYUGrd9IHOWD+bpH84oU6v98
        4Vyjl/o5/974SPGfRLdrx0Cxbi2Vb0laoWd/fjXPb2PGzy1e0jP91q2xkd/CI5dQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oihCf-004twp-21;
        Wed, 12 Oct 2022 21:15:42 +0200
Message-ID: <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
Subject: Re: Add linux-um archives to lore.kernel.org?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-um@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um-owner@lists.infradead.org, linux-kernel@vger.kernel.org,
        helpdesk@kernel.org, David Woodhouse <dwmw2@infradead.org>
Date:   Wed, 12 Oct 2022 21:15:40 +0200
In-Reply-To: <20221012191142.GA3109265@bhelgaas>
References: <20221012191142.GA3109265@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-12 at 14:11 -0500, Bjorn Helgaas wrote:
> The linux-um@lists.infradead.org mailing list is listed in MAINTAINERS
> and is quite active [1].  Once in a while a commit links to the
> infradead pipermail archive [2] (the link in that commit appears
> broken).
>=20
> I propose that we add linux-um to the lore.kernel.org archives so
> future commits can use lore.kernel.org links that don't depend on
> infradead.
>=20
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

I think we talked about this before, but I also don't have any archives
worth talking about (only since mid 2019 with a small gap in mid 2020).

If anyone wants to collect the archives from all people, I'm sure it
could be done. I can contribute what I have ...

The tooling makes that pretty simple, actually.

I think lists.infradead.org mostly got lost though, right dwmw2? So that
way I don't think we'll find much (old) archives either.

johannes
