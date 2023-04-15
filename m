Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1366E3243
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDOQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDOQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:07:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C223A9A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=c4fvZclj7H/dfqfF9/5HYhF0ucn+Db6pvUeEhkUPxzU=; b=QtVTzomt749HvZDTFe3sJ3ywFG
        Np0dQgNK2gQRtj5jj5rDnbIud2cp1Yp4pEMpZ6GliFta/ZeXg5HBI1Hy8S6/zDh92UbSAT0a6SdF9
        V2xjdkZvksZWg+X3AT4FzzXFI0upuSXNhJNJjiPy5RshSaj+Hzyf9XK13Os7EcTe1G7sehTeX9dPA
        w5iFklfbdt+wysqWN39FXW0BkHAns6MQF+hkRoypykvZ4oGxi48yoPz9MOIHLQMNRjsh9MwywVkYg
        q3G5+VMpLih8cusiqCR7RQo8NNXAZaenBxlWtCcPbGm+VNBJRmmYTBEcYPcS2EhmlSMHqfWH1GNk+
        sp4t+/5Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pniRR-00CQ4L-2y;
        Sat, 15 Apr 2023 16:07:57 +0000
Message-ID: <1d836cd6-72aa-d7c4-cbc0-71592b13781e@infradead.org>
Date:   Sat, 15 Apr 2023 09:07:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/15] w1: ds2408: drop kerneldoc annotation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
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



On 4/15/23 03:42, Krzysztof Kozlowski wrote:
> Drop kerneldoc annotation from comment which is not a kerneldoc to fix:
> 
>   w1_ds2408.c:210: warning: This comment starts with '/**', but isn't a kernel-doc comment
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  drivers/w1/slaves/w1_ds2408.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
> index ad102c577122..7fa911989193 100644
> --- a/drivers/w1/slaves/w1_ds2408.c
> +++ b/drivers/w1/slaves/w1_ds2408.c
> @@ -206,7 +206,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
>  }
>  
>  
> -/**
> +/*
>   * Writing to the activity file resets the activity latches.
>   */
>  static ssize_t activity_write(struct file *filp, struct kobject *kobj,

-- 
~Randy
