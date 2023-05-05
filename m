Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229B36F8513
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjEEOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjEEOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:50:45 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EBC17DE1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:50:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683298241; x=1683305441; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=EK1JydfP+yDGRYuOn6HFDzhJ0o/Eh62PlPzIuRHXoLQ=;
 b=PbMDolKVXgUqRXif2rABTxGo3KYghGDttEzbjFIBqyqoO8b6+8YqO29s/DEELWrjA9m+zGPI9lrhmC3kppjlFJCtMQah454H/V9WClcOgKQpyylyrZQfEl2PrtnxnRQGTXwIllgcakDlTdKplpu5/1pYxPpUaaEZMVo6KOZR5QvgwiI9V3AKc2aIsPU8bVkJTRlItZCoeQM8aAPDdr5Q6+9nLmxhqBYpKbx8/WLfafBbgPqowUvTFnoJ4QBrywPXfhCjooZXECcafGQdM+QQgsWa/iSJrY9DoKDe1Wn06+nXj2cPk/Fwe2h9ONAz+aS56u4zEe1xLQG0P5qWhk4V1g==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 43f335790acc with SMTP id
 645517c1dd415858cb8b0911 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 May 2023 14:50:41 GMT
Sender: james@equiv.tech
Date:   Fri, 5 May 2023 07:50:40 -0700
From:   James Seo <james@equiv.tech>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 06/11] Documentation/hwmon: Revise patch submission
 checklist
Message-ID: <ZFUXwOlQ73lJDHFr@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-7-james@equiv.tech>
 <ZFSHa2ThLorH5fwI@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFSHa2ThLorH5fwI@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:34:51AM +0700, Bagas Sanjaya wrote:
> On Thu, May 04, 2023 at 12:57:47AM -0700, James Seo wrote:
>> -* Only the following I2C addresses shall be probed: 0x18-0x1f, 0x28-0x2f,
>> -  0x48-0x4f, 0x58, 0x5c, 0x73 and 0x77. Probing other addresses is strongly
>> -  discouraged as it is known to cause trouble with other (non-hwmon) I2C
>> -  chips. If your chip lives at an address which can't be probed then the
>> -  device will have to be instantiated explicitly (which is always better
>> -  anyway.)
>> +* Only the following I2C addresses shall be probed: ``0x18``-``0x1f``,
>> +  ``0x28``-``0x2f``, ``0x48``-``0x4f``, ``0x58``, ``0x5c``, ``0x73``,
>> +  and ``0x77``. Probing other addresses is strongly discouraged, as it is
>> +  known to cause trouble with other (non-``hwmon``) I2C chips. If your chip
>> +  lives at an address which can't be probed, then the device will have to be
>> +  instantiated explicitly (which is always better anyway).
> 
> IMO hwmon here refers to the subsystem (not code identifier name), so
> inlining here isn't needed.
> 
>>  * Make sure there are no race conditions in the probe function. Specifically,
>>    completely initialize your chip and your driver first, then register with
>> -  the hwmon subsystem.
>> +  the ``hwmon`` subsystem.
> 
> Also here.
> 
>>  
>> -* Use devm_hwmon_device_register_with_info() or, if your driver needs a remove
>> -  function, hwmon_device_register_with_info() to register your driver with the
>> -  hwmon subsystem. Try using devm_add_action() instead of a remove function if
>> -  possible. Do not use any of the deprecated registration functions.
>> +* Use
>> +  :ref:`devm_hwmon_device_register_with_info() <devm_hwmon_device_register_with_info>`
>> +  or, if your driver needs a remove function,
>> +  :ref:`hwmon_device_register_with_info() <hwmon_device_register_with_info>` to
>> +  register your driver with the ``hwmon`` subsystem. Try using devm_add_action()
>> +  instead of a remove function if possible. Do not use any of the deprecated
>> +  registration functions.
> 
> And here.
> 
>> -* Do not provide support for deprecated sysfs attributes.
>> +* Do not provide support for deprecated ``sysfs`` attributes.
> 
> Dunno if sysfs (as subsystem name) also needs to be inlined.
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Good point. I will remove inline references to hwmon and sysfs.

