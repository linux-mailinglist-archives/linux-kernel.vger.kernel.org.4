Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9398469423D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBMKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjBMKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:07:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92F79A5C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:07:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1A3B4B3;
        Mon, 13 Feb 2023 02:07:48 -0800 (PST)
Received: from [10.57.50.214] (unknown [10.57.50.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7755D3F703;
        Mon, 13 Feb 2023 02:07:05 -0800 (PST)
Message-ID: <cec2d271-2ccc-9d6c-04c7-ea1e8f3e1ee4@arm.com>
Date:   Mon, 13 Feb 2023 10:07:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] Extend logging on TMC start / stop errors
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, yabinc@google.com
References: <20230210151008.4587-1-mike.leach@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230210151008.4587-1-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2023 15:10, Mike Leach wrote:
> Recent issues with trying to debug TMC timeouts and flush issues shows
> a general lack of logging and context around the possible errors
> 
> Patchset addresses that.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> 
> Mike Leach (3):
>   coresight: Update timeout functions to allow return of test register
>     value
>   coresight: tmc: Update error logging in tmc common functions
>   coresight: etf: etr: Update logging around flush_and_stop() errors
> 
>  drivers/hwtracing/coresight/coresight-core.c  | 50 +++++++++++++++----
>  .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++---
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 12 +++--
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  8 ++-
>  drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
>  include/linux/coresight.h                     | 10 +++-
>  6 files changed, 93 insertions(+), 26 deletions(-)
> 

Looks good to me.

Reviewed-by: James Clark <james.clark@arm.com>

At some point I might go and add some TRACE_EVENT(coresight_...)s around
things like enabling and disabling devices. It might help to see what
led up to an error rather than just the error itself.
