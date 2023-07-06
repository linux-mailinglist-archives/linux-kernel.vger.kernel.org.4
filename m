Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F1749E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGFOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjGFOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:05:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFC1FC3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:05:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7dfb95761so794375ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688652310; x=1691244310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxQkqfWZadf4e7ZXMTgD092G9UqtDRhpq1Uw7mcccPU=;
        b=JTE3J7vEtroDjkz0J0YJUxxGfAHynnIxKHpjaVXx2tz3n+EjmGpoAwgKy8R+WRRkM+
         k3W+5qv1YTlCAP+UcB2ArjJE4oYq6lo4PdCKDpis97xigZlEhYbsl+wADl7kiov7SE51
         uONKqWk8WLeXviTouiOV8nPGg5p/8qhWtLX046dcmjqBGTa6bBPYqpMrhXHOaC+32/p8
         vU0q6jpv+a6clYR3MEHTLQ7PXHDaJFRHD1ZYPHlxTSJa6vWz+O7pF8b7OC9ajvVwCXaF
         iwVe+Bs3u0D8yOOXmHfA3jACZKS7DrFRjzqe3YrsDUc4cQI7/xPvHL9x1/ZiwFcsFVh/
         96pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652310; x=1691244310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxQkqfWZadf4e7ZXMTgD092G9UqtDRhpq1Uw7mcccPU=;
        b=Vl/CQ9RNwW8cmTErna713gv7PbJ289pyTpnAMi57d1tXIsekTjOr/0w98eIL5L7iti
         1G+JZ4lZdgXdTQyOnjR2i9fw/tJ2gdHaAs2Bl/uarcKFiRvpNAmJLuatmyoGv4maQNrp
         EClaUDc69DOHhEOqMSWJT4HWYG2hKSGMlhgWlZ3Irwfs7N5C7LgBTlcoPiPOfQfyKcnA
         5I9polZEyI6cH7eBFT9nAhVWuu38Kh8MlzTReLJWBLobFZIzJST5iyNJvPrsoH90Q2Mv
         RyXfMqZMn1Fqb7ehVRLv10dfBCIpk3YdN6tHkAwxuOz00Q5A8o4c9Kdu24U4NOYG7dsZ
         /NCg==
X-Gm-Message-State: ABy/qLaR7CeYMyUYH3vTVmX8zVbom+3gXNbkH0H9h661gmYYQYF0q8dH
        f8kkaoS6dKWmsZetwXUhrOvxzw==
X-Google-Smtp-Source: APBJJlF0ctEzgA1/zFlM8pxVZNhDqmweSCoYq6B7d7aHZfUBpY1EEJJpP33cMEIK5KwxycIElxNZUg==
X-Received: by 2002:a17:903:41c7:b0:1b8:b55d:4cff with SMTP id u7-20020a17090341c700b001b8b55d4cffmr2486422ple.2.1688652309827;
        Thu, 06 Jul 2023 07:05:09 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902b7c300b001b80d399730sm1468406plz.242.2023.07.06.07.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:05:09 -0700 (PDT)
Message-ID: <c77cf93f-c27e-63aa-c2d4-c494bd9e3bee@kernel.dk>
Date:   Thu, 6 Jul 2023 08:05:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBibG9jazogbXEtZGVhZGxpbmU6IHJl?=
 =?UTF-8?Q?name_sort=5flist_to_sort=5frb?=
Content-Language: en-US
To:     =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230704040626.24899-1-lipeifeng@oppo.com>
 <32dad510-1508-f0dc-ab49-60d56ed2c2d6@acm.org>
 <TYZPR02MB55955F57A8CCC819054338BFC62FA@TYZPR02MB5595.apcprd02.prod.outlook.com>
 <TYZPR02MB55950B363465E43DB0044ACEC62CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <TYZPR02MB55950B363465E43DB0044ACEC62CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 3:27?AM, ???(wink) wrote:
>>>> Mq-deadline would store request in list:fifo_list and 
>>>> rb_tree:sort_list, and sort_list should be renamed to sort_rb which 
>>>> is beneficial for understanding.
> 
>>> Huh? I think this patch makes the code less readable instead of more readable ...
> 
>> Huh? Maybe we had different opinions about it, I thinks the essence of this word is 'sort'
>> So that reader can get the meaning of it easily. And in my mind, *_rb is more reasonable for rb_root ratherthan *_list for reader.
> 
> Hi Sir?
> Should it be merged for the above reason? Hope for your reply, thanks.

No, the patch makes no sense. I agree with Bart that it doesn't make it
any more readable, in fact it's worse. We have a sort and fifo list, the
backing data structure isn't that exciting by itself.

-- 
Jens Axboe

