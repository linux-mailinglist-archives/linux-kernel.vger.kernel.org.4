Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F506A7F76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCBKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCBKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:01:26 -0500
X-Greylist: delayed 3572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 02:00:58 PST
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EE46156
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EogLFcVbQRUQ3zsIo9NgsjC0jIGju+sWk3KgrzT8SDw=; b=C6HxO8R6Gc2VQjuH4s9M7qH34W
        D4ss9HzmLIJF6Mb4QTcFYgl2imZa1vRrmpPlK+BwCe5pCc/XqSWiPmB9lc1WJ+BiCECgkawAtd+WW
        hRbfJaGhY57PHUFRI5D3XPgzquVebXrX5rLN+gpfG+5shzs1DTcZmXu7/n7PRncP8bSQjWJ1TS2Bc
        qiMhh6PNdsvgbC1fjPqOlh0gfkm3+QNOSVMqNLjaLDp1E9/tS6XHL1KiExSRIYjvwVKrR1OVpM+mg
        tcViiKmt0TaX6ZiQJV6Qt1QNr72u1BT/15xafsiJLo5FOfXiirQQP9f0sVu4osL3FXxwzmLLvYWno
        Qm0ge9lQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:48406 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1pXduG-00Bpix-20;
        Thu, 02 Mar 2023 09:03:16 +0100
Message-ID: <be465a23-7f31-004c-3bb7-d8021187da5d@norik.com>
Date:   Thu, 2 Mar 2023 09:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] watchdog: imx2_wdg: Declare local symbols static
Content-Language: en-GB
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230228151648.4087637-1-linux@roeck-us.net>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <20230228151648.4087637-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 02. 23 16:16, Guenter Roeck wrote:
> 0-day complains:
> 
> drivers/watchdog/imx2_wdt.c:442:22: sparse:
> 	symbol 'imx_wdt' was not declared. Should it be static?
> drivers/watchdog/imx2_wdt.c:446:22: sparse:
> 	symbol 'imx_wdt_legacy' was not declared. Should it be static?
> 
> Declare as static variables.
> 
> Fixes: e42c73f1ef0d ("watchdog: imx2_wdg: suspend watchdog in WAIT mode")
> Cc: Andrej Picej <andrej.picej@norik.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Hi Guenter,

thanks for the fix. Sorry for the trouble.

Best regards,
Andrej
