Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A96A71FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCARWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCARWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:22:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01389460B9;
        Wed,  1 Mar 2023 09:22:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p16so9070148wmq.5;
        Wed, 01 Mar 2023 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677691349;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDQHP8BG8R5wdJ7RTb+80l2ekEuyVXCqz8ZnvG7NU2E=;
        b=MXqcEB1rg/3NyMESFE4svUXado9uxbiDrvKogUtcjg2aU575GuICui5bKmW+87FGKM
         OQIgHtE6lZ1rLlCzzoJwXR5yPulcZM/PumnU+lOGTwKL6jnmiPQhxcRn94NIithJvg/a
         Yy2M7jN5wkOI9txLQZw0wNcP4db11DaA8wmIQSGjnWLUAuKXH2CiUmPa+5NRNy9OMuvr
         OD/xdxkSHQsieJYpbtK7LjQwBRnvJSlUFBGTl0leWHR2Az/iixiPZJg4iye1bQW8w7CJ
         y8sUsxOY5CT3nRjzfZPMlW4BRnk93AAlX3L0DrZ8z8iojrpG5/+bjuJMyJ7WwWrcDff/
         lCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691349;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDQHP8BG8R5wdJ7RTb+80l2ekEuyVXCqz8ZnvG7NU2E=;
        b=AmENHsC/7lEXRQMGLnNfqAsEKt9uIbhM+8ucr4L3YCaVmppC2D5zl0HqQH3m12qNGD
         dNC2hXKwe036b1+Ff0UJhKgxNPln941wRqP+aeaQ6FHa2liO0yTBT4764P9UYwPdriI+
         ETILlXj0v3uKWIduFpuXJRtj4UNdMKdgasJ72c9Eb89SJRYgLD9+OONZqW4bZjxBgW01
         bUPutpFkXne62qNkoxn+IDhFl9/HKjpsMeMPIP5ReYM+so3UYNNarzaIN1SSVrKLIPMY
         3vKX7vTF6Lxgvh9NdtS3fLYMm+KPpAPzwM3QXBhkVWn/YYsAKv6K6sJVz0XU+ybmnCX+
         lIcw==
X-Gm-Message-State: AO0yUKWFhrG/YaBfs15w5j5+/GEJJLgv7BK2mwyaCNoPlwbqr9GCczUa
        J4g6Lku22krkOhZrgpy5Kyo=
X-Google-Smtp-Source: AK7set/xIQTGZ0oSP5Ir+iPChbH3yS0TpDGFVtf9t8yYtqEV3aMhGuoNbxDpLj4X7tn8uDDYAraJpw==
X-Received: by 2002:a05:600c:3507:b0:3dc:4fd7:31e9 with SMTP id h7-20020a05600c350700b003dc4fd731e9mr6131748wmq.7.1677691349057;
        Wed, 01 Mar 2023 09:22:29 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b003e0238d9101sm178410wmq.31.2023.03.01.09.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 09:22:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 01 Mar 2023 18:22:27 +0100
Message-Id: <CQV7Y50LK5UL.2YJUX3W7B4NU9@vincent-arch>
Cc:     <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asahi@lists.linux.dev>
Subject: Re: [PATCH 1/2] rust: sync: arc: implement Arc<dyn Any + Send +
 Sync>::downcast()
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
 <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
In-Reply-To: <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This mirrors the standard library's alloc::sync::Arc::downcast().
>
> Based on the Rust standard library implementation, ver 1.62.0,
> licensed under "Apache-2.0 OR MIT", from:
>
>     https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src
>
> For copyright details, please see:
>
>     https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
