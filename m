Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C572CA52
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbjFLPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbjFLPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:35:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3368E10C3;
        Mon, 12 Jun 2023 08:35:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF511FB;
        Mon, 12 Jun 2023 08:36:33 -0700 (PDT)
Received: from [10.57.27.113] (unknown [10.57.27.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E9163F5A1;
        Mon, 12 Jun 2023 08:35:46 -0700 (PDT)
Message-ID: <16b08ba8-f23e-af24-881c-61fe4e4c92e1@arm.com>
Date:   Mon, 12 Jun 2023 16:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v5 03/13] coresight-tpdm: Introduce TPDM subtype to TPDM
 driver
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1686553666-5811-1-git-send-email-quic_taozha@quicinc.com>
 <1686553666-5811-4-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1686553666-5811-4-git-send-email-quic_taozha@quicinc.com>
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

On 12/06/2023 08:07, Tao Zhang wrote:
> Introduce the new subtype of "CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM"
> for TPDM components in driver.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 1 +
>   drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
>   include/linux/coresight.h                    | 1 +
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 118fcf2..23b18c2 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1093,6 +1093,7 @@ static int coresight_validate_source(struct coresight_device *csdev,
>   
>   	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>   	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
> +		subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&

minor nit: Alignment. Please always double check your patch for
styling issues.


Otherwise looks good to me

Suzuki
