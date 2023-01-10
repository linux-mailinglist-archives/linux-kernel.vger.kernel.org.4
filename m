Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2966394C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAJGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjAJGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:24:14 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99148CF2;
        Mon,  9 Jan 2023 22:23:54 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j9so8013968qvt.0;
        Mon, 09 Jan 2023 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOHmc5BykUazHoHlreQeulyX97j1UysbgSi5gj3vkIg=;
        b=qiALoAo04rGufanVuIq1+4mX3Vh3H686aE9nIPn7bgI293FeIxIjBRVm1O+Bl7rDjy
         EGg2JH31lRx15cPt61S2uXCIuswTWu2aekx0VrUguW/94c5KmX1/LwlaerlObo95mX2q
         EHVnDWQ8iBgB7YqGTd1J+key290tdu3C8paivWNihfOyY9eVyED4rZfJhvlWtJpdKhZ3
         JUv+6WlodE08SdN26/OpQY4XqmXTmJ9rkrCvJdHTLSDasPTTk8xX3R3gi2tcvdlrA8f4
         a5V96Mr6Q1uNkRJWQauzoJmrouN1CbTDOuwjcfDVpHD5tMffUo/0QGAOfybzkekZhg2Z
         tcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOHmc5BykUazHoHlreQeulyX97j1UysbgSi5gj3vkIg=;
        b=uKlPusBaGmu+wy07CjAS9+Xf2qrVyg3ehvGqC1+ZpWuxmiCH/eiL5HMGgNEVGclNSb
         qUwTCioLuxNRIDO0Occgy1MP2chvBMZw6uMji2RMCBma1XeJczG9882vk4XUSTrz+d3l
         ltjNzyZzzxbjE0XFdEsQ8jr9skRJVBK8/k2pzhGv0v1sotdo+Q4mamjJW07UDpmY2udX
         uuYRraC77b8fWKYfH0GqwhbLeiJPc7FMl/P+RgMXQSdwvY+unAqr5F29MwD7DqMiaz2V
         8y376T4g64ySfZZ2MnASF4Ohkgdtvk9ItrNGQNB/TDZ8c1lPG3P3UuiHMWVDIM90QVCU
         z5Lw==
X-Gm-Message-State: AFqh2krMxUCs0xokQ3WCmHs/9P4ahmGW/pXpQx1OG382jFVTu4AfKvbZ
        V7X8qIMbQysAI31dOdcCEro=
X-Google-Smtp-Source: AMrXdXvOoSwGkkQ+ub1eZIfrX0Gop55V7Y+cDK8qQnzCsKuQXdQdm7qeBfBuZbhcJ/AgKWzOTa3VNQ==
X-Received: by 2002:a0c:f10b:0:b0:532:2b59:95c with SMTP id i11-20020a0cf10b000000b005322b59095cmr14192765qvl.32.1673331833819;
        Mon, 09 Jan 2023 22:23:53 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:cc93:35ee:990:f219? ([2600:1700:2442:6db0:cc93:35ee:990:f219])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm6667599qkb.116.2023.01.09.22.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 22:23:53 -0800 (PST)
Message-ID: <2ec3f5dc-b974-e799-2b96-d7b09dee4df1@gmail.com>
Date:   Tue, 10 Jan 2023 00:23:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] of: overlay: fix warning being reported as error in
 add_changeset_property
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     "Ankit 16. Kumar (Nokia)" <ankit.16.kumar@nokia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1671195782-23078-1-git-send-email-ankit.16.kumar@nokia.com>
 <VI1PR0701MB68298749C8133A7D69CFDBBFC9F09@VI1PR0701MB6829.eurprd07.prod.outlook.com>
 <a7e15b62-8929-b76e-77d7-42d78aaa02e1@gmail.com>
In-Reply-To: <a7e15b62-8929-b76e-77d7-42d78aaa02e1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 08:35, Frank Rowand wrote:
> On 12/30/22 02:40, Ankit 16. Kumar (Nokia) wrote:
>>
>> The print causes false reporting of the issue which actually is a warning
> 
> How did you select the commit in this Fixes tag?
> 
>> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
>>
>> Signed-off-by: Ankit Kumar <ankit.16.kumar@nokia.com>
>> ---
>>  drivers/of/overlay.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c index ed4e6c144a68..0da39b8461e7 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>  	}
>>  
>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>> +		pr_warn("WARNING: memory leak will occur if overlay removed, 
>> +property: %pOF/%s\n",
>>  		       target->np, new_prop->name);
>>  
>>  	if (ret) {
>> --
>> 2.30.1
>>
> 
> NACK.  This patch is incorrect.  The reported memory leak is a bug, not a warning.
> 
> I'll write up some information about why the memory leak occurs, then reply to this
> email with the additional info.

The additional information is now available at:

   https://elinux.org/Device_Tree_Linux#Object_Lifetime

> 
> -Frank

