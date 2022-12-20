Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF4651A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 06:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiLTFvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 00:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTFvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 00:51:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421DBB1C5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 21:51:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m19so7875788wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 21:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhGgoNnE9xElRONQ65yjh+766v5b8X1JMiql8M2/aVg=;
        b=faakIOkmU1PtUHPKTSuNBCAS4ncH/Tw2DEksrkDv28pLUM/7iBV/xEuS0dqd94jtkh
         DyGDFKY6oV3/fs+XpTD9xMhfzr5tk43XuJ+G3Hq38o1BoE2czu16N2g49VlJqtOv9W6t
         e1gxpNlO+mWonAm+rNC1tsKml79rIoNuGYo5GnyJza7ttb7EOP3zHnsRDxs1/ZMc4rDY
         D7hF9LA/zf+/9E55Rl5XWDsTJ+W4+ERIBCja2YS7rWhnAAwALHI340q1vMPVCZ+Gbgfw
         wJebRFFqBkMGsri+Hd6UxjUZRwKrNmNi05jjZ3TRrrJR5XG1+3orS6FGf/DAqJ/ICOEz
         RxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhGgoNnE9xElRONQ65yjh+766v5b8X1JMiql8M2/aVg=;
        b=LVkWahM0Si3xyVcG9jlFIMpriq3Qyfv33YatzYPn2WJ0l6/qGFVDLSB04jFGlafmNE
         7UVS3TwajpaqpNb8MSZIm/RRj/fLrA3ZOr+rEQIiaZ4DfmrlrUEr4FBku+qg2U/UoeOb
         uGndnlQWy33Oht9VSxzRyAPOJWsl+WDvW8yJbLqn56xeoy5Af8NQI/iVi121y6JDo1bQ
         DVw+PIL7TwPqrXNyitypwi0SyadGxx4apDfLMqJpi84n/UPLJo1qCTnnR7yyqVJFaD8/
         /O1dJoxPu+K1gtY2YrmUP0P6aC+RD3Ftaa1lf+jQsyDGMQsmGRZHdybNvh4uvZ7UuM4b
         7rig==
X-Gm-Message-State: ANoB5pl6qvKuy+dmpMOVDPzTW2QBYhCqNL3xNdhdZSXy2Arj7mHJ90qO
        +998fqxXDCNkOwHpsftbkSRBGA==
X-Google-Smtp-Source: AA0mqf54UTZMz6Y+tNgphTwnCQEOorpxqUD69GvNroUBSslNiSlD7aGprNfJ9hk3fKt39NbI36FqvQ==
X-Received: by 2002:a05:600c:1c81:b0:3d1:e907:17cb with SMTP id k1-20020a05600c1c8100b003d1e90717cbmr33550079wms.1.1671515500863;
        Mon, 19 Dec 2022 21:51:40 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b003d1e3b1624dsm23892246wmq.2.2022.12.19.21.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 21:51:40 -0800 (PST)
Message-ID: <4a378429-9a23-13a2-5837-512823e182c3@linaro.org>
Date:   Tue, 20 Dec 2022 07:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mtd: cfi: allow building spi-intel standalone
Content-Language: en-US
To:     Tokunori Ikegami <ikegami.t@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221215163950.649791-1-arnd@kernel.org>
 <d68c9137-f485-e0a0-dfc3-c72c26d0433a@gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <d68c9137-f485-e0a0-dfc3-c72c26d0433a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.12.2022 17:12, Tokunori Ikegami wrote:
> 
> On 2022/12/16 1:39, Arnd Bergmann wrote:
>> From: Arnd Bergmann<arnd@arndb.de>
>>
>> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
>> fails to build, as it includes the shared CFI header:
> The header file linux/mtd/cfi.h is included by the head file 
> linux/mtd/spi-nor.h so seems the warning caused.
> Is it really necessary to inculude linux/mtd/cfi.h from 
> linux/mtd/spi-nor.h?
> (It seems that it can be resolved the issue by removing the including 
> cfi.h from spi-nor.h if unnecessary.)

SPI NOR does not depend on CFI. cfi.h shouldn't be included by
spi-nor.h, indeed.

Cheers,
ta
