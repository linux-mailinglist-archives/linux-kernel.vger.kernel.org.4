Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F0644A94
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLFRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLFRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:47:00 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947036C7C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:47:00 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m5so6528651qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qz9eWRKuOMkZyY7yCLP4bfB61B8iFWuAmg5J5O6xxbc=;
        b=CX81Miey0t51ao24TZ2oOyZuH0V16FdY5dDo88+POfGyM2FUYIa38h4SZ87A0oq/mb
         ahHAJTbeomoIOgfljUzZM9vdalqOoeQFtbDFEqi+3ziLqqgbk8fnrvy7Hxv3H4/b6Mjg
         vq9Vge90X+ZXPr9RFnAxglnCja4Ydm3Z2UtAG2QJskra1CBNO5nX8Tm+zfU1jvg2JGv3
         Vgv5hFA0lyHLshRwiF1Crbl6oh5oQ8eBrp5wVlGy9NZkVwtnvvujufvXuUgfLmhHNm7X
         QQU8YPudhpMIKMbwQ2SwCBpugZyuGwiMJ0YXxgS8olZ3aWrN2xNgZThWC2Si0yKEu423
         PBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qz9eWRKuOMkZyY7yCLP4bfB61B8iFWuAmg5J5O6xxbc=;
        b=IYCkREGT+aSwYK6WvGPQejLRNX2zuVaOoVwI0FUfDzQx7j+FOwuyv6N6m6b26fYoYf
         57pXqkl6vqGZ7vIBwnHTjJMdy8jmkDLXpCBTXBwvkrGlQqeLPBPQzDrR8qSJm3CfbxvW
         mgKRAzAHAzNzrCP89HKA6Ngv47/ONEbDobXoE1l69sVQG8FUCQN/SVpWUAxTA1//NCjW
         7HxVzoV37QSXmsRwrP3LIzO2E3BLJLI/sH9aKKfhk3YAcsGccD/y0sBxe8pc7qqIQvBN
         2+3m5MN0c4BtQB+KMT6u359hhd8X4vZK7rjClm7v7C/JFwKQy5Sc/J9Ybv8gj0oL1R+A
         rtOg==
X-Gm-Message-State: ANoB5pm8AbgXQ5DhrUMaDKRWVan8lgVy+Lyw5fkQEPQTQSClTDuR1xhO
        jeCQsa65Gw6Qr10oTpbeGMHFNw==
X-Google-Smtp-Source: AA0mqf7Msy5LM0t0T4y/zIJ7du4drst1jlBhVBLU7EVYPos606MNc5wjXVQHWrhFLoSgMsVtwkw5PQ==
X-Received: by 2002:a05:620a:ed2:b0:6fb:c26:608c with SMTP id x18-20020a05620a0ed200b006fb0c26608cmr78390519qkm.307.1670348819315;
        Tue, 06 Dec 2022 09:46:59 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b006f8665f483fsm15939628qko.85.2022.12.06.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:46:58 -0800 (PST)
Message-ID: <3c3a7b0c053c5366be4ad0c4a9a3bd205aaea731.camel@ndufresne.ca>
Subject: Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_HEADERS_ONLY flag
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 06 Dec 2022 12:46:57 -0500
In-Reply-To: <34d5c5d7-cedd-a12c-557b-33274f62cf70@xs4all.nl>
References: <20220712093754.23370-1-ming.qian@nxp.com>
         <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
         <35256805b1ce0b2b7533f53f658c799a37255469.camel@ndufresne.ca>
         <34d5c5d7-cedd-a12c-557b-33274f62cf70@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 06 d=C3=A9cembre 2022 =C3=A0 10:05 +0100, Hans Verkuil a =C3=A9cri=
t=C2=A0:
> > For decoders, if a a decoder is in "separate mode", it seems that sendi=
ng
> > headers must happen this way. If this uses a separate path internally, =
the
> > kernel needs also to be aware which buffers are what (and we don't pars=
e in
> > the
> > kernel). In very basic case, the driver assume that the first buffer af=
ter
> > streamon is a header, but that prevents resolution changes without a
> > drain+flush, which android and chromeos folks seems to use. (I always d=
rain
> > and
> > flush for what I'm doing).
>=20
> OK, thank you for the explanation.
>=20
> So if this is going to be added, then existing drivers that use
> V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE have to be adapted to use the new fl=
ag
> as well.
>=20
> From what I can tell those are the mediatek vcodec, venus and s5p-mfc
> encoders.
> I suspect/hope that it won't be too difficult to add this new flag there.

The exercise will also be very informative for the reviewers, so yes, I wou=
ld
ask Ming to update all the drivers, though its fine to only compile test th=
is=20
and leave it to the maintainers to verify (at least that's my opinion). I d=
on't
see this change as a break, as any existing userspace will just ignore this=
, and
maybe managed to support it by deep parsing (which will keep working).
Otherwise, existing userspace using this mode have been broken for
renegotiation, and that change will not deteriorate (nor improve) the end
result.

Nicolas

>=20
> Regards,
>=20
> 	Hans

