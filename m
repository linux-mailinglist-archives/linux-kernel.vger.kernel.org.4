Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C76FBCFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjEICQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEICQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:16:18 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E01A9D047;
        Mon,  8 May 2023 19:15:48 -0700 (PDT)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 2A34F180119BDF;
        Tue,  9 May 2023 10:14:47 +0800 (CST)
Message-ID: <44d14534-b6ec-4fa6-fb0d-1a3e75fc594c@nfschina.com>
Date:   Tue, 9 May 2023 10:14:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <2023050841-pedicure-magnify-bea5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am so sorry for this. I will modify my name format to Su Hui.

This patch is for v6.3. It seems not be modified by others when I view 
source code.

I didn't know someone else had sent the same patch which wasn't merged 
in to

mainline git source.

Thanks for your reply.

Su Hui

On 2023/5/8 22:55, Greg Kroah-Hartman wrote:
> On Mon, Apr 24, 2023 at 12:19:40PM +0800, Suhui wrote:
>> No need cast (void*) to (struct fusb302_chip *) or (struct tcpm_port *).
>>
>> Signed-off-by: Suhui <suhui@nfschina.com>
> Is that your full name?  If not, please always use whatever you sign
> documents with.
>
>> ---
>>   drivers/usb/typec/tcpm/fusb302.c | 2 +-
>>   drivers/usb/typec/tcpm/tcpm.c    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> This does not apply to 6.4-rc1, what did you make it against?
>
> thanks,
>
> greg k-h
