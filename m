Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35626EED7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 07:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbjDZFV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZFVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:21:54 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1EC2709;
        Tue, 25 Apr 2023 22:21:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A815F42181;
        Wed, 26 Apr 2023 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1682486509; bh=TiVwkl0bdCjyZansOxApssplxzbGxuiV0CUflGMyBDc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bzF3owjPQuF1nKFoRcrDTEuHjlOI+aIgj9we7/Slr2X9SP0Uf1tCmvltIOo79SpeQ
         zFkrV5ZzEI13yOc30xuCiGVWDEyfqISN1WmLGHmcoZsqwqA8PY5HMPjJNCT0xh2UyH
         0xN+F6YvOOQ+g1QICD7RfYQ7WwXPHZMS4zQb8awPqNFmlvXPbFQOrmlEfmWJxzV8Nz
         spo8i7t9fJB8AiTRZDXHFytbN0DsVGDO8iiFFadkx+Ij0LfIwwgB3VX/QoQdx2Y8xw
         Y+zfyNWLxaldz0yg5zWSnmeedxcXdzxG70Tnz3VzALO+sfJmHzsJby6rZDaJNz6oJL
         S43QQGiUQNFJg==
Message-ID: <478d993b-3011-f335-139e-1f98db6f6b00@marcan.st>
Date:   Wed, 26 Apr 2023 14:21:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ACPI / property: Support strings in Apple _DSM props
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.kernel.dev,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230424-acpi-prop-v1-1-ffa9a300b1cd@marcan.st>
 <20230424202030.GA19243@wunner.de>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230424202030.GA19243@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 05.20, Lukas Wunner wrote:
> On Mon, Apr 24, 2023 at 03:46:57PM +0900, Hector Martin wrote:
>> The Wi-Fi module in x86 Apple machines has a "module-instance" device
>> property that specifies the platform type and is used for firmware
>> selection. Its value is a string, so add support for string values in
>> acpi_extract_apple_properties().
>>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
> 
> I was about to review this when I spotted my Reviewed-by tag above.
> Turns out this was first submitted 16 months ago.  Wow, time flies!
> 
> https://lore.kernel.org/all/20211226182012.GA5527@wunner.de/

Yup, the original series was never merged and I've been pushing the
brcmfmac bits piecewise over time instead... and then I completely
forgot about this patch, which turns out to (now) be the last missing
piece for WiFi to work on Apple T2 Macs :).

- Hector

