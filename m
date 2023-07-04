Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475EC746BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGDIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:25:05 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A8E5B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:25:03 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.1.4])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qGbLI-007voF-5E; Tue, 04 Jul 2023 09:25:00 +0100
Message-ID: <2c98134b-b6f4-d5a4-0c71-28f29dab474d@codethink.co.uk>
Date:   Tue, 4 Jul 2023 09:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 0/5] updates for i3c error printing
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
References: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 17:20, Ben Dooks wrote:
> During work on an i3c compatible system some of the
> probing does not produce much useful error output. This
> series is an attempt to add error reporting where it
> would be useful to track down the culprit.
> 
> Ben Dooks (5):
>    i3c: show error with node for invalid reg property
>    i3c: add error print to show device failing during populate bus
>    i3c: show node when printing unsupported 10-bit i2c dev
>    i3c: show error messages in of_i3c_master_add_i3c_boardinfo
>    i3c: dw; add print if cannot get resources
> 
>   drivers/i3c/master.c               | 28 +++++++++++++++++++++-------
>   drivers/i3c/master/dw-i3c-master.c | 12 +++++++++---
>   2 files changed, 30 insertions(+), 10 deletions(-)

Has anyone had a chance to review these?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

