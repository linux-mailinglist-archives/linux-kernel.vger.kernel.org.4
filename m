Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3468ECC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBHKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBHKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:25:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA36457CF;
        Wed,  8 Feb 2023 02:25:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gr7so50012138ejb.5;
        Wed, 08 Feb 2023 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAiuvTtBVT5H2AGg07DPbOggtDU15V2H0SBz8mvPnAI=;
        b=bGWMjVjgNwJ6nYDWV1D3pU23XzadqF4LSZxr92HCUzZJFPYLLNaIMYfy6Bd6dv/4Bt
         hfCkaZA5KcoB/LRUHvtMooKsemW8+qe/leywa2UKmQJWdFgNSxZoQxYv/pJkLrdWrEqb
         fMq9r2eCg5JC1DreZ30Hk+VtaNElUZqBMOlZdZlan0EuQHKNteO6bd0ykqADptKmM6Rw
         1YkXiYX2A1tYWB/VYTQRr+jGxjpvKTaCsK40nwc4it0mwkohH5mAoXNpFMhlnUJEbS/l
         oReCdyHMCmw79Nz6RSXTZd9Io5QpC4wKM91ympeNj0v7gGfqN1FAdnxUfJbDisdn6k5f
         ccWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uAiuvTtBVT5H2AGg07DPbOggtDU15V2H0SBz8mvPnAI=;
        b=KT5H9sNFp6drVs4QM0IyunrMTMVmC4n0TCXc4V3rk8l3ZEeaEWvFYawK/KVKJsYrQ9
         86dMUrEz3JfN7ZdaDeca6cg6Luu1q5/9QJwMmv0LhPkMgFHv152lpT3QB5QzlI8gMjNw
         zu0l8OcC7mVxUDd8JKBT/6gYGsLpROo+H3f39gy5XnwGQuRWTLzHe8nh2olIWUcxXna0
         1Op7cy5Hg0rBsNu6ay6uG/o8M0e4Are7oDGgRSTnQXRhKXytAd6fSjqmR9HbvqNX7IJv
         Vmh1hDByg4OsKj78UbWkOiOi0Wtcr2u1oUmbdD4UABli3a01weZv0EEFJDKbyynZiyaw
         3vow==
X-Gm-Message-State: AO0yUKUxTzXynnqQzrEmdpOCgaK31IRNKVxF7panspSZKrRsTYSkC3L2
        NeJZUwjGSxTcmABKOol0EU0=
X-Google-Smtp-Source: AK7set8VUcIbIdd/MDNC0KChsHD7nLT/jgOJZA5Q5v+SYgFNvU9TZOtIx9c3OYYgmi3dc+osmgjbyA==
X-Received: by 2002:a17:906:f49:b0:887:915d:7502 with SMTP id h9-20020a1709060f4900b00887915d7502mr6931291ejj.31.1675851938563;
        Wed, 08 Feb 2023 02:25:38 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id dz16-20020a0564021d5000b004a0f9d31d18sm7675594edb.71.2023.02.08.02.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:25:38 -0800 (PST)
Message-ID: <0496ff17-0a02-1192-3c9a-412656a38b6a@gmail.com>
Date:   Wed, 8 Feb 2023 11:25:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3 2/2] nvmem: brcm_nvram: use bcm47xx buffered data
To:     Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675717472.git.wdehoog@exalondelft.nl>
 <e179c12f73a6035690e814b842f677bbb38f5c96.1675717472.git.wdehoog@exalondelft.nl>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <e179c12f73a6035690e814b842f677bbb38f5c96.1675717472.git.wdehoog@exalondelft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.02.2023 09:42, Willem-Jan de Hoog wrote:
> From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
> 
> The bcm47xx module has a copy of the NVRAM data in ram. When available, use
> this one instead of reading from io memory since it causes mtd/ubi to fail.

This doesn't explain anything. Why do we need that? If anything we
should rather get rid of that NVRAM firmware driver. It was needed
before we had all NVMEM stuff in place. Finally how can reading
iomem break mtd/ubi?!

It seems like some hack instead of proper fix. Possibly because of lack
of understanding the issue / some subsystem.
