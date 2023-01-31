Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6268350F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAaSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjAaSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:20:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F349B46D42;
        Tue, 31 Jan 2023 10:20:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797FB2F4;
        Tue, 31 Jan 2023 10:20:53 -0800 (PST)
Received: from [10.57.78.39] (unknown [10.57.78.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9893F64C;
        Tue, 31 Jan 2023 10:20:09 -0800 (PST)
Message-ID: <f2bec8f8-e844-effb-122a-1779f4ab9fe7@arm.com>
Date:   Tue, 31 Jan 2023 18:20:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 31/35] Documentation: trace: correct spelling
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-32-rdunlap@infradead.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230127064005.1558-32-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 06:40, Randy Dunlap wrote:
> Correct spelling problems for Documentation/trace/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/trace/coresight/coresight-etm4x-reference.rst |    2 +-
>   Documentation/trace/events.rst                              |    6 +++---
>   Documentation/trace/fprobe.rst                              |    2 +-
>   Documentation/trace/ftrace-uses.rst                         |    2 +-
>   Documentation/trace/hwlat_detector.rst                      |    2 +-
>   Documentation/trace/rv/runtime-verification.rst             |    2 +-
>   Documentation/trace/uprobetracer.rst                        |    2 +-
>   7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff -- a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -675,7 +675,7 @@ Bit assignments shown below:-
>       reconstructed using only conditional branches.
>   
>       There is currently no support in Perf for supplying modified binaries to the decoder, so this
> -    feature is only inteded to be used for debugging purposes or with a 3rd party tool.
> +    feature is only intended to be used for debugging purposes or with a 3rd party tool.
>   
>       Choosing this option will result in a significant increase in the amount of trace generated -
>       possible danger of overflows, or fewer instructions covered. Note, that this option also

For the above:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks
Suzuki
