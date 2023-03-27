Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6006CA97E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjC0Pqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjC0Pq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:46:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2657D44B3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:46:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m22so4060439ioy.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679931979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZwAqUq38LWbbRXveAPtCbJ8i9E1aUhFu3Kbzb9UA0g=;
        b=ubMPdNS18Ypllanmkqdb6FnctPLZ7rp9kOmEMxhfG5A6nmyia9rxZ8cvJbS8koxQpc
         pdxkIayiubjB8wg1VhwgbhFDrnCtmszQsau5gtvz+cSF2v7frY96TX3+U78Pcw9kN0V9
         QDT77x2649scvpNkCE0EsJQoIa4S5j8AJ/A2MJFczkD/FNa96zS2G/GSqU/NyJU5unwC
         OMSTbaa0Jg66kMSkf5l5Q7J5vyY4oa8pd6+sZm6lDZCIIF+0GiQ/ybsYpKglmUTEUWG+
         KTQ1TU9gaiYlgdHwcJIDWNhEiE55kcIjNkmEgMjr7McXrlUbB8RTZYxPG09ir7zMU1Jd
         4Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZwAqUq38LWbbRXveAPtCbJ8i9E1aUhFu3Kbzb9UA0g=;
        b=d+NBprTBNh2vqc4JyjmFHOL1zxPIfj33JgMvzH8m11zGTakriioCQHcjb+J9ONwNJ1
         Mkk2r5lJKHnc+kJkJOWY2rcZjOxDoOVZOoTIQs1D1w6CQaHYVKf66cArWjMGavqDNfUF
         xJcDlL/XQwgKQ3r2JXNDY+HHS9jd0TQQ9Hq4gepVoqwtfwrRyCZFM3oqtHMExGcqkA2Z
         nuFqSYHKDE9qRJ9HL+SLYBr9DTvBqRVBwVtQL95V/DydhUTTiWID5cbva+o+nCQ2+KWJ
         gdo7L/PW5ONIQhJCKv+K3BhHvKfVcp7tZLQ75bL0Yqw1nBwcOaCm+J5JgaKGRLK1yYbB
         7kHw==
X-Gm-Message-State: AO0yUKXoChmbF0SoEhSkQfAMYbM/yer4sFKPvers1qWJHufj4dq5Owlm
        dg4ZVO8a4+whMA3nc7ZSYJNMyQ==
X-Google-Smtp-Source: AK7set/JJkb11nsQMtzvyqc9BOV1bCICTfG3HNgaCQya39xeBSvUNmzo8SNpivEGtFFunjnVXtLykg==
X-Received: by 2002:a05:6602:1301:b0:758:6ae8:8e92 with SMTP id h1-20020a056602130100b007586ae88e92mr7166727iov.1.1679931979423;
        Mon, 27 Mar 2023 08:46:19 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f18-20020a02a112000000b00408b3bc8061sm4180511jag.43.2023.03.27.08.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:46:19 -0700 (PDT)
Message-ID: <c1fcc9c4-1409-0890-7032-c247c15097e5@kernel.dk>
Date:   Mon, 27 Mar 2023 09:46:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: next: x86: RIP: 0010:do_iter_read+0x241/0x340 - BUG: unable to
 handle page fault for address: 000000000042da60
To:     Christian Brauner <brauner@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYs1ytc7B2ffLpYCqscwVTZ2vb7aAV0cEc-s+2QS1g3hyA@mail.gmail.com>
 <20230327075841.pblnllclg2idy3rp@wittgenstein>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327075841.pblnllclg2idy3rp@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 1:58 AM, Christian Brauner wrote:
> +Jens for awareness because of
> 
> Subject: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
> https://lore.kernel.org/linux-fsdevel/20230324204443.45950-1-axboe@kernel.dk
> 
> which seems like a likely candidate.

It's certainly that. So odd, I even ran these test cases! I'll drop the series
from for-next for now and dig into this separately.

-- 
Jens Axboe


