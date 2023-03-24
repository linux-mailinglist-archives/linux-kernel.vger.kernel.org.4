Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64B6C7CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCXLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCXLBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:01:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F32D7244B4;
        Fri, 24 Mar 2023 04:01:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B088411FB;
        Fri, 24 Mar 2023 04:01:44 -0700 (PDT)
Received: from [10.57.55.150] (unknown [10.57.55.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E54483F6C4;
        Fri, 24 Mar 2023 04:00:56 -0700 (PDT)
Message-ID: <e383c17d-12b8-b134-acc5-82f515714562@arm.com>
Date:   Fri, 24 Mar 2023 11:00:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-4-quic_hazha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230324061608.33609-4-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 06:16, Hao Zhang wrote:
> Add documentation for Coresight Dummy Trace under trace/coresight.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   .../trace/coresight/coresight-dummy.rst       | 58 +++++++++++++++++++
>   1 file changed, 58 insertions(+)
>   create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
> 
> diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
> new file mode 100644
> index 000000000000..819cabab8623
> --- /dev/null
> +++ b/Documentation/trace/coresight/coresight-dummy.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================
> +Coresight Dummy Trace Module
> +=============================
> +
> +    :Author:   Hao Zhang <quic_hazha@quicinc.com>
> +    :Date:     March 2023
> +
> +Introduction
> +---------------------------
> +
> +Coresight Dummy Trace Module is for the specific devices that HLOS don't

Please do not use cryptic abbreviations, please use "kernel"


> +have permission to access or configure. 

Such as Coresight sink EUD, some
> +TPDMs etc. 
Say "e.g., CoreSight TPDMs on Qualcomm platforms.:

So there need driver to register dummy devices as Coresight
> +devices.

Add:

"It may also be used to define components that may not have any
programming interfaces (e.g, static links), so that paths can
be established in the driver.
"

  Provide Coresight API for dummy device operations, such as
> +enabling and disabling dummy devices. Build the Coresight path for dummy
> +sink or dummy source for debugging.


I think the following content may not be needed as they are part
of the standard source/sink type devices, nothing specific to
dummy devices.

--- vvvvv ---
> +
> +Sysfs files and directories
> +---------------------------
> +
> +Root: ``/sys/bus/coresight/devices/dummy<N>``
> +
> +----
> +
> +:File:            ``enable_source`` (RW)
> +:Notes:
> +    - > 0 : enable the datasets of dummy source.
> +
> +    - = 0 : disable the datasets of dummy source.
> +
> +:Syntax:
> +    ``echo 1 > enable_source``
> +
> +----
> +
> +:File:            ``enable_sink`` (RW)
> +:Notes:
> +    - > 0 : enable the datasets of dummy sink.
> +
> +    - = 0 : disable the datasets of dummy sink.
> +
> +:Syntax:
> +    ``echo 1 > enable_sink``
> +
> +----
> +

--- You may remove the above ^^^ ----

> +Config details
> +---------------------------
> +
> +There are two types of nodes, dummy sink and dummy source. The nodes
> +should be observed at the coresight path
> +"/sys/bus/coresight/devices".
> +e.g.
> +/sys/bus/coresight/devices # ls -l | grep dummy
> +dummy0 -> ../../../devices/platform/soc@0/soc@0:dummy_source/dummy0
> +dummy1 -> ../../../devices/platform/soc@0/soc@0:dummy_sink/dummy1

Suzuki

