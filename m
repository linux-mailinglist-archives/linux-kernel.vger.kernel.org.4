Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91260203C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJRBMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJRBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:11:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203CB1172;
        Mon, 17 Oct 2022 18:11:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl1so12457196pjb.1;
        Mon, 17 Oct 2022 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SznCcMXglU6qBXz+hAGaPsCnaJwQX00dxnYrwKOqxo=;
        b=BAWK424W2URGZYYa6yXP3alZc+SZIoQoG01R/b1jZxAHAX98y0g0cqRums1t+Ly0uK
         4epKNq0jaDzWtJJhLuagD20/74EM5fNx8OwjZ0vsTR/P7M659CURK34zFwVYc5TUnHBN
         8uRqzg/KgZDEye+TAzKyNBJn7sHDkv1hNXn6e1DHyr8Ecn8S8Nom/6keyJRQsZ6NNgZ9
         sDKisOPIMrnVMRQK+TPTDKCb4qz9ReAFVBqNcEJcVIBc45/9i81CDsaHhnOlkbI/s83q
         A0gNlRY0//5DUL9Cq1uIjGHxIOBdb2TpRWvZQmqtHnHiHTa1fwW5wYrAdHz91Pf7hLa/
         uYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SznCcMXglU6qBXz+hAGaPsCnaJwQX00dxnYrwKOqxo=;
        b=yKjFCo5ZBvm6umZBONmoiPnVWmqtr9ujMcwD05KvVMJx0gNHBYQ5rb0Bgl42ROLiWg
         ophzerZCWzWUrN8fo65tljimWFH/iKEeyvo5uVqBi2A0UYuF7EPc8HDBWN3FFoEupf6h
         ini6ev40Ys/4/1LRcGqKClewmLBkDLotov1ItIdOlSD6Q+GyXtQvHluno8KncWBhNJis
         o0viFwwRJCi+sOVsKzby4PoetxHLnpCw7kfXD9LVWVhzwR4rRU2VAW8BkhnUh/R0P6XA
         ktGOOP3VRnlu1kNEEurU9ZMgeaaIxRTWcYKtRypRrbSvx3CBw1e5z1+8UyB8eAJtppkA
         c7pQ==
X-Gm-Message-State: ACrzQf2fsTC923tnJ4G9zPDlL9ygQ3wY8g7CCpIQtYM9K3cB7gLI5Nem
        gpYu5XnA1dtanZRDNV8ryPo=
X-Google-Smtp-Source: AMsMyM5mOgU6WKJ6otDDjamUlMvt4XCJA5hLos0QfEE2YJGafiqKSvbVCbJIvlq+z0WD0eiYXBK8xQ==
X-Received: by 2002:a17:90b:2250:b0:20d:9587:45c4 with SMTP id hk16-20020a17090b225000b0020d958745c4mr634960pjb.17.1666055507516;
        Mon, 17 Oct 2022 18:11:47 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id cq14-20020a17090af98e00b001fe39bda429sm6732186pjb.38.2022.10.17.18.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:11:47 -0700 (PDT)
Message-ID: <6f8aa670-fb4f-3ff9-bcd9-8490e752b349@gmail.com>
Date:   Tue, 18 Oct 2022 10:11:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] overflow: Fix kern-doc markup for functions
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221017035732.1968394-1-keescook@chromium.org>
Content-Language: en-US
In-Reply-To: <20221017035732.1968394-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Oct 2022 20:57:32 -0700, Kees Cook wrote:
> Fix the kern-doc markings for several of the overflow helpers and move
> their location into the core kernel API documentation, where it belongs
> (it's not driver-specific).
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Akira Yokosawa <akiyks@gmail.com>
LGTM,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Kees, which tree do you expect this one to go through?

        Thanks, Akira

> Cc: linux-doc@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/core-api/kernel-api.rst |  6 +++++
>  Documentation/driver-api/basics.rst   |  3 ---
>  include/linux/overflow.h              | 38 +++++++++++----------------
>  3 files changed, 22 insertions(+), 25 deletions(-)
> 

