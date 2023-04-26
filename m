Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF806EFC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjDZVEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjDZVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:04:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D971FCE;
        Wed, 26 Apr 2023 14:04:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4efd6e26585so6071359e87.1;
        Wed, 26 Apr 2023 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543076; x=1685135076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXn3Qe0ODKJu31q9zPWv7Wmykn21fz2cAXCa+pUXVoQ=;
        b=WnwgJNi1yxyfEGQQ7qnDBXMXxYlhc8kk5doJj1MFlZFUlWsGR2kSYlR5qtAwGj67XS
         d0bGeQ27Ipo9petOd1HfqmvSDBdeOziOKvuaG4EyeziQwGwwNPqQ75MCII+4xJ/67Vdc
         /h3jCMETSFWSoPzuDdYpmhY+XzZf3VpDCsIMKxPr7RJtsE4s3i+rzqSkWxePwPa/9Hsr
         ZD/ZlB/sS7YhP7CByBEAk5qBcTFNFYqLv047rh91xUGNDJ46Tr9WwgcIMJh4I6CXsLNA
         nyfL5tFLdk9apvjT6z02eHwBCjRYhCKJsjFFPa9c3b4EEMQDo/Y0yfiSAZqdUGPOsrGw
         ICVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543076; x=1685135076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXn3Qe0ODKJu31q9zPWv7Wmykn21fz2cAXCa+pUXVoQ=;
        b=Zqg6vrdE1wLlpE6bbsmckS9K5+oCVpRfe6vyhuwaU0IGiNkuh/ryWDyN8YjHluaDad
         p5hDH7Q9fcy3osS2YjiMDrndQ1JfJODoQGinHZ2ikSt//sEzDZBesi+bGPc6GyD8A6AF
         wfYe3yZYmiZUeu1SxHor/ltUEWdB61kKFWOz5RyE2NWXr8z4XCy8jIUDU+jefhfqHb02
         j8eyZaPm9YyRVirW+gjsfq9DLDLat8l2iB7n+9FZjCYhHUNNBXFT2QMdDgVTDtuuOEUP
         apVT3mHDYRj7PFri1ED1lygsr8rveIxSqhbKkJtjo/Wm7C3Px0zXBMuWzini1FFw40Q7
         UflA==
X-Gm-Message-State: AAQBX9ezNU6JVW99i5x3VFZfOgzW58SJ5e+fMyQvXonZTlAniW75tKp9
        fMxoh1K1yA8zI6BhVPhkvzYRu5eYALda8uKhzhxIpxBC6SONypXC
X-Google-Smtp-Source: AKy350bEaJOLX5xin8Kf5h/5gskz1USLtiV6Ugoxug3gasB+LEYv4sfOOeIFzjf0V7VqbXJzqiwVooke9iDP4Wnxa/4=
X-Received: by 2002:ac2:4904:0:b0:4ec:9e40:e445 with SMTP id
 n4-20020ac24904000000b004ec9e40e445mr6631940lfi.19.1682543076324; Wed, 26 Apr
 2023 14:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
 <20230426204923.16195-1-amiculas@cisco.com> <4b8e3c30-9626-dffd-0aff-4b5c650154ad@gmail.com>
In-Reply-To: <4b8e3c30-9626-dffd-0aff-4b5c650154ad@gmail.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 27 Apr 2023 00:04:24 +0300
Message-ID: <CAPDJoNuX17h0=F7VRP=-VODG1bcdCYZAD+WNSofvpWPwwvbxMg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: helpers: sort includes alphabetically in rust/helpers.c
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the format I see in https://docs.kernel.org/process/5.Posting.html#
```
Link: https://example.com/somewhere.html  optional-other-stuff
```
And looking briefly through the git log I see the simple `Link:
www.example.com` format.
But I'm happy to change this if needed, can you point me to the right forma=
t?

On Wed, Apr 26, 2023 at 11:57=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 4/26/23 17:49, Ariel Miculas wrote:
> > Sort the #include directives of rust/helpers.c alphabetically and add a
> > comment specifying this. The reason for this is to improve readability
> > and to be consistent with the other files with a similar approach withi=
n
> > 'rust/'.
> >
> > Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1003
> > Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> > ---
> > [...]
> Shouldn't the link use the `Link: <url> [1]` format? Otherwise LGTM.
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
