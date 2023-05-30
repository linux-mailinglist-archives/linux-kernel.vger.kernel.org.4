Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65A7156C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjE3HbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjE3Ha2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D060DB;
        Tue, 30 May 2023 00:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8996116F;
        Tue, 30 May 2023 07:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32152C433EF;
        Tue, 30 May 2023 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685431792;
        bh=YH/dqY5tr8oYE4vsAZLXzHiXv9oL5DxRkEBaQ/8J2ss=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M0IA/Wpoi5Py2g0i4aJTdGo90jaZ5MSCuxAUT7rsZ1xsCaRijM+9r03vnjfhs/dTX
         QfcwvRy6Rp4suhB1ngxuNJl2JQ7HeJNGi8bvb9DidaKSKD8sxNEKX0fxubOH1zqYBH
         xYOzTGXtMZ/9X1RwjE4DKV6rglI5ARJX5/PJ3CJ4BFTSEZTVP6eY0FrBpjn+usOGxV
         RaaR6Txro9TQbMFzdaaLeIn7wOIecMq5CPkc46Sr1VJkMUIQQn2xwEBsd8szw18FHZ
         RMB9rwGEKP+xAXiXx4XH4VgHRZ3OOXOHwBGP/qexR16B1iuGb5SZ7XSlEBmUO50Ps2
         1Ctu73YsrkoNA==
Message-ID: <e4f29418-6612-cbe6-10be-7fb3b078caac@kernel.org>
Date:   Tue, 30 May 2023 10:29:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: Signed-off-by missing for commit in the usb tree
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230530081611.20239925@canb.auug.org.au>
 <2023053050-patrol-item-1844@gregkh>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2023053050-patrol-item-1844@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:27, Greg KH wrote:
> On Tue, May 30, 2023 at 08:16:11AM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> Commit
>>
>>   b4a4be847184 ("USB: fix up merge of 6.4-rc4 into usb-next")
>>
>> is missing a Signed-off-by from its author.
> 
> Known issue, it was part of a thread as to how to fix up the merge and I
> wanted to give the original author credit for it.
> 

Thanks Greg & Stephen.
I have no issues with the patch.

-- 
cheers,
-roger
