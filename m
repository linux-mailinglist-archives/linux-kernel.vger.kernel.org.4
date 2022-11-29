Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59F63C246
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiK2OSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiK2ORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:17:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B768C7F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:15:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n1so12640880ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRpdkJK2Wo92ON846N6eHVIM5x8Sd+GDvvbGsGBzl0k=;
        b=I+R/M8dE9pmPamxZ3RSuWcocOq1rviSIGC0ap0QPJgzV1OFULdizRcDBcRmhvJ3niN
         UBLin+dkqj5rdvepvMyFLA7YMrqpuTk0W07CFV4CEBZJdEt7RAkSdIJddwMLHap9qo5a
         UV1W3K+GE2LD68UDPxWMo/GWAPsiZfcnL8/QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRpdkJK2Wo92ON846N6eHVIM5x8Sd+GDvvbGsGBzl0k=;
        b=OXZHk3EjFHhCLHAye5kqKqqrxvBg1w00X6zSD5j5p1Rn6VrYcADxIezLWqRZAEPDRQ
         VwAJWM/2BICwcg1/HF2X8++DuwXT+0BXfgMPXNR5HRaWFOyEQxFbeZOjZ1+F8TbH5n9Q
         DhuDI9rdNQwXfHjUsRPG/6wv1qWRDiOBc7NRSSMSnt564IgAfJy5/d+mkH3UOsyE3ony
         enSvCJ1x2mqYTChFempyx8n9sleo7AEM394b4CZw/6AQSaHIgJqTk4A3dENeWtVJ+CCj
         CDNaDOFO/4A1EFLg3+jWdsS24CALPhjRDv3epdLW/vEwbgGXpmc9dKlGqigfAr3hBjHn
         clJA==
X-Gm-Message-State: ANoB5pkURJ7mNf8vIcsuwiJTqM9zQ1NessbW/JUYkXtHBntYJ3WETg5L
        G1lEqWUlxU5PfvihsjR5svx/zA==
X-Google-Smtp-Source: AA0mqf66BjvHqAMZwEdJBt0dFTt5/SHy1+6HQvcJmTOWZBR9LFU3R1/MSDg9xbs8lvTCdJbqEGsmrQ==
X-Received: by 2002:a2e:be8b:0:b0:278:ea67:a38c with SMTP id a11-20020a2ebe8b000000b00278ea67a38cmr11889405ljr.63.1669731333470;
        Tue, 29 Nov 2022 06:15:33 -0800 (PST)
Received: from [172.21.3.193] ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512071000b004a8b9c68735sm2071805lfs.102.2022.11.29.06.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:15:33 -0800 (PST)
Message-ID: <05782b6b-4e09-2b13-32c4-4984753dcef0@rasmusvillemoes.dk>
Date:   Tue, 29 Nov 2022 15:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 5/5] rtc: isl12022: sort header inclusion
 alphabetically
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
 <20221126141806.62205-5-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221126141806.62205-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2022 15.18, Andy Shevchenko wrote:
> Sort header inclusion alphabetically for better maintenance.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

