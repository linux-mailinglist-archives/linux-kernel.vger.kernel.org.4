Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB36A0726
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjBWLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjBWLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:15:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4CB5328F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:15:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x10so39975437edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBnqHGQezE2IyBBd9t88qMIvutHEY5Rpl2abqvqfeSs=;
        b=oTX6kYDbTKG9Lu4Dsnk0vuQDVDkX/TYoSX3awjP4CAgdQvfx1H832cA6w1rZ09X6BX
         FjszmLmnbO/dhrw0fG+64OzL7YOlFwNOJNBI88821WvchSVc/b63IJs48QWvxdRKBWva
         /VzdH/UDfld5XFZBLdx49330t27fsIxH9r1fPiO/l0kAJ94Aw/UgiqyQT23FBtXZJnbe
         CrKEQCnT0UfA0f2NRochCv6CdtI6u6yn1RowARdQRD75Y7k3GJ4Pg9CgrlEWrjgxtzQw
         my2gUitEBbjIyXWFbPgYkaNMXdA2e1mWU4Fmybw0OkKL9cnY5ykpmdlxppFnPQlgWcEc
         YLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBnqHGQezE2IyBBd9t88qMIvutHEY5Rpl2abqvqfeSs=;
        b=ifDdAe0eFeJdpK21/JeR4StoEeWPUqU8GgFnPBKmHf1dZopxzYHC4S57HZGzEAeV9u
         xqGm/JikYSnTDWvoeSbHR4vRbJ5qCF86GbyPOumL6WReHSa5lv4oTDSHpxF+tuTDRcqy
         zTpKxQ+B4GkCHevA0/Q8dtxFLmYAzGpjGLGJcLKJkKcGb0lZ/C/+YFE0jgx4ht8MMwhU
         5gnX4Qy4I8JLujKka7YPOHMV3rih7DhHauLfbsmOwW8eSJV/Or5yYXpLbzmVU4TgpiJd
         bDcb4/kkJxfCO84KC7caud8XtUw5b80aU8Q1UMaJvimOhSkFj1LtceW4FhTjpg8goFIL
         jIcg==
X-Gm-Message-State: AO0yUKVFuGVS7drdy3dLSJ85fjvLb+JdrJwWGmpe/5CFm7hUWPg2KKj2
        D/nHLJ5GnNzXtcT6BeiSc0pUNg==
X-Google-Smtp-Source: AK7set8eibBObJ0JJRlJP0C1NRS36UyC5W+9+4UIoIuShY5Bhn8lOjCbugT2E+dhjLNpnr5ysRWHxg==
X-Received: by 2002:a17:907:6d0a:b0:8af:4418:8700 with SMTP id sa10-20020a1709076d0a00b008af44188700mr27119496ejc.47.1677150932130;
        Thu, 23 Feb 2023 03:15:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh13-20020a170906a0cd00b008d9ddd2da88sm4259117ejb.6.2023.02.23.03.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 03:15:30 -0800 (PST)
Message-ID: <8ea9b68c-67cc-cc6f-39d4-0c5bdbfe3203@linaro.org>
Date:   Thu, 23 Feb 2023 12:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Content-Language: en-US
To:     Bin Meng <bmeng@tinylab.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     andrew <andrew@lunn.ch>, agross <agross@kernel.org>,
        arnd <arnd@arndb.de>, andersson <andersson@kernel.org>,
        "chuck.lever" <chuck.lever@oracle.com>,
        dinguyen <dinguyen@kernel.org>, festevam <festevam@gmail.com>,
        "gregory.clement" <gregory.clement@bootlin.com>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        "konrad.dybcio" <konrad.dybcio@linaro.org>,
        linux-imx <linux-imx@nxp.com>,
        "neil.armstrong" <neil.armstrong@linaro.org>,
        kernel <kernel@pengutronix.de>, elliott <elliott@hpe.com>,
        linux <linux@armlinux.org.uk>,
        "s.hauer" <s.hauer@pengutronix.de>,
        "sebastian.hesselbarth" <sebastian.hesselbarth@gmail.com>,
        shawnguo <shawnguo@kernel.org>,
        newbie13xd <newbie13xd@gmail.com>,
        "sudeep.holla" <sudeep.holla@arm.com>, ziy <ziy@nvidia.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20230210093224.689990-1-bmeng@tinylab.org>
 <em4fed7efe-b8aa-4a34-86d4-655b0a96fec0@1adcb789.com>
 <e6d97e34-0c63-019d-93b6-c39e722d1d8c@linaro.org>
 <em4f9482cc-1919-4f29-92a5-41ba5f6c3bb3@1adcb789.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <em4f9482cc-1919-4f29-92a5-41ba5f6c3bb3@1adcb789.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 12:00, Bin Meng wrote:
> On 2023/2/23 18:50:36, "Krzysztof Kozlowski" 
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 23/02/2023 11:46, Bin Meng wrote:
>>>  On 2023/2/10 17:32:24, "Bin Meng" <bmeng@tinylab.org> wrote:
>>>
>>>>  Drop CONFIG_MTD_M25P80 that was removed in
>>>>  commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>>>>
>>>>  Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>>>
>>>>  ---
>>>>
>>>>   arch/arm/configs/axm55xx_defconfig     | 2 +-
>>>>   arch/arm/configs/davinci_all_defconfig | 1 -
>>>>   arch/arm/configs/dove_defconfig        | 1 -
>>>>   arch/arm/configs/keystone_defconfig    | 1 -
>>>>   arch/arm/configs/mvebu_v5_defconfig    | 1 -
>>>>   arch/arm/configs/mxs_defconfig         | 1 -
>>>>   arch/arm/configs/pxa_defconfig         | 1 -
>>>>   arch/arm/configs/qcom_defconfig        | 1 -
>>>>   arch/arm/configs/socfpga_defconfig     | 1 -
>>>>   9 files changed, 1 insertion(+), 9 deletions(-)
>>>>
>>>>
>>>
>>>  Ping?
>>
>> No need for pinging, but you need to send to soc folks. Otherwise no one
>> will pick it up. You will get the address from get_maintainer.pl -f
>> arch/arm/boot/dts/Makefile (yes, it is quite hidden on purpose).
> 
> Yeah I used the script to generate the cc list.

Did you read my message fully? Because the CC list is not having the
proper address, thus maybe you based your patch on some old kernel.
Please rebase.

> 
> Let me know if I need to split this patch into several ones (per-soc a 
> patch) so that each soc maintainer only picks up their own?

If you did what I wrote about and the kernel is fairly recent, then no
need...


Best regards,
Krzysztof

