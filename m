Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060E6A4178
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjB0MKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0MKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:10:52 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57B1F5D8;
        Mon, 27 Feb 2023 04:10:51 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536cb25982eso168525227b3.13;
        Mon, 27 Feb 2023 04:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRRq/5GQqxIc46hXGY4H3v6xxg8Hsy+ok80SpKG+jLE=;
        b=IqLxFFvAKgRN8+KOe0Ns1JOXwhb2buHwYp9c+qncSQMzrQbulS72XzKIUFednkliHe
         MY7myH4FU/xEW2Yvwz4SS1Vv2Qr7LXmdoqkr3layZBlu9vGd7J8FcegnujpoIKWwsZnG
         YpEV4jSm4JVg0lRxlzhEB9lbVPG7kjgRc4LG5Q8sXVtGdsoi6JGMJUfTX/SKTlAqwLp3
         HrGrILRs2P7B0PVpvihUIFc3bJeWa3CMvMDGwgtygYIQhA1/l19YsQRoe1ku+w95Yj5v
         JSEtOfCMXqZ2Z1Z/cTfYPz61A+sRWE0UETcnsHt2dqJ669JwkLU675rGlyycCJnmG5iw
         uKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRRq/5GQqxIc46hXGY4H3v6xxg8Hsy+ok80SpKG+jLE=;
        b=s/Pv4EWrjIF0tqNDwLbHBj+OQsk2j9lqiyuhW7qUV4wkNz3SvGB1aN6qIQgoV6FkAL
         bL5aB2Z+5Dg53KUpgSXKAgQ+XDYzZPXRcf8BrrtOyO+68oGzYjXCzjUQs1WB1GqZxL2e
         Y1BVQhWbuhSRjJdn/6mz98FzCFmLL94Exv2rAPg1zH7B8UYSe2TyN2pzxvOshvyzrieI
         L3DZs6DJccoqv+NxjLLkUB4a60LnnHIcqOZr0e+e3FdhWTeiRKEOgAvipgr3e4F0TowA
         Y33cyil+PkAwLK60rvQUScx6Bwv6KM5qXzilFj1+bbBMrh3vXTSPF2rQWEupiDm8x6JN
         nMOA==
X-Gm-Message-State: AO0yUKX+bGE2YGrDbILHEUISZ/Fu34kaIsrObJqFiDxZpgHVl6+gG8Id
        fdwb/W2JIytaTSRoTBApSunSD5UwbXDIeyYcaaU=
X-Google-Smtp-Source: AK7set97eDh3HLuNWh7xikVD1qnW++Lf0g7OIb1Adxk+AuKT0ePWwVzYCq74X4Mdj7MZsHvgV/ayLFmCjEX0qc+YMDA=
X-Received: by 2002:a81:af1b:0:b0:533:8080:16ee with SMTP id
 n27-20020a81af1b000000b00533808016eemr10118374ywh.10.1677499850891; Mon, 27
 Feb 2023 04:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net> <Y/lOlcSpc+d9ytq/@boqun-archlinux>
 <20230225222340.34d749ee.gary@garyguo.net> <Y/rCU1S+GDgIojNf@boqun-archlinux>
 <20230226133606.583cd1d8.gary@garyguo.net> <Y/uiAfZnfbbMrQuD@boqun-archlinux>
 <CANiq72kTiHF76T0AycM43qj4rUgQpHzBqXujdvk+H2qoDz22AQ@mail.gmail.com> <Y/vZdv6IVmrcP7wR@boqun-archlinux>
In-Reply-To: <Y/vZdv6IVmrcP7wR@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 27 Feb 2023 13:10:39 +0100
Message-ID: <CANiq72kHe+BD1ZXjDQD_vWrpx+nBfy8fkjhHa8fx=3Bpk+Uuug@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
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

On Sun, Feb 26, 2023 at 11:13=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> Interesting, sounds like a missing feature in `rustfmt` or maybe we
> don't use the correct config ;-)

It may be coming [1] (I haven't tested if that one would work for us),
but in general it is hard for `rustfmt` because the contents are not
necessarily valid Rust code.

[1] https://github.com/rust-lang/rustfmt/pull/5538

> "Yeah" means they have different behaviors, right? ;-)

Yes, sorry for the confusion :)

> Thanks for finding an example! Means we did use return.
>
> For this particular API, I'd say function right now, `try` blocks if
> avaiable.

Do you mean going with the closure for the time being and `try` blocks
when they become stable? Yeah, I think that is a fair approach.

Cheers,
Miguel
