Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C67195C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjFAIil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjFAIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:38:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4D7A10C6;
        Thu,  1 Jun 2023 01:36:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 916DC169C;
        Thu,  1 Jun 2023 01:37:28 -0700 (PDT)
Received: from [10.57.22.124] (unknown [10.57.22.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51083F67D;
        Thu,  1 Jun 2023 01:36:40 -0700 (PDT)
Message-ID: <d8f74a05-d3b0-a39b-6fe4-bbea2e98e653@arm.com>
Date:   Thu, 1 Jun 2023 09:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 00/11] Add support to configure TPDM DSB subunit
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <7e2eaf1f-369a-d664-1011-3da6efb382a3@arm.com>
 <725b6ccd-ff70-a3d2-fe44-797c0509e643@quicinc.com>
 <13686cd8-c887-32ef-d314-0955be366373@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <13686cd8-c887-32ef-d314-0955be366373@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 09:17, Tao Zhang wrote:
> 
> On 5/23/2023 3:50 PM, Tao Zhang wrote:
>> On 4/28/2023 12:53 AM, Suzuki K Poulose wrote:
>>> On 27/04/2023 10:00, Tao Zhang wrote:
>>>> Introduction of TPDM DSB subunit
>>>> DSB subunit is responsible for creating a dataset element, and is also
>>>> optionally responsible for packing it to fit multiple elements on a
>>>> single ATB transfer if possible in the configuration. The TPDM Core
>>>> Datapath requests timestamps be stored by the TPDA and then delivering
>>>> ATB sized data (depending on ATB width and element size, this could
>>>> be smaller or larger than a dataset element) to the ATB Mast FSM.
>>>>
>>>> The DSB subunit must be configured prior to enablement. This series
>>>> adds support for TPDM to configure the configure DSB subunit.

...

>>> There is v6 available for the above and there may be changes in the data
>>> structures. But the series is stable now, and may be you could cordinate
>>> with James and repost the series at rc1 ?
>>
>> This patch series has depended on James's v6 patch series. It's a 
>> description mistake.
>>
>> The link I posted is James's v6 patch series.
>>
>> Would you mind continue to review this patch series first?
>>
>>
>> Tao
>>
> Hi Suzuki,
> 
> 
> Do you have more review comments on the rest of the patches(#5-#11) in 
> this series?
> 
> Or do you prefer me to update patches(#1-#4) and resubmit first?

Apologoies for the delay. I will try to complete this series this week.

Thanks
Suzuki

