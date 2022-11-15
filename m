Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F0629979
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiKOM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKOM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:58:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04EC641A;
        Tue, 15 Nov 2022 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668517129; x=1700053129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=odcUNrpXlpwBBrvLzRHOUBZ4LFlpk63pV4O7hObhms8=;
  b=e8rbxV4Fga81MZXD68R8SMsd+wjz1Ue6qtE+48l+9sxNZuJ83ETL9TfO
   RXXJAy+lsDmn9zcHAVLg7/GMWDeRUoUlUG6bGTfHCEYR9fOsBRQNeqFVQ
   Krrs0pv86WtALpBDr8M+u4n2fX5wL/KZ5mKDmkEKcEhrz7e6G0krwmL28
   O8eCMJMq6ZJUY6xVNhjc78mK3r+tB66Tv/z5c7vKePmm/n1TQ5PvSTX4/
   VV7xQah7s09zUR/+niK3hcF6USxR5uixBczcME22tyP37sS763WPL8/oG
   UN7CgSWbrZs8rT5LNAT10/k0C7xx9h2S/7l0JGC0uhxfQY9thO/CDgm0+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398535132"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="398535132"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 04:58:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="641197495"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="641197495"
Received: from jawiblin-mobl.ger.corp.intel.com (HELO [10.252.18.33]) ([10.252.18.33])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 04:58:47 -0800
Message-ID: <16b18a0d-4921-311e-be24-1103f90a8ac2@linux.intel.com>
Date:   Tue, 15 Nov 2022 14:59:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] headers: Remove some left-over license text in
 include/uapi/linux/hsi/
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <4919073b3dee8ca7612989659d31b12f9c5491ba.1662897400.git.christophe.jaillet@wanadoo.fr>
 <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/11/2022 23:01, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Sep 11, 2022 at 01:56:59PM +0200, Christophe JAILLET wrote:
>> Remove some left-over from commit e2be04c7f995 ("License cleanup: add SPDX
>> license identifier to uapi header files with a license")
>>
>> When the SPDX-License-Identifier tag has been added, the corresponding
>> license text has not been removed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
> 
> IIRC that was intentional, since the plan was to seek for an
> explicit Ack from the copyright holder when removing the text.
> I've added Greg for clarification and hopefully the latest
> mail address from Kai and Peter.

I'm fine with the removal of the boilerplate text, SPDX is covering that.

I would appreciate if you pick my personal ack for this:

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> -- Sebastian
> 
>>  include/uapi/linux/hsi/cs-protocol.h | 14 --------------
>>  include/uapi/linux/hsi/hsi_char.h    | 14 --------------
>>  2 files changed, 28 deletions(-)
>>
>> diff --git a/include/uapi/linux/hsi/cs-protocol.h b/include/uapi/linux/hsi/cs-protocol.h
>> index c7f6e7672cb5..07c3bfb67463 100644
>> --- a/include/uapi/linux/hsi/cs-protocol.h
>> +++ b/include/uapi/linux/hsi/cs-protocol.h
>> @@ -6,20 +6,6 @@
>>   *
>>   * Contact: Kai Vehmanen <kai.vehmanen@nokia.com>

I don't think Kai's nokia.com mail address is valid as a contact
information...

>>   * Original author: Peter Ujfalusi <peter.ujfalusi@nokia.com>



>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License
>> - * version 2 as published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - * General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> - * 02110-1301 USA
>>   */
>>  
>>  #ifndef _CS_PROTOCOL_H
>> diff --git a/include/uapi/linux/hsi/hsi_char.h b/include/uapi/linux/hsi/hsi_char.h
>> index 91623b0398b1..5ef72f0daf94 100644
>> --- a/include/uapi/linux/hsi/hsi_char.h
>> +++ b/include/uapi/linux/hsi/hsi_char.h
>> @@ -5,20 +5,6 @@
>>   * Copyright (C) 2010 Nokia Corporation. All rights reserved.
>>   *
>>   * Contact: Andras Domokos <andras.domokos at nokia.com>
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License
>> - * version 2 as published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>> - * General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> - * 02110-1301 USA
>>   */
>>  
>>  #ifndef __HSI_CHAR_H
>> -- 
>> 2.34.1
>>

-- 
Péter
