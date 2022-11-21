Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D406C6325F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiKUOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiKUOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:32:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE27F0D;
        Mon, 21 Nov 2022 06:32:55 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D2B872D9;
        Mon, 21 Nov 2022 15:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669041173;
        bh=FjGQ5+CMRl+1dgXapRgEguFO20KgPtRjhpSaSmUMkO4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=AhiwNKaAVpcjRt8NVMCzo/kNou3W4d5z6vTdlZOi0zw/GErTczjjkR0uR5LJspsqr
         wOfFSGZ2Yq/RI5aYy6RhlEdIv5PiGNbUZBYHmoXum3K2zhwAFEI4zfQ+BqV8+lAT7o
         wrCrdOti4L+WmhIHB/pJQJ+0t/GKwRDDrALoMWQU=
Message-ID: <f02b5a25-9263-f396-14de-3a7781835222@ideasonboard.com>
Date:   Mon, 21 Nov 2022 14:32:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
 <2c69ae41-7920-1438-8bfc-8581aad0ee00@ideasonboard.com>
 <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
 <Y3tSj20qwJZ23VAY@smile.fi.intel.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH v1 2/4] media: ipu3-cio2: Convert to use
 software_node_register_node_group()
In-Reply-To: <Y3tSj20qwJZ23VAY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy and Hans

On 21/11/2022 10:27, Andy Shevchenko wrote:
> On Mon, Nov 21, 2022 at 11:22:17AM +0100, Hans de Goede wrote:
>> On 11/21/22 11:19, Dan Scally wrote:
>>> On 18/11/2022 18:56, Andy Shevchenko wrote:
>>>> The currently used software_node_register_nodes() is going to
>>>> be removed. Prepare driver by switchich to new API.
>>> Also looks good to me:
>>>
>>> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Thank you!
>
>> Any chance you can also give this series a test run on an IPU3 device to
>> ensure that it does not cause regressions ?
> Yes, it would be really appreciated!

All seems fine (including the kunit test) - you can add


Tested-by: Daniel Scally <dan.scally@ideasonboard.com>


to the series

