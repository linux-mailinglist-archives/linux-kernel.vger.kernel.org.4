Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920535FAD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJKHdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:33:06 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 00:33:05 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FBB89AEE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=10ivr//41bZZoeNd/Yii2ybmXkrBrEPl8L1SzuTQVrA=; b=a5n1j8dwxGN4+jJdY8T0DaQ25P
        8KMBmjOfz92zpQ8D5Oe9q6NRAzbt1mGNiKfIQAjZt/Iew73yszmz2ov5US0qEPi5MaR0KoHaEtKP/
        0vBPFR6RHa/CC+M4atb7qpy2TRJRdA9WxZSFUriww29ALgHBkMikbhxgSgXvBO6XJvqIr9X5huLAC
        ZP9mQua9NuyM5BlSwMyJGzIaaLH6VodUv0PmGhMq0IYZHKGN806akd0xPCwis/jpi0R1k5lJ1DWw8
        au4uD2yARsETS1MIpxPM4RRgpCrlKUaEbV5vK5KeKtEQtXiPfnYmc2vzIx3hUktMe07O987pi78ju
        6+RLpkkQ==;
Received: from 236.51-175-223.customer.lyse.net ([51.175.223.236]:60384 helo=[192.168.1.161])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1oi9iB-0002Q0-2b; Tue, 11 Oct 2022 09:29:59 +0200
Message-ID: <0a6bc69d-398c-7883-d186-c0f7c526ceaf@skogtun.org>
Date:   Tue, 11 Oct 2022 09:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH] Remove Intel compiler support
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221011031843.960217-1-masahiroy@kernel.org>
From:   Harald Arnesen <harald@skogtun.org>
In-Reply-To: <20221011031843.960217-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada [11/10/2022 05.18]:

> include/linux/compiler-intel.h had no update in the past 3 years.
> 
> We often forget about the third C compiler to build the kernel.
> 
> For example, commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
> only mentioned GCC and Clang.
> 
> init/Kconfig defines CC_IS_GCC and CC_IS_CLANG but not CC_IS_ICC,
> and nobody has reported any issue.
> 
> I guess the Intel Compiler support is broken, and nobody is caring
> about it.

Also, Intel ICC is deprecated:

$ icc -v
icc: remark #10441: The Intel(R) C++ Compiler Classic (ICC) is 
deprecated and will be removed from product release in the second half 
of 2023. The Intel(R) oneAPI DPC++/C++ Compiler (ICX) is the recommended 
compiler moving forward. Please transition to use this compiler. Use 
'-diag-disable=10441' to disable this message.
icc version 2021.7.0 (gcc version 12.1.0 compatibility)
$
-- 
Hilsen Harald
