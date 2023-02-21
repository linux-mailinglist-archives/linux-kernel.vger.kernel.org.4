Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01569DD93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjBUKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjBUKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:09:54 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E320D0D;
        Tue, 21 Feb 2023 02:09:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676974178; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cKXclDJnOR+glU4wDT8iZ04RWKFBwEmZYZoTl1XqtC1SU0ZrfOASGRXqrzJJYSoruUO7Dx7nN2XLda8T225IVwPUmqOzoXCyqzf9gUxwg2zcYoOcBy9Y79PwZmrHXUG8v7vTBGALC+nGonM8nmxWg0DOE6yW051Rq54xsuHVcV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676974178; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=I18HypflR5Yn9dvjeX0N0iWo/tlnOKACxPwne4yaBUk=; 
        b=QtvALihmveuBP14O3zvGme+x2DajcB2562YIkiuYo08lOXAjHg3LSwEwUYc4Rg1M2EDaCN2iCFfu+QjkuudfEpVlfr8ftWzOBH6HC05cOcIUDjmsIsLDEYd//zNUIh/c8tA4k8e1ywBtjPGgZoQq1tklbDSsncis3mPjKe1UK/k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676974178;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=I18HypflR5Yn9dvjeX0N0iWo/tlnOKACxPwne4yaBUk=;
        b=XNqbRyaJSXib7hYHP8k1pXwwtFy0xuduiEUyxbtqsj+YkKJZzIPAS6/yrz/FIKx+
        8KcvMCgNveENxUyYD0BFAJHEDa+9K/VRt6AvH6VCuV/6rFXvlaytULj7bkBnS3t6W4J
        oJpNbKjuxLG5DdmmRkUCJGQ9Uqe+aYAvTeEqmsvY=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676974153569756.4162754277759; Tue, 21 Feb 2023 02:09:13 -0800 (PST)
Message-ID: <85a39e81-51a3-e90f-622e-f2cc7528aa92@arinc9.com>
Date:   Tue, 21 Feb 2023 13:09:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] mips: ralink: make SOC_MT7621 select PINCTRL
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, erkin.bozoglu@xeront.com
References: <20230221092435.22069-1-arinc.unal@arinc9.com>
 <20230221092435.22069-2-arinc.unal@arinc9.com>
 <CAMhs-H9qLw6uhjPnFWovQBMFe38y95Q_VvG8Bj9wovSR+1J_2g@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H9qLw6uhjPnFWovQBMFe38y95Q_VvG8Bj9wovSR+1J_2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2023 12:38, Sergio Paracuellos wrote:
> Hi Arınç,
> 
> On Tue, Feb 21, 2023 at 10:24 AM <arinc9.unal@gmail.com> wrote:
>>
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Currently, out of every Ralink SoC, only the dt-binding of the MT7621 SoC
>> uses pinctrl. Because of this, PINCTRL is not selected at all. Make
>> SOC_MT7621 select PINCTRL.
>>
>> Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handled under
>> the PINCTRL_MT7621 option.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   arch/mips/ralink/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
>> index 06031796c87b..83e61e147b90 100644
>> --- a/arch/mips/ralink/Kconfig
>> +++ b/arch/mips/ralink/Kconfig
>> @@ -54,7 +54,7 @@ choice
>>                  select HAVE_PCI
>>                  select PCI_DRIVERS_GENERIC
>>                  select SOC_BUS
>> -               select PINCTRL_MT7621
>> +               select PINCTRL
>>
>>                  help
>>                    The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc
>> --
>> 2.37.2
>>
> 
> Which git tree are you working against? CONFIG_SOC_MT7621 is not
> selecting PINCTRL_MT7621 at all in v6.2 [0]. I think it should select

mips/linux.git mips-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/

> 'PINCTRL_MT7621' and the 'select PINCTRL' stuff added inside the
> PINCTRL_RALINK option in [1].

I'm working on that, although not exactly the way you describe here, on 
this branch of mine.

https://github.com/arinc9/linux/commits/ralink-pinctrl

Arınç
