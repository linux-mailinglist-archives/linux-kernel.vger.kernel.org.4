Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2C6DA403
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbjDFUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjDFUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092B4C2F;
        Thu,  6 Apr 2023 13:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED5A60FB3;
        Thu,  6 Apr 2023 20:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F129C433EF;
        Thu,  6 Apr 2023 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814021;
        bh=+lB9vXDw9cnDV7ltf0tk9O1r3yj5ZbitVGLuAGe8cXw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=h8XwQg/10rAs/NEvqqZV7yPPod1vxm7QekIIMNPg3cmgtJUl6yneql9N9O0vmKMx6
         zWo2KCUy4zgvzJgbaOa1KtKu1Yy+3igbCzJtmzK7b44B/4At/KPdafwYuWBhozB5ib
         kwebaXUH44mstu1ZQPAxDJICA6jicIs8/yOHWMeYpIko9OvYhSPUQ5CMyHH6UhjsYf
         9QwKN+IiqWF53pCBvimH2TtpNNZTKJrlvQRm2BOOEBfLJSUMFZLRuQ+c86LsGlccEK
         HWo0mIfyFATIXjDWvD6gMYUAOLGW7RPpp0b644yE75SQxp9XdZyp07PI3yamWtQ9B7
         e964bYAOyM03A==
Message-ID: <e8611940-6d1f-e415-e4fa-166eb98f5995@kernel.org>
Date:   Thu, 6 Apr 2023 22:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] MAINTAINERS: hwmon: drop Agathe Porte
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406204520.3013244-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230406204520.3013244-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 22:45, Krzysztof Kozlowski wrote:
> Mails to Agathe Porte bounce ("550 5.4.1 Recipient address rejected:
> Access denied. AS(201806281)").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 1 -

I forgot to update bindings. :(

Best regards,
Krzysztof

