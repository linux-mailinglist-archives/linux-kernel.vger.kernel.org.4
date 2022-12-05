Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE536643880
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiLEW4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLEW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:56:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22F1836A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6tKh/snqzRlgpGlCi6iJv5RiB/fIiHhdOGzwFGtnRbE=; b=F3++cR9640IgCdRwVRgD7VMUON
        px8Utqj66hDUrqadxXt2mTWM7psBRoFTIGugPxnbN8wc8kU6E+ZA0cLyIdtNCpDvQt1QHRxq03mjY
        sjb5wfu/jK6FpIsQWGgXtGr4HOoeqlYTnFHL5feDJFXKNSS+GHhp5Ut41gLuaiXArRFxLvPcA9O/5
        JQXhznkXddddPewsVnJrSnhzex6Kx81Qw9CXK21wGpdzNsOKUSl1GLoSvrbxoa98kLAmOKC9OeTPj
        roodm/3TmFjOCoBP2bFhrHwwxJDuetrmwPcIVZU0T5dT+ckiRN0tFIOavjW2roRYSE40xJKZ3TgPx
        E1s5L0gw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2KNk-00BdBp-8I; Mon, 05 Dec 2022 22:56:16 +0000
Message-ID: <e2440212-fbc3-3866-415f-135c391c8c6b@infradead.org>
Date:   Mon, 5 Dec 2022 14:56:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver
 (GQR)
Content-Language: en-US
To:     Zopolis0 <creatorsmithmdt@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
 <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
 <CAEYL+X8opFs47DMM=St42-piw9j4Ha7CP75YeFCP67pgtRn7fQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEYL+X8opFs47DMM=St42-piw9j4Ha7CP75YeFCP67pgtRn7fQ@mail.gmail.com>
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



On 12/5/22 14:14, Zopolis0 wrote:
>> MAINTAINTERS file:
> 
>> CHAR and MISC DRIVERS
>> M:      Arnd Bergmann <arnd@arndb.de>
>> M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> S:      Supported
>> F:      drivers/char/
>> F:      drivers/misc/
> 
> Should I re-send the patches to those then?

Probably. I would.

-- 
~Randy
