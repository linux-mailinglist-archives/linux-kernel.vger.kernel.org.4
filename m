Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE8617FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiKCOth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiKCOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:49:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AED17E3A;
        Thu,  3 Nov 2022 07:49:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1355533wmg.2;
        Thu, 03 Nov 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6XPo/k7heVDESQZpImoWUJDkxoQwwB8JDz0aFByags=;
        b=Us9V1/BdKTxxamujzNwkkFGRkUmW6S1w1PpIaEgvlqlZvhm9uvWU3US37rCNWldORI
         l/BL5me6PT+Zn6EUX4Y6SMU3U6hDoFbY5HdEVhpmZcCpKpk/AjLYvrqatab4OAsgdL6s
         Kf8m8Sy+DOKs6z+Jq3u6NWEeH2yM9kp1tTH7jYrtMdzn8/AiAgNANShrUJ7dc+oDJG5k
         sIYOlITsaZ3DBNyrXCXIHx9fw5+ZKoaNMGiC0PcJKNdcUhoiJTZCgr8VGvyRhDqdgsdr
         sJe4t4BKzXjVlV9iqlUrZDYdP6BxGUrgId6aFrS16HMSYQu4dQ5B7JwJMVFpYc1qxZ3D
         3DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6XPo/k7heVDESQZpImoWUJDkxoQwwB8JDz0aFByags=;
        b=KyY/yotgwyYA0xDzmUpNuqTSpdH76W80fnBENiMdeR7Q8J9quhvJsR11uu1ssX1UnS
         Z4jOMp+YDxTNp8djOtTIO+CrpsDivR5eBrD+1cXIL2jqCl2CkWHr4A2IZkS3tG/Wb7Kr
         k3tvNpqZSuT9xrdfu38SvgRzHMiN1WnBwz6FeUB3oFJUMNOV0hYnruVVweCE96q25/qV
         IwdPAxSCEhzAmSn1/YLuD/PJNO8tcz6CiIub5iihYptPOGAJvuSOQ2wTyJ7fLnIJwGnN
         vELNVNZSReazFyyRvkrOdxTWIAKW6ESWpiVrq9u2Z97H0qcET20j1wBpKaX9ma5w09/j
         tEgg==
X-Gm-Message-State: ACrzQf3g/x7/Cy3qhQRtoByKcD/7r0tw3gYANNASCtvZwDuKWKYJehzg
        pY5Vd0YUbNbP3pwwU+OHOOk=
X-Google-Smtp-Source: AMsMyM49js37BJfeTe2EkgqiIxd21xul39YrnWt496H015GdItEKOZqrMj4nHElwuJCkReajdwTYVg==
X-Received: by 2002:a05:600c:4f05:b0:3cf:4818:1704 with SMTP id l5-20020a05600c4f0500b003cf48181704mr19781528wmq.181.1667486972492;
        Thu, 03 Nov 2022 07:49:32 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id k4-20020a05600c168400b003c6f1732f65sm8044wmn.38.2022.11.03.07.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:49:32 -0700 (PDT)
Message-ID: <ef637642-7d0f-66b8-2225-b6f8609f037e@gmail.com>
Date:   Thu, 3 Nov 2022 14:49:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] cpufreq: SPEAr: Make read-only array sys_clk_src static
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103143654.85275-1-colin.i.king@gmail.com>
 <20221103143807.tamhepos3cureoga@vireshk-i7>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20221103143807.tamhepos3cureoga@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 03/11/2022 14:38, Viresh Kumar wrote:
> On 03-11-22, 14:36, Colin Ian King wrote:
>> Don't populate the read-only array sys_clk_src on the stack but instead
>> make it static and add in a missing const. Also makes the object code a
>> little smaller.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/cpufreq/spear-cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
>> index 7d0d62a06bf3..c6fdf019dbde 100644
>> --- a/drivers/cpufreq/spear-cpufreq.c
>> +++ b/drivers/cpufreq/spear-cpufreq.c
>> @@ -39,7 +39,7 @@ static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
>>   	 * In SPEAr1340, cpu clk's parent sys clk can take input from
>>   	 * following sources
>>   	 */
>> -	const char *sys_clk_src[] = {
>> +	static const char * const sys_clk_src[] = {
>>   		"sys_syn_clk",
>>   		"pll1_clk",
>>   		"pll2_clk",
> 
> Same questions from longhaul patch apply here too.
> 
See answer in that patch :-)

But really, this is kind of basic C level stuff. I suggest reading K&R 
2nd Edition, Section 4.6, last paragraph before exercise 4-11.
