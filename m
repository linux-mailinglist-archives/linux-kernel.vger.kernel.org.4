Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B1C6DB8A7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDHDvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHDvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:51:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC2CC13
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:51:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ke16so375280plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680925900; x=1683517900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVWRi4WEP0KmS9Oko1fKAiiw0MxTetFtW06tzPcF84Y=;
        b=KrrVCE337PT1BeXBx7sP0vBjmPBH4f50ZrbXtOlcApXBf0F+XLLxZrWojdV7Kpqw8Q
         LkNEScwmJ/M9uDWY8u7hvY7AsoQD/osdM1uTSAjrVsLSUnrvr9jJSbmGoy0y6OM5FlYT
         ugooVAGHgUtvBdCH7smyysqF3aS9QETWtKYLZ62YpFOWi6G7MxJ2CdrUvs8XwC1JKuWc
         umtxC/Y48S9I5K1QJi1XE5CP43e3dFWpm0aL6IlfCTqxW1+k5QQaGhhUV7ocaBt1ZWXr
         QQfux6/+rtAAIWqTaicaf9B/z9ZN0r4eL5AZet4HMEHcsXok4z9gkrDRZJDhsHEiPRho
         t9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680925900; x=1683517900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVWRi4WEP0KmS9Oko1fKAiiw0MxTetFtW06tzPcF84Y=;
        b=GBcjMUnzSLNHkGvt2T71xuqWONXcQDeWF/tr2w2Gpm8TpIWgKhgFvw1fmge8EAvfJs
         FqbZbOSXFGI/DBGYzxqTvkTRFnxfLIKlpJqiRIrVmzBRHxQ/5bZvco6o1W/J3GSZtXy0
         cBW8XH7OvQ1AYTHpxRP1nh+THN+i+T5Tayi0T7sgAkZZc3pLgbxbaXpCXdjx5qYCBMte
         kvpgQ6UFXsos47s+ODjB4m/ZbAdmOv433uRpxdSbqdRhITZ6lc3dfER6vH9aJQGwqKBE
         M7YM9eiIMRXZUdLDalyMZiZHazsNYqNWOLMEMPeqZ2oaNvR9M+jKqorYnUp4csDEC+lr
         N9Qw==
X-Gm-Message-State: AAQBX9cpkYrHMPIiYip813kgHTfUuMCeLeJ+wSy/8u+s52J/wYxJxtPf
        qPvOfgMO2Gwxf4SsimOyyt7ED0UKSqVr0w==
X-Google-Smtp-Source: AKy350ZHLNM3lJtl/rP+YnGeRrblBoYUTKQfADT/Q+MUFx2kdXmp+KfQPEkQ41ndQ93TmRTbM+VMAg==
X-Received: by 2002:a17:902:e892:b0:1a5:16fb:628b with SMTP id w18-20020a170902e89200b001a516fb628bmr4268069plg.24.1680925899795;
        Fri, 07 Apr 2023 20:51:39 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:edd1:65a9:3c34:5a28? ([2600:8802:b00:4a48:edd1:65a9:3c34:5a28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902728200b001a1a07d04e6sm3627808pll.77.2023.04.07.20.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 20:51:38 -0700 (PDT)
Message-ID: <1f2af136-5517-0fa3-fba7-1a952affa7bb@gmail.com>
Date:   Fri, 7 Apr 2023 20:51:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RESEND 0/3] scripts/gdb: timerlist fixes
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Peng Liu <liupeng17@lenovo.com>
References: <20230406221217.1585486-1-f.fainelli@gmail.com>
 <20230406161818.6626e128cf1a2e8483bb6572@linux-foundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230406161818.6626e128cf1a2e8483bb6572@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2023 4:18 PM, Andrew Morton wrote:
> On Thu,  6 Apr 2023 15:12:14 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> Since you have been collecting my patches touching scripts/gdb,
>> (re)sending those fixes from Amjad that restore a functional
>> "lx-timerlist" scripts.
> 
> The first two issues appear to have already been fixed:
> 
> https://lore.kernel.org/all/TYCP286MB21463BD277330B26DDC18903C6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM/T/#u
> https://lore.kernel.org/all/TYCP286MB2146EE1180A4D5176CBA8AB2C6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM/T/#u
> https://lore.kernel.org/all/TYCP286MB214640FF0E7F04AC3926A39EC6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM/T/#u

Oh yes, indeed there was a prior submission by Peng.

> 
> Thanks, I'll queue up the third patch.
> 
> (And I'm going to have to redo the above three patches and rebase,
> because I now see hotmail's Message-ID's fooled my Link: extraction
> script, grr)
> 
> 
> While I'm there, I'm wondering if the xrange patch should be backported
> to -stable kernels.  We want gdb to work well with Python3 on older
> kernels, yes?

I would say so, yes.

> 
> 
> Also, I added your Signed-off-by: to "scripts/gdb: timerlist: convert
> int chunks to str", since you were on the patch delivery path.
> 

Thanks!
-- 
Florian
