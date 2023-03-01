Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF66A71F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCARTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCARTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:19:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B634A27988;
        Wed,  1 Mar 2023 09:19:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az36so9094135wmb.1;
        Wed, 01 Mar 2023 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677691184;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVLUoMBClRsLJTrNJuKg+DNnna+fSwHUpLxyvEvQJJU=;
        b=hGIWnqpKj9B5BELlIG92XwTie5VSWrj2kGuAfpbs9LGD9wBDfsgvjaSNcr5apiJC68
         8DWjmL1lt0KAuvqc7GOc9b6qnzi1zWY4VX8K+g83XUwOFhAjXwghbJ4UgwfGtAh5ydVq
         oNZpbORAhThRkBVZMv58snaAA5M50UZqTBdiRJ4Ign8yEDbogLuEHLhSkXxPL/anYK4A
         5I8ndV7qcjphHGcuOs40p0CPebJNIvHsLpwS8H5qSvnNSpfvogjiSGn4vv4MnDBNnprc
         LFlNS7z42RB1g4m7hZvshlgTsC8IH81R36b19g3yiNwzXDrqp6apeoO3+JJ/oj34Kg3K
         BAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691184;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVLUoMBClRsLJTrNJuKg+DNnna+fSwHUpLxyvEvQJJU=;
        b=EUPwpwn3ryNdccuEjlZMrgK/1l4CxxgY/Pyz8jzAtMdTYLtF4S0r60PCx7nXenxzs9
         EZvMYFmy3GSoQNjEULOqLO12c+8OX3jlx+6QVj474XrBlfKuuBPiXkLr9U/VT3aS9q2+
         HwoZOyPKRRQef3IP4EiJd0OyKnwg5xaqkYON/MN030VWCPBB7G17B8DurWNr10LJJdMF
         x202maJCT65+WCkJbSRJy5wGa6DBja0DAgs1Hzp/UBzaVPDg+w1u0xobUoCCEm1w9DXP
         mwjI+1NYS4lxF25zegfpualz0BlMBAUcMs/Wq0JRiVrDnQeClQq056YenhgLL12R4ea2
         pqmg==
X-Gm-Message-State: AO0yUKXZCnq47qjzZre6INzpq9rzqIdfxd/qOQaQf3Ni+ek/a+2emAMw
        ornqR6PMFc3V5WwBHY0ugmQ=
X-Google-Smtp-Source: AK7set8lQ8cqGjyf5GgzueugEeOGCskEuHNOA6VdFXO1Nx5pZJd05ym6Gw3DKRtCrczGsFG7hufDmA==
X-Received: by 2002:a05:600c:3319:b0:3eb:383c:187d with SMTP id q25-20020a05600c331900b003eb383c187dmr5249410wmp.27.1677691184203;
        Wed, 01 Mar 2023 09:19:44 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dd1bd0b915sm210956wms.22.2023.03.01.09.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 09:19:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 01 Mar 2023 18:19:41 +0100
Message-Id: <CQV7W12MZX16.PLH1OAM17G7N@vincent-arch>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asahi@lists.linux.dev>, "Finn Behrens" <me@kloenk.dev>,
        "Sumera Priyadarsini" <sylphrenadin@gmail.com>
Subject: Re: [PATCH 3/3] rust: macros: Allow specifying multiple module
 aliases
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-3-b39fae46e102@asahilina.net>
In-Reply-To: <20230224-rust-macros-v1-3-b39fae46e102@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Modules can (and usually do) have multiple alias tags, in order to
> specify multiple possible device matches for autoloading. Allow this by
> changing the alias ModuleInfo field to an Option<Vec<String>>.
>
> Note: For normal device IDs this is autogenerated by modpost (which is
> not properly integrated with Rust support yet), so it is useful to be
> able to manually add device match aliases for now, and should still be
> useful in the future for corner cases that modpost does not handle.
>
> This pulls in the expect_group() helper from the rfl/rust branch
> (with credit to authors).
>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Co-developed-by: Finn Behrens <me@kloenk.dev>
> Signed-off-by: Finn Behrens <me@kloenk.dev>
> Co-developed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
