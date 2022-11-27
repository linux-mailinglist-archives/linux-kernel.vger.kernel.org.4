Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979A639CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiK0U3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0U3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:29:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6103DF99;
        Sun, 27 Nov 2022 12:29:08 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so8235665pgc.2;
        Sun, 27 Nov 2022 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqT2jwj+ovMyzCyXRFkgVGSRBt1LK3EGa10LCZOW9kw=;
        b=nHtg/S1jzVMxVvRJQyPVoZgw6iTheoJcGktq6nYekGf7AofLVtsZpp4FjwaHTPp2dg
         t0jDepKHDDFrTVvxCme8nf/3yxKkL6rSPhZ6ukfKLqsytA/X8iBYlwwFtT8+Z6Bf1bK+
         icqkUuDbq+zz/rIEsP9CLIVTuKXAMJfxoTYGHJcIK9LAhm5O4dasRmE7aJy6jNW3K2vc
         HKi5qF8RPv9AuT6C8wc3XKkAO5HuN0sSpZxbhl7qSwI8cKK+WSOTJU1919ZCKA4ijMDG
         eLCwacnFwnhcLnoMyOcwNUwVG2TBaGxO+XPH5dQ8srOF6YVNZpbLalqY0ucZN8KKiMYp
         dzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqT2jwj+ovMyzCyXRFkgVGSRBt1LK3EGa10LCZOW9kw=;
        b=U1IkKgA/m+O1HtYngYs2B7IKS5T6nvQq+y2NPP59F/KR3evqJzZY5glKkiK7CbR0PI
         KPgJroc5zm9Koef5RLXg4L4elppmrVKwY+KD2NPnNcOruXnPVTEpx7ljJTu3X1csDtVZ
         AMEvDtoxXBQSmy4LKEPQHvf6wLaUFofUF55JtMFo9NiQ60FhzMseZJBOW+iVuyjb+hd0
         5S2OouSgbY4v6+D231Cn6Li4TN1pkc6JEsONEIxhfQumZmEPdeNI1cAzN7d/4EZPpA/3
         cCKBhKka+5qXh59Cv2n0GlDQ6IYw0OMtBMOFlm27+bJlaFePfmD6yj/zMXz0gg4aMLan
         W9ow==
X-Gm-Message-State: ANoB5pn51Epy6EhadAo4nRTXSF6NbGM7XDrUFxi6b+W69J3XckWZrd60
        Yu9CBgr7r23NGd1B48SUs+oWnNPd1is=
X-Google-Smtp-Source: AA0mqf5IawY8rqoLGJkUzo30PexflvAE2ZrH3Qoi8JsMX4IJ/LkzN5rtTslkrNB85iJ3HBs8VqazWQ==
X-Received: by 2002:a05:6a00:450b:b0:574:c544:3b5e with SMTP id cw11-20020a056a00450b00b00574c5443b5emr12065656pfb.66.1669580948310;
        Sun, 27 Nov 2022 12:29:08 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:f1fc:63fc:c03e:8357? ([2600:8802:b00:4a48:f1fc:63fc:c03e:8357])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79ec6000000b00574ee8d8779sm2892230pfq.65.2022.11.27.12.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:29:07 -0800 (PST)
Message-ID: <d8b85833-82ce-a173-ac4e-ccff9ae3e660@gmail.com>
Date:   Sun, 27 Nov 2022 12:29:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] MIPS: BCM63xx: Add check for NULL for clk in clk_enable
Content-Language: en-US
To:     Anastasia Belova <abelova@astralinux.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20221125092601.3703-1-abelova@astralinux.ru>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221125092601.3703-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/2022 1:26 AM, Anastasia Belova wrote:
> Check clk for NULL before calling clk_enable_unlocked where clk
> is dereferenced. There is such check in other implementations
> of clk_enable.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
