Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951245E70F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiIWAzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiIWAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:55:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783D5AC76;
        Thu, 22 Sep 2022 17:55:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 46BA32A2372;
        Fri, 23 Sep 2022 00:55:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a307 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EEF2C2A23FF;
        Fri, 23 Sep 2022 00:55:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663894507; a=rsa-sha256;
        cv=none;
        b=kmKbPjnXVZOAJWd1dfwGPtDR93Sx4IrxW2DU17oYZC1NeznzK0Acuy3SHkUL64KeqhbQEy
        knwhc/eRx6FPv0T+WXfvuw4B1Uso67njEHnCbjYxsiL/u1ig/aF4fVKemugZwWCoGxXHeV
        eqr5z42ynLHoXaMw44cTK0KfoXQDFkeD52tcKbDrhzkuWduf1MJQ8ByadVS9nPQ3OaPSRC
        3Nnnytx/sheQo/SNG4bzbVQYs37lUyunWBnStWnD8y0nqrfU4CixHXoWYb07cWVuCoc6dM
        FguXfFzg4ztvs4gAZlchLBYG/vi3V22USvHRD4AbX7ir5spV2KawI/O0XdJ/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663894507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=NJOv1GZ9ChsVc8WwI5/0ebbSN1q2BAy6Ktze6dEKf3U=;
        b=XSKuHDeovNzQIivv1Jtx3sEdNxqDaCnHoiDq5Uk2lf9tbiJpmyTyrQihfB7rBEqBsjV2cc
        2UDZp5/6bshhph8lbMcjhnvM34d12X8+fu6TpoCb7P1uFzbXnXlB/qIaSYzNqszEEj9atF
        aIgmvO9iIM8++UPR/WOcFb6njpdSvBtMw037S8FCZJDI0vSHbJzipcCR4WaBx1S8oOjGmU
        xgHCw/OxCvwDv0aEDyJGaEKZEAV5vaVNVrpq8bMszTmQ8e3Sb8PGRuri0UQulRkE0YtMp1
        KZifVBoiSithLTZNFfib6RKmqu0+rLNj0tuOP0IgD7vxEWZRIEHf8l1YfdbKww==
ARC-Authentication-Results: i=1;
        rspamd-64f49dbfc4-kn9w5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Industry: 1aa0a90b1793987a_1663894507478_2110057017
X-MC-Loop-Signature: 1663894507478:1481827794
X-MC-Ingress-Time: 1663894507477
Received: from pdx1-sub0-mail-a307 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.207.159 (trex/6.7.1);
        Fri, 23 Sep 2022 00:55:07 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-16-184-147-84-238.dsl.bell.ca [184.147.84.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a307 (Postfix) with ESMTPSA id 4MYYbC1sLyzYH;
        Thu, 22 Sep 2022 17:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1663894506;
        bh=IYzaid1zIMxed8ACVzO1GtnRCaPzyovdpKRBURN9jFc=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=xNqRleZDWPQKFRgPuc6+Hgec4akieUu/OuSNnZdagx6tMRHy6JuO8AS/XcGjQxPOd
         ky4axQwWzs4iyF92Yo0vXtQRyz0Rru11NDYsvBMUkqDwTkBZb4l/SdPbYFqgSwVWFi
         l2NBcRjF0eyWf4Pnz5k1nNsrqiUiGJUYvUQ4PXBl8JZXgs+5Xi47SUcv5RM8YiXfWZ
         M9A1s6YoYBieXfIillMv6bJjeWufVnGCsUtemzjfuw/0S6IXIHTUcYwwJfnMSAPPe5
         oGE23ipAmunHfh6k0mDTPk2yxJWHjv1BBEVOHwZ4TdMOgycqLWITGrnJCbiHJ7mW2Y
         SLfxbBswGXQ9g==
Message-ID: <760dbc4d-625b-ca31-ab89-a7d44a68483b@gotplt.org>
Date:   Thu, 22 Sep 2022 20:55:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] fortify: Use __builtin_dynamic_object_size() when
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220920192202.190793-1-keescook@chromium.org>
 <e2a0debe-e99f-2259-1cb9-35193c387c82@gotplt.org>
 <202209221714.1D792FE6@keescook>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <202209221714.1D792FE6@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-22 20:20, Kees Cook wrote:
> Yeah, this could be another interest set of additions. It seems like it
> might be more "coder friendly" if, in the future that has the
> __element_count__ attribute, it could be used in function parameters
> too, like:
> 
> If we had:
> 
> int do_something(struct context *ctx, u32 *data, int count)
> 
> this seems less easy to read to me:
> 
> int __access(read_write, 2, 3) do_something(struct context *ctx, u32 *data, int count)
> 
> as this seems more readable to me, though I guess the access-mode
> information is lost:
> 
> int do_something(struct context *ctx, u32 * __element_count(count) data, int count)

It doesn't *have* to lose access mode info:

int do_something(struct context *ctx,
		 u32 * __element_count(count, __read_only__) data,
		 int count)
{
...
}

where omitting the access mode could imply __read_write__.

Thanks,
Sid
