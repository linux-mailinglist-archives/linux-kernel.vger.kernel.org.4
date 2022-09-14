Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA945B7EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiINB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiINB7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:59:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0596330;
        Tue, 13 Sep 2022 18:59:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b23so13435284pfp.9;
        Tue, 13 Sep 2022 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MBMoUjs1/LRqBPqtJw8QUCIFN2AxXmsOdyU31zMj8Qo=;
        b=VBXE1s30H4C5zDJ+8Zsaf/BEkL8GJBxe78wCKCHLzsPHPPPlGefbeRo+L99ns+KMDG
         PPFe151cmLEGo4ugIpQBSB+nF6/g3Tf8wxWtt1vRn52QAyaWyMHFMiA8rt3GTwd1Ti1b
         2ElO2EvzQvMZqlYjngu6sBH5RrbB6SA2ZuTrm/xnNNDyV+UeuktuKx+Do8SKyKbpyoAj
         2Vee6FgDrT2LKtvaTei4jUqs6iHlr4IwLNWqRITlYyZAmIuCDBEu1bEQ4/48KCChlf/y
         dQcEeXsiBkxL2QbeBztIg+3G9riiIVckypWkON2394bshz1bNX0fQDvWzSORRPrRpKJQ
         w06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MBMoUjs1/LRqBPqtJw8QUCIFN2AxXmsOdyU31zMj8Qo=;
        b=zyb3uF3ZuzbUcxFVkj/Qma2EAcomPW6zeOklwsFCuwJwwsU7pqPX8WTPzJtb2+wVjs
         O5ctX53ngMiJBJ0k/VeOKzDYgLKCL0U5aOO4bni1VNiGhKoJpQcGBZDXHsTrTgY9tuu+
         fzqCU5RN9/9YJ5oyWUPorh5QQUzFYkuho0q9w6H1K7RvGCNIuuNnQi3uKYATQloD7IAg
         SNHTQqWMp5/1iwtJFAao1a8phuxni7gYZjx2xh+2ozd6KUWYf2ULTaqPtjLkmMmsX1OA
         p+7jfjgkCxzyXN7D/t84Zg/b2ibnUwFduf8iNKjV5zBFOQW4Yfo77WC97q373U9ebR4a
         V9OQ==
X-Gm-Message-State: ACgBeo36mPmS0dvLxyyV9HrkmJiSBsQkluiIUiYo+vrbTZJeu6KrKt+m
        y9DXNch9edJGXugbpGM7j9o=
X-Google-Smtp-Source: AA6agR4u3WENglYh7kF/L2nouFheMKGNZeIS1UoTSAW+q8V0bFwC4eQTSs2u2oyGbrcMOdxBoV7fmw==
X-Received: by 2002:a63:8a4a:0:b0:434:c99c:6fd4 with SMTP id y71-20020a638a4a000000b00434c99c6fd4mr29301515pgd.24.1663120778134;
        Tue, 13 Sep 2022 18:59:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b0017808db132bsm9210355plk.137.2022.09.13.18.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:59:37 -0700 (PDT)
Message-ID: <db2fdc22-44b8-1e81-ace2-c83c143ac20e@gmail.com>
Date:   Wed, 14 Sep 2022 08:59:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
Content-Language: en-US
To:     Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
        sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-gpio@vger.kernel.org, linux-next@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20220912113634.167820-1-kumaravel.thiagarajan@microchip.com>
 <d34d9264-1f0b-d465-bc1d-75f8c736a35b@gmail.com>
 <BN8PR11MB3668C9D5BD38AECBE160D013E9479@BN8PR11MB3668.namprd11.prod.outlook.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <BN8PR11MB3668C9D5BD38AECBE160D013E9479@BN8PR11MB3668.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 01:27, Kumaravel.Thiagarajan@microchip.com wrote:
>> On 9/12/22 18:36, Kumaravel Thiagarajan wrote:
>>> build errors listed below and reported for the builds of riscv, s390,
>>> csky, alpha and loongarch allmodconfig are fixed in this patch.
>>>
>>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error:
>> 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
>>>   311 | static int pci1xxxx_gpio_resume(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~~~~~~
>>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error:
>> 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
>>>   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~~~~~~~
>>>
>>
>> What about this description?:
>>
>> "Sudip reported unused function errors on riscv, s390, cksy, alpha, and
>> loongarch (allmodconfig):
>> <pci1xxxx_gpio_* errors>...
>>
>> Fix these errors by using DEFINE_SIMPLE_DEV_PM_OPS."
> It looks good even though it does not include all the details.
> But is not how much of detail good enough subjective?
> I thought some might be looking for more information and chose this way.
> Do you think I need to change this? Please let me know.

Yes, with full error text as Sudip had reported.

-- 
An old man doll... just what I always wanted! - Clara
