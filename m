Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1E6F84FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjEEOkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjEEOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:40:16 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBED18912
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:39:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683297596; x=1683304796; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=1zV5HkaO4AcJ2oJf1urH6etlYKt5oTziBWscnFyDS8k=;
 b=n+LvbNTlTR2M84lzJEseOk1nD6juue+aeZkwijoJpEL9FbziPK70KE89+n3EyvMdrBdZnBBidJg+IXfcU5u7YW7nDGOWGVpqNuHzP0Vb8QOCp6sndu2sklYhImQTMf64nfUp3ehcVEO+oJKM+mHJ9IJWkSf4ewjwhzecAp0Aw+8PiQPOPpWnhHNhjy7XJMXyR86hhvcX8EOeMCQR5LW0PPYL4LHihipJMFqIon0mKhaI3xZlUVjL4Qr5vovp5Pr67rjIEtOIl/uKlmFEnMgju4EPwjrxnFnGjJNCE1oxq02G68us8SB5NWj26EEnWHTQKNXwgiMtSUmZ0RcBbranbQ==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by f5ac2268c446 with SMTP id
 6455153cf77227a8301b0176 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 May 2023 14:39:56 GMT
Sender: james@equiv.tech
Date:   Fri, 5 May 2023 07:39:55 -0700
From:   James Seo <james@equiv.tech>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/11] hwmon: (core) Rename last parameter of
 devm_hwmon_register_with_info()
Message-ID: <ZFUVO4ECF0Xlcmx8@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-3-james@equiv.tech>
 <ff6efe53-2173-1372-a1ca-c0928cf8a160@roeck-us.net>
 <ZFUBZyG5eoz2TpZX@equiv.tech>
 <ec28c2c2-4623-0d92-00bc-b8cd53c965b2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec28c2c2-4623-0d92-00bc-b8cd53c965b2@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 06:30:53AM -0700, Guenter Roeck wrote:
> On 5/5/23 06:15, James Seo wrote:
>> On Thu, May 04, 2023 at 08:29:57AM -0700, Guenter Roeck wrote:
>> 
>> Hello,
>> 
>> Of course arbitrarily changing variable names is pointless. But this
>> patch fulfills the intent of 848ba0a2f20dc121a3ef5272a24641d2bd963d8b,
>> which makes this change for devm_hwmon_device_register_with_info() in
>> hwmon-kernel-api.txt and in hwmon.h - but not in hwmon.c. The same
>> commit makes the same change for hwmon_device_register_with_info() in
>> all three files, so it obviously should have been in tree already.
>> 
>> The other reason for this patch is that for the purpose of generating
>> function documentation from kerneldocs, it is not feasible to call
>> this parameter "extra_groups" in the kerneldoc and still call it
>> "groups" in the function itself. Doing so results in the lines
>> "const struct attribute_group **groups / undescribed" and no mention
>> of "extra_groups" in the generated document. Leaving things as is, so
>> that [devm_]hwmon_device_register_with_info() have different names
>> for this parameter, is potentially confusing and more noticeable to
>> to the eye than I would like once rendered.
>> 
>> Is this good enough to proceed? And as a subsystem maintainer, is
>> there anything else, specifically or in general, that you would like
> 
> Marginally. That should have been explained in more detail in the
> description.

OK, I will add more detail.

> 
>> to see addressed?
>> 
> 
> I don't know. There are changes which seem to be more based on POV
> than real improvement (such as the removal of the credit from the
> PMBus document). I'll have to verify each and every reference to determine
> if the change is appropriate. Also, the changes are substantial.

Yes, sorry. At some point comparing a local make htmldocs build to
docs.kernel.org became much easier to follow than slogging through
diffs, and some of the markup only makes sense once rendered next to
the automatic cross-references that Sphinx adds.

> It will take a lot of time for me to review, and right now I do not have
> that time. I have a hard time keeping up with code reviews.
> 
> Guenter
> 

No rush. Your time is always appreciated. As I have gathered some
feedback from Bagas, I will submit the smaller changes as a PATCH
series in a day or two and an updated RFC series that you can
tackle at your leisure.

James
