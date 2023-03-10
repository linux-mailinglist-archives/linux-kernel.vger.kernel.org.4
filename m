Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF36B50EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCJTaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCJT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:29:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE227E8A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:29:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az36so4158587wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678476596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PScVdSvo964dji84f+E3c8q8Z3D10XU3FUFbEIQL5M=;
        b=I1tFubY34VdYvbiaMV6bMVJtb+FgxjqTDUFjZcWqCVsSj6b7usEequMVu12dLvOGi3
         842MaXs0TRyMTB03cbqbQqYHypR7Pt8S9dsCRZUrPNlql7C2J/PmeaOdMcHAt/QjFdOn
         xUX62FvPezXjz1KRUFDHBmeHDN7JUwgkUrtdeiDuOww/imSHUDouML+u/39dwvLRjUaQ
         eM589F4AuS/j6Ayycg0cF5umIoKDtKw4oh7CSGug0rCp7Zx+TKhl9kuMXrs2ZjGSpjaJ
         h4ueWtA4SPeDsmpZWl7x6kHldrCC3pLKFRpOmcqTtiPIWQMzLvdw0tdjJUGjNFbO3L21
         Ohew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678476596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PScVdSvo964dji84f+E3c8q8Z3D10XU3FUFbEIQL5M=;
        b=B2o2CccEJsrQa6aEt8IZMWdaYvrRWTPhNOjJwuuL7Kl/uW+d5RHSQfwNxJlMh6UI2j
         dfAnJ4VRRWOn9umUilKmAZQ/FT2KzUSlnCeAc4H/OPNQ8U8enHiqzlm8kh5Svq8lsGLT
         maKuTDzn9FKhSHiYzoX12B7gT9DY7/HZ2gbFwOkm/xzZFDr+ZPGCTGaonokvuRDKqxeD
         az/Jzft+Pm/SysunwywXtZiHx7tTSH/nhb8b8LcMxsEXw2fx4jRCnQHpBIzHdLSKJs/x
         bzOWr5Nt2eB/Yb34lv180ICXyTrs6lak+jr2q6jb8CqxdLdznXwacvLttYtZ1biW/izj
         yFDw==
X-Gm-Message-State: AO0yUKURaa31umWab0SPh6Mtcw6h9KDpHIC2xXXc7g1+yh/jHv8RfeN/
        cVTnq7kp2DY0JUtQ0rByuuS/HDhyiO3zgQ==
X-Google-Smtp-Source: AK7set9lLW35D4gGhOdmpXTFKA7pzUwguhXMnfH7b43QBIQVJlKKSGJNmPbghHrpx/fEUfucx5G4Zw==
X-Received: by 2002:a05:600c:1c1f:b0:3eb:2b88:8682 with SMTP id j31-20020a05600c1c1f00b003eb2b888682mr3988918wms.17.1678476596185;
        Fri, 10 Mar 2023 11:29:56 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003dc4480df80sm820581wmq.34.2023.03.10.11.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 11:29:55 -0800 (PST)
Message-ID: <9cb2b3c4-f047-3028-885b-6554c7600e3d@gmail.com>
Date:   Fri, 10 Mar 2023 21:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
To:     Alex Elder <elder@ieee.org>, outreachy@lists.linux.dev
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <6ed4616d-03e7-f055-cd25-934e69d253df@ieee.org>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <6ed4616d-03e7-f055-cd25-934e69d253df@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٠‏/٣‏/٢٠٢٣ ١٨:١٦, Alex Elder wrote:
> On 3/10/23 9:51 AM, Menna Mahmoud wrote:
>> Fix " CHECK: Alignment should match open parenthesis "
>> Reported by checkpath
>>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>
> Is this (and your second patch) the only place(s) where
> this issue gets reported?

> yes, after fixed them i got 0 check.

> I think this type of alignment is not a major problem,
> and alignment isn't done this way in general in this
> driver, it's probably OK to keep it that way.

Okay, thanks.

  -Menna

>
>                     -Alex
>
>> ---
>>   drivers/staging/greybus/fw-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/fw-core.c 
>> b/drivers/staging/greybus/fw-core.c
>> index 57bebf24636b..f562cb12d5ad 100644
>> --- a/drivers/staging/greybus/fw-core.c
>> +++ b/drivers/staging/greybus/fw-core.c
>> @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
>>               }
>>                 connection = gb_connection_create(bundle, cport_id,
>> -                        gb_fw_mgmt_request_handler);
>> +                              gb_fw_mgmt_request_handler);
>>               if (IS_ERR(connection)) {
>>                   ret = PTR_ERR(connection);
>>                   dev_err(&bundle->dev,
>
