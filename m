Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79246663C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAKT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAKT3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:29:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF3D13D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rqQeN6/Cf2+K34wArxyBVjlOUTyvbg/yFM9wo9L2e7A=; b=Q37HqO2OEhjXwom3iUv42CdBtQ
        kT+I3ekN5ia/t9fxn3IJkksvFC2dFuelL3D3p5YJKRFAxj9xOD4V6AblrKdmIYaOpePcwnXftwPnJ
        rV003SHib5i+QwcgHpVQlsVtqcTkApc+WBsmxLYQn4Xse3XqLNDfphxzGOFNI6Y7b6y22jiI/5NoE
        QTd5Uq8H1wzSbX6sQJOgnhigCvHG6me7wqKoFWxlFhGztCATEYpyRoMTjy6iDfpPJKvWIQ3tjk5F9
        C8i64nuxx9Zzc4eC4CE5u/ZpfoeWnm1I1Wqx7RwRSI83xFphFInPT4dewoNeSgzr2BRlmRFVCPqU/
        9rd94PnQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFgmf-00Cjq7-7C; Wed, 11 Jan 2023 19:29:13 +0000
Message-ID: <baf03556-718b-ea50-db48-04819a9cb094@infradead.org>
Date:   Wed, 11 Jan 2023 11:29:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] driver core: bus.h: document bus notifiers better
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230111092331.3946745-1-gregkh@linuxfoundation.org>
 <CAJZ5v0hOOeGBKiOpnsQSm=CKum-JEASmygKXrU76WK7gynVdKw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJZ5v0hOOeGBKiOpnsQSm=CKum-JEASmygKXrU76WK7gynVdKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 01:54, Rafael J. Wysocki wrote:
> On Wed, Jan 11, 2023 at 10:23 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> The bus notifier values are not documented all that well, so clean this
>> up and make a real enumerated type for them and document them much
>> better.  When doing this, remove the hex values and just rely on the
>> enumerated type instead as that is all that is needed.
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
> 
> I would add a Co-developed-by for Randy along with his sign-off (which
> was given IIRC).

or
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Either way; doesn't matter.

> Anyway
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> 
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>> v3: - fix up the documentation to be proper kernel-doc format thanks to
>>       Randy.
>>     - Remove the values entirely now that this is an enumerated type,
>>       they are not needed.
>>
>> v2: - move the values to decimal from hex as pointed out by Rafael.
>>
>>  include/linux/device/bus.h | 42 +++++++++++++++++++++++++-------------
>>  1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
>> index d529f644e92b..7b4a48b5159b 100644
>> --- a/include/linux/device/bus.h
>> +++ b/include/linux/device/bus.h
>> @@ -257,21 +257,35 @@ extern int bus_register_notifier(struct bus_type *bus,
>>  extern int bus_unregister_notifier(struct bus_type *bus,
>>                                    struct notifier_block *nb);
>>
>> -/* All 4 notifers below get called with the target struct device *
>> - * as an argument. Note that those functions are likely to be called
>> - * with the device lock held in the core, so be careful.
>> +/**
>> + * enum bus_notifier_event - Bus Notifier events that have happened
>> + * @BUS_NOTIFY_ADD_DEVICE: device is added to this bus
>> + * @BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
>> + * @BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
>> + * @BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
>> + * @BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
>> + * @BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
>> + * @BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
>> + * @BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
>> + *
>> + * These are the value passed to a bus notifier when a specific event happens.
>> + *
>> + * Note that bus notifiers are likely to be called with the device lock already
>> + * held by the driver core, so be careful in any notifier callback as to what
>> + * you do with the device structure.
>> + *
>> + * All bus notifiers are called with the target struct device * as an argument.
>>   */
>> -#define BUS_NOTIFY_ADD_DEVICE          0x00000001 /* device added */
>> -#define BUS_NOTIFY_DEL_DEVICE          0x00000002 /* device to be removed */
>> -#define BUS_NOTIFY_REMOVED_DEVICE      0x00000003 /* device removed */
>> -#define BUS_NOTIFY_BIND_DRIVER         0x00000004 /* driver about to be
>> -                                                     bound */
>> -#define BUS_NOTIFY_BOUND_DRIVER                0x00000005 /* driver bound to device */
>> -#define BUS_NOTIFY_UNBIND_DRIVER       0x00000006 /* driver about to be
>> -                                                     unbound */
>> -#define BUS_NOTIFY_UNBOUND_DRIVER      0x00000007 /* driver is unbound
>> -                                                     from the device */
>> -#define BUS_NOTIFY_DRIVER_NOT_BOUND    0x00000008 /* driver fails to be bound */
>> +enum bus_notifier_event {
>> +       BUS_NOTIFY_ADD_DEVICE,
>> +       BUS_NOTIFY_DEL_DEVICE,
>> +       BUS_NOTIFY_REMOVED_DEVICE,
>> +       BUS_NOTIFY_BIND_DRIVER,
>> +       BUS_NOTIFY_BOUND_DRIVER,
>> +       BUS_NOTIFY_UNBIND_DRIVER,
>> +       BUS_NOTIFY_UNBOUND_DRIVER,
>> +       BUS_NOTIFY_DRIVER_NOT_BOUND,
>> +};
>>
>>  extern struct kset *bus_get_kset(struct bus_type *bus);
>>
>> --
>> 2.39.0
>>

-- 
~Randy
