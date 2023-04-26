Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE686EF9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjDZR4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDZR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:56:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C04EF5;
        Wed, 26 Apr 2023 10:56:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fb8a8a597so89158327b3.0;
        Wed, 26 Apr 2023 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682531761; x=1685123761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNnFeQsCpLxS8BWhDUFhfQgFVbVpcjM4oqjjdFxwN7g=;
        b=hUS52wWcuyYhQ2sYsB1elyCiRL5WnwDSjRZdypEG8+lsAsMH0xB/VPibZwzEGP1tnK
         ufsAeF3GUkg6a9PXxHX+aSVoZGOybH6tqXhUiz7j0/N7MJLy16k6Mls+u70qtS/Ju2IN
         t4aQe/LSPVrtz27GGSofwEyfDQpt0sK8HKf1Ocs9eF/YcsrV1q52hnymodVSoRvu/+JR
         qfmFNLYlAQVInFONl1np/ZpFGEGfDB80ERIviInRbJ+d2Xx+MdfWWua+Jo3rPsQg/dxj
         gthgKJ8T6A6//1A4/c+muHl/9gWhzVgQPkKfgwmQPyeaz2mtwAvOS+ZmcAkWNLGHADFq
         RmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531761; x=1685123761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNnFeQsCpLxS8BWhDUFhfQgFVbVpcjM4oqjjdFxwN7g=;
        b=DBQOh1w9rNY56f89DvPNyRE9FLJDvyxczBxojTr4dkMfQ3mum0u5j9W8xYI24Wbcyu
         biHX8uVT+qxvXTKHTlywPSd2OvIBSt8b73FFfLuLllRrJQlVbG6WNbMnFB8IgXloXgc7
         ZIqG7O9lJL+yhaclZ7txsFZLophXtFlNR03rBpJqQfZ49XXbdjYSP8s1mWnq7MY0953l
         olg9kKehBrlWOqL6Tjxc1nRs/CkE0Z9d/nsqUSMspgUH4+uMbPOcieiCY5QMEc2jBykp
         W3kwlShc4JZ/dWEWObNd5EL7yvqFTryGY/Ee1SwQb545Hd0MMoakWrlJpkw7p2hTeFCl
         kjQA==
X-Gm-Message-State: AAQBX9f5bCqNZYFaWt7Rdo+nf7sEZBGLRNsfOuAWrjCU3Xr+2SS9STDb
        UHgy94LqJYe4A0wCAlNz5hLcOhkeXncBN1KxHAk=
X-Google-Smtp-Source: AKy350bMaZOhtxUuPaoTkMfU9W5kpbDAZdv0hnpL0C8l3iRJH97GTQOubU51xDiVDprmSc60a5CGJV+tzKnC1i2SkTk=
X-Received: by 2002:a81:9195:0:b0:555:cd89:cc50 with SMTP id
 i143-20020a819195000000b00555cd89cc50mr14033716ywg.29.1682531761421; Wed, 26
 Apr 2023 10:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72kXa-SgRiVhvjU7X4fa8XSJB4po9xf_V4L6Gn2o+t6T+Q@mail.gmail.com>
 <20230426081715.40834-1-amiculas@cisco.com>
In-Reply-To: <20230426081715.40834-1-amiculas@cisco.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 19:55:50 +0200
Message-ID: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Sort rust/helpers.c's #include directives
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
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

On Wed, Apr 26, 2023 at 10:18=E2=80=AFAM Ariel Miculas <amiculas@cisco.com>=
 wrote:
>
> Sort the #include directives of rust/helpers.c alphabetically and add a
> comment specifying this.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1003
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>

Looks better, and the content is fine!

A few minor notes and tips:

  - Please annotate the version of the series when you resubmit a
patch series, e.g. v2, v3, etc. `git-format-patch` can do this for you
via e.g. `-v2`.

  - Typically the title would be prefixed like "rust: helpers: sort
includes". In general, try to take a look at a subsystem's pattern for
similar commits.

  - The description should also give the rationale for the change,
i.e. the "why" and the "what". This one, for instance, could say that
this is done to improve readability and to be consistent with the
other files with a similar approach within `rust/`.

I can fix these on my side if you prefer, but it may be good practice
if you want to send a quick new version.

Thanks!

Cheers,
Miguel
