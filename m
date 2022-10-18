Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563A4602C34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJRMyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJRMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:54:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE6C4C2E;
        Tue, 18 Oct 2022 05:54:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l22so20288495edj.5;
        Tue, 18 Oct 2022 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VZrAcxYIFLhBzdmWrO+0osx70QYrpMUX4awPJm7NAI=;
        b=ftXv806rGAILQ+FzU8QV4pQRO+u2iUTu9nNDx5gr0EITjpUgxiQYaD+uFko26DChbf
         mteF68jR/Vl7xHlegQibANlr8D7p1xs9MOAb594xr23jplXZF+Ay+roWraFHR17d0z02
         ZYbswuzR+9nH579Ql0xyfu4+uE3KeF6FbX05nQnHUl/tny+uwrt7sd5LFHuMvWXjrcKL
         JW4xebwV3D/5/5BWpJWLZYH6kv0Q3mgFlGt83t2qxgi4gniGWJUtPa3kH44WSNI2UbIu
         ufU1f2GoB8j5U6vJ6bi1zLIquXU2QCMLUKswrQH/rlrS2l5o50idJoewYg7pkgGaRdFh
         ZOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VZrAcxYIFLhBzdmWrO+0osx70QYrpMUX4awPJm7NAI=;
        b=1SxOeoEq7z5nYd12VLmuMisdGmuqYYm5inZIQrqzAjjwqzVu3bynLUfbEOmR0MJ7qJ
         8thN2ZKNCL/4xC48sg3Ramd/ZSOw1ROslgVStK0PHWM2qOfMXha8xvU5W3Qx80ARdtYU
         J0Na4kO60ioEDPad4Wmr2wnx4eVWC2ESXbD7zksanmNoIrWY/MDi+PzX7JOdPKIFzgml
         PUOYHL/h34dQsYcvHeNrCOvUjg5xqVcnH83Jb6HpZT4mirh+RW46jMKJbmT+jneeVF0I
         3j3FasdYh+Rl06RpTSF+RfHTbDNWRCRrNbdsnPEZR9myDTvppldcXMylBCfT3qW1+g9h
         /Ecg==
X-Gm-Message-State: ACrzQf3ZJeEkSmQyjRrFg1OfRjTUmgAVBhkGD7FPZ+esVc/T0y7XdgRf
        s6S2bn9LrAxMKD1Uhrc8+Y0=
X-Google-Smtp-Source: AMsMyM7kL8grcFCnBhd5sOHIhyXGwrFcVflwEN5K6HesM+p/OpsVt1t8AZUk4PWPZsGvtMNiyXxjTg==
X-Received: by 2002:a05:6402:3887:b0:458:289e:c9cc with SMTP id fd7-20020a056402388700b00458289ec9ccmr2491864edb.101.1666097648734;
        Tue, 18 Oct 2022 05:54:08 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id k17-20020aa7c391000000b00456cbd8c65bsm8962346edq.6.2022.10.18.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 05:54:08 -0700 (PDT)
Message-ID: <f7e79f3a-be97-334b-84f2-76da0981e991@gmail.com>
Date:   Tue, 18 Oct 2022 14:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] perf report: Skip symbols for idle symbols
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220608055146.1446-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220608055146.1446-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.06.2022 07:51, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Displaying idle symbols is rather useless and makes reviewing "real"
> symbols harder. perf top already skips them so perf report should
> probably do the same.
> 
> BEFORE
> 
> # Overhead  Command          Shared Object          Symbol
> # ........  ...............  .....................  ...................................
> #
>      75.04%  swapper          [kernel.kallsyms]      [k] arch_cpu_idle
>       1.05%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___inval_dcache_area
>       0.78%  ksoftirqd/0      [kernel.kallsyms]      [k] __netif_receive_skb_core
>       0.75%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_table_lookup
>       0.58%  ksoftirqd/0      [kernel.kallsyms]      [k] __dev_queue_xmit
>       0.56%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_start_xmit
>       0.55%  ksoftirqd/0      [kernel.kallsyms]      [k] __skb_flow_dissect
>       0.53%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___clean_dcache_area_poc
> 
> AFTER
> 
> # Overhead  Command          Shared Object          Symbol
> # ........  ...............  .....................  ...................................
> #
>       4.21%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___inval_dcache_area
>       3.13%  ksoftirqd/0      [kernel.kallsyms]      [k] __netif_receive_skb_core
>       3.01%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_table_lookup
>       2.32%  ksoftirqd/0      [kernel.kallsyms]      [k] __dev_queue_xmit
>       2.23%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_start_xmit
>       2.21%  ksoftirqd/0      [kernel.kallsyms]      [k] __skb_flow_dissect
>       2.13%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___clean_dcache_area_poc
>       2.00%  ksoftirqd/0      [kernel.kallsyms]      [k] eth_type_trans
>       1.86%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_poll_rx
>       1.73%  ksoftirqd/0      [kernel.kallsyms]      [k] __local_bh_enable_ip
>       1.63%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_rules_lookup
>       1.61%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_poll_tx
>       (...)
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Ping? Does it look OK to you?
