Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3774167C7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbjAZJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjAZJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:51:20 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51285D903
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:51:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b7so1181703wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgf3hT7Q51RwYY6X426tlOtIyXXWU3x+uA4ERR9/K60=;
        b=KZ5jb/fzIX0sz1E4Kc3JD9zlUEvxv054yzswpWGDW4KBHE5nhX4z6+dIK+U4CU5A1f
         7Kpk9v3/qXB2xzEm901M/AHN2R1mg2gQypkXvQwwZicOKMFfR7iKZm9XBgu/t5vkPG73
         G1Vpa1m8IVkYZXAOhQn5O7dVgz1naYcRZZ4Wy03cvzswWZgQPeT2IXq4aGBRb6aGCA1x
         g/OY8QlPBj/UJEa4qpztTHntNvlVFVmB+ncvkBEQaJk2MLuQ4IjfItkm1nYJl4FliSZ3
         YzUCAJkTbex45sxc0lGaPHknrYZgg4McIdjBgHoUIMWCUNiN3DX3s2UcWxZc/00oAnPF
         JehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgf3hT7Q51RwYY6X426tlOtIyXXWU3x+uA4ERR9/K60=;
        b=RmpS1ItRd/xnkoS9mIqFDgF6UO/BzeHMwMzjnxBq2uXHS+XYO4MrRZUN4AEBsK2Fbk
         YpdXu5qKzAVFG9FZ4XSh3bAXGtUN83c5nHkM3U0fVjlEXXkx5oivxFJ0HjLXDZyE8BE5
         yZmMf5MDGXtIsSYYlfv+1SiEgtwS0DWrelrjzJdlXAk2B3/NkANFXkBLgXm0T/aGlXT7
         paDzRiuFgB8B6/WybXEiv+KoonY0RpjbkjJgfIQs44NwCNQzDxZP4y/pAtCd15TXA01s
         DiQx4ZJOtixdgBTTApsAbee00Ta5/qFYRCHCwKtt8nnneXW0MDDUUS0ok3f7cS6NiteW
         nO9w==
X-Gm-Message-State: AFqh2kqopqNXs9WTsY4xK7cfRbzeYZ3l4T8Xw4iSKurC7BYceaJo0ddh
        fwCPKTOOCRHDDw0F132uY/SX8g==
X-Google-Smtp-Source: AMrXdXvrNt8t6NlvWUlu4bXiX1TjpUBMoB5tNp0j+nZwBeWxSKFrQJIAwh2LVQ/8kNV/uq1jpGLFkA==
X-Received: by 2002:a5d:5954:0:b0:2bd:bdb5:baf1 with SMTP id e20-20020a5d5954000000b002bdbdb5baf1mr28541765wri.10.1674726674404;
        Thu, 26 Jan 2023 01:51:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b002bc6c180738sm963388wry.90.2023.01.26.01.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:51:13 -0800 (PST)
Message-ID: <1692b03b-bb93-abba-82a6-ab5a1a6fcc37@linaro.org>
Date:   Thu, 26 Jan 2023 10:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <fb2a6e85-42ad-8b17-4433-8d5e96c87a80@linaro.org> <Y84wDxiBE6CZqSO5@ninjato>
 <8f9d6e07-6549-9b2e-a45b-f262b59bfe5f@linaro.org> <Y9JBfTVqjXZqi1r3@ninjato>
 <CAMuHMdWbEJ3kdAWXfMb5wqDhtjbDgJ8cCdnT-CTe2P4FAyAb7A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWbEJ3kdAWXfMb5wqDhtjbDgJ8cCdnT-CTe2P4FAyAb7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 10:27, Geert Uytterhoeven wrote:
>>> I did not get whether this is runtime characteristics or it can be
>>> customized with compatible (just you did not do it)?
>>
>> We have compatibles per SoC, i.e. "r8a7795". We don't have compatibles
>> for ES versions, i.e. no "r8a7795-es10" or "r8a7795-es20".
>>
>> The latter would not be practical. We can't know in advance how many ES
>> revisions there will be, so we can't prepare DTs accordingly. Updating
>> later would be also difficult because we are usually not notified if
>> there is a new ES version. Only if there are problems with it. And which
>> board is available with which ES version is chaotic^2.
>>
>> Also, if we update DTs later, old DTBs would not work with newer kernels
>> (requiring a later added compaible for a new ES version). This all still
>> ignores that it would be a churn to update for every ES version of every
>> SoC. We have quite many to support. That's why we use soc_device_match()
>> for ES versions in many places alreday. It was never a problem so far.
>>
>> That's my reasoning, probably Geert has something to add. He maintains
>> the Renesas DT files.
> 
> Exactly. We only use soc_device_match() to distinguish where we do not
> have a compatible value to do so.  As we have SoC-specific compatible
> values for about everything, this means we usually use soc_device_match()
> only to handle quirks on specific revisions of SoCs.
> 

OK, thank you both for clarifying.

Best regards,
Krzysztof

