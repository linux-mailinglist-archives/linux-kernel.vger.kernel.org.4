Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F386C3718
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCUQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCUQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:40:02 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F24EED;
        Tue, 21 Mar 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PzFbeSMMbS4CC7XY2NIBhcKqrJEORtC8j3V9n4WJKHA=;
  b=mK6kLhXLytGD1zE70XoQ6WcMB+mJyZieWcb6GqWmQMfOVpN0GBdaE4fg
   1oU3+eZXBLvCLchaYuZFATS8et4Q+7qxQ7ZV1p29S1a4Art/+eDSPeeo+
   8HfOFnSJUZZMC/ekg0lpUiwC/tW/C9oBktNSKwlOlb1b1qOWJEJWKMl27
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="98353568"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:39:55 +0100
Date:   Tue, 21 Mar 2023 17:39:55 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/3] edits in greybus driver
In-Reply-To: <196b5d53-701f-e2dd-596c-9fdb6a59f5cd@gmail.com>
Message-ID: <8020f263-158d-db6e-f34-425b72983bb@inria.fr>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com> <ee77a227-13bd-70ad-1d8e-f9719970e0f8@inria.fr> <196b5d53-701f-e2dd-596c-9fdb6a59f5cd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1428913748-1679416795=:10740"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1428913748-1679416795=:10740
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 21 Mar 2023, Menna Mahmoud wrote:

>
> On ٢١/٣/٢٠٢٣ ١٣:٤٦, Julia Lawall wrote:
> >
> > On Tue, 21 Mar 2023, Menna Mahmoud wrote:
> >
> > > This patchset includes change happened in greybus driver in three
> > > different files two of them patch one and three related to
> > > checkpatch issue and in second patch convert two
> > > `container_of` macros into inline functions.
> > >
> > > Menna Mahmoud (3):
> > >    staging: greybus: remove unnecessary blank line
> > >    staging: greybus: use inline function for macros
> > >    staging: greybus: remove unnecessary blank line
> > Different patches should have different subject lines.
> But I have already the same edit in both file, so should I re-write the
> subject for one of them?
> >    You need to either
> > be more specific about the file affected or merge the two patches with the
> > same subject into one.
>
> each patch related to different file. So, Can I to merge two commits for
> different files but have the same edit in one patch?

They are both for greybus, which is what you advertise in the subject
line.  And the sense of the changes is the same, and the changes are quite
simple.  So I think you could just put them in one patch.  If you find
other occurrences of the problem in greybus you could make one patch that
fixes all of them.

> but in this case no need to create patchset for all changes in `greybus`
> driver, right?

A patchset is needed if the changes affect the same file, because there
might be complications if the patches are applied in the wrong order.

>
> If okay with that, should I versioning the patches to resend them again, or
> should add "RESEND" subject prefix?

RESEND would be if you send exactly the same thing, because some time has
passed and you are worried that the patch has been lost.  Now that you
have put these in a series, it is perhaps best to leave them in a series
and increase the version number, to avoid confusion on the part of people
reading the patches.

julia

> please tell me the best way to resend these patches, appreciate your help.
>
>
> Menna
>
>
> >
> > julia
> >
> > >   drivers/staging/greybus/gbphy.h                  | 10 ++++++++--
> > >   drivers/staging/greybus/greybus_authentication.h |  1 -
> > >   drivers/staging/greybus/pwm.c                    |  1 -
> > >   3 files changed, 8 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > >
> > >
>
--8323329-1428913748-1679416795=:10740--
