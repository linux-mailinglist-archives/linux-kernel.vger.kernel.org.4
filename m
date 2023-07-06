Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177A7496CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjGFHvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGFHvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:51:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89C1BD2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:51:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b318c5cfso2097425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688629863; x=1691221863;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhmbPLkoVnQhuhvNhVkHDTHyTpdp4PNjj/xlZtzICCA=;
        b=pZJlJ0lhz4RO8QoDrWADXtr8A5uaqPG0cwNebZMTSJRHlc338zrRGHFo3MIorFa2tQ
         oq6MlKfAlG8KZ60E/115YlDf0YYqa4FJzW+ggBF+IfVqyzKcsWvhIlOtly2TXdIAtZIC
         kQJ1mkIGoR3h9cWBkekYbDH7W1yTJaNw4IgML0FxAYY5e+Sw5eu+aMhdo/Ihcj/IhGkL
         c5t+jlYZ2/9vc3tgLabzRqijUCaQebkqOnX1LXdznIo7jHagMovL4z991lH/lpNQ3sYZ
         gkx7jmNwWPYxk5o9hpenRu5awvq/1Ifiy+KXJm5Q/c8apaSwVDVCHTajkHdmZ8HPJOpA
         06jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629863; x=1691221863;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhmbPLkoVnQhuhvNhVkHDTHyTpdp4PNjj/xlZtzICCA=;
        b=W7A6WiPkfclu6aUUzuZl7HA08XkvTbPiH5nopFd/UBGs5r/ZksokHjOEVFMM6Bt4SU
         CMiHJ4ascuaaNLdkJ2n7XiSMlchlew1CvJ+hOiKD5RJFMjup4SKbegM02oVTMYE8MK/E
         auBSLJXkz06Q7s/DuyTst0TEY1/POC/2T3wUiAFKFu/ZB5NWmnna899GkZpjAoYUUOVt
         kyWA0xbZauUWX5gfpxU10jA72w+BDh60ti1DT2LlJpPb9LwqYf1qM9KaFSvo0gFMucoG
         y0N3jpaaCGVQ/jXPTyD+b1GGXhAIZQjVnOhf3BvOy885DZJbIY/gSmCqZCUoQSu9bygb
         CdKQ==
X-Gm-Message-State: ABy/qLbrsIwUIt7a0Po7fTbGpL2u7rrhlBvCDWX1BVEJVzZdlGRuuuBE
        DvqVnUoaIb+YTQ+mB3e+0Ui08FB946hfqw==
X-Google-Smtp-Source: APBJJlHczXf/MN0VAPTai+IfIcf2/+/D8hnfRWRFIWPZptyNQl2VwFGl9sZr3ln/+QTcnNrzEnEylg==
X-Received: by 2002:a17:902:f7d3:b0:1b8:b73d:a75b with SMTP id h19-20020a170902f7d300b001b8b73da75bmr1127393plw.44.1688629863140;
        Thu, 06 Jul 2023 00:51:03 -0700 (PDT)
Received: from localhost-live.default (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with ESMTPSA id g5-20020a1709026b4500b001b027221393sm750161plt.43.2023.07.06.00.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:51:02 -0700 (PDT)
Subject: Re: [PATCH] arch/powerpc: Remove unnecessary endian conversion code
 in XICS
To:     Gautam Menghani <gautam@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230630055628.17790-1-gautam@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Message-ID: <39920b0f-f261-8417-af7a-eef791ad5726@gmail.com>
Date:   Thu, 6 Jul 2023 17:50:57 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230630055628.17790-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/6/23 3:56 pm, Gautam Menghani wrote:
> Remove an unnecessary piece of code that does an endianness conversion but
> does not use the result. The following warning was reported by Clang's
> static analyzer:
> 
> arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
> 'server' is never read [deadcode.DeadStores]
>          server = be16_to_cpu(oserver);
> 
> As the result of endianness conversion is never used, delete the line
> and fix the warning.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

'server' was used as a parameter to opal_get_xive() in commit 
5c7c1e9444d8 ("powerpc/powernv: Add OPAL ICS backend") when it was 
introduced. 'server' was also used in an error message for the call to 
opal_get_xive().

'server' was always later set by a call to ics_opal_mangle_server() 
before being used.

Commit bf8e0f891a32 ("powerpc/powernv: Fix endian issues in OPAL ICS 
backend") used a new variable 'oserver' as the parameter to 
opal_get_xive() instead of 'server' for endian correctness. It also 
removed 'server' from the error message for the call to opal_get_xive().

It was commit bf8e0f891a32 that added the unnecessary conversion and 
never used the result.

Reviewed-by: Jordan Niethe <jniethe5@gmail.com>


> ---
>   arch/powerpc/sysdev/xics/ics-opal.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
> index 6cfbb4fac7fb..5fe73dabab79 100644
> --- a/arch/powerpc/sysdev/xics/ics-opal.c
> +++ b/arch/powerpc/sysdev/xics/ics-opal.c
> @@ -111,7 +111,6 @@ static int ics_opal_set_affinity(struct irq_data *d,
>   		       __func__, d->irq, hw_irq, rc);
>   		return -1;
>   	}
> -	server = be16_to_cpu(oserver);
>   
>   	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
>   	if (wanted_server < 0) {
> 
