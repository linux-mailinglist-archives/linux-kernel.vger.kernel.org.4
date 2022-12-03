Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB4641465
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 06:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLCF6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 00:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 00:57:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D932612A;
        Fri,  2 Dec 2022 21:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=y+Q6icb5gf7L8lM2da2GQW7PPHjMW0v2gUtTHLGjGV4=; b=n2VHN6fNRoYypi9fxPFQXBYHcf
        j5Oj+VHCG708oKFxEC7I6aYb2fkUpKWfxxUkS2NCOxLch74gou+AV/v3yFTQiOCY2yVv0oV6JpEyN
        bPjwvOgy0ztr52Fbxz/PUSZ3IsMzc6cdF/oLj0qJjXjpbNB+gRaFdZhhfcWaovk74cc0wWwEPpwYI
        2AupBdAKQ6savLEZkJj73YcukdhubR30JXjIk9SVDbYI0mJa/XprSSOyxrSDGGpH2gJ5IrYy76N01
        SYg0EIYTy7KHed8dWufSEd3ZhKOb8DED1qxAj3afo8+y2T7A15bGBILgtXjq1ps+ofes9mSXY/Fu3
        tR0bzQbw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1LX3-002YO1-ML; Sat, 03 Dec 2022 05:57:50 +0000
Message-ID: <49eefb22-28c9-c383-7d8b-5e90bb4cdda5@infradead.org>
Date:   Fri, 2 Dec 2022 21:57:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RESEND PATCH] platform/x86/intel/ifs: Add missing documentation
 entry
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, ashok.raj@intel.com, tony.luck@intel.com
References: <774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org>
 <20221203052445.502450-1-jithu.joseph@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221203052445.502450-1-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/22 21:24, Jithu Joseph wrote:
> Documentation for test_num member of struct ifs_data is missing [1].
> 
> Link: https://lore.kernel.org/lkml/774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org/ [1]
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  -Resending to "bp@alien8.de" as "bp@suse.de" reported undeliverable
> 
>  drivers/platform/x86/intel/ifs/ifs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index da1474e1d8eb..046e39304fd5 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -208,6 +208,7 @@ union ifs_status {
>   * @status: it holds simple status pass/fail/untested
>   * @scan_details: opaque scan status code from h/w
>   * @cur_batch: number indicating the currently loaded test file
> + * @test_num: number indicating the test type
>   */
>  struct ifs_data {
>  	int	integrity_cap_bit;
> 
> base-commit: 1a63b58082869273bfbab1b945007193f7bd3a78

-- 
~Randy
