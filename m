Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBE6E3241
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDOQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDOQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:05:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C261BE1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=vfX97L9Ghd2i2aJ8EsgFqKiFciZdaPZEWkAYB8x8dUg=; b=xX1Qw8/uP+SCaLglZGcGollNNP
        EI0wTxxcL9JqoVdJQrmJruSGuJPPGhS3+G21M/vG5JpOxhUzDrgaWmwF0NIoq4NOADsY3iZUrfL/i
        DUh8hNshsiuERtWS8XYFnzLah3uTZpVyQpyILuDuDnxfmtIBbuIHJDj3ii2LTXd0pdrU9Rc8P9l+g
        e2njLQTCBzM01NHTtMw9UiLoxKjZBBnLL1fnQ1N0IImjsjnDpLdI7UcU+Jj0vaEpWMROCetpM0VpH
        ZSKh7qkjuOmdaIftyabA2BlTdQF8YWR65OFpSatbY7Q2f+AgQZAkoFMlFoa+RQpGv7F5XrazBX55s
        e6ks4vqg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pniPE-00CPmo-0B;
        Sat, 15 Apr 2023 16:05:40 +0000
Message-ID: <f5683efc-733e-a5ee-b3ba-6b35e04e23b4@infradead.org>
Date:   Sat, 15 Apr 2023 09:05:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/15] w1: omap-hdq: allow compile testing
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
 <20230415104304.104134-13-krzysztof.kozlowski@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230415104304.104134-13-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/15/23 03:43, Krzysztof Kozlowski wrote:
> omap-hdq does not depend on anything from ARCH_OMAP for building.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

It appears that patches 4 and 12 are the same...

> ---
>  drivers/w1/masters/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
> index 692cac3ff0ee..ad316573288a 100644
> --- a/drivers/w1/masters/Kconfig
> +++ b/drivers/w1/masters/Kconfig
> @@ -53,7 +53,7 @@ config W1_MASTER_GPIO
>  
>  config HDQ_MASTER_OMAP
>  	tristate "OMAP HDQ driver"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP || COMPILE_TEST
>  	help
>  	  Say Y here if you want support for the 1-wire or HDQ Interface
>  	  on an OMAP processor.

-- 
~Randy
