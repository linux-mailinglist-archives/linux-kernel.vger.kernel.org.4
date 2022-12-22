Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0236A65423F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiLVN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLVN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:59:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280A13EBC;
        Thu, 22 Dec 2022 05:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3A861B96;
        Thu, 22 Dec 2022 13:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377B2C433D2;
        Thu, 22 Dec 2022 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671717583;
        bh=ZfUC8QuxpIOQKZDvahJW1arFR8cIEjLdc/Nr2xYH7/A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ar++h+qa0VDDS13T9TRRuKRw7h1t4jQ4rP4Xpi4NlIycbJW/86PH3CdjHnYAKBR5p
         PVwb14Jn8xC5EfZxFZM+9RCoBk1AZZX+VoY3HvMOn/gVjS4MawSPptd2k+Rjm/59xr
         UD/5YPWOMkibaQqgNqFuyp8Wc9hyMT9rx1c8RBjfZkoAsQOnvShJBoII0ghEAmpQl3
         zmBEzq/uJo/jbYrXLxRuqsFKYhlLcLTBDyjr8SpGESzybDhXHisuGhm2ufKWFsxnWB
         K2obJQXE8ZcdNp/xatvGgUTi5UEJyHfrKiKQZ3T5gO4c23Ztc7+/4y5pNOddSQtbXp
         atkMjpQGyX6cQ==
Message-ID: <791569bf-e373-d600-618b-a343922f3687@kernel.org>
Date:   Thu, 22 Dec 2022 14:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/2] dt-bindings: Add Arm corstone500 platform
Content-Language: en-US
To:     Emekcan Aras <emekcan.aras@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222123244.147238-1-emekcan.aras@arm.com>
 <20221222123244.147238-3-emekcan.aras@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221222123244.147238-3-emekcan.aras@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 13:32, Emekcan Aras wrote:
> Add bindings to describe implementation of
> the ARM Corstone500 platform.
> 
> Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
> ---
>  .../bindings/arm/arm,corstone500.yaml         | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,corstone500.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,corstone500.yaml b/Documentation/devicetree/bindings/arm/arm,corstone500.yaml
> new file mode 100644
> index 000000000000..cfe41f7760fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,corstone500.yaml

I don't think you solved my comments. Otherwise please point me how did
you solve this one:

"OK, so similar as Corstone 1000, but please tell me - any reason why
you keep them separate in the bindings? Next time new file for Corstone
1001, 1002, 2000, 2221 etc.?"


Best regards,
Krzysztof

