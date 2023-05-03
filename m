Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745436F5917
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjECNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjECNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:31:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35A7BF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:31:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F661C14;
        Wed,  3 May 2023 06:32:02 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46A513F5A1;
        Wed,  3 May 2023 06:31:17 -0700 (PDT)
Message-ID: <c4868b79-b617-e6f6-383f-00d14042fd67@arm.com>
Date:   Wed, 3 May 2023 14:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2] perf cs-etm: Add fix for coresight trace for any range
 of CPUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com
References: <20230421055253.83912-1-gankulkarni@os.amperecomputing.com>
 <ZEx5n8MdwuV5JE2r@kernel.org>
Content-Language: en-US
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ZEx5n8MdwuV5JE2r@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 02:57, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 20, 2023 at 10:52:53PM -0700, Ganapatrao Kulkarni escreveu:
>> The current implementation supports coresight trace decode for a range
>> of CPUs, if the first CPU is CPU0.
>>
>> Perf report segfaults, if tried for sparse CPUs list and also for
>> any range of CPUs(non zero first CPU).
>>
>> Adding a fix to perf report for any range of CPUs and for sparse list.
> 
> Can some ARM people please review this?
> 
> - Arnaldo

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki


