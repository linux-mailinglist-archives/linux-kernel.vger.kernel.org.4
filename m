Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E48C6C5058
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCVQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVQTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:19:05 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEC13DEB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:19:03 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:18:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679501942; x=1679761142;
        bh=5ALAy5pala/Uch3PDmDpaH5urLbdFuosVmerjiirmy4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=FcblW/U6YDpSVX88KRGptcsTah8DZLGUshKfFv4z/KKtKVfaQW6aKiAfGdkD4DoDU
         bHKMeNW5mrNgC15uJuuT3jWxDx62jemwO+5dpLMi+119jFMkmw+CkRlxRj86bTHykv
         BuKVpvE7bqgA6L8L31gPB0zQlhOm4p9wMEq8XahVGKTv3ycg8ItoOHl6s3Gk6m7REO
         pofN8WNJwETtJMO6Cp0BYYHs9tb74E/cVp+7sHpsbbXKKOTF/rT6qTP1YRl6xwmHMg
         N5WQ8bEP+xukdqbN8nzl7U6godJQd8uR+RlfQrJkRhAAUKMvEOZHFou6xGk6Ye8AUt
         MkcgMtkWhbMmA==
To:     Boqun Feng <boqun.feng@gmail.com>,
        Benno Lossin <y86-dev@protonmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 4/5] rust: init: add common init-helper functions for `Opaque`
Message-ID: <7f2af153-0537-ab64-81c3-a15714d8afd7@proton.me>
In-Reply-To: <ZBoONi8oMO4X7DWy@boqun-archlinux>
References: <20230321194934.908891-1-y86-dev@protonmail.com> <20230321194934.908891-5-y86-dev@protonmail.com> <ZBoONi8oMO4X7DWy@boqun-archlinux>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 21:06, Boqun Feng wrote:
> I wonder whether it's better to make these as methods of Opaque<T>, i.e.
>
> =09impl<T> Opaque<T> {
> =09    pub unsafe fn ffi_init(...) -> impl PinInit<Self> {
> =09    =09...
> =09    }
> =09    ...
> =09}
>
> then it's a little more obvious to users that these methods are for
> Opaque type pin init.
>
> Thoughts?

That would work, will add it to v3.

Cheers,
Benno

