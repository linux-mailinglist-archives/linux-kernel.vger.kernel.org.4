Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791AD6ADA49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCGJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCGJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:26:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F653717;
        Tue,  7 Mar 2023 01:26:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id k10so25722872edk.13;
        Tue, 07 Mar 2023 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678181178;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ztapAqrp0P0arwM5QDm4n16xyUTGqlP0zUmPheiyv8=;
        b=ajw0Ap8dLJ0TFUrTkUnw3NQh/6Hl0eG+9B/0Z8Yq8vvj9ltkeF2rPq7WWmcgAjZVkF
         bxz27W2e73rYXr0qP7TsVMmHHd3f2707LiWu8HnA9FJJdGvjByP3u2JwFrd+2IEjpMh2
         VXx1liWRNYheg/Z4ARSHN7aAPHjB8ZJYzp8GAq668mmoAGIr860MEy5QgntC+Qdtmr2Z
         Hcr+1aAyzC6pyp22E3MAl0/YmvGo/OHR8BJgORQLg4SRU6CJzU5CfdF5hl8ZLz1VDKrz
         UnaKsxxdqy26QfWtTtfYH6+AkiCn2lq6EjqHDHbBX+zcFLevhTfHK+m6BBWqML6HxdzI
         Qv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181178;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ztapAqrp0P0arwM5QDm4n16xyUTGqlP0zUmPheiyv8=;
        b=fJpNKTbFRGagRufsVsf9sdNDDCkoMnWDR0/ncYQtejM8hDZ427Mq5JLl4uiQE5p5o8
         L01c52rkfOHOn+7myJbaLsBv1VbBG71THSJOxwYtWcZoSgBUmSjsybBUQVD1P6R1yg0s
         aR9kMXdkK8suqb07RVQ6h7gvgVYyJHNAhyXJOhJS6cxXEhoahHFG4Tg8w1Vf77GQMWih
         mOzoVD1tN/yLzk2WC1AiUnGm2g72ebOZdSenz4z7YsiFHKmr5mvhMaFlqEbsvJOnXPpt
         JUdjmgUbuywx9Y5hTd7yzBa1p9xLyWdqxPy5782AtKGWx3cI3V/Iy5gClzI50wceaRVV
         jQ4w==
X-Gm-Message-State: AO0yUKVsXvF3SZa8j+aZe9Jb8j0Qr9ZgNxQNLT0mKsQ4Gk6BMr+r1RNB
        FPh8laKIg2vrFGJYL2id2FY=
X-Google-Smtp-Source: AK7set9vnOx118VHRJHv28HiwsiIKXKtrIehHz+W/nZGoYhuq4nLXCAiKufIQdTAhvQTJ74zUjoavQ==
X-Received: by 2002:a17:906:fa82:b0:8ea:a647:a5aa with SMTP id lt2-20020a170906fa8200b008eaa647a5aamr18566645ejb.38.1678181178059;
        Tue, 07 Mar 2023 01:26:18 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id hb15-20020a170906b88f00b008d09b900614sm5741459ejb.80.2023.03.07.01.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:26:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Mar 2023 10:26:16 +0100
Message-Id: <CR01KTDBXXM6.1IJUOC2OAJQX2@vincent-arch>
Cc:     <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH] docs: rust: point directly to the standalone installers
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230306220959.240235-1-ojeda@kernel.org>
In-Reply-To: <20230306220959.240235-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The Quick Start guide points to the Rust programming language front
> page when it mentions the possibility of using the standalone
> installers instead of `rustup`.
>
> This was done to have a hopefully stable link, but it is not too
> helpful: readers need to figure out how to reach the standalone
> installers from there.
>
> Thus point directly to the page (and anchor) with the table that
> contains the standalone installers (plus signing key etc.).
>
> If the link breaks in the future, we can always update it as
> needed. And anyway having the full link includes the domain and
> gives more information about where the old docs were in such
> a broken link case, which may help.
>
> Link: https://lore.kernel.org/linux-doc/CANiq72=3DgpzQyh1ExGbBWWNdgH-mTAT=
dG5F600jKD1=3DNLLCn7wg@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
