Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA36A8B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCBWIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCBWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:07:58 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40A7296;
        Thu,  2 Mar 2023 14:07:57 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k23so310232ybk.13;
        Thu, 02 Mar 2023 14:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677794876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afscz4XnGfIY4qhRbHWfBYoZhXBwOKJhBXE1v93mr9o=;
        b=qT/jzOw3H83kLrDUfvQQFCq+WzmUhDojVJ3B/uuRt6INhZh/++dgP4snXXXBF1+VnR
         w4DGehxKkftvvXGBbdY7FO+tYH5IuvI6jEBpoa6JIh4/lK1YcEB1T6yL9+j7IP1IGTzz
         oWKVZYCIvd5abvPcQFdLAY3XZ19ZuCdcNZBzDoN5NOIecVKYMX+eKObx5ayk0GWM3bKL
         MQqtWS7dHDm+GHlaGpNx1FdKAVrWKPJbdduvxkPeEmS5fZVaMJMrk0HZRXmP65R1Cg3u
         sgRnkBeV9ysfeyoNTp/9A/o3lgUjmPZNoU67v04WXMQ8cswTtDhynnt7qymUpIt6rrAg
         yHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afscz4XnGfIY4qhRbHWfBYoZhXBwOKJhBXE1v93mr9o=;
        b=edeM19zAQ2v6AoidyJ3FAhg5lD/dZdg26zlmJDb02lUs4fCcinAaAZwH+yd7KIRuFl
         YTY0VaApMNwWE/zIMkoCwzAzOSX70Z0Avq8F4lPav/BXbAbQ8TUajoHvtX1PsUuyUsl2
         dRUZWydQzzV2RDGlbOnQF4wnJwOsQxKLqLUABn3F2Qn5eXs2+vK9sMkuywy+d45qgoed
         14NWBChjQ20VyjlJfvfSpJw+okZSg6qX67TSzsGQ+Y1sNd0lP/YQ8moRvDh1enaMx6n9
         3U3L3zu2q3gE0/mfmx2qOJUZFWCk4cEV2BKUQw+4/jtuj1JF3aIh6darA/shqmZ72kTE
         bpPw==
X-Gm-Message-State: AO0yUKUAv3/kw1VmbFsN0DPigMQmjxJgYp9yjW9jrGvTQvMHUY69qlCI
        9YdYF+5GrQIq7qRm2CpZyldZX9nyhZV5rzC2MQQ=
X-Google-Smtp-Source: AK7set8VIdr4R8bYsvgCrid/f+ICd4JT5bwL3QhEubSE3TqdK6fhTWw/po1QIYLeakpSrF5KGAkcLYZaVal0bl8dto4=
X-Received: by 2002:a05:6902:c7:b0:a6f:b921:cded with SMTP id
 i7-20020a05690200c700b00a6fb921cdedmr5355244ybs.2.1677794876573; Thu, 02 Mar
 2023 14:07:56 -0800 (PST)
MIME-Version: 1.0
References: <ZACvxNOuuyifQ9Nx@kernel.org>
In-Reply-To: <ZACvxNOuuyifQ9Nx@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Mar 2023 23:07:45 +0100
Message-ID: <CANiq72mUTnVxD4H_mYzdE0+RU3MMbBxugfgFUKCHp1jw=kvMjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 3:16=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> To address this build error:

Applied to `rust-fixes` for tomorrow's -next run.

Thanks!

Cheers,
Miguel
