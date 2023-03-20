Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4295E6C1D26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjCTRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjCTRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:03:32 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A94522CBB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:57:48 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so9587418wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679331322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4MAFHvhcmlrcPH3sYssVqROTTKEF34EPFaIHEWRMl4=;
        b=NTGXwBhvJeTgfd6rP8NYN1icgUYjkP4zDOPKyCaMSseKC1tPKPYVDimg7zgu6KBrKo
         eu/S1Vy4KBvpVEgcmOM3ZPJ9KPN9yHyUmsSIZG4PG/9dU9QmPloOU29G2KC6kalhP7Lp
         +nU6DQf3Nx7ErnPG2HnqU/ahcLkSvMHFYP2EFEQqxAKD6pm+cfkPG6d2jGSn1ppbphWN
         GPLI86c1j0WI1wPU0OFIJNsdfnc/hG8JKiZW68U8heqFeuofRAu4prGTMcIAQxCgNXFG
         RxW29d0hDtfCgj7IGqhGEwvjP8NVZUREmad0moR3td//YQ/dEC2VWFOAFEKeufJ5Y7tZ
         rqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4MAFHvhcmlrcPH3sYssVqROTTKEF34EPFaIHEWRMl4=;
        b=i9WAu4Dom1w1Yx+l7QgU+IYBc1k7dyUmXrruvwQEAz+3s51U+BhGKZIXtlqHayXKJv
         mPs/tLVoyA8PYv2YLittmJdbXCGFnwIlI8NdN5Yws9gxsQh3UvBZUz1JgKLWtik3xlyP
         GcaT4HByZ2UlwnVpUign5aBpj0DYVQv6NKkdMTLFUK1MwfltYig/hRDmat2g8EjdBfgE
         6omdqm/jPhmn9FcQjXZM0oRYrCSTp/NmaRgVYvT5ThWvko4QRNTDpXABq0Lmw8UG78M2
         w4zyjwJViIAN2aSzpHSUuyzfZdblzOf8YQTfuwJU6WEsWWpj2iZ9s40V28L57utBckvC
         OV4w==
X-Gm-Message-State: AO0yUKVSV6p7PgsNQtzIZqTZ9AWcv+PGcviiRhnSxh758CHOjboPk/zm
        xWlkZman6iwY6ur5/bi0V9A=
X-Google-Smtp-Source: AK7set9cBmFURZEUYI/v690q27dcZcgNTxzCflXP/W4l3GRqoCXnwbyobFD7bDdfZ0J0HMUtxzkVng==
X-Received: by 2002:a05:600c:214:b0:3e2:1368:e3a0 with SMTP id 20-20020a05600c021400b003e21368e3a0mr186323wmi.18.1679331321937;
        Mon, 20 Mar 2023 09:55:21 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003e9ded91c27sm17438247wms.4.2023.03.20.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:55:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Date:   Mon, 20 Mar 2023 17:55:20 +0100
Message-ID: <3648719.TKLx3GfHUD@suse>
In-Reply-To: <ZBhvU/USP0es8e4P@khadija-virtual-machine>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine> <3180435.l52yBJDM9G@suse>
 <ZBhvU/USP0es8e4P@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 20 marzo 2023 15:36:03 CET Khadija Kamran wrote:
> On Mon, Mar 20, 2023 at 02:38:24PM +0100, Fabio M. De Francesco wrote:
> > On luned=EC 20 marzo 2023 07:34:04 CET Khadija Kamran wrote:
> > > On Fri, Mar 17, 2023 at 11:29:25AM +0100, Fabio M. De Francesco wrote:
> > > > Khadija,
> > > >=20
> > > > Congratulations for having your first patch in Linux, via Greg's=20
staging
> > > > tree.
> > > >=20
> > > > It will take some time before it reaches mainline, although it is
> > > > already on its way to get upstream.
> > >=20
> > > [snip]
> > >
> > I'm confused by this statement. Can you please rephrase?
> >=20
> > > Am I getting it right?
> >=20
> > Not sure, it depends on what you meant with the previous phrase.
>=20
> As you said above that the commit message makes the reader miss the
> permission details, so should we write more about permissions in the
> description?

No. Greg took your patch as is.
No new versions for patches that Maintainers (i.e., Greg Kroah-Hartman for=
=20
drivers/staging and several other subsystems and drivers) already applied.

We've been discussing this topic after Greg had already taken your patch on=
ly=20
for the purpose to clarify to you why he suggested a better commit message.=
=20
However, he suggested that better message while stating that he prefers to=
=20
take your patch as is to give you time to work on something new.

I suppose that you received the two automated messages, the first which=20
communicates that your patch has been applied to his staging-test tree and =
the=20
second which says that it has moved forward to the next step, which is the=
=20
staging-next tree. I saw those messages in Cc because I put my "Reviewed-by=
"=20
tag to your patch, so I know you had them.

=46abio

P.S.: Today I sent you an off-list message. Please locate it and reply.

> > > Thank you!
> > >=20
> > > Regards,
> > > Khadija
> >=20
> > You're welcome!
> >=20
> > So, thanks for working on this patch as long as it takes to get it done.
> >=20
> > I think the lesson to be learned is that in our community there are=20
barriers
> > to the entry of substandard products and therefore people have to do th=
eir
> > best if they really want to see their work applied.
>=20
> Yes, you are right. Due to this reason, the whole process is making me
> learn a lot. I am really glad to be a part of it ^-^
>=20
> > These tasks are not for the "faints of heart" :-)
> >=20
> > Fabio
>=20
> Regards,
> Khadija :)




