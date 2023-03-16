Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0556BCD56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCPKzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPKzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:55:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67BE21515B;
        Thu, 16 Mar 2023 03:55:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD7E2F4;
        Thu, 16 Mar 2023 03:56:16 -0700 (PDT)
Received: from [10.57.54.186] (unknown [10.57.54.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39F283F885;
        Thu, 16 Mar 2023 03:55:29 -0700 (PDT)
Message-ID: <0db33881-7978-41c9-45e3-63dc2ed7be4f@arm.com>
Date:   Thu, 16 Mar 2023 10:55:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v1 0/3] Add support to configure Coresight Dummy subunit
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
References: <20230316032005.6509-1-quic_hazha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230316032005.6509-1-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 03:20, Hao Zhang wrote:
> Introduction of Coresight Dummy subunit
> The Coresight Dummy subunit is for Coresight Dummy component, there are some
> specific Coresight devices that HLOS don't have permission to access. Such as

What is HLOS ?

> some TPDMs, they would be configured in NON-HLOS side, but it's necessary to

What is NON-HLOS ?

> build Coresight path for it to debug. So there need driver to register dummy
> devices as Coresight devices.

Build a path for who to debug ? If this is used by some privileged
software, shouldn't that do all of the work ?

Suzuki

> 
> Commit link:
> https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy
> 
> Hao Zhang (3):
>    Coresight: Add coresight dummy driver
>    dt-bindings: arm: Add Coresight Dummy Trace YAML schema
>    Documentation: trace: Add documentation for Coresight Dummy Trace
> 
>   .../bindings/arm/qcom,coresight-dummy.yaml    | 129 +++++++++++++
>   .../trace/coresight/coresight-dummy.rst       |  58 ++++++
>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>   drivers/hwtracing/coresight/Makefile          |   1 +
>   drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
>   5 files changed, 375 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>   create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
> 

