Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273AF604E14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJSRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJSRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:05:57 -0400
X-Greylist: delayed 1576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 10:05:49 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412381578A5;
        Wed, 19 Oct 2022 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=++P8P8qjfNt1suFBjhkyQfz1Y5h3Np7YkfW/laOGHwk=; b=Trqs8jTjgRTZsnIk3NHCQV0jjm
        rzksNYJYBhbwplL/YGv7o1oKiybfQvH1BVguYJCczKhDczOymMFI06JapYcx1JwihFAlKjEwb/hu3
        jn2MBHoBoedNl74jOSqMKo0GkmBF6wB8cBZ8yrGI9W5pVWqjvlx7ktAIoYn+OiZ19qFhMdvdw3hI2
        9w1VaiWZaxSGG5vqarpMsaUX4wGla5cXc8iZyTLN0tqUBzodFP78sqlA4MAFSQssKHhl/p9QzApR2
        O/Xv7N2MltlenQjZrS+1faRCczzZ2NYGot2MsEoG0CTjCLWfgGBUZVvvoaccZ6ZliGfdQwGWCA65l
        XOYOeA5w==;
Received: from [2600:1700:4830:1658::fb2] (port=50850)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1olC6D-0003V7-8h;
        Wed, 19 Oct 2022 12:39:29 -0400
Message-ID: <0586f41d-e316-b6b9-b962-f50766a680ed@lechnology.com>
Date:   Wed, 19 Oct 2022 11:39:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/14] clk: remove davinci dm3xx drivers
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-5-arnd@kernel.org>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20221019152947.3857217-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 10:29 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The davinci dm3xx machines are all removed, so the clk driver
> is no longer needed. The da8xx platforms are now using DT
> exclusively, so those drivers remain untouched.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


