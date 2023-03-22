Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA76C5045
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCVQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVQNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:13:51 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4F1F486
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:13:50 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679501628; x=1679760828;
        bh=a54horzX9GTM8oYX6semc4zWAv4b31nzPVtBi3QGcEI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=J45mMpX6SBGBiJxfW9dOSDDVHtKgLzxu4P61MYxCjsyH0Sai34uuhJu4ISu5pMLar
         EpTICbZlIoITFHCqLUN+sYVFT45k/ao0bWcWn6YyMDC7/3glV9Uy3YW1yxBOkL3/6Q
         j6k3tOUZlgnW2nUyFjFpTRdqGSIswmM5htF/r+zp72w4oJCJ49ZUvW3UAdFKom5jFG
         3sht9n4Ibshvhne/zC5BOR5/3dUNnAAJuMScuvc6drDsgdCK7V+hrIgwIdP+a6yOjg
         KzvD1NqRJaZPV+UvbSGJZFzjI8eveUWyNswAQCAezliKPcxZcKSTYAvMPas3cmemYh
         Hiv8qUYAoqyxg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 0/5] Rust pin-init API for pinned initialization of structs
Message-ID: <0e9686f2-f30c-89be-0505-fb36f1c0a5c5@proton.me>
In-Reply-To: <20230321194934.908891-1-y86-dev@protonmail.com>
References: <20230321194934.908891-1-y86-dev@protonmail.com>
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

> Link: https://github.com/y86-dev/linux.git patch/pinned-init-v1 [5]I sent=
 the wrong branch, the correct branch is `patch/pinned-init-v2`.

Cheers,
Benno

