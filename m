Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56A6A71F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCARSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCARSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:18:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0DD520;
        Wed,  1 Mar 2023 09:18:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so13999300wrh.9;
        Wed, 01 Mar 2023 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677691083;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF8WidGUgZdClTE2SxFTHM5D5u9SZH0JpiUiTRv3sNE=;
        b=CaPSr0tYYn7bLfrrnDMhuvFBzPCZ6oFOM1Rt7jwvJOJuTRXWQPcJ2jVGWzmUOJsbpN
         3e0nN/GU3hbEE/OF6JecTzHyCIdzXoF0nK2sVoOVDQjJrVWDnUkdLVAkIVgBxxnR3JRQ
         4h2efryVweiLEZdRtzi1vOHnrpsg8mUxazvbzJdT5pRj99y+zK39xTiHYELTn7XEwx2d
         3OU9BMfdWrHUwye0AekCVcSeNLOUWo5V7AYCceRbAVek444rIUcKyK3WnzIdaplM9S8N
         WyG5+76ZN5Asi2xi2/FxTpD6pbtV30Q+wHMfi3a4n5v1XaMNTo4UwqG0L4dtd6zERf2r
         BCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691083;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pF8WidGUgZdClTE2SxFTHM5D5u9SZH0JpiUiTRv3sNE=;
        b=wP/PeqNWC9jEOSo8/j/HTg0Mmbgo1ZgmqZc2Ub1MJXKnMv8ohozymEo8zSAF6p72dQ
         fc/t8MR62tHBXnOtu1lfRjbUQKJ6o+6+o34Y8h6Ju1479Tw4nSPfjohgzNMW+bnfkaXF
         HHNn887f84l3oNwf3j32Sqiqxgw0RxXQjFSvByeS/YEekhUNUq70LnAPjRZrUQuiZx/Z
         lug3lnoAF6cA5PDZlnXaiB54/h/1EXLvYyeGUd+z6f3fEqjVVkrCLha9QPuJYddo8b73
         E4BaPTN3+8cbx2vJ6UZwmt6oHbTA9SZOfW3C4njwtwLK8KMKSAxrw0sZYBl1gVOrODEY
         z9uw==
X-Gm-Message-State: AO0yUKXIgkG1qN6u5+mSajHuORmwnfkjXmUkH1ALuTqMUOC5H4hTR0M1
        F9hZlWLyXIm5W5EycWy1N0k=
X-Google-Smtp-Source: AK7set9d4QepgMrmf+d3SU8o8bFy80PzYhSLxqamhOxlqV4Uf+ksXs7Sq2WOl6+XKeKDnkq4OkaATw==
X-Received: by 2002:adf:e0cc:0:b0:2c5:5847:7374 with SMTP id m12-20020adfe0cc000000b002c558477374mr5315708wri.67.1677691083583;
        Wed, 01 Mar 2023 09:18:03 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id u4-20020adff884000000b002c70851bfcasm13128388wrp.28.2023.03.01.09.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 09:18:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 01 Mar 2023 18:18:01 +0100
Message-Id: <CQV7UQPYDLQU.AVIOZFTN5ADH@vincent-arch>
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asahi@lists.linux.dev>
Subject: Re: [PATCH 2/3] rust: macros: concat_idents: Allow :: paths in the
 first argument
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net>
In-Reply-To: <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This makes things like concat_idents!(bindings::foo, bar) work.
> Otherwise, there is no way to concatenate two idents and then use the
> result as part of a type path.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
