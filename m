Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35843604FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJSSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJSSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:54:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE55D1C2E90;
        Wed, 19 Oct 2022 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Q/W/d+/drS030GPETtaIIn10LSjQL2MQ3q9HZ5gvbqA=; b=hfdD7/XZTqBjmzmV/mjlMHrLzC
        sQpAhSH0JVqBG6od/kZYGuF8V5Q6tEBPGcvogRd0zLFxvpG0sxZw3bRZRpMfSzNxSjjE6lBNxcKK2
        FGgKGErMKh3+UUOLRpN/Vvs9onSXFQhqq1BXXfJcHsAmCxQ7fYgmfabxqTrIt+4qkz4teSC8bDAW5
        0ZX6rX1IIVVQicXtNTM2763N9nLGDxt8cZljBdMfAiLb0HsjkZXvAwG5ZPx1+OUy0YMdSHx05BLkh
        dEM7yAzekqgwe2+MhbGOeH/ySAuEdCVXOH+rrY1ke5neJuojDPP+pe+rry37X4cmzyxmK5V2KqBaC
        1HCtM2Ew==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olECR-004jqG-CL; Wed, 19 Oct 2022 18:53:55 +0000
Message-ID: <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
Date:   Wed, 19 Oct 2022 11:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] of: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/22 06:02, Jilin Yuan wrote:
> Delete the redundant word 'of'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 8cefe5a7d04e..16c7e5a2a868 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -19,7 +19,7 @@
>  
>  /**
>   * of_match_device - Tell if a struct device matches an of_device_id list
> - * @matches: array of of device match structures to search in
> + * @matches: array of device match structures to search in

Hi,
Rob has already explained this at least 2 times.

The second "of" is "open firmware".
I would write it
              array of OF device match structures to search in
:)

>   * @dev: the of device structure to match against
>   *
>   * Used by a driver to check whether an platform_device present in the

-- 
~Randy
