Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF685B574B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiILJkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiILJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:40:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8BF11AF08;
        Mon, 12 Sep 2022 02:40:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC22D113E;
        Mon, 12 Sep 2022 02:40:05 -0700 (PDT)
Received: from [10.57.49.22] (unknown [10.57.49.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB79C3F71A;
        Mon, 12 Sep 2022 02:39:57 -0700 (PDT)
Message-ID: <1037211f-6c10-16de-4819-2a51d115f65b@arm.com>
Date:   Mon, 12 Sep 2022 10:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 06/13] Documentation: coresight: fix a documentation build
 warning
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        corbet@lwn.net
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1660829433.git.mchehab@kernel.org>
 <ff5c57f03d106dc5cc14448ec0db224267fb1bfb.1660829433.git.mchehab@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ff5c57f03d106dc5cc14448ec0db224267fb1bfb.1660829433.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 14:38, Mauro Carvalho Chehab wrote:
> Using wildcards for cross-reference doesn't work, as the Sphinx
> automarkup plugin is not smart enough. So, changeset
> c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
> tried to fix it, but at the wrong way, as it the building system
> will keep producing warnings about that:
> 
> 	Warning: Documentation/trace/coresight/coresight.rst references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm,coresight-
> 
> As automarkup will still try (and fail) to create a cross reference.
> So, instead, change the markup to ensure that the warning won't be
> reported.
> 
> Fixes: c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
> 
> See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/
> 
>   Documentation/trace/coresight/coresight.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 4a71ea6cb390..826e59a698da 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -130,7 +130,7 @@ Misc:
>   Device Tree Bindings
>   --------------------
>   
> -See Documentation/devicetree/bindings/arm/arm,coresight-\*.yaml for details.
> +See ``Documentation/devicetree/bindings/arm/arm,coresight-*.yaml`` for details.
>   
>   As of this writing drivers for ITM, STMs and CTIs are not provided but are
>   expected to be added as the solution matures.

