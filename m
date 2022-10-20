Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F93606365
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJTOnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJTOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:42:59 -0400
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58169159974;
        Thu, 20 Oct 2022 07:42:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C8199C062D;
        Thu, 20 Oct 2022 10:42:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 09Qn1BFO0JbC; Thu, 20 Oct 2022 10:42:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id C28599C066D;
        Thu, 20 Oct 2022 10:42:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C28599C066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1666276970; bh=312VwPoO9EN6ems018dwBc7eHCw2XRv7lNPATT84L6U=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=pvZBKw1SMFL5/bl/2AFwJ3RcQpXpSgrd7hh7fQwalweyqDY5GcaltUVTpMwpvB8kI
         U3MbgW+y9CMCqSw2ZFZ7sP3byKy+eNqWzU4SWhFzS7KqKOhTShz+LbHtaf3EB3S4rk
         vGdyQZ8xeMek6EE5DbkCOtZJCawOCsuAcONJgDysEyJV/FbBLkb0CsQxL+xpP6/FO4
         iSd+xwMNNuFpZHygpNdOvk74RluD+OTA9lCzoSj8EGfAyH6Tzu3S3uAhGcwmOGCRai
         fCTvQJLhydWsno37T0nhwWAsY4rrJQRaXM84IecUhoDp8qRH2WDPXwAKjVtAMBohJq
         MwqGNeNtxYRnA==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5wD4LvTvv3NF; Thu, 20 Oct 2022 10:42:50 -0400 (EDT)
Received: from [192.168.48.98] (unknown [192.168.51.254])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 92AB79C062D;
        Thu, 20 Oct 2022 10:42:50 -0400 (EDT)
Message-ID: <0f29aa0297d6fc5daa86f81925754c1f6d3f679c.camel@savoirfairelinux.com>
Subject: Re: [PATCH] mmc: add TS7800 FPGA based MMC controller driver
From:   firas ashkar <firas.ashkar@savoirfairelinux.com>
To:     Arnd Bergmann <arnd@arndb.de>, alex@digriz.org.uk,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Oct 2022 10:42:50 -0400
In-Reply-To: <a577dfcf-5a0a-4568-8f6d-872a8324dfcc@app.fastmail.com>
References: <20221018133800.10636-1-firas.ashkar@savoirfairelinux.com>
         <a577dfcf-5a0a-4568-8f6d-872a8324dfcc@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thank you for the comments, pls check below for replies and acks=20
--=20
Firas Ashkar
Developpeur Syst=C3=A8me Embarqu=C3=A9

savoirfairelinux.com | Montr=C3=A9al, Qu=C3=A9bec

T=C3=A9l.: +1 514 276 5468 ext. 118


On Tue, 2022-10-18 at 21:06 +0200, Arnd Bergmann wrote:
> On Tue, Oct 18, 2022, at 15:38, Firas Ashkar wrote:
> > add standard mmc/host controller driver for TS-7800v1, instead of
> > the
> > original block based 'tssdcore' driver provided by EmbeddedTS
> > linux-2.6.x
> > code base.
>=20
> I'm looking at this driver since Marc pointed me to your
> work on the platform and I noticed this post as well.
> Not doing a full review, but I'm still pointing out a few
> issue that caught my eye.
>=20
> > +
> > +#define DRIVER_NAME "ts7800v1_sdmmc"
>=20
> Maybe drop this macro and just use the string directly.
This define macro used in multiple locations
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR_OR_NULL(pslot->rw=
_dma_buf)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s|%=
d - Error, No allocated DMA read
> > buffer %ld\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __fun=
c__, __LINE__, PTR_ERR(pslot-
> > >rw_dma_buf));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*data_error =3D ret =3D -ENOMEM;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto done;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dat0_sent_crc16_buf =3D kzal=
loc(sizeof(u16), GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR_OR_NULL(dat0_sent=
_crc16_buf)) {
>=20
> You should never need IS_ERR_OR_NULL, as all interfaces
> in the kernel are supposed to either return an error code
> or return NULL on error. Please fix the error handling
> for this throughout the driver.
ack
>=20
> > + spin_lock_bh(&ts_sdmmc_host->bh_lock);
>=20
> I'm a bit confused by your locking. Why do you use
> spin_lock_bh() instead of a normal spin_lock() or
> a spin_lock_irq()? I don't see any use of softirqs
> (typically tasklets and timers) in this driver, so
> disabling softirqs in the critical section should
> not change anything.
ack
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
