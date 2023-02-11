Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AA693100
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBKMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:34:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D23A0AC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:34:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o18so7752277wrj.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CePxB7KFqcJdJnqeVLCStgh+6TjuDL6vXxnh/Q/YF8=;
        b=kpaU8oj+heF1buMKAQwvfntLGpMBH+J7ZRSMmIwe34emSctXXCtTQhtHmY1eN+M96o
         YxPA7JkHcauXEWEzjPbwZgh5gzXo2lqbQy8dm7xkC7LxpnopAVoKHtqyV3D8a/6H5HrL
         SIIx87BOKwkLBO5SeBVkCuu/SFiSW2JAG2iI4Dm64N4IH3VBWWVtLgZnLZ5gD8VsjxM/
         JBECCCVt0TzmkpFSP0tesN7s4vE3dDGrOOJqxPXPrAKuVl9/cVzfJZJdxIi3ZUBrfhWh
         ZE6i7mIQcMAWbASkw4UWRmuZ2xl4u7xjRsthfaEf/iCzhcksIU/k0Ts571FHXfS+LEdq
         7Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CePxB7KFqcJdJnqeVLCStgh+6TjuDL6vXxnh/Q/YF8=;
        b=FgWfXu5oVjRCyWb7+xwG9s0gC0EOJ7dIt+rlqVVXis00f+QIq/NmOVG2fq2mJ4MgXq
         gjrQ13HwSqYytQlzfD2k3VfiNJ4sfsze/c5M95ow1xL7sOAyy8nhynbHN/v7NAGJvv2C
         9INzDGg0UgAaCm+bAzWlh5p/0PECUSg1TvHC8S0qimc3ncsnL0puKFkuBDcLjaM6n17y
         bAatdR+K4BNHjn0sPEFQhQwORyl3uUpDCz4nPSnL3J7PwjaNcuQx5OV8nKVUxvLQcp9c
         l9MOXtdFF1Ju+LQT1xntrMOFIBgjZVi+nAOWU4hNfMgq1V87eqTYXGOxzy8TX8B7Nqi4
         jasg==
X-Gm-Message-State: AO0yUKV45VFNbdEXsT9s3UsobLqTR0npi2Q5dAglrwHiLv7ETEbwMovq
        qRi7QaKQu3dAjQ/s6m5lLzJYmhIqqpOXABId
X-Google-Smtp-Source: AK7set9b1POm+apOqPdzNGr7L72OnK2sTfzTvEZccjfPPNjPOBpxRzi25NCJfowZqRaUVDEmPohmWw==
X-Received: by 2002:a05:6000:110:b0:2c3:ea52:7d0e with SMTP id o16-20020a056000011000b002c3ea527d0emr15512002wrx.69.1676118882669;
        Sat, 11 Feb 2023 04:34:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm3991745wrq.25.2023.02.11.04.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 04:34:42 -0800 (PST)
Message-ID: <c901eab2-ca65-46ce-a100-b24bf7c1600b@linaro.org>
Date:   Sat, 11 Feb 2023 13:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] get_maintainer: add email addresses from dts files
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 13:14, Krzysztof Kozlowski wrote:
> The DTS/DTSI files represent hardware description for Linux kernel,
> which is necessary to properly recognize and configure hardware by
> Linux.  DTS is usually created by people having the actual hardware and
> having interest in keeping it in good shape.  Such people can provide
> review (they might have board schematics) and testing.  Unfortunately
> they mostly do not appear in MAINTAINERS file.  Adding per-DTS entries
> to MAINTAINERS would quickly make it bloated (hundreds of new per-DTS
> entries).
> 
> On the other hand there is no point in CC-ing every Copyright email
> appearing in files, because it might be outdated.  Add new in-file
> pattern for storing maintainers dedicated to specific boards:
> 
>   Maintainer: John Smith <email>
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

This is obviously not a valid tag anymore... I'll sent a v2 tomorrow.

Best regards,
Krzysztof

