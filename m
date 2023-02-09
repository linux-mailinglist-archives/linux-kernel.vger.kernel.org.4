Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FF690815
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBIL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBIL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:56:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085D170F;
        Thu,  9 Feb 2023 03:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DDA361A11;
        Thu,  9 Feb 2023 11:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06194C433EF;
        Thu,  9 Feb 2023 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675943225;
        bh=/cmWTKP+ZzUuyI0iSgBBz7tpFTNu/+ueErc+Sk9xR1w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RMalBmRtOmbCtWIDvIP3YC/FYnD9v0SfWBhVdLZKngqRjqgOzusV+RRkRgBcsInK/
         L9XGROLwtPYqP2R9hGa9yNVjKPKgLIg2wadGpvbpzZUIaNPdrSu/QIzPp7xTXffYVo
         6+ctepGtM1QK7mOTsC+qA/wy6ylllYQfHiJB6Y+voR5YoxyRAoX1a8xmvFrla/NIRg
         EjhP2ouWi6MJFHqwaaqB9pVUod8j4xSQg2dKcviUB8qDSaaYJxiO+4NcXmYnfIlybe
         BANoUdWiac+B+BZnHf94/JWizWVP/4+NmiAfMZSRYUQiVa1+9y1ibtrIcznA6RHgTf
         nRuhtg8ge29TA==
Message-ID: <f51b1a5b-cb61-2ab8-7ca4-9b81a4f43fc6@kernel.org>
Date:   Thu, 9 Feb 2023 12:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 21/24] Documentation: trace: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-22-rdunlap@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230209071400.31476-22-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 08:13, Randy Dunlap wrote:
> --- a/Documentation/trace/hwlat_detector.rst
> +++ b/Documentation/trace/hwlat_detector.rst
> @@ -14,7 +14,7 @@ originally written for use by the "RT" p
>  kernel is highly latency sensitive.
>  
>  SMIs are not serviced by the Linux kernel, which means that it does not
> -even know that they are occuring. SMIs are instead set up by BIOS code
> +even know that they are occurring. SMIs are instead set up by BIOS code
>  and are serviced by BIOS code, usually for "critical" events such as
>  management of thermal sensors and fans. Sometimes though, SMIs are used for
>  other tasks and those tasks can spend an inordinate amount of time in the

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
