Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245506A23A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBXVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBXVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:22:24 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB1196AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:22:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id ay9so878322qtb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcobua8ogxfB0rTZZ9/k1LCNR0f0kmPDNROWyCL3reA=;
        b=ZezUPmwtigm0hIq0/UA4ERBhy7qpFzJqLgNACfsfEy2iYd5CjZ3vw/TpBguWJ9n+B1
         TWeofj2H4GhD12mruB7Hi0meRBOD/AIVSioC2BB036klTjutP6kvpvAAfDsO1ugTQxx/
         VRaGH6wXnQAUBsNChz7DRVdwb0oXsKq5dI1gxIsAv12qaGzYMdr8xWNAQs8NClZnpbva
         8dzm/R3IhI0aiBkIQxBB7PHRVxrfLtv/OI0KQCwYfqq5uWBacCk3wnJzPt4XmfDFpbmG
         ZxtDL0Ks1nLZFEIMQabuB0Y0X0gMQ1B3afWjjdI8wg9yFIcgADw2nHZOkxyYXSQXvD9s
         Xmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcobua8ogxfB0rTZZ9/k1LCNR0f0kmPDNROWyCL3reA=;
        b=D6JLwP0Z3tt5wuSEkfTKG13JuhSrhKxKwhbh2LMpoPADWgVFukI1rFmRvmpILxvI+8
         SNykHi9HrCCRTNFYPHz8l38nlRulI7W7UsHfQ0y61L5Rsb8Tcn8NzwSpJXF2vtXJOgE8
         YD4QNKYwHM5I34kLPhHm4KDe/ZUuErzHiRYAisqZQmTXZN+TzIZDSzK3kFK2G7PCJcpp
         2NWhmUJpT19I8Kj5+cKI19GTpByrG0K10KA4eZ4MqJWanrnkNEPgxOuYQS8LvmPNIMIF
         7EHb71AXekbj25ckczzcbQiBYzw5P2q1dn98zytWISm/3XZe0v2L8EFr+g5EUgtWrEIf
         KMCg==
X-Gm-Message-State: AO0yUKXTxXijVxjV9J9GS4wVjaxtvXHjqxg9ik4sWiBekrw1UeY7kKjY
        JRZfFaTDWUximVPLvRDDY9G6TYqwIO0=
X-Google-Smtp-Source: AK7set/WfJLKu27rCIEDAfYWxpevvsuxaYUwgfx9b7nE5qsmaL1MTMgbiVujUUpmXR+0N3MKlkcrPA==
X-Received: by 2002:ac8:5c49:0:b0:3b8:293c:24eb with SMTP id j9-20020ac85c49000000b003b8293c24ebmr1939159qtj.30.1677273741849;
        Fri, 24 Feb 2023 13:22:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y24-20020ac87058000000b003b0766cd169sm286222qtm.2.2023.02.24.13.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:22:21 -0800 (PST)
Message-ID: <185ef755-24ff-cb98-81a6-13bc05a5bd61@gmail.com>
Date:   Fri, 24 Feb 2023 13:22:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_reset=3a_brcmstb-rescal=3a_Use=c2=a0dev?=
 =?UTF-8?Q?m=5fplatform=5fget=5fand=5fioremap=5fresource=28=29?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202302151707187228042@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202302151707187228042@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 01:07, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

