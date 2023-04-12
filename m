Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835456DF561
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDLMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDLMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:35:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D85C2680
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:35:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB67D75;
        Wed, 12 Apr 2023 05:35:58 -0700 (PDT)
Received: from [10.34.100.129] (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9593F73F;
        Wed, 12 Apr 2023 05:35:12 -0700 (PDT)
Message-ID: <6cff363a-97bf-b898-44d0-54f4c2ab647c@arm.com>
Date:   Wed, 12 Apr 2023 14:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] cacheinfo: Add use_arch[|_cache]_info
 field/function
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-4-pierre.gondois@arm.com>
 <20230412-femur-aspect-b54b10ad9fd1@wendy>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230412-femur-aspect-b54b10ad9fd1@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/23 13:47, Conor Dooley wrote:
> On Wed, Apr 12, 2023 at 09:18:06AM +0200, Pierre Gondois wrote:
> 
>> +static inline bool
>> +use_arch_cache_info(void)
> 
> Tiny nit, why the newline when `static inline bool
> use_arch_cache_info(void)` is only 50ish characters?

Ok sure, I ll do that.

Regards,
Pierre

> 
> Cheers,
> Conor.
