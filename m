Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116406AD14B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCFWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCFWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:16:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841555531
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:16:40 -0800 (PST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4933041B4B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678140998;
        bh=/Cz9JAODfWj9EecWtolAL46Y63zYaEN/sjObQ7ypGFc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FQJH7Y0yTRbvsG2vo5WYbAEZr3G1Cgy/icVDSNRXvr2SVSfIcvSAmIEKIaeppTRO1
         rXRoM6zNSmSrlsJSHNHYkYkFC70y+JBy82I4EcXcJMbMEJWfFX+lKw4XUPY8Aq3Hpx
         X92Q18TcmAODs+AwpbLrBXGuIHYHhUX/dRU5ZM3ehWn/WOUFhmYuN2KnvxoZGfnFn+
         BpiScDeSLFT4PSf9aX3ez1zk73qIoHMrfUNGvNBB3MQAHslNvkBydF1RtKqrTb8NoX
         OfDgeAzHcwVVu3NGQtmH8G/WEnXnOUd7oJEyexLe9fLnW0hObsqNI9o76KKEyy7YF5
         aC21oqm4w4D6g==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-536cad819c7so115865957b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cz9JAODfWj9EecWtolAL46Y63zYaEN/sjObQ7ypGFc=;
        b=X4FXQhYt0oQTCqR/WXN5wC90YLiaTZt051qz3/xTr13x+fZtEMAPLtKbU+vVyB80U2
         YecGQnl8ugmZpSho/Yu6Hl0BSzil8deedVojKYtwqub++CZJ54Rqwn489BIgvnq+6UZJ
         /1pNahk9wUGHqPo2SVTL5eZC4ATeoXImhRCgohrRxq1yyQE2DPE9LlphWDdrCpmI1hTq
         QBPRtNKGVQ+nY5C16zwzUIHFm1UUnzyQuT7NA24DwKfui50E7sOAvsCMS2DdJATaNtnA
         MLb6dahNgmWFAVCwk3JuwUdelxeYO+Zg0tx3nSi6Yc0Rro9GksczBA6PxcKI1gPaubRf
         pJVQ==
X-Gm-Message-State: AO0yUKVJxKtkeJgi80gjzoYcsJ5HOG71X7KgpcHBXRjGVc5CIgMmrE6f
        z1ZG19l5wqtgG5pEPgoTh/X1NvuWehz64V/v8AvLNHqbOGWBse65CQXcRhlrmOZYZrEwUUSVnUa
        6C8AYKlCz2cxAGB1IpjnmmJQ/KUMrHwm4W19F8N+cFB24kG8IDJVSmgy6fw==
X-Received: by 2002:a81:ae4e:0:b0:52f:3399:ed08 with SMTP id g14-20020a81ae4e000000b0052f3399ed08mr7452414ywk.6.1678140996996;
        Mon, 06 Mar 2023 14:16:36 -0800 (PST)
X-Google-Smtp-Source: AK7set91uXjC5HOEE11UD3MtHxIaPsn5S5dDIxuq8BliPL2DtF/t9vW9Yo+mNYAjmS4pwxFY8g9CJl8okjO0C2kEqns=
X-Received: by 2002:a81:ae4e:0:b0:52f:3399:ed08 with SMTP id
 g14-20020a81ae4e000000b0052f3399ed08mr7452400ywk.6.1678140996747; Mon, 06 Mar
 2023 14:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegvQyD-+EL2DdVWmyKF8odYWj4kAONyRf6VH_h4JCTu=vg@mail.gmail.com>
 <CAEivzxdX28JhA+DY92nTGn56kmMgdeT9WX__j7NU3QHpg+wcdQ@mail.gmail.com>
 <CAJfpeguYO9J=np5vxH+HjCSAxn=8fcQRhh_-BVadTt86zWfkpQ@mail.gmail.com> <d20393b4-017e-19f1-b49a-452a6f3acdc8@ddn.com>
In-Reply-To: <d20393b4-017e-19f1-b49a-452a6f3acdc8@ddn.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 6 Mar 2023 23:16:25 +0100
Message-ID: <CAEivzxdWe_gC0L0-Ui4fdytLecCEaknz4+CPTaLUgdaYhbhjhA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "flyingpeng@tencent.com" <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 10:05=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
>
> On 3/6/23 20:18, Miklos Szeredi wrote:
> > On Mon, 6 Mar 2023 at 17:44, Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> >>
> >> On Mon, Mar 6, 2023 at 5:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> >
> >>> Apparently all of the added mechanisms (REINIT, BM_REVAL, conn_gen)
> >>> are crash recovery related, and not useful for C/R.  Why is this bein=
g
> >>> advertised as a precursor for CRIU support?
> >>
> >> It's because I'm doing this with CRIU in mind too, I think it's a good
> >> way to make a universal interface
> >> which can address not only the recovery case but also the C/R, cause
> >> in some sense it's a close problem.
> >
> > That's what I'm wondering about...
> >
> > Crash recovery is about restoring (or at least regenerating) state in
> > the userspace server.
> >
> > In CRIU restoring the state of the userspace server is a solved
> > problem, the issue is restoring state in the kernel part of fuse.  In
> > a sense it's the exact opposite problem that crash recovery is doing.

I can't argue, you're right. In the "recover" case we don't care about user=
space
state, we just want to forget everything in the kernel but only keep
mounts (someone may want to keep opened FDs too).
In the C/R case we want to recreate full userspace and kernel states.

These are different problems, but in some parts they require the same UAPIs=
.
I think I need to write a detailed motivation for the CRIU part in the
-v2 cover letter, so we can discuss it. What do you think?

> >
> >> But of course, Checkpoint/Restore is a way more trickier. But before
> >> doing all the work with CRIU PoC,
> >> I wanted to consult with you and folks if there are any serious
> >> objections to this interface/feature or, conversely,
> >> if there is someone else who is interested in it.
> >>
> >> Now about interfaces REINIT, BM_REVAL.
> >>
> >> I think it will be useful for CRIU case, but probably I need to extend
> >> it a little bit, as I mentioned earlier in the cover letter:
> >>>> * "fake" daemon has to reply to FUSE_INIT request from the kernel an=
d initialize fuse connection somehow.
> >>>> This setup can be not consistent with the original daemon (protocol =
version, daemon capabilities/settings
> >>>> like no_open, no_flush, readahead, and so on).
> >>
> >> So, after the "fake" demon has done its job during CRIU restore, we
> >> need to replace it with the actual demon from
> >> the dumpee tree and performing REINIT looks like a sanner way.
> >
> > I don't get it.  How does REINIT help with switching to the real daemon=
?
>
> The way I read the patches, the new daemon sends FUSE_INIT to advertise
> all of its features.

Yes, thanks, Bernd!

Theoretically, we can implement some basic C/R without using reinit.
It was my first idea and I've described it in my LPC 2022 talk,
but this approach is not fully safe and universal because CRIU fake
daemon will implement a particular fuse protocol version (and define a
particular set on fuse ops/features),
but the dumpee fuse daemon can use a different set of fuse ops and
fuse protocol version. So, changing fuse daemon fully transparently to
the kernel is not fully safe.

Thank you guys for your attention to this!

Kind regards,
Alex
