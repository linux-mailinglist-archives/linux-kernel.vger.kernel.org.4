Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486195E5E86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIVJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIVJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:26:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2799DB2745
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:26:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D683D1595;
        Thu, 22 Sep 2022 02:26:32 -0700 (PDT)
Received: from [10.57.33.96] (unknown [10.57.33.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C321C3F73D;
        Thu, 22 Sep 2022 02:26:24 -0700 (PDT)
Message-ID: <1867fb58-cb96-5d82-2518-e7212b6849a0@arm.com>
Date:   Thu, 22 Sep 2022 10:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] arm64: defconfig: Add Coresight as module
To:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     coresight@lists.linaro.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <20220921140535.152627-1-james.clark@arm.com>
 <20220921140535.152627-2-james.clark@arm.com>
 <YystQ3pw3uBpi0CT@sirena.org.uk> <20220921164622.GA1124503@p14s>
 <07d37df2-246e-70ea-4a9f-e33354d8864d@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <07d37df2-246e-70ea-4a9f-e33354d8864d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 10:04, James Clark wrote:
> 
> 
> On 21/09/2022 17:46, Mathieu Poirier wrote:
>> On Wed, Sep 21, 2022 at 04:26:59PM +0100, Mark Brown wrote:
>>> On Wed, Sep 21, 2022 at 03:05:35PM +0100, James Clark wrote:
>>>
>>>> +CONFIG_CORESIGHT_CTI=m
>>>> +CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
>>>
>>
>> I agree - integration registers should not be enabled by default.
>>
>>> Do we want this turned on by default?  According to the
>>> description it's a bit dangerous and it's exposed via sysfs
>>> rather than debugfs.
>>
>>
> 
> Should I disable just CONFIG_CORESIGHT_CTI_INTEGRATION_REGS or
> CONFIG_CORESIGHT_CTI as well? There are other writable registers exposed
> via sysfs outside of these two options, so I wanted to check if it's
> just the integration registers that are the issue.

It is good/fine to keep CORESIGHT_CTI. But you may remove the 
INTEGRATION_REGS. They are there for "verification" of the CTI
integration on the SoC. We added them only for the platform
bring up purposes.

Suzuki
