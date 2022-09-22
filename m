Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAB5E5F27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiIVJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIVJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:58:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABAFBF52;
        Thu, 22 Sep 2022 02:58:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t70so8636777pgc.5;
        Thu, 22 Sep 2022 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mlVUe7l2F/vn3OtB4sD70BapoKrCHXhr5Co6S55gUs8=;
        b=phU2ntpVCueSAj/8cPKMMPYoxyT8QvvZCsKgV3NaB8AVN7BkMyanpoyrZRgE1ygMxm
         qFmHtayg4CItXpNclyrKGQOm+N7qztt6yV4uWepO6aO1XZjhdi2aaNPGBM9ba4IZxjfv
         MbdUPLd90T8FXlJCHhagU4F9E7U9mhisnWvDVerMGtRQ1jlcghh8D1GGYJUGLjsAPohD
         8IwPssVUARhnt+j9Je4FsVIt24yG/GlD9N4wYgh2I3WkA2/AuzZ92Fs2lYw47c1jicSi
         tEjqxibJ317gu0zgvM7uwkJqZXIyFqniecKVjUBK+4r9Ja1exDtGdRX7hlSCDyjPbjRO
         otlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mlVUe7l2F/vn3OtB4sD70BapoKrCHXhr5Co6S55gUs8=;
        b=ShIO5q4vmQaMyEcbnxjqBXAnAz70cYoE080ygcgoB2+e7+N5/Ox3MXwU0h7cDqBWUo
         JhU5CCfH6DL2MgZ5mWmpv94Urd5p5s3rfPjUZUhAbT/HE3iSSl21HXe62CJnslJgsRNC
         HVpuZubCJZIy2AhLMDPoi8KBfAiS1GyzTPBGUpJE2SnC0mryhcUMHb2L8RLNNyRSwtYQ
         cxUqiFURaIfk1LPkenTHH5e5sUPqxf016i4dWMtP7PCoSqRkQLnTAnjcVAuSxFKLBuSi
         lAN0/NqnRUc+vX6dkFGnpChiWQqw/xOaw+qobPmDIELrGCqog5p5c5yTg3O5rSL9t0Lk
         u0KQ==
X-Gm-Message-State: ACrzQf2YSjI0wa0HJm+cvici9rmjXz7f0Sly7gFp9WWuinl+AH5/CSUX
        8s2Lpc/MzjEr+P6FoCkySd693eYnEyo=
X-Google-Smtp-Source: AMsMyM4+MlOo982tTNcMFbOk5Y11Q+6T2ezdcAOx8BwSoMhbWYb6/PYAObZL9a2t8WfICQow2nwvVA==
X-Received: by 2002:a62:1bc8:0:b0:546:c62e:e84 with SMTP id b191-20020a621bc8000000b00546c62e0e84mr2622551pfb.45.1663840696649;
        Thu, 22 Sep 2022 02:58:16 -0700 (PDT)
Received: from ?IPV6:2001:b400:e404:66d5:563:faf0:1fe2:f8cc? (2001-b400-e404-66d5-0563-faf0-1fe2-f8cc.emome-ip6.hinet.net. [2001:b400:e404:66d5:563:faf0:1fe2:f8cc])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b0053e0d6f353esm3988642pfq.27.2022.09.22.02.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 02:58:16 -0700 (PDT)
Message-ID: <904af4cb-147f-a7ba-63e3-c27cad0350f2@gmail.com>
Date:   Thu, 22 Sep 2022 17:58:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] power: supply: mt6370: Fix Kconfig dependency
To:     Ren Zhijie <renzhijie2@huawei.com>, sre@kernel.org,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220922023337.15609-1-renzhijie2@huawei.com>
Content-Language: en-US
From:   ChiaEn Wu <peterwu.pub@gmail.com>
In-Reply-To: <20220922023337.15609-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2022 10:33 AM, Ren Zhijie wrote:
> If CONFIG_IIO is not set,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
> will be failed, like this:
> 
> drivers/power/supply/mt6370-charger.o: In function `mt6370_chg_mivr_dwork_func':
> mt6370-charger.c:(.text+0x670): undefined reference to `iio_read_channel_processed'
> drivers/power/supply/mt6370-charger.o: In function `mt6370_chg_probe':
> mt6370-charger.c:(.text+0xb43): undefined reference to `devm_iio_channel_get_all'
> make: *** [vmlinux] Error 1
> 
> To fix this build error, add depends on IIO to config CHARGER_MT6370 dependency.
> 
> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>   drivers/power/supply/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 591deb82e2c6..62111f4bb093 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -623,6 +623,7 @@ config CHARGER_MT6370
>   	tristate "MediaTek MT6370 Charger Driver"
>   	depends on MFD_MT6370
>   	depends on REGULATOR
> +	depends on IIO
>   	select LINEAR_RANGES
>   	help
>   	  Say Y here to enable MT6370 Charger Part.

Hi Ren,

Thanks for catching this!

Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>

-- 
Best Regards,
ChiaEn Wu
