Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1F73C75E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFXHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFXHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:30:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE791FE9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:30:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9887ebe16d0so162133566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687591815; x=1690183815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcS41/ldoa741kSrifEhXhMe0V/B2ibfblqUGgLow7k=;
        b=d0r8OSWoSXlEkeryQ/AkskYT20ZpLf7hUZ+hlgf1/20qCEFWFVgqe+01e9JUBchZ9z
         5aZhuGwpf0jsrc1NLsaZfMBDcl39pmLmV1OtIQBS8hff8q3JMw4azXlHttGVeQ/fmRBb
         DUGBBye5qmWdUShY55Q8B3Qqu1Wlm0RuNhtPrm+jBu7l0kgn4sBGWBGRoCM8hVMEeV/7
         W9QTS8QO2TlVm8YM8zcgf3JtlhSabbDX74G1d+53/J0PAdiWq3cmG1JV5WAFVv6v5tVs
         wjnv1hVh0P87ChOAqMaP+5zaKRxKO8r4lgBm46eT9WvOw0tfPtR4t73b2TXx9u8Cjimo
         4jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687591815; x=1690183815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcS41/ldoa741kSrifEhXhMe0V/B2ibfblqUGgLow7k=;
        b=GVUtUnbLR1rKrTUglKTGi/eO0IlbD02lMpm/ZVyMrzYtPKPzfKthGpNwzKwXMRCt/B
         L12IPpVTU8p8jLigifhxHzOLqfX4T++H52zxJakw2zaaQ9kTSHlSk/u65I7IokLg1zt6
         KLsK9A3zPtpeNLKF3uTgfUU7JlGx6aHJ94UVFeJxHXBdzaLCko0er/zmdnO92Gdv48d8
         Q98Vi4fsvGLBq1EppkdF1xppz+uTm/m6en9L0OzTO5k+UWqi0fch/BHTqDytKplhyX0U
         pgek0tMNdJ4vGJIytkGlZ8PJKIj2+gY0qL3F9s9tNvbWmY5L+F4Jaddjf0wQLo2jSru4
         bk3Q==
X-Gm-Message-State: AC+VfDyyko44s9U0SnX0Hn73DpkVzEdSXRJaP4mnhxhFIfQFF1ELQHkI
        MbxY6JCv89RP7/X8PS7uV1k+gA==
X-Google-Smtp-Source: ACHHUZ6jc6iLzoLGrEpEGClSLNBRrLCZoAE38t0g3Caz8YfgYjX/uxIvlDqX0NJYqzBtqTB2+gtdHw==
X-Received: by 2002:a17:907:31c1:b0:961:a67:28d with SMTP id xf1-20020a17090731c100b009610a67028dmr19545969ejb.22.1687591815393;
        Sat, 24 Jun 2023 00:30:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b00989828a42e8sm565288ejb.154.2023.06.24.00.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:30:14 -0700 (PDT)
Message-ID: <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
Date:   Sat, 24 Jun 2023 09:30:13 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 05:42, Lee, Kah Jing wrote:
>>>> So you miss init ramdisk.
>>> Currently we are using the bootargs to mount the rootfs from QSPI NOR
>> flash:
>>> [    0.000000] Kernel command line: earlycon panic=-1 ubi.mtd=1
>> root=ubi0:rootfs rootfstype=ubifs rw rootwait
>>> Is it possible to mount the ubifs rootfs with the ubifs=m config during boot?
>>
>> I think yes. rootfs devices are for example modules, so filesystem can be as
>> well.
> Was going through mtd ubifs page - http://www.linux-mtd.infradead.org/faq/ubifs.html
> Quoted: 'In order to mount UBIFS as the root file system, you have to compile 
> UBIFS into the kernel (instead of compiling it as a kernel module) and specify 
> proper kernel boot arguments and make the kernel mount UBIFS on boot.'

Why? Module loaded by initramfs would also understand cmdline arguments,
right?

Best regards,
Krzysztof

