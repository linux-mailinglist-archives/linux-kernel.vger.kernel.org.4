Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310C694BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBMPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:50:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CC1A48B;
        Mon, 13 Feb 2023 07:50:10 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D7ovr2025285;
        Mon, 13 Feb 2023 09:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=jldZvw4zVpJhniiaCbllaoUgG3G1o0l8gk91WplKNgc=;
 b=ITRSGIljzssxgRStLpn+P8I54mVZMMsNjIhbiORF6J1viaFbckKxHCtAQuqFRUf5VI5I
 A02oXrwmKuboY0j+eNbrdXfPc+isEzXpcZLq2dzSH0sZ4Vwfk++GF1T/Eh/jeGamEItp
 uj2U72d8XPCioKVDYCy4AvfR6grXnGJQqKlsade3UQ5et5q9QxI19k/yWCmNI6nG6pR7
 8A1Vr8kxathNp3CR6iOLkN6MvrkkYandLto6f8SoSb5/3wdAmlItewFQ6dTJrIPMhGob
 i8TLncXOhhVA09vgUU+uipVl19BEvnF4mmXxQnysjS9RG2kczVzmhpXiBbPq7E+L6UiB 4A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3np8atte77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 09:50:03 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 09:50:01 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 13 Feb 2023 09:50:01 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 781C2B0E;
        Mon, 13 Feb 2023 15:50:01 +0000 (UTC)
Message-ID: <1294e968-d03e-ee4a-e1c1-d9293b813c63@opensource.cirrus.com>
Date:   Mon, 13 Feb 2023 15:50:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] PM: Add EXPORT macros for exporting PM functions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230213132048.2612961-1-rf@opensource.cirrus.com>
 <CAJZ5v0hE7u_rTEn1KRFhE55Y3MHS_Le4rAbFPmR+0r+Eg=3K9Q@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAJZ5v0hE7u_rTEn1KRFhE55Y3MHS_Le4rAbFPmR+0r+Eg=3K9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -5AXWlKoT9TAhEBEdIGSwZcxod39M5lB
X-Proofpoint-ORIG-GUID: -5AXWlKoT9TAhEBEdIGSwZcxod39M5lB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 15:43, Rafael J. Wysocki wrote:
> On Mon, Feb 13, 2023 at 2:20 PM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Add a set of macros for exporting functions only if CONFIG_PM
>> is enabled.
>>
>> The naming follows the style of the standard EXPORT_SYMBOL_*()
>> macros that they replace.
>>
>> Sometimes a module wants to export PM functions directly to other
>> drivers, not a complete struct dev_pm_ops. A typical example is
>> where a core library exports the generic (shared) implementation
>> and calling code wraps one or more of these in custom code.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   include/linux/pm.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index 93cd34f00822..21618f7087f8 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -379,9 +379,17 @@ const struct dev_pm_ops name = { \
>>          const struct dev_pm_ops name;                                   \
>>          __EXPORT_SYMBOL(name, sec, ns);                                 \
>>          const struct dev_pm_ops name
>> +#define EXPORT_PM_FN(name)             EXPORT_SYMBOL(name)
>> +#define EXPORT_PM_FN_GPL(name)         EXPORT_SYMBOL_GPL(name)
>> +#define EXPORT_PM_FN_NS(name, ns)      EXPORT_SYMBOL_NS(name, ns)
>> +#define EXPORT_PM_FN_NS_GPL(name, ns)  EXPORT_SYMBOL_NS_GPL(name, ns)
> 
> Why are the non-GPL variants needed?
>

I did all four because there are all four variants of EXPORT_DEV_PM_OPS.
Why are the non-GPL variants of EXPORT_DEV_PM_OPS needed?

I can remove the non-GPL variants of my macros.

>>   #else
>>   #define _EXPORT_DEV_PM_OPS(name, sec, ns)                              \
>>          static __maybe_unused const struct dev_pm_ops __static_##name
>> +#define EXPORT_PM_FN(name)
>> +#define EXPORT_PM_FN_GPL(name)
>> +#define EXPORT_PM_FN_NS(name, ns)
>> +#define EXPORT_PM_FN_NS_GPL(name, ns)
>>   #endif
>>
>>   #define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
>> --
>> 2.30.2
>>
