Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDC6D9983
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjDFOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDFOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:22:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5898684;
        Thu,  6 Apr 2023 07:22:42 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-183f4efa98aso1429752fac.2;
        Thu, 06 Apr 2023 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680790962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kw+ATOWbxCBKXCFbp8YGcA6O2Jj82sWHsQ1IUWHnWcE=;
        b=F+H1UnQEHMigRQQUeavOh5bmgbRCTxKhHZV2uVzrFwOXxGCQPQaSditvT+MptCkg5E
         98mSmkrXgg9e+wldKvha/XJ+asJMg47BHd17EPFro498tawE5QxR4dFtwaKfPJ81264F
         eGvZfWaAkhRejxuNlQQongjqeQOLfcpvgIc7Z0QY9lcxyIRiIS3LM7u1fae4xgZHQczs
         UBdqn1FSOf5mkIgqXQi6icd16NWVjUq9Q12JZbVtJenjWA4FNYLVuoJOwA48OF8ktoj0
         PrtmB1QnJSauvpJ0jTMJKZyb9SZvGE1ETzrlD0Hpk0KVJXWEQwxVJB277K8j4MRpJCJL
         ZHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kw+ATOWbxCBKXCFbp8YGcA6O2Jj82sWHsQ1IUWHnWcE=;
        b=czU834VG5LQoXmJKvXiAkSnVl6w/Ih75LoVOQJInTe4o/+izjFHqLDBlhXeAW6qHhF
         zB6hnhvBJ/CACUsKWTyumbBUiKMlgmpwtjPUvgvXET7SIcETik/1wt6ovrztqmXVMWSZ
         v0E/+ILipWDot98nfxHNIOgWon0PPwbcwKL7duKQt7SgrSL+QtBEEgVBV88cjdORxJku
         X0H0CdNwZ5jDLiiH5lZXpWy0YgfrIM9RHoLFcJe8yGlirDMu3b/Uoxiuw7K0XhVH4epY
         yE5BVbHNYSvIG9veHv3R9dcE+GyoAIBwK5eN8aM26blS1Zni4tijed8zNcEsf96kjw2o
         mh8Q==
X-Gm-Message-State: AAQBX9fxqxrJCuy1eWZ/btuD81Gx5KcwogQbTdMy2jf+twzuBtu7eoju
        gmMMSOPkYRnwMyZd0cWevSHTsA4jSGY=
X-Google-Smtp-Source: AKy350brzYzTONEbP+060M6TDHDzcLRlT2MyMZjAPDfGzu1bulVqP90I2XB+SMlYQrhqLFRAqnRfeg==
X-Received: by 2002:a05:6870:15ca:b0:17a:a59a:e931 with SMTP id k10-20020a05687015ca00b0017aa59ae931mr6295116oad.11.1680790961848;
        Thu, 06 Apr 2023 07:22:41 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j13-20020a9d7f0d000000b00690dc5d9b9esm749217otq.6.2023.04.06.07.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:22:41 -0700 (PDT)
Message-ID: <c2ebdc61-6aff-ab64-a0cb-e2170edfa689@gmail.com>
Date:   Thu, 6 Apr 2023 11:22:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] rust: virtio: add virtio support
Content-Language: en-US
To:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
 <20230405201416.395840-3-daniel.almeida@collabora.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230405201416.395840-3-daniel.almeida@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 17:14, Daniel Almeida wrote:
> This patch adds virtIO support to the rust crate. This includes the
> capability to create a virtIO driver (through the module_virtio_driver
> macro and the respective Driver trait) as well as initial virtqueue
> support.
> 
> A sample virtIO module is included for conveninence.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/bindings/bindings_helper.h |   3 +
>  rust/helpers.c                  |  25 +++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/virtio.rs           | 261 ++++++++++++++++++++++++++++++++
>  rust/kernel/virtio/virtqueue.rs | 126 +++++++++++++++
>  samples/rust/Kconfig            |  10 ++
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_virtio.rs     | 195 ++++++++++++++++++++++++
>  8 files changed, 623 insertions(+)
>  create mode 100644 rust/kernel/virtio.rs
>  create mode 100644 rust/kernel/virtio/virtqueue.rs
>  create mode 100644 samples/rust/rust_virtio.rs

IMO this should be split further. If I were to suggest I'd say to do it
as following.

- virtio bindings
- virtqueue bindings
- sample virtio module

This way the size of each commit would be more amenable to reviews.

> 
> [...]
Regards
-> Martin
