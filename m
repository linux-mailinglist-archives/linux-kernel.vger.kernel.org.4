Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1D681719
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjA3RBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjA3RB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:01:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB86FF11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:01:26 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o1so891697ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tjmaj2MJCcTKHXMncTm7aW6k5LVjR/lC5G4E9cb48UE=;
        b=MNZNEZdmQX7+K0QS12v4RgLYh5FQYC0W9kg6t7wWU9EEDC+KAVWIDekE01y0fpkgBA
         zWEayL2RynNTe0UNuNtaiAA93AfafwBJXsIEfmp8/3lZAyAdOSchhGZkJm2ER/yv9WtJ
         goDVzc/c83wSyg2wtfEZmBqTQ/E2F4j7oBlu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjmaj2MJCcTKHXMncTm7aW6k5LVjR/lC5G4E9cb48UE=;
        b=F1i6H2AqdiXCLkBK4UNe03IDhuXuxrgqZ/QkWm2sA6kMF+vJ2N9PRmH5vIOJHdA+P6
         o/RBN/17Epe7QOYtJZ5q1ndoIq4UJ1vhsM6coJa5ZVR6syCgFIUjnTTzyKoX0cvm6Xv5
         88w/gdTrDcYobG9SgfyG2nXiPacsSev4XIQ5TLuXl8F+WFrp/7bE4k5WrwBvsmz958eE
         bAIUGkL22fx2mBv1XjxMAuVDMTd4KJKzt9rGwlXxN/0fXhOCO+JgcwXGHJIJD6gIM8O3
         ijPKWl3eUczfzWag/gax+DwGAYeCwv3hYxGbSSQxoT6ZF2ePRG1iyXpz+a1+yw6DCVQG
         tkvg==
X-Gm-Message-State: AO0yUKVn9aGJJgGq0nMMK1EjF0FHl2HpSP+Vg4z23O0b31Ptf1Qzs0+P
        uMLJ9NwlSODvHKJynSQQ1+xwYA==
X-Google-Smtp-Source: AK7set/m9LOt7r7IU303XDwjQdWiXMRNjNB7JM1ZXoUQuMCKkmegQdTBjoVaQwpZ9WFYYV6Ttbh6MA==
X-Received: by 2002:a5e:dc04:0:b0:718:2903:780f with SMTP id b4-20020a5edc04000000b007182903780fmr1282486iok.2.1675098085362;
        Mon, 30 Jan 2023 09:01:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w24-20020a6bf018000000b0071c89dbc77bsm1209271ioc.43.2023.01.30.09.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 09:01:24 -0800 (PST)
Message-ID: <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 10:01:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 31/34] selftests: iommu: Use installed kernel headers
 search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
> than using kernel headers in include/uapi from the source kernel tree
> kernel headers.
> 
> Remove bogus ../../../../include/ from the search path, because
> kernel source headers are not needed by those user-space selftests, and
> it causes issues because -I paths are searched before -isystem paths,
> and conflicts for files appearing both in kernel sources and in uapi
> headers with incompatible semantics (e.g. types.h).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>   tools/testing/selftests/iommu/Makefile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 7cb74d26f141..32c5fdfd0eef 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -Wall -O2 -Wno-unused-function
> -CFLAGS += -I../../../../include/uapi/
> -CFLAGS += -I../../../../include/
> +CFLAGS += $(KHDR_INCLUDES)
>   
>   CFLAGS += -D_GNU_SOURCE
>   

Adding iommu test maintainers:

I plan to take this through kselftest unless there are conflicts.
In case there are conflicts and you want to take this through yours

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
