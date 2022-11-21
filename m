Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76124631B10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKUINs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKUINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:13:42 -0500
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2457227FD2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:13:41 -0800 (PST)
Received: from [167.98.27.226] (helo=[10.35.6.112])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1ox1vs-00Bn5c-GT; Mon, 21 Nov 2022 08:13:36 +0000
Message-ID: <7cd41722-16a8-1571-57ca-b11a15279517@codethink.co.uk>
Date:   Mon, 21 Nov 2022 08:13:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] riscv: defconfig: add SERIAL_8250_DW
Content-Language: en-GB
To:     Corentin Labbe <clabbe@baylibre.com>, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221119121953.3897171-1-clabbe@baylibre.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20221119121953.3897171-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 12:19, Corentin Labbe wrote:
> jh7100-starfive-visionfive-v1 DTB was recently added, but all my try to
> boot it in kernelCI failed.
> This is due to a missing serial driver in defconfig.
> So let's add CONFIG_SERIAL_8250_DW which is needed.

This block is an extended 16550, so not sure why the 16550/8250
driver isn't being used as a backup in case the DesingWare variant
isn't there.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

