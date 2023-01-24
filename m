Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABE7679AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjAXN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjAXN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:59:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6C27299;
        Tue, 24 Jan 2023 05:58:46 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 125568A9;
        Tue, 24 Jan 2023 14:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674568683;
        bh=+IKoJk285CRjKexmMgjG1gUz9g2XFQkogbpPUD07jrk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aNie/7FI6nBD+uimQzn6J9Ms2yl0JDSi8zcwil6xJh3vCLVEwm6/LwYE8ZXG8E3n0
         kdwsTXAIZ2PPKlieum+tdHp4unIYnyzYr0JFBwkFADAcrPOTUS2p85HWRVFWMAQ1aY
         kb60+dy6J5EN/9Bs6vp/8nlZrPTRFF1AtHAfDsDE=
Message-ID: <bc21ec03-bc20-3640-d5f0-9e72f50eabce@ideasonboard.com>
Date:   Tue, 24 Jan 2023 13:57:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] MAINTAINERS: Add myself as UVC Gadget Maintainer
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20221206113841.1359976-1-dan.scally@ideasonboard.com>
 <Y4+SxVzTywR3qHdg@pendragon.ideasonboard.com>
 <Y81RdyDX6SHGYc3W@pendragon.ideasonboard.com> <Y81ZmhguW3F0eGOv@kroah.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <Y81ZmhguW3F0eGOv@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/01/2023 15:43, Greg KH wrote:
> On Sun, Jan 22, 2023 at 05:08:39PM +0200, Laurent Pinchart wrote:
>> Hi Dan,
>>
>> I've just noticed that neither linux-usb nor Greg were CC'ed on this.
>>
>> Greg, could you pick this patch up ([1]) for v6.3, or should Dan resend
>> it with the right CC list ?
>>
>> [1] https://lore.kernel.org/all/20221206113841.1359976-1-dan.scally@ideasonboard.com/
> Please resend it with the correct list :)

Oops; how did I manage that!? Thanks for the heads up Laurent; I'll 
re-send it


> thanks,
>
> greg k-h
