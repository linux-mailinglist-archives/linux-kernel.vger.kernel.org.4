Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD977187F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjEaRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEaRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:02:50 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005713E;
        Wed, 31 May 2023 10:02:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bad010e1e50so8639739276.1;
        Wed, 31 May 2023 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552567; x=1688144567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG1P2Nrcljeuk69DDeSeiYWvgO1FehBAcRPCmpA4UwQ=;
        b=KlobxtPFR6Ysp6yLDDnsHdfCA0ZYPKNHo639LUMZ8h+NKMw0AsLGQl9DxnfOQw3e2t
         TW2uqDVYIRr0NxB3TR0TLq4VHjzTZ0HR3uHJAGfjZExu4a5dorYiPmSUjUvuoFKU7z/J
         t//fDhFcLuZPmABgOLGTQKaVsua0XCepxrlXFzi9hpozGaqft4xdSGZ6aNannGoClQAB
         10vOsoWQAIYyMThwcBP4OrElZ1n05Ldic5W1Iih18/jNZlpIZAt0LTjSdhQyMZaapc4l
         ceK3f8R6DEoIA0bK3GiIKjUikG7cJQPIsFdzVl6Ic8HEGO1DP6TatppQRwHS3uRnj7Qx
         GLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552567; x=1688144567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG1P2Nrcljeuk69DDeSeiYWvgO1FehBAcRPCmpA4UwQ=;
        b=fI6v2Uf8bCiXDU+oDXgmvUnoku31ny2VfjvA7cuUz0SqHatHPZoqJPq+5SGdwrdpEj
         j1tEO+FOKVHJfd6fA9FDVARolWOVQjdEmzeC1iDm1qEcb5Hr4M084CGSgK/p6EvAmeYK
         7WCD0+GFIdiDpaz6mylIQaRZvDsPfe08ffG0GuiGCxFjab38MnZydYuTSvwhZNO1VvBL
         RRfJ2ytvGM/6zkgNdE8u18TuxTWhBTs4xe6E5Djb/tuzT+UXgz6Ed6qAA+XGR26iDhkx
         R1kx4bSQtbg1NMyPiT9VVC55OZ4JPcO22KtqT4RTKQYnzvpCbNlPN9EFS7hMsuZj7khA
         tcmg==
X-Gm-Message-State: AC+VfDxduygTsdLtxjELsJgOCy7HBaFpBMdlgtFH1ZrlzNDwPRgQ+yet
        wcHNQF2tF0k2pMrk4zYMprBpIdrjVtjFH3wJo4I=
X-Google-Smtp-Source: ACHHUZ4wotzWkEI82wv2kvB1VEZ7nfcFE3vwSgsGw2wq4N9wemD12VZl2B9p3aWRiZZKlqFF5jUFl1vMDSV2L10Ic7Y=
X-Received: by 2002:a25:1982:0:b0:ba8:313c:6bec with SMTP id
 124-20020a251982000000b00ba8313c6becmr6517049ybz.0.1685552566699; Wed, 31 May
 2023 10:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-4-ojeda@kernel.org> <20230419030243.540348-1-yakoyoku@gmail.com>
In-Reply-To: <20230419030243.540348-1-yakoyoku@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:02:35 +0200
Message-ID: <CANiq72knVpyaKdT2iwrBNYorAt3Y5M-r6pXHc9JAZRCVmBYusQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.68.2
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gyakovlev@gentoo.org, jan.steffens@gmail.com, jistone@redhat.com,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        william.brown@suse.com
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

On Wed, Apr 19, 2023 at 5:02=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Kinda bunch to review, although may I ask if each time the `alloc`
> crate is updated is worth to mention the changes upon it [1], can be
> skipped otherwise.
>
> Link: https://github.com/rust-lang/rust/commits/master/library/alloc [1]

That could be nice if we could give a link similar to, say, what:

    git log 1.62.0..1.68.2 -- library/alloc/src/

produces (or perhaps a list of PRs) -- is it possible to do so with a
GitHub URL? If so, please let me know!

Cheers,
Miguel
