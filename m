Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6047768B69E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBFHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBFHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:46:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8B4EDE;
        Sun,  5 Feb 2023 23:45:59 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 286794DA;
        Mon,  6 Feb 2023 08:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675669557;
        bh=w3VNz6O2dOeY6DcvzR7FtI4JX5np0V8jiDeBUs8bso4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=e2b7IIHHvpVNQEZ3NURTL9XZrlmMPOKgw2RtIWi7OcnRS7MxQGobysb9uN1DAbCdj
         +ngroi4ivf5pSkQJ5igEXgRiWr54M4zRdukb19RAQ5n4dvoIHh0HxS0DH2GsQhKyMU
         6n0V7BLwdBNy9McmsmR6lyCPijD3NoI5X9Ju5q3c=
Message-ID: <93b56558-b25c-401a-031d-971fc644054b@ideasonboard.com>
Date:   Mon, 6 Feb 2023 07:45:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230206145004.6e043ed3@canb.auug.org.au>
From:   Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: linux-next: build warning after merge of the usb tree
In-Reply-To: <20230206145004.6e043ed3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen, and sorry Greg - I should have noticed that, I'll figure 
out why I didn't. Does this just need a patch on top or some other 
process to be fixed?

On 06/02/2023 03:50, Stephen Rothwell wrote:
> Hi all,
>
> After merging the usb tree, today's linux-next build (htmldocs) produced
> this warning:
>
> Documentation/ABI/testing/configfs-usb-gadget-uvc:14: ERROR: Malformed table.
> Text in column margin in table line 4.
>
> ================        =============================
> bInterfaceNumber        USB interface number for this
>                          streaming interface
> enable_interrupt_ep     flag to enable the interrupt
>                          endpoint for the VC interface
> ================        =============================
>
> Introduced by commit
>
>    a36afe780461 ("usb: gadget: uvc: Add new enable_interrupt_ep attribute")
>
