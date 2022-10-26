Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9992860DBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiJZHIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiJZHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:08:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6790FA50E4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:08:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b5so13952279pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qUlIwZeb2OzRCIxvB0RXwAn3a0hotQnA55yAaKYVwQ=;
        b=K99xW6wkB1mD+TijD5Gh3u4HklETbLnyToQwYYGHiCr+/OtIPpuxgnfaD3mDPIaAFq
         IYPUXBOn2xy+P0FPlEavAa34rQdtikRSZzJtye7/b9X7Pp9R+aH0N0na2mUKbUYEu23x
         TOqBOfNbBdF56TEAS/dXWJbwk6uT82LNJeaeAsU6MCUKKwr8ZOy2rXtLY/CqivsPkYYU
         EQ9AGUerLPKD+lLydQIf1PQw6LzeONWFAtd9aM0MO4J9nLFG8lZsS9Eq1azqFbYY+z2z
         qvrKf8UxsuXdoRHG4Nx+7XqxbyQIH4FGADgnNhx3WYrZAHs7f+H8rOYH42yhWaqdZIUT
         xwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qUlIwZeb2OzRCIxvB0RXwAn3a0hotQnA55yAaKYVwQ=;
        b=NjgjbVtTJ1WuhDpCX/u/viJNFaPh6L0631BC+3BsbscjtudDRWctFi2MedewqwdagD
         rf7AJzNdmQQeuz3FdwZwLacGnGghbTdRU8y6BnIcRQfshsI1SqzjhcLynvZkvXS6EzWg
         nLfmkHcpvQC3zBmexB6GUbvdMYbQuPv/ud3XriB84Eo5nntDYK+0TcBMK/mebs3nmXWc
         bnIMEaF41gr2nU+UbN8lqZ/lkKGiAgGqs29Veaz0JyMnYOFhS1JDcKEMHgcc7auFzfxC
         9hZl3m3zsuLI0szvlTUTVZyFey5YE/EYT1KB+d3a81elTj0RzVmjkoY0m7+P/QNYEwOV
         94Uw==
X-Gm-Message-State: ACrzQf1XbVZZ9B1tSXQ7X4OdK5m5Mmg8/iGslDNyNTNhjrTcYB2Sf5xw
        G9yUgLI7mF1JcJ6oNcL5y14NMQ==
X-Google-Smtp-Source: AMsMyM6aVto8lYOTPaPCvCgWV9fgdB/2yGnk7ODLMaLkPX3e/fr7VWYGMr+1XuxqZ1qYNeDk7fxSqA==
X-Received: by 2002:a05:6a00:24d2:b0:567:3c7d:d888 with SMTP id d18-20020a056a0024d200b005673c7dd888mr42180988pfv.33.1666768090907;
        Wed, 26 Oct 2022 00:08:10 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id g25-20020aa796b9000000b0056bf24f0837sm2400289pfk.166.2022.10.26.00.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:08:10 -0700 (PDT)
Message-ID: <e6d6a81f-9292-a95a-ca71-642f3d1b2628@9elements.com>
Date:   Wed, 26 Oct 2022 12:38:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 0/3] Add devicetree support for max6639
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <CABqG17gYexJkzLou1HVP7n4CGyXq70oq68E+nCOwvf=OMFhqTA@mail.gmail.com>
 <20221025180130.GA1229379@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221025180130.GA1229379@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 25-10-2022 11:31 pm, Guenter Roeck wrote:
> You did not address many of my comments.
I've update comment to explain defaults. Thus retaining previous behaviour.
This patch series is about incremental change just to make it DT compatible.

Thanks,
Naresh
