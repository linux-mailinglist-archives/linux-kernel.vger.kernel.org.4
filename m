Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5683F64F563
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLPX5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLPX5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:57:34 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999555A9A;
        Fri, 16 Dec 2022 15:57:33 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3cbdd6c00adso54072007b3.11;
        Fri, 16 Dec 2022 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0jxoLmhjzdQFU4Rcca6h1zELOoOj2Hhrq5sWSEt7V8=;
        b=HKVw5J3noI9XmTp4k5G5m6+ylCn+yW93A8XQkAdG6J0nZjK32B+jT+rwcdWmz1pT5V
         UJwEz+vfCU+EunGlHsDGZekb7UkXj6gVB0LX6AB+lfgWsLwCwmhEA1MqUOGTpZxs87ix
         N9w//MYY/k3CER6eOJaRf1C+TR+HSZfOm4UwvXN12W2ka5cex6o29Tuk6neAyxkBuNeA
         VpZA+HQvEXyUZzNMRYxz0ERRm0ThKupJphUHgMhZMWW2mq5ob/6tmc+aErEt9z1VrI7G
         OuM4mZrax5w+/tRQWaFFjaYToTDXhvXv0It8FToCuaYw0Ot3FhLjA/mpLiwC/rQm/Tfp
         PgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0jxoLmhjzdQFU4Rcca6h1zELOoOj2Hhrq5sWSEt7V8=;
        b=0iES4Db0XONHT+IFPNBHgWst67tWDu4ZrNfnNAoNYYoFj/p0sz53SDpITlM86X2+TM
         vE3RvgxzFPHddOR9xsJVgpmcnD3YDhMLFWglBRoWFNtyrDfZOJfiQWloo4QPo+Tyzyr9
         CfCvUpUZfniv45SmCGbtmS5nPRLnD6dYpvYg0qpZMIHgF9P3k13nffXvxNKd3N18JrTM
         jMzR9IlwYWMlkvEacm0x8cKEiHOKY50rMP6g/ZLvILnWK5gN6oOESMZzhnKCjy9Z77T0
         Z1jsg5S+Sn848IDvyDprufVPz5cE/CWPthIds2MpDw6oWd81Sc826EBCzZ25j6yRKIHG
         xB3Q==
X-Gm-Message-State: ANoB5pntWuFNh1nCpd0jaqLk2ejDDKuDUQsIdsTQmeCb0bZxcvAyc8cW
        hHr5nDChKK6cWzqTVi27wAu2WtavpjJe+xTUxMczLYEffflbpw==
X-Google-Smtp-Source: AA0mqf6MPZLiYnqnGy6wTGkTNxkB7D4Tgsi4gjQvQRggN39XsKevSR1CQmjsI822xDdkBkoiPfoeSOHvvuBZq25FqYI=
X-Received: by 2002:a0d:eb15:0:b0:3b8:7fc6:c06b with SMTP id
 u21-20020a0deb15000000b003b87fc6c06bmr3567855ywe.129.1671235052681; Fri, 16
 Dec 2022 15:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20221216174927.1008629-1-wei.liu@kernel.org> <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
 <Y5zt9PSUD6d1MTyZ@boqun-archlinux> <Y5z/msA6FWH0Bgmq@liuwe-devbox-debian-v2>
In-Reply-To: <Y5z/msA6FWH0Bgmq@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 17 Dec 2022 00:57:21 +0100
Message-ID: <CANiq72krvm2bT3suU9ecxpECZYNZ99+ed5y65tUDpNiqGvWKOw@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: drop repetition in offset_of macro
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 12:30 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> What will be  even better is someone please contribute such a macro to
> libcore so that I don't have to replicate the code snippet everywhere.
> :-)

It is happening! :-) See https://github.com/rust-lang/rfcs/pull/3308,
currently at the end of the FCP ("final comment period"), i.e. the RFC
is likely getting accepted soon.

We track it at https://github.com/Rust-for-Linux/linux/issues/514 (one
of the sub-lists in issue #2).

Cheers,
Miguel
