Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A362253D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiKIIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:23:09 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 631511D0DE;
        Wed,  9 Nov 2022 00:23:08 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Nov 2022 17:23:07 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id C175620584CE;
        Wed,  9 Nov 2022 17:23:07 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 9 Nov 2022 17:23:07 +0900
Received: from [10.213.109.193] (unknown [10.213.109.193])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 8032AB62A4;
        Wed,  9 Nov 2022 17:23:07 +0900 (JST)
Message-ID: <b12340ed-3707-c950-1812-fdb9becebb56@socionext.com>
Date:   Wed, 9 Nov 2022 17:23:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] mmc: f-sdh30: Add compatible string for Socionext
 F_SDH30_E51
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
 <20221108082533.21384-5-hayashi.kunihiko@socionext.com>
 <CAJe_ZhfMq1ET+TonauySxfCUv2n=xrsEf9T4o9zePwS5feeGMg@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAJe_ZhfMq1ET+TonauySxfCUv2n=xrsEf9T4o9zePwS5feeGMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi-san,

On 2022/11/09 1:03, Jassi Brar wrote:
> On Tue, 8 Nov 2022 at 02:25, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> ....
>> @@ -228,6 +229,7 @@ static int sdhci_f_sdh30_remove(struct platform_device
>> *pdev)
>>   #ifdef CONFIG_OF
>>   static const struct of_device_id f_sdh30_dt_ids[] = {
>>          { .compatible = "fujitsu,mb86s70-sdhci-3.0" },
>> +       { .compatible = "socionext,f-sdh30-e51-mmc" },
>>
> This also needs to be specified in the dt bindings, not just in the driver.
> And if this patchset is for the "e51-mmc" type controller, introduce
> the compatible first and apply the changes for that controller.

I understand.
I need to confirm if the extend operations in this patch depend on
new F_SDH30_E51 or common with original F_SDH30.


>> @@ -258,4 +260,5 @@ module_platform_driver(sdhci_f_sdh30_driver);
>>   MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
>> +MODULE_AUTHOR("Socionext Inc.");
>>
> Socionext now is what Fujitsu was when this code was written, so this
> addition seems ok.
> So may be add it as
>      MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD., SOCIONEXT INC.");
Although I'm confused how to write this, I'll write it that way.

Thank you,

---
Best Regards
Kunihiko Hayashi
