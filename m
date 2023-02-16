Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079AC698B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBPFJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:09:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48793CE2F;
        Wed, 15 Feb 2023 21:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GTyOxFejK60eKYTy4sgLg9Yv+kVCqT/xvsRTmVn2BcI=; b=inLqL6C+dqTL68RQQi7kAWOe84
        +MJ8XJHdKhGx2xuIJSxPBQXuQPpVvQ+BgtKzkZN1CaTSfzeA5uzza9Ez7lvpXY3qYoo7P0U1MozhO
        tOBq6vFjFDJWA5mK401Pn91fauYZe9sdu5WKpJqbg5yUtxgqx974kqDb4Gr7ZugV+Wu8jmx8bPkoJ
        7t/YGdfXmqjgigoq1YqdqzeBmJj6+gyPlOV/Grw9g3WvaVh9C5zR4WQZ2zquuwAsCgOiL4zAGNK4s
        OYd2TntQMX1euD5eh1OAPj/6lEaGSLQG9oqutsevQS7XTIHQ9BlzdfvxvQ6T6k4mtin7Rhgjk82QN
        XtzGJk5w==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSWWF-008Ujb-CC; Thu, 16 Feb 2023 05:09:19 +0000
Message-ID: <1e3d31c7-bc95-6476-badb-663c4280e1bf@infradead.org>
Date:   Wed, 15 Feb 2023 21:09:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Paatch] [staging][atomisp] Remove unneeded version.h include
 pointed out by 'make versioncheck'
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-media@vger.kernel.org
References: <4b9f2443-3360-bdb0-c4d4-7687db333d0a@gmail.com>
 <Y+22naE0azHHF0nY@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y+22naE0azHHF0nY@kroah.com>
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



On 2/15/23 20:52, Greg Kroah-Hartman wrote:
> On Thu, Feb 16, 2023 at 01:57:45AM +0100, Jesper Juhl wrote:
>>> From d0b9a59ac1bc69523b5cc8b2bab0b0e0b4bd0ab6 Mon Sep 17 00:00:00 2001
>> From: Jesper Juhl <jesperjuhl76@gmail.com>
>> Date: Mon, 13 Feb 2023 02:52:24 +0100
>> Subject: [PATCH 05/12] [staging][atomisp] Remove unneeded version.h include
>>  pointed out by 'make versioncheck'
> 
> Why is this in the body of your email?
> 
>>
>> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
> 
> We can not take patches without any changelog text, sorry.

Jesper,

For examples, see

  https://lore.kernel.org/lkml/20220828024003.28873-5-masahiroy@kernel.org/
and
  commit cfb24463a53e.

HTH.
-- 
~Randy
