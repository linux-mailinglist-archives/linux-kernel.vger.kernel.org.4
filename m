Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08F65BF1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjACLiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjACLhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:37:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF910B5D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:33:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso22889159wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/hJPuqHDVBK5C/RLmxWV9DciKyeYJTxrtXybCRPl7o=;
        b=V8KmJ8p5/FNTyH0pdGuUPF3yht2s8wE0+QMZjC9UcuigmHdDdiGNKYVh4I+f946kfn
         mc11MMlO6KZiHBuVgY+4uzhlPitnwCuSKJpVvGVFy2wfiCV0XbFKsVQF0I8Nx3SlqV50
         3hLc6Pxf6wM6pU7dxTKwK5f1EyEnJcj3dOQwVnC210eK014xpDKlih/fYk56okahiMFS
         22WXW8B5mg3C9UB3RQTJDMj2m2+/kdjretjIFWWcNiCaHpqwVKOP9RqhlYtyW3xfzaRc
         iTrVKJL4R//qwKyilsQ6sYXMtyT49VqT5FL9ty5MgUxcTMMOEsnAH/xtPifEEHmPv1K9
         I6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/hJPuqHDVBK5C/RLmxWV9DciKyeYJTxrtXybCRPl7o=;
        b=1akZTSQl7jLTz5wqjU6nZWdF+tFT3bbNIBXjygn7PHmaalgxd/MzZtLO3AYCJ+6AT6
         se+dWB2XJC/gbtifNwB4zeIvXaRFxWwOWtmruTrYZOcFqemHmXwjiipEnCF/B0CaBfRb
         LXkhF25fY3IDZ+xP/nYT07t43avlhwgNIsiB00AcV3tf/LIHhsXNSyL4ep8NrPscSTX0
         fzemb6bnLpIFegsudUnMf0MmXPhdXVv8xLBhD/5LpFHbE2tzQbOWW8sFcluM1MBdNW3V
         meOL/mDku46QSj7txPyZCCTRjpHm8af0l2NTD+SJ0Nug2Bsx3haeNWxaHuy9JdG5miuA
         P+nw==
X-Gm-Message-State: AFqh2kow2qqfH5uXMTDb+zHPsPCPW5tej3pWVoENJOLuydmVyq5kDJkj
        o5LVAAQcwrvpOgBHLoFC2QrM1fhN4uPVWjV1TZI=
X-Google-Smtp-Source: AMrXdXu1/BlJjZPE28WihSovTCFi0Eu8CmzQeOrGtC8qggLMpSvhUuh5xzxlJLPcacaQ11GN2RFbaw==
X-Received: by 2002:a05:600c:378c:b0:3d2:1f10:3318 with SMTP id o12-20020a05600c378c00b003d21f103318mr34604536wmr.31.1672745595428;
        Tue, 03 Jan 2023 03:33:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id t184-20020a1c46c1000000b003b4a699ce8esm46770088wma.6.2023.01.03.03.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:33:14 -0800 (PST)
Message-ID: <fc321ad7-0622-5869-d934-97baaf540c07@linaro.org>
Date:   Tue, 3 Jan 2023 11:33:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] nvmem: sunxi_sid: Fix for D1 variant
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20230101183316.43642-1-samuel@sholland.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230101183316.43642-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/01/2023 18:33, Samuel Holland wrote:
> This is the first two patches from [1], with the stable CC added.
> The first patch fixes a bug causing incorrect values to be read; the
> second is a cleanup. I split the series since this bug needs to be
> fixed regardless of the DT binding discussion.
> 
> [1]: https://lore.kernel.org/lkml/20220814173656.11856-1-samuel@sholland.org/
> 
> Changes in v2:
>   - Split out the driver fix from the other changes
> 
> Samuel Holland (2):
>    nvmem: sunxi_sid: Always use 32-bit MMIO reads
>    nvmem: sunxi_sid: Drop the workaround on A64
> 

Applied thanks,

--srini
>   drivers/nvmem/sunxi_sid.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
