Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207BE67B7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjAYRCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjAYRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:01:33 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F148593;
        Wed, 25 Jan 2023 09:01:32 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 203so8719218iou.13;
        Wed, 25 Jan 2023 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec1Ka0db1NrX1Xb7d95sT9qUeiw8lmRBXlQq56Tj8+c=;
        b=TAHjGISDVcHzQJ7O+EVA+8A0dOl8L6jAXumEOFX13od6F2COjwX5d8GUyYDW4iHg1N
         BknN44cQLaSCws3uEf5xB1+Tpb4IPERmY4E/tECkGkhj4LdOyojZg8CM1icIdSnYIE8e
         BIa0fuFf4nJ9BcRlY4zN9Vbvm+G1nmx744EDE1USWyPIrs0Zn9sOabCSQWOLSDOIjtUe
         1oeacil1nLfduuSOOhnUeUTef6naudguuW5Er9vC3TFSn16ZVoZNndlaHZ+sK/HgG0WS
         CXl8hOGqg9oELkKNiuF1RdqYqKiXMPyGCuJDdX3f5f46nr30xqWN4esTJzVO6H6GYuwW
         1lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec1Ka0db1NrX1Xb7d95sT9qUeiw8lmRBXlQq56Tj8+c=;
        b=53KDGWsGlL7QtAUUMcIqYP/Re4YY6PXBkTuIYMYQxhe+0UM3oNvu/F1SrUsAs49Qoj
         RJI1QRFLfIuddl9I/GVjy4D3dCk6f+7LpxvBNRm4AcIvDThjwByyiEKQVq+eUy5WnvQD
         IbecJs6BZGxEpMCe5DclV+dLutBy2Uqu7xEMLxWlo0udUirEh6ZWT7YBN5SnHHQ17Oh2
         3oUUGe0mY4+gs1kKYkjWvsiH3mm91pza5dbAMEeYVUhc9mpgWcb+rBFSVxLE/a2bQ5PA
         /WLsa+TvGatzvEvuMzLnEjMevZD4fx7XwtL9mB1AMNzJKKC1H2fyJJhfOQYtXHhLCiVI
         b9Qg==
X-Gm-Message-State: AFqh2kqUGn5Sf/u+yYTwAXx3uCmqQ6wfUY5jXqwQpdatZuIsYCd40QqP
        27ON1GOwgEtx+K1eUOT0f+T1LrgBnLsP6JL7q0f43hB5UUk=
X-Google-Smtp-Source: AMrXdXvgmWJenxWNl6uHkQ679tdqmRtHUOqyTNLrAWKiBQAK+mZ5VsPFIv6EeYW4gCr55iuoyUHqqQC5wCpHKj5GJS4=
X-Received: by 2002:a5d:8798:0:b0:704:5916:5290 with SMTP id
 f24-20020a5d8798000000b0070459165290mr2644851ion.10.1674666091656; Wed, 25
 Jan 2023 09:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20230123152430.3e51fd25@canb.auug.org.au> <Y86cy1AM4w5ju5A4@kroah.com>
In-Reply-To: <Y86cy1AM4w5ju5A4@kroah.com>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Wed, 25 Jan 2023 18:01:20 +0100
Message-ID: <CAMUOyH3p1ji0AQSKD6b05ozUfQ5_09jzx8VttQSGZampjBZofw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the usb tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 3:42 PM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jan 23, 2023 at 03:24:30PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the usb tree, today's linux-next build (htmldocs) produce=
d
> > this warning:
> >
> > include/linux/usb/composite.h:510: warning: Function parameter or membe=
r 'bcd_webusb_version' not described in 'usb_composite_dev'
> > include/linux/usb/composite.h:510: warning: Function parameter or membe=
r 'b_webusb_vendor_code' not described in 'usb_composite_dev'
> > include/linux/usb/composite.h:510: warning: Function parameter or membe=
r 'landing_page' not described in 'usb_composite_dev'
> > include/linux/usb/composite.h:510: warning: Function parameter or membe=
r 'use_webusb' not described in 'usb_composite_dev'
> >
> > Introduced by commit
> >
> >   93c473948c58 ("usb: gadget: add WebUSB landing page support")
>
> J=C3=B3, can you send a follow-on patch to fix this issue please?
>
> thanks,
>
> greg k-h

I just posted a new version where I also merged in Andy Shevchenko's
patches against by patch.

Best regards,
J=C3=B3
