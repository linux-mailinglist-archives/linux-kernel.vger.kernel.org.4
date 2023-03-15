Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE36BBFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCOWfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCOWf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:35:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBF17CFE;
        Wed, 15 Mar 2023 15:35:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id br6so8026131lfb.11;
        Wed, 15 Mar 2023 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678919726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBQi+5dIqeDwFMprehG3XMTRCEtSR7cljAPsT8mERhk=;
        b=YCJc6deBGJJ0Y+WxJydUOrby+y1BUvA6LG5OzvLuJnMngDsMna+5JWeRXS9rr5wFkW
         b2JjY9DitehAG7pqFeA26E2wM2yjQIBncu0M9cqP1ZMF3DfIcPJUBCGNxtchK+Tudrc5
         0aF5Ndk9D6SB9R1ROSTFhrarCLDupMNfBSU3GElbRNx8v5Z+j6fssqU24N50tPZqN1AO
         D85YKcV8XZqTLabmrDK0JFgMTVmtg+BtZmOnM3Q9IBI+cA/KWHok2Pr+Xl6tz9q6Lk4m
         OaHBnvZ/FDNlbuwayCr9ishQU0452978OTzo5hmEk96X45E5edUUoY4N6cRNRHA9BXfk
         TqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678919726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBQi+5dIqeDwFMprehG3XMTRCEtSR7cljAPsT8mERhk=;
        b=PFPN16n27MeEbn2zFTPcDksbnNKGQ4fbQyIzrmjEBMJPCGEgBtbBQS71krJNRmGDSY
         KwH4gv/dSeB2gv2YJMHhMnIX7VAG3t6Q9yu9eq4EWn/yZ6GXNwAeGDi3W9SXyxjUtnQb
         nD9QcUPTr2c665pXh7v1TDs3acf1FnXbWqi/z5K2OahdHHQJEpHVNI2+HjeiZnE5cLmN
         tzRJGr31gFwM2LO0Sl8uyw89VjzQljiiNwbQGX0vuExaqvCUctEDy3A7FFVe5hCdbzMk
         EvpMHJfoPGL/UcUJ6BEbVvw/hcT3ciGYYctem+wlhBY/Wh6plPuNGiGTDB5yj7D1hQ9w
         k0sg==
X-Gm-Message-State: AO0yUKUmS3VcnckkIBeNDQUpoXAya/R6ox+kXn+pdJ7udqZBZl3HSitD
        4RtUeBJpTW7MFoHcZRGgfAE=
X-Google-Smtp-Source: AK7set+NlbH77yCQNdZ8cQG/2ZLDYZrC5HNJPl6aMu2YmKjuOC6m/7SKRDYPZQ7NSWveOqb0a16ZQg==
X-Received: by 2002:ac2:547b:0:b0:4ca:fac4:5a34 with SMTP id e27-20020ac2547b000000b004cafac45a34mr2376916lfn.61.1678919726067;
        Wed, 15 Mar 2023 15:35:26 -0700 (PDT)
Received: from localhost ([46.211.236.75])
        by smtp.gmail.com with ESMTPSA id t24-20020ac24c18000000b004cca1658a41sm963226lfq.300.2023.03.15.15.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:35:25 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:35:19 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Message-ID: <20230316003519.27224216@gmail.com>
In-Reply-To: <20230316001749.44e51d08@gmail.com>
References: <20230315210135.2155-1-pauk.denis@gmail.com>
        <20230315210135.2155-2-pauk.denis@gmail.com>
        <20230315233054.5ac21db0@gmail.com>
        <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
        <20230316000453.553bf6a8@gmail.com>
        <20230316001749.44e51d08@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 16 Mar 2023 00:17:49 +0200
Denis Pauk <pauk.denis@gmail.com> wrote:

> On Thu, 16 Mar 2023 00:04:53 +0200
> Denis Pauk <pauk.denis@gmail.com> wrote:
>=20
> > On Wed, 15 Mar 2023 14:58:24 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >  =20
> > > On 3/15/23 14:30, Denis Pauk wrote:   =20
> > > > On Wed, 15 Mar 2023 23:01:35 +0200
> > > > Denis Pauk <pauk.denis@gmail.com> wrote:
> > > >=20
> > > > Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
> > > >=20
> > > > Pro A520M-C II/CSM is also tested by Holger Kiehl
> > > > https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d4=
5-475c-963e-f5232a8b95@praktifix.dwd.de/
> > > >=20
> > > > Could it be applied as single patch or need to rebase over "Pro A52=
0M-C
> > > > II" patch?
> > > >      =20
> > > Sorry, I don't understand what you are trying to say. I just applied =
all
> > > patches in sequence as received, with no conflicts. Should I undo tha=
t ?
> > >=20
> > > Guenter
> > >    =20
> >=20
> > No, Thank you!
> >=20
> > I just like to mention that Holger Kiehl sent separate patch with
> > "Pro A520M-C II" support and it could create conflicts. I have found it=
 only
> > when I have sent my patches.
> >  =20
>=20
> I have rechecked repo and "Pro A520M-C II" is added twice after apply bot=
h of
> patches (my and from Holger Kiehl), could you please remove one of mentio=
n of
> it?

I have resent updated version of this patch without duplication of adding "=
Pro
A520M-C II",=20
https://patchwork.kernel.org/project/linux-hwmon/patch/20230315222702.1803-=
1-pauk.denis@gmail.com/

you could revert this patch and add apply new one, or fix this one.=20

Thank you!

Best regards,
 =C2=A0 =C2=A0 =C2=A0	Denis.
