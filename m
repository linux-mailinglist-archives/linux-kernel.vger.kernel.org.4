Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52873D9EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFZIii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:38:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A3DA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:38:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9883123260fso284333866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687768712; x=1690360712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6C70QC7oTuEBX07td74LYFVngZ/ZD0QT+wpt1vK7TM=;
        b=AXEg/ayLQYYo5WiyQudICvriMVUdFGvD2qxU7I4OaFmZ+qWlN8pRgh3E9jlcyZA9Gy
         VBv4scxDMPMAGijxdHJSTA/yVZdbqoIGbFqgu0uOlhFpMaq5o6iiqIiIp4jTqf8U546a
         pBVVhWE7anHhbllb8wvujTwEoVgWkhvyjVkGG+ekN9vE7Y0H8rqEfjS/6KfUQgoaD2+g
         JSlu7bCMAksSMF2sBelbLKCALfUkZ/G0ybZSUo7cWyEf3bvssYK2cszCXiftwd8ZP+PZ
         vE3y6zxjIiVm/LYgI8NtZiw43lZmdv56LKsbRZ5wvG4SVitmZpmDy0RCxKUaEemFsRpn
         hgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687768712; x=1690360712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6C70QC7oTuEBX07td74LYFVngZ/ZD0QT+wpt1vK7TM=;
        b=c4kGy1+cmbQVdOabV9LKrzT6ZXZTpqRdJXDXjiUIyfNKtcOJF39ot5MN83bsYjvSEa
         WkAmj/1dr+ZSo0VYWndUXF9a2mgslgYfp5wv9m5mjtzdHk/HWfVCICcEuJZyI7hVh3aZ
         p0kfVQcEaYfa86nBRfWmQls54+XCpuEjBzhJFxbFf7EnVhT61bjNZM5RN/4GJU4ndvSh
         u3TmpuuFOQ01uCF7fP59UfhfYPXUlGTfqx7HfAjdknBR6uHy2xfE2FFe2NtnwnowLoYg
         B0M7flqI2cyRdSpWBAdpNu4lIO/vEnO00g5wRUAa9w0/bCluTihXoDTs5l1wSWKd6xrx
         8cMA==
X-Gm-Message-State: AC+VfDyVq+zw3tYFL3F5esQBJW2XcsJS2XERoU5zvEddhDjSRer4DOyA
        CAZVoPar9pWn0MHNDYYihD60iBjPON3aQ0qA7Fs=
X-Google-Smtp-Source: ACHHUZ4LNTsnUXNucmi/9jh23hsAlsXNhcpjhOTol4ts8a7KX+uLi0x40ReW21ny/nP6zXUttsiFJg==
X-Received: by 2002:a17:907:31c3:b0:95e:d3f5:3d47 with SMTP id xf3-20020a17090731c300b0095ed3f53d47mr20321721ejb.48.1687768712351;
        Mon, 26 Jun 2023 01:38:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b0098d0c01d9aasm2986707ejb.87.2023.06.26.01.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:38:31 -0700 (PDT)
Message-ID: <12c68124-9687-d68c-294a-2bfd13338edd@linaro.org>
Date:   Mon, 26 Jun 2023 10:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Content-Language: en-US
To:     "Lee, Kah Jing" <kah.jing.lee@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
 <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
 <PH0PR11MB56734DB18155588535DC0384CB26A@PH0PR11MB5673.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB56734DB18155588535DC0384CB26A@PH0PR11MB5673.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 06:16, Lee, Kah Jing wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Saturday, 24 June, 2023 3:30 PM
>> To: Lee, Kah Jing <kah.jing.lee@intel.com>; Dinh Nguyen
>> <dinguyen@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Catalin Marinas <catalin.marinas@arm.com>; Will
>> Deacon <will@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
>>
>> On 24/06/2023 05:42, Lee, Kah Jing wrote:
>>>>>> So you miss init ramdisk.
>>>>> Currently we are using the bootargs to mount the rootfs from QSPI
>>>>> NOR
>>>> flash:
>>>>> [    0.000000] Kernel command line: earlycon panic=-1 ubi.mtd=1
>>>> root=ubi0:rootfs rootfstype=ubifs rw rootwait
>>>>> Is it possible to mount the ubifs rootfs with the ubifs=m config during
>> boot?
>>>>
>>>> I think yes. rootfs devices are for example modules, so filesystem
>>>> can be as well.
>>> Was going through mtd ubifs page -
>>> http://www.linux-mtd.infradead.org/faq/ubifs.html
>>> Quoted: 'In order to mount UBIFS as the root file system, you have to
>>> compile UBIFS into the kernel (instead of compiling it as a kernel
>>> module) and specify proper kernel boot arguments and make the kernel
>> mount UBIFS on boot.'
>>
>> Why? Module loaded by initramfs would also understand cmdline arguments,
>> right?
> The suggestion is to use initramfs for rootfs -> remount UBIFS as chroot?
> The concern is additional initrd image and steps to store in the
> limited NOR flash (256MB, Boot data + Uboot - ~66MB, UBIFS image - ~88MB, 
> kernel.itb - ~10MB = 164MB).
> With the mounting Rootfs from UBIFS volume, we can skip the initrd step, and
> save some space for the user operations. 
> Let me know if I understands that correctly.

arm64 defconfig creates huge development config for all platforms, so
why would you ever use it in resource-constrained system? It would
barely fit. defconfig modules take 50 MB alone and you don't need most
of them.

I think you misunderstood the purpose of this defconfig and now try to
apply some arguments for different use cases.

Best regards,
Krzysztof

