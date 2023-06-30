Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07D7431BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjF3AfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3Aez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:34:55 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0A241FCB;
        Thu, 29 Jun 2023 17:34:52 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Jun 2023 09:34:52 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 1D4AF2224561;
        Fri, 30 Jun 2023 09:34:52 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 30 Jun 2023 09:34:52 +0900
Received: from [10.212.156.14] (unknown [10.212.156.14])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 86BA51592F7;
        Fri, 30 Jun 2023 09:34:51 +0900 (JST)
Message-ID: <1c2a9e31-4ecc-17cb-3be7-8607dbc29329@socionext.com>
Date:   Fri, 30 Jun 2023 09:34:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629004959.22825-1-hayashi.kunihiko@socionext.com>
 <57dd6bdc-c8dc-219c-f9dd-d2f210a5ce2c@intel.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <57dd6bdc-c8dc-219c-f9dd-d2f210a5ce2c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 2023/06/29 21:57, Adrian Hunter wrote:
> On 29/06/23 03:49, Kunihiko Hayashi wrote:
>> Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
>> sdhci_pltfm, so the structure is not correctly referenced in PM functions.
>> This applies sdhci_pltfm to this driver to fix this issue.
>>
>> - Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
>>    other functions that covered by sdhci_pltfm.
>> - Move ops and quirks to sdhci_pltfm_data
>> - Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().
>>
> 
> Does it need a Fixes tag?

Ah, I see. I'll add it in v2.

>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
