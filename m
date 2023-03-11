Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088186B5CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCKOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCKOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:39:03 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792AEB89E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=70ULOWvNZDhIBg4vnstMVFwRyoxPMpkyu+flXX6WHg8=;
  b=oBBDl5JEgQh2HilqASq9c6QFzZ0YysFeqdmYczgig5W3R6UZk+6Zu0Tr
   VgTqQA6sy6p65pYgatxx5IhD9i7X0X73v/b+trvXrOHAgCHlSb+2fLZCl
   3qhwIlkFS4Xk+qQbpqF5rusMXFbzjYj/NOrzNCNzeccJK0yxsw+Bz95jX
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="96649566"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 15:38:59 +0100
Date:   Sat, 11 Mar 2023 15:38:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
In-Reply-To: <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303111537430.2802@hadrien>
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com> <alpine.DEB.2.22.394.2303110958250.2802@hadrien> <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com> <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
 <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com> <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-72012524-1678545539=:2802"
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

--8323329-72012524-1678545539=:2802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 11 Mar 2023, Menna Mahmoud wrote:

>
> On ١١/٣/٢٠٢٣ ١٤:٥٧, Menna Mahmoud wrote:
> >
> > On ١١/٣/٢٠٢٣ ١٤:٥٥, Julia Lawall wrote:
> > >
> > > On Sat, 11 Mar 2023, Menna Mahmoud wrote:
> > >
> > > > On ١١/٣/٢٠٢٣ ١٠:٥٩, Julia Lawall wrote:
> > > > > On Fri, 10 Mar 2023, Menna Mahmoud wrote:
> > > > >
> > > > > > Fix " CHECK: Alignment should match open parenthesis "
> > > > > > Reported by checkpath
> > > > > See the message in the other mail about the log message.
> > > > >
> > > > > Also, you should not have two patches with the same subject.  Here,
> > > > > the
> > > > > changes are on the same file and are essentially the same, even
> > > > > involving
> > > > > the same function call.  So they can be together in one patch.
> > > > >
> > > > > julia
> > > > okay, I will. appreciate your feedback. thanks.
> > > Please put some blank lines around your response, so it is easier to find.
> > >
> > > thanks,
> > > julia
> >
> >
> > Okay, I will.
> >
> > thanks,
> >
> > Menna
>
>
>
> Hi Julia,
>
> according to Alex feedback
>
> " I think this type of alignment is not a major problem,
> and alignment isn't done this way in general in this
> driver, it's probably OK to keep it that way. - Alex "
>
>
> ,I won't resubmit these patches, right?

The existing code indeed looks better to me.  So you can skip this issue.

julia


>
>
>  -Menna
>
>
> >
> >
> > > > > > Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> > > > > > ---
> > > > > >    drivers/staging/greybus/fw-core.c | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/greybus/fw-core.c
> > > > > > b/drivers/staging/greybus/fw-core.c
> > > > > > index 57bebf24636b..f562cb12d5ad 100644
> > > > > > --- a/drivers/staging/greybus/fw-core.c
> > > > > > +++ b/drivers/staging/greybus/fw-core.c
> > > > > > @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle
> > > > > > *bundle,
> > > > > >                }
> > > > > >
> > > > > >                connection = gb_connection_create(bundle, cport_id,
> > > > > > -                        gb_fw_mgmt_request_handler);
> > > > > > +
> > > > > > gb_fw_mgmt_request_handler);
> > > > > >                if (IS_ERR(connection)) {
> > > > > >                    ret = PTR_ERR(connection);
> > > > > >                    dev_err(&bundle->dev,
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > > >
> > > > > >
> > > >
>
--8323329-72012524-1678545539=:2802--
