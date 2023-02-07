Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6534868E220
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBGUqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBGUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:46:04 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0923A84F;
        Tue,  7 Feb 2023 12:46:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id c13so4083877ejz.1;
        Tue, 07 Feb 2023 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUN3UIdP4KIPNBI/X6EMqo5BbUYmuXYRGv5c40D5QhU=;
        b=gNc4/0rtB9+RmWXc23p0kdo4wH9VnEwX1fkf2JQ5Z2oozvGoUBMzkEbXOgWxZi7Vl6
         K53sBsMFxmNABndzBnOq1R/EZl7TlKgHdruleeeW2zHqJVmTK+GBxEg4gkx9bQaOz/El
         1F3ZGCEuTsGfUGJY3YVhTYW++cjwTdfiTGBqC8353mbZr8bpKWKhXMUFW9x50DC8Xu/+
         D9KTogBxkuqWbz/JjJ9WLGInTiQjaJtzJ5XJy/pOQ/bNJW2TqQNmTDnzgjddVAKRo3dU
         oACvS2S9hn5VRD4qh5U+RiksON12z0Zts8BAV3/XJo3FtprumPzXD+o4Dg5WnT01ASXN
         NA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eUN3UIdP4KIPNBI/X6EMqo5BbUYmuXYRGv5c40D5QhU=;
        b=YsVNuiZfh6s4nxazetjL1trUb32zyWSJeavQE1Lw0jBbrcVxSCQL9bt5yM9lGRZQXo
         /xNMgPuD5F4yqy6YX2kMhQOjYTR8EBPnnNGspKcA3yD5vEYjuUKXrybPmdP4q9ZxIdzB
         ANn2PnYeIV9lMTIObxuSNHs6vR61fbhMuTaDBxYhuqIaB9B08j8W0XybamlOsQs9XNEr
         wXB8W+9xey2Gk0P5n8j3paxKzFFre+Ck06kKM9A9GqI5wCr7G20WJYY64Y7b3xdkry9Y
         SfA+dtNve83sSKmlbvNPOejFF/Xs0SKeXRUfG0DEU5RuE5WlwN/ulrUdps1bshpmKl/H
         txNA==
X-Gm-Message-State: AO0yUKWp1QVZFe4DK0Z3/t6EN6f+shxU4ai49FqFvUiA9JdaOmq7pJgR
        QoEXSpicQ+4HtCdOcdS8fxg=
X-Google-Smtp-Source: AK7set/ZmySSZP4tgoA5FLKI8BH6KdmEZFSRIFnAgz8nmerbEUi5Z5b5/fJ9SY4bcakOC9wabc97WA==
X-Received: by 2002:a17:906:e213:b0:878:71fe:2f12 with SMTP id gf19-20020a170906e21300b0087871fe2f12mr4633860ejb.50.1675802762349;
        Tue, 07 Feb 2023 12:46:02 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:cd23:cd6e:ae14:44fe])
        by smtp.gmail.com with ESMTPSA id kd21-20020a17090798d500b008857fe10c5csm7244732ejc.126.2023.02.07.12.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 12:46:01 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Feb 2023 20:45:59 +0000
Message-Id: <CQCMHZWN9GKV.20T08UNZV7FTJ@vincent-arch>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        "Finn Behrens" <fin@nyantec.com>
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for
 {Unique,}Arc
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-2-boqun.feng@gmail.com>
In-Reply-To: <20230207185216.1314638-2-boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display` or `Debug`. It's useful for logging and
> debugging purpose.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---
With this review I will override my previous one, because it=20
contains a typo inside the Reviewed-by.

Sorry about that!

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
