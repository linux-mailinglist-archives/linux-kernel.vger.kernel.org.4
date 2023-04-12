Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF36DFF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDLUNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:13:51 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D733C27
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:13:50 -0700 (PDT)
Date:   Wed, 12 Apr 2023 20:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1681330428; x=1681589628;
        bh=R+WoLmWuecqwRSEBmC5tnSn+wxUTipT0To/pDvrDmlc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RxO1+5fRUD7vXsUe+Df1yh0XPkds+RM3QbGWWnhb43rlSsEMHp5g1uUN3V/BMbaGy
         VwirVEf6/RhJgCuW48gf4/3CnOMe+L/CzE1olgF3OHt+xD0BZxPFE2Ie3dtEofOhN/
         tO6BjMWshp/c27NPPLVQrS+0nzDqZJ3D+D1VUwN4eOKHroNDYE1pBvzB23efZqtv4B
         0/MoyD9t3GwdzU2TLgP14vn9s39ZUnP8Pe64Q+WND83EDLgWbPNGnS9r4IN0azOb4s
         wIgpZDYaAY57s7pBA1b+/4AONizg4VkvSnxWApPJtnLbLr/isqCMh7D6cplgCygFgE
         9STx4VX9v1XBA==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v7 00/15] Rust pin-init API for pinned initialization of structs
Message-ID: <TTE27GJ76877W-sIzVb_b80o8dCEf-CSDOKHLMTeYD23mET-2EymYGp9PII26HWZb0vF-emqnkIVdVKNwEqQHmWNZq_7P_GiL_U9Eyk0R58=@protonmail.com>
In-Reply-To: <20230408122429.1103522-1-y86-dev@protonmail.com>
References: <20230408122429.1103522-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

could you please change my current email on the patches from
    <y86-dev@protonmail.com>
to my new email
    <benno.lossin@proton.me>
Please do this for the Signed-off-by tags as well as the actual
git-author. Lina's patch to introduce `UniqueArc::assume_init` has
my Co-developed-by tag, also change the email there.

Much appreciated!

--
Cheers,
Benno
