Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DE660A40
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjAFX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjAFX0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:26:51 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C04E714B8;
        Fri,  6 Jan 2023 15:26:50 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4bf16baa865so41205037b3.13;
        Fri, 06 Jan 2023 15:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzMwwdZY3oMiVjSJDQ9I4Kl9NTgscPHXL13NH+00AiY=;
        b=BudRq+yLdzWdBk7w1nfo7PylN5GTI3Zfl0fUXhAujRwr2KAocfV77UMVbP/+4hmPWX
         Wf8hbTI5KS1OT6z5JQQ2IMoITWVziOSwqPqgzGwo8NhbILROPxiShRf8h2rC8+RrbZEF
         hyCmUtTIRuw77C0EMsQ+LucO/bNBdTK2f0JyKL+zahTXtAJ6SVGKbe2vS5+ZLTGCrYD+
         0MiOYFdAR6vFdyAvlJpfzKYIu48QHgVi8uzBX3klEKmxn8l8VJLx1X/HHN91ydI7doYi
         Dnhw+/nDRYEpoqL7cJ7G9+YWBN997DTZBYO8kjLYiorRdmTHD1HMkqFuDEZQFfqN4oVL
         8bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzMwwdZY3oMiVjSJDQ9I4Kl9NTgscPHXL13NH+00AiY=;
        b=rhn6TOz9j6reRgkpIlDMWI9IT6oHU6CC6vRMxYQIiNcGPQskyiZ7kcoEgcOY/houVR
         cepmxMT8JFhVY7s9ty694Ej3poTW15hK5DNd3HE5T581vhpZWbBe3kLo+EDdqGCT9b9Q
         4IVK3V24rp70lmbUmOG1QpkIgZ1Tj65+eNwbs0LQrFYqi5enL1TGdlVo5FcX++lWOBiS
         PXKlyl9IhnkEDLgqNksMzjStCeG/12vi14u8AeUKZ8UYrPqYb6jTe5cCNjkkXxNDxsMl
         P8GP0ryg/SxuY7pRBh5wthBhBGJyxw+gQG4Uhfyk5foxSbiHEyRJUeK+v33fxEqdjIPI
         uawQ==
X-Gm-Message-State: AFqh2kp2bFZ0V1SNQtiYCHJGH6KslKWsZWxazUT6gC6PkjGi9n292FHC
        vlRIY83vQ5Dkuf+R8v35cN4xsXMGcAczDNzrQhVQnWP/iTSU2Yr1
X-Google-Smtp-Source: AMrXdXsjllksGM0DMnueHbPOmq+XMnr9w3tkvoLDythchnZrcP8JhfJVo/VMX2ztMrvycS+l+7qinbFNNC8qpghsPvc=
X-Received: by 2002:a0d:f601:0:b0:3d8:8c0e:6d48 with SMTP id
 g1-20020a0df601000000b003d88c0e6d48mr440064ywf.462.1673047609522; Fri, 06 Jan
 2023 15:26:49 -0800 (PST)
MIME-Version: 1.0
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic>
 <Y6r+UbfkXruwHU2v@zn.tnic> <76353487-736A-4470-AD31-77F47F8C08F6@me.com>
In-Reply-To: <76353487-736A-4470-AD31-77F47F8C08F6@me.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 00:26:38 +0100
Message-ID: <CANiq72mZ3d-W53o4iFryouRKkHkdyR=_qBWkMGm1aNd8Y9ZSnQ@mail.gmail.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
To:     Alexander Altman <alexanderaltman@me.com>
Cc:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
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

On Tue, Dec 27, 2022 at 9:31 PM Alexander Altman <alexanderaltman@me.com> w=
rote:
>
> One way to resolve this temporarily would be to add the following line ab=
ove
> the offending struct:
> /// <div rustbindgen hide></div>
> This will cause bindgen to ignore the struct entirely and not translate i=
t.  If it=E2=80=99s
> actually needed for Rust code, now or later, then we can=E2=80=99t do tha=
t and need
> to actually replace it with something translatable, or else leave it hidd=
en and
> manually create its translation on the Rust side.  For the latter, just u=
sing a
> u32 for the entire bitfield-containing union would be sufficient.

Thanks a lot Alexander for taking a look!

This is https://github.com/rust-lang/rust-bindgen/issues/2179.

What we do for constructs that `bindgen` cannot map is to add the
appropriate parameter/line in `rust/bindgen_parameters`. We hit a
similar case for `x86_msi_data` that you can see in that file. So
please feel free to add it there.

If we end up needing to access it from the Rust side, another
alternative is to write a C function that performs the required
operation on it that then the Rust side calls.

Cheers,
Miguel
