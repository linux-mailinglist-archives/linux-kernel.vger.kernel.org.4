Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3196862E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBAJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjBAJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:31:02 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA2861D5A;
        Wed,  1 Feb 2023 01:30:52 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m2so49072430ejb.8;
        Wed, 01 Feb 2023 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W0uwriFZ/qWa8L1CESLZ45Mvp1IN80djmUBD3/EzTo=;
        b=HTkcHa8jyOLjzkZpHjI4NCxstknuNZlj+HN2dJ1zaqNxSgO9PQ8W04vpviVTSjAVPU
         EqgG4dyCipoOAo0byMFhNi0CzWgP92T6iL4pCVy3yVoutx8RHKLxWx4ROMLuZmAJfOOV
         gGthZllAk2jDrFQdMrFdfN/kratEJQe+q/gZ2gLHTTf6eFxRSpPFyGMEivsqnYRUoPSl
         Y0ljCEE+CI0zgT7LdontXHs2wEmcVTr9lIgXVhcIOoc4VMJLSjycweWk0oQzuubEmV1u
         /ZPIgX/ZL8giIu6eivQYaobyQgDVj3GbVdbxDttvVUSRBvGx17XpIWEnesXUorpnvhhm
         pZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0W0uwriFZ/qWa8L1CESLZ45Mvp1IN80djmUBD3/EzTo=;
        b=oAqgfHFSi9tVUf2K6r/f6/dk0J/AapIQ+1/FXoJBumfQFyjvmm81HCDLh+jZK5mMBx
         sRybxg19yqOKQ0PkBfVI/MVDJZ9cljF00L1r2TGyVCM5yHiE1PJnFh7SBwpzifW58JcV
         cdTLyKy5gxQ0XnoKszbFV1wDyPxYljYUrnoZcHD4U8UtCTQgWHjyfCkq9aQwaXEhiT0T
         P+RKYrughZNKo/SDNYBndqMt2wngO9t37fT+R/QOQOBOIoiAEur9kU067GI9eZ71eV+i
         ngPWsp70DCCMmOdxVSl671kDYA4gYAN8PNlPUDzjM96ZRfABYoTYq18kNTwk5PpcmQAN
         h74A==
X-Gm-Message-State: AO0yUKW2MAkWlFndA3mQQKTDxh88RnRIFlD/5b0apb0i2+gPu268+3Lx
        ILsSfdnCj4NIeH71qQIgbTEvAW5DtzQ=
X-Google-Smtp-Source: AK7set/0cQB2FiTDh1W3kpeL3CSXwH6Hu0hx8ld2hzv2F4WbquBKlup62j9maJz2n/aHSCvmd/vckQ==
X-Received: by 2002:a17:906:fb19:b0:86b:9216:2ddb with SMTP id lz25-20020a170906fb1900b0086b92162ddbmr1602330ejb.52.1675243851020;
        Wed, 01 Feb 2023 01:30:51 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id r5-20020a170906a20500b00871075bfcfesm9656003ejy.133.2023.02.01.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 01:30:50 -0800 (PST)
Message-ID: <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
Date:   Wed, 1 Feb 2023 10:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO
 one
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230201084821.1719839-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.02.2023 09:48, Michael Walle wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Mediatek EFUSE uses a simple MMIO that can be handled with a generic
>> driver. Replace this driver to avoid code duplication.
> 
> I don't think this is the correct approach. You'll restrict that driver
> to being read-only. I admit that right now, it's read only, but it can
> be extended to also support efuse writing. With this changes, it's not
> possible.
> 
>> static const struct of_device_id mmio_nvmem_of_match_table[] = {
>> 	{ .compatible = "mmio-nvmem", },
>> +	/* Custom bindings that were introduced before the mmio one */
>> +	{ .compatible = "mediatek,mt8173-efuse", },
>> +	{ .compatible = "mediatek,efuse", },
> 
> Why do you assume that all mediatek efuses will be the same? This should
> rather be something like (in the dts/binding):
> 
> compatible = "mediatek,mt8173-efuse", "mmio-nvmem";
> 
> So if there is no driver for the particular efuse, it will fall back to the
> generic one.

Oh great, I'm making circles now.

Rob suggested I should convert existing drivers, see:
[PATCH 2/2] nvmem: add generic driver for devices with I/O based access
and I thought efuse ones should be good.

Please tell me how I should handle brcm,nvram without wasting more time.
I thought I had it sorted out but I just wasted 2 days.


I believe I need to make brcm,nvram NVMEM layout. Without converting it
I'm afraid you'll refuse my changes adding cell post processing (that
happened to my U-Boot attempts).

Before I convert brcm,nvram to NVMEM layout I need some binding & driver
providing MMIO device access. How to handle that?


