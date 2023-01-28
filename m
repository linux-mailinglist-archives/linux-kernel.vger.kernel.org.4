Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86767F77B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjA1LNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjA1LNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:13:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8347786AA;
        Sat, 28 Jan 2023 03:13:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y11so6863470edd.6;
        Sat, 28 Jan 2023 03:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BALqKCNimh6YexUKOLQ9itGrp3FI+4x53rzz3lKq88M=;
        b=LliQ4YnnUPyg/7negszK/VFXlZACFbwla8P4Y3veCmnA+zB7N+6yCV9tquKe4Do33O
         09Kv+zFjKOLLb8NhXCFInK3pJAAG7P8x7P27OsyYH78hdq3oNReNm/eGbW8mxTVvy6ca
         U5KuKGnpIotOV2MSRPD/X+X82oEYtYwQRh2zEAkwdR9pspR1gH/WrKdKrYylRfH7DCa9
         V3YQm/y9PxgIkgOFXwHfYe1hINleD05ZM8xcYvKOz9SqVh6e+Rw0RsEr4fabBTQPfJen
         GmiDFMIRVKDC/iDwUuJvpPMwlRXeThO0p/qZ87mOz9HLN0GAvxauqTRRH0Dqz+HgGv5W
         VSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BALqKCNimh6YexUKOLQ9itGrp3FI+4x53rzz3lKq88M=;
        b=33BSPj1Aww+UFiT7cZFYH4wH3F6oEmyllm4dCD/NeAZQD6PJyLt+1CES8Gc11W10CF
         nLiO0pQxdGuUDeD5Pdunp79PtxVlSm3rIicwc9ZWouJXt8Bx4jLeeLf/qMjHiscfA3SS
         QSF2tEewB6W2KNoBFwTQIKkbWGfsARFk9KobUUyX/El7p7LPUZL7EGfxREv8nMIaSE8H
         ZbKpyl9cxE+5PGR8t/pYqu/UprtYk2xqvZVXf/q+YBp7KGyyjRAhqFArhJmA7NSt24xV
         PgB3ltHLbPVa9sLdDL1PNrzyOdUICpl8chzc3vUH3leQIItSeoAyQ4Hb5r4Do2f+2XzD
         ob3Q==
X-Gm-Message-State: AFqh2ko7ZXLsahLm4OwbLrJQJUDpt6XUAeutvS5/jJ/JObZvFljrhkOA
        BZvOvrWxm8t3u5aNOt2p58Y=
X-Google-Smtp-Source: AMrXdXucALAEHgAxBNt30XmS9jYljPYEQr0Vfl5gnrZRtGZGBafUAVNWq/wKyGbpsLQV6g0S9vLHTw==
X-Received: by 2002:aa7:cac2:0:b0:497:948b:e8 with SMTP id l2-20020aa7cac2000000b00497948b00e8mr40411353edt.6.1674904393085;
        Sat, 28 Jan 2023 03:13:13 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id w11-20020a50fa8b000000b0049e09105705sm3719103edr.62.2023.01.28.03.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 03:13:12 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 12:13:10 +0100
Message-Id: <CQ3S1YW1TFJ0.KGRDY0XZGSL4@vincent>
Subject: Re: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the
 unit type
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
        "Gary Guo" <gary@garyguo.net>
Cc:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20230119174036.64046-1-wedsonaf@gmail.com>
 <20230119174036.64046-4-wedsonaf@gmail.com>
 <20230127140319.22af6060.gary@garyguo.net>
 <CANiq72kXNvQ-GY-uw24s_1NmQ5G12Cu+JfYKFQ0rC-4Fnm8o8Q@mail.gmail.com>
In-Reply-To: <CANiq72kXNvQ-GY-uw24s_1NmQ5G12Cu+JfYKFQ0rC-4Fnm8o8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jan 27, 2023 at 3:11 PM CET, Miguel Ojeda wrote:
> On Fri, Jan 27, 2023 at 3:03 PM Gary Guo <gary@garyguo.net> wrote:
> >
> > this should really be `core::ptr::invalid(1)`. That's currently
> > unstable, but can be equivalently written as
> > `NonNull::<()>::dangling().as_ptr()`.
> >
> > This has a different semantic meaning from `as` since it explicitly
> > suggests an invalid provenance and thus will not alias with other
> > pointers. (Although I don't think compiler currently can take advantage
> > of this fact yet)
>
> We talked about starting to use `strict_provenance` when it came out
> -- what is the latest status? i.e. do you know if it is expected that
> it will pass FCP etc.? (my understanding originally was that it was an
> experiment).
From what I remember the feeling was positing into hace `strict_provenance`

Here is the last meeting  that was back in August =20
https://rust-lang.zulipchat.com/#narrow/stream/213817-t-lang/topic/Stabiliz=
ing.20strict.20provenance.20APIs.3F

I guess, we could just put a fix me around the actual code, I feel that the=
 Gary change deserve a=20
own patch with the own description.

Cheers!

Vincent.
