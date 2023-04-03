Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4635B6D5498
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjDCWO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjDCWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:14:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DCB3AAA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:14:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so123173143edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680560090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz91yzAU2UAnIEGcuZAN2UBettORvR8cQ9bqohgSsk0=;
        b=ALO8Qn5xFvNz4rsPDF44hTiNkO4Evw9/Okujyehi/8Walss4GDxeTrJdXNumvKuXhX
         3CBxSkVdS2peJUdjMCOxgjtSf4ZEVha/oijhlDUGxD4AZOGLW57VjTbBG8Fk4rKq/BUq
         lZLLFG/4pGHPQ1Q5nFL0sv73HUS3Jz0QyOnmlK5XLMxoiq8xUOeBuFlw+yB6qCpI7iW2
         hOVu+4Lu7i0Pe6YDLMWw6rDMmsBUjPeIfCK/rhgQ8X2aRpd6VkI+sMxpONP151Lvyrmy
         v3xZTUTouhFktpwj5xqLsYJhnGaCMxP3Tmk+0djfL1qgJHj5auj0ppFrHyHxrCcnPZfA
         0VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz91yzAU2UAnIEGcuZAN2UBettORvR8cQ9bqohgSsk0=;
        b=2nXoVxPnv/YqBJV/yhkiGfKa3Mc+MDvj/IhVndTbpg2b7g8IA7+zAvstyjTogf60N3
         S+eoJuEy0avDD0zU9xb024JJXbySZnZUShSwboSJITbZAAaaf3OP9dWO2bYYDfGqLyND
         Xz3FNnH3UDsdxhzW0tWvRfUwLKPZy48g3+qGjoHi9/+n0RdGGzB7U/bgHBIcq0P2IMZk
         xRTiNIiZboF7maByIqXLlRITtKcTF9aSjb8k7ApTo027PDQkY2W/WR2dyjBT2dRQU2iA
         jaalmcbdHo3KtShhGVDmNqD/7caMmAr9ODSuqcGdr6Lq6k/TlRN4XUJawSulvkuJuTSI
         GWbw==
X-Gm-Message-State: AAQBX9fQo4bTJCSp3m5hPQmlHZRLGc209lQMRy59PFnl/q4AaAy0cZxY
        opAhgFAHpzFd6pYRH+wpGyTeXjmp5jitFhh0JXa3Kg==
X-Google-Smtp-Source: AKy350YmRv1iLngkX0mOxnDqYMEfEwwayOWjMkTvHV7B+sEUefsVnWdOIcoeTTZqAnBKtezbUNy00LAlmbCeogBuH3M=
X-Received: by 2002:a17:906:b55:b0:93f:82cb:fe44 with SMTP id
 v21-20020a1709060b5500b0093f82cbfe44mr114966ejg.11.1680560089996; Mon, 03 Apr
 2023 15:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230401200651.1022113-1-joe@isovalent.com> <ZCpMv1UHM1Vn+/ha@debian.me>
In-Reply-To: <ZCpMv1UHM1Vn+/ha@debian.me>
From:   Joe Stringer <joe@isovalent.com>
Date:   Mon, 3 Apr 2023 15:14:39 -0700
Message-ID: <CADa=RyzmpE-XwOan0B5s20yi58EbM2VUFZDSLaGJQ3nnWgzvWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] docs/bpf: Add table to describe LRU properties
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, maxtram95@gmail.com, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBBcHIgMiwgMjAyMyBhdCA4OjQ54oCvUE0gQmFnYXMgU2FuamF5YSA8YmFnYXNkb3Rt
ZUBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBPbiBTYXQsIEFwciAwMSwgMjAyMyBhdCAwMTowNjo1
MFBNIC0wNzAwLCBKb2UgU3RyaW5nZXIgd3JvdGU6DQo+ID4gKz09PT09PT09PT09PT09PT09PT09
PT09PSA9PT09PT09PT09PT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQo+ID4gK0ZsYWcgICAgICAgICAgICAgICAgICAgICBgYEJQRl9NQVBfVFlQRV9MUlVf
SEFTSGBgIGBgQlBGX01BUF9UWVBFX0xSVV9QRVJDUFVfSEFTSGBgDQo+ID4gKz09PT09PT09PT09
PT09PT09PT09PT09PSA9PT09PT09PT09PT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ID4gK2BgQlBGX0ZfTk9fQ09NTU9OX0xSVWBgICBQZXItQ1BVIExS
VSwgZ2xvYmFsIG1hcCAgIFBlci1DUFUgTFJVLCBwZXItY3B1IG1hcA0KPiA+ICtgYCFCUEZfRl9O
T19DT01NT05fTFJVYGAgR2xvYmFsIExSVSwgZ2xvYmFsIG1hcCAgICBHbG9iYWwgTFJVLCBwZXIt
Y3B1IG1hcA0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT0gPT09PT09PT09PT09PT09PT09
PT09PT09PSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPg0KPiBUaGUgaGVhZGVy
IGNvbHVtbiBlbnRyaWVzIHNob3VsZCBhbHNvIGJlIGJvbGQgKGFzIGFib3ZlIGlzIHR3by13YXkN
Cj4gdGFibGUpLg0KDQpUaGV5IGxvb2sgYm9sZCB0byBtZSBhbHJlYWR5LCBkbyBJIG5lZWQgdG8g
dGFrZSBhbnkgYWN0aW9uIGhlcmU/DQo=
