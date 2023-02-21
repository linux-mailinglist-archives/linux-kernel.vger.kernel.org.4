Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D669EA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBUW3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBUW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:29:35 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DE2CFF1;
        Tue, 21 Feb 2023 14:29:33 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536be69eadfso78222547b3.1;
        Tue, 21 Feb 2023 14:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WceuJ8ipts0UOpiT/1mKTzkxwZ9KCev5b/cduPZ7ipM=;
        b=mHXK3HV/KEU2F1Y65ssS2NiVXYebymD3gw8kYwgN3T+MtGvSRypgDoBFg9i5wbAFuq
         JbCBo0srDIdt9T4foDTVpysNp0D6nb4v3ocO4FzN5YEUC2wFWbSqPiN6ClqXsRrcgf+D
         kCLDrUTSu5BQm60FqYPQm1t43DKTBo7w9Ydaazdx12E2rQe78uVnI/DBwa1bGeCJMwE4
         M/nsC4ES6E31XoDVeBQI+3OSQUthFU+eBN5sd+CzDH+M8lZTuqnK4dmMq0Yysas6sU6M
         35QSPyXjSmS0bIhBKErGp+sMZ1FCeiDWJVO37eAd7Ihuw/6G+cWzx9+71oCA0ceb7h/j
         /MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WceuJ8ipts0UOpiT/1mKTzkxwZ9KCev5b/cduPZ7ipM=;
        b=tyEPP2pnVxQV1Pe8qlRnxYijdA8EVMlUtmY8bvDoQStWbQO09WgvagHg/WsPnQ+41C
         vEnPTU0hqhKQWfPocyrEXJxlLsj2MorrHziiAfpEkHMSQPloIMKfb5GEps6mb36B5z1R
         gH4nawfxeRZ67/XzaA5GEGa7Zb13P8zYYRdtSd1ST4hMWi4TtK3ivopg6I9wjWrdXA+K
         YwAJKF5MzR7hH+rEbmV/joneJ22mvtC8DaVCbRRUKOqnLppAgivb1nQ6X/ro/+ugVTYt
         ZkMIzNzJv4k/8wINK2SD8EouCoOTGApm22zbin3FW6nxXJh0q4uX5x/iq/QRIPnOe6xZ
         YXdg==
X-Gm-Message-State: AO0yUKWtDUfasd6Ve7WGhIZjzRG1zgiGWtykUtjy2npH1Sds8gLQ10Ax
        Nlgj2LxBv4Yq5p0rkN4imxwsPbkflzqKN4cczDQ=
X-Google-Smtp-Source: AK7set97PV68FCxlHREfjluc/eQ6TYqCrrVB9uY/b0FuFuY0Lk/twQoIDFWMEKjZxyeQ9YvhxOQ+ssHZSreZ5ahzLl8=
X-Received: by 2002:a81:66c5:0:b0:527:9733:fdee with SMTP id
 a188-20020a8166c5000000b005279733fdeemr450381ywc.490.1677018572231; Tue, 21
 Feb 2023 14:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux> <87h6vfnh0f.ffs@tglx>
 <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net> <87edqioo1e.ffs@tglx>
In-Reply-To: <87edqioo1e.ffs@tglx>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 21 Feb 2023 23:29:21 +0100
Message-ID: <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Asahi Lina <lina@asahilina.net>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
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

On Tue, Feb 21, 2023 at 7:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But xb abd xr are the same datatype because they represent a time delta.

In principle, one could also have different duration types too. For
instance, C++'s `std::chrono::duration` type is parametrized on the
representation type and the tick period, and thus an operation between
two time points like t1 - t0 returns a duration type that depends on
the type of the time points, i.e. which clock they were obtained from.

Cheers,
Miguel
