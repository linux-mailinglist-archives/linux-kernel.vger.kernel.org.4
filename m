Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B44690D90
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjBIPug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 10:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjBIPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:50:32 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB66312E;
        Thu,  9 Feb 2023 07:50:26 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id AA5CB100002;
        Thu,  9 Feb 2023 15:50:22 +0000 (UTC)
Message-ID: <dc6e254dfd35505e0404755523b0f5c4906f83d9.camel@hadess.net>
Subject: Re: [PATCH v2 3/3] HID: logitech-hidpp: Add myself to authors
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Thu, 09 Feb 2023 16:50:21 +0100
In-Reply-To: <20230209145331.qqryivtatswdxvlf@mail.corp.redhat.com>
References: <20230206221256.129198-1-hadess@hadess.net>
         <20230206221256.129198-3-hadess@hadess.net>
         <20230209145331.qqryivtatswdxvlf@mail.corp.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-09 at 15:53 +0100, Benjamin Tissoires wrote:
> On Feb 06 2023, Bastien Nocera wrote:
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> > 
> > Same as v1
> > 
> >  drivers/hid/hid-logitech-hidpp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index 9e94026de437..03b77ca03081 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -30,6 +30,7 @@
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Benjamin Tissoires
> > <benjamin.tissoires@gmail.com>");
> >  MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
> > +MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
> 
> Just FTR, I have asked Bastien to set himself as an author given all
> of
> the work he has been doing on this and to have one more person to be
> the
> go-to person from folks having an issue.
> 
> And Bastien, would you mind adding yourself to the MAINTAINERS file
> too?
> This way you'll get Cc-ed when people submit patches.

Done in v3 specifically for the hidpp file.
