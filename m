Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9736A23AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBXVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjBXVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:23:13 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D21B2CD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:23:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c18so921476qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZcfwYpRFhxRbtVVFgXzd4RYCjZIkZuJjM17ifJohVg=;
        b=qkuoN/kQ0TML4aC0Muu2PAHKLj6ib/OH7cPNW345hvn/1yNlN1MyWP6GGLDHvSWn+w
         R1Wv4qvD42f64LLMldhJEbk7WMpaJoZB3mSXo5tor8XjWgFTNyXklXzxrdTz7ZOV2BuY
         zkQ0lcUbDBsGBqaXdeCmcEH2F/RODBGryRMU/rdFKUTKd4wvdCTiahDHU6mEgaRKjY2r
         ziXs0FsMyfFpLyqF/pc5oniMIhStf88qi+SQC6BxDm3FmBqDEQPXY9XFEN7qAe6YdDd0
         /PevOJSVN7xyrhQwT7BH2zE+8B1cdOEjsVH35MXsX9iMBbTEqEtLqzgOuV5qD5J8jngR
         floA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZcfwYpRFhxRbtVVFgXzd4RYCjZIkZuJjM17ifJohVg=;
        b=CyR14KFnvbY2oI6TUTwXfz8nAJH0HVG0AkYiLcJ6lkWRn2QAStFliijAl5/FfyrOh0
         l478NefDPhErCsDhzBbFxiKeBkf4dLGCIK4x493+kziIssPBDPJWwVLpcmquBJcAo4FB
         GMy+edwkv4fczV7CJV+kbNaVWqG3PlobnWqkckxYod+hDdgMAb0NTv5F7pZJnioRStmS
         bfoBcEyWtZ2AUolRV7iI97TvEB2IJbKoXTmsQsnpVmNTu6ngZeVZkLpdO/FLRk7WE6ym
         Nb+BLqxSAnMN5XT+MAl6MmZs7nLn6IIoj38IxC8Df1PwmsJ8y0kbUdxWb7A484ffdjVL
         shgQ==
X-Gm-Message-State: AO0yUKXi9YhiuYWd0S9+n2R1/YKti8LWzhAGnok/LLFjvYYH4D+l8Sqo
        gU/a5zA2k/qR17JBhFqommiYNuyllWA=
X-Google-Smtp-Source: AK7set97/18E3r6MecElnDDstyVJEJ5rRpZUkU9pfEa8P5qsvxHk1TPc0RN1J1ds28wWvJIwUA0h0Q==
X-Received: by 2002:a05:622a:18a6:b0:3bf:a7c1:46a9 with SMTP id v38-20020a05622a18a600b003bfa7c146a9mr24350088qtc.40.1677273791789;
        Fri, 24 Feb 2023 13:23:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ay35-20020a05620a17a300b00728bbe45888sm75850qkb.10.2023.02.24.13.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:23:11 -0800 (PST)
Message-ID: <360c0777-14b3-41a2-310c-6489f90a5104@gmail.com>
Date:   Fri, 24 Feb 2023 13:23:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] reset: brcmstb-rescal: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202302161052126378140@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202302161052126378140@zte.com.cn>
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

On 2/15/23 18:52, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to Use devm_platform_ioremap_resource(), as this is exactly
> what this function does.
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

