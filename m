Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC626BD4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCPQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:10:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38DCABB2D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=LBXYyc16/5pKDM5euOk0KleI9z9fdOz7J7qGrgTPaO4=; b=P7gTP1QPRqunmO4touha00AnAg
        zYOjYKmLfQIMQ1LrXZ5Qc2B6BBVyLDtLsryHOW8tnRPnROCVxhFQIRFKePTT7V4ahKQPUxpIil3x6
        O6EwTqZcgp4ltKW/SdA9ajr0bg40f0lXCQwebWg8+u6AwpSPj5jDMwrqRPCwbr8x8MiNr7Zz0OrQI
        SxqpHXkssMp/pEarLF9vwIahKGkwmWtzo9VFckUbQb90Gi0nQbaZO+O98RUDZlOizoa9vvV53HbUO
        mxSpyX2c54FTcdDlsBF2I5sj87XeX8jaEmpLMG+qwJXBwhdT7uACZ+yMDWUCUSGHm009EJ+S66YO2
        PtZl5jhw==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcqBL-00Gx6z-2t;
        Thu, 16 Mar 2023 16:10:23 +0000
Message-ID: <bc047600-4e40-5d7b-980c-bdab28324057@infradead.org>
Date:   Thu, 16 Mar 2023 09:10:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] Staging: octeon: Fix line ending with '('
Content-Language: en-US
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev
References: <20230316155202.GA82100@sumitra.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230316155202.GA82100@sumitra.com>
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

Hi--

On 3/16/23 08:52, Sumitra Sharma wrote:
> Adhere to coding-style.
> 
> Checkpatch has reported code style warning:
> CHECK: Lines should not end with a '('.
> 

Not to complain about the patch, but where is this documented
in coding-style?  I searched for it and cannot find it.


Thanks.

> Enhance the design of a function header:
> Align the function parameters immediately after '(' in a single line.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
> 
> v2: Change patch subject and description.
> 
>  drivers/staging/octeon/octeon-stubs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 7a02e59e283f..3e7b92cd2e35 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
>  						  int32_t value)
>  { }
>  
> -static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
> -	int interface,
> -	int port)
> +static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
>  {
>  	union cvmx_gmxx_rxx_rx_inbnd r;
>  

-- 
~Randy
