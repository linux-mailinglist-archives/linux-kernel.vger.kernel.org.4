Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E96D6B46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjDDSNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjDDSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:12:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8111A1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:12:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so33750756wrh.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680631977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6UvJYb0vhNu7LxirRk26kxVyScSe7FvDHHBR5w4eq8=;
        b=E99kdlr889mPaDlkmAJ09SWhAhJlJQmaXAZlAvya22AveV86wUfXtgLRYPiJ+zL8Nh
         /TIx3GMyE2GrPaDcBdCNItvjGiLPMgb/AD2MytftBiDIc8BNkaxQu5K3f1uGrjTV01tE
         eV0ENuqva2sB+/MaYJXIlo6Urr3p2PeMDpbPeg69tIoy/eZUTC/w9JhlLd7Zm0ofN6lT
         h/LaAAD6BRVtIu9qU7e0OVrT6zSZweeH7DyCo8p3wCq+KcU1rdgRgfMdQeoF6AwovNGZ
         xQGbKHI6WX9GXB9xoC7c65Yxt1KHUHBPi98lZuuNOzTrh4xcj7aEXx175/FPNRrt9xp+
         F20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680631977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6UvJYb0vhNu7LxirRk26kxVyScSe7FvDHHBR5w4eq8=;
        b=MZDbyG0s3PqtLmMhgvUtbYuQrWe+jU5SbxcPihCWXxmEofkoMslRqqHRhP66uJ7x+d
         lyhs28QaSyLaiG16zMWu9EIPvNSC9iFJRTdPYcSP2gU80ekNaAxZ3N93vSoiJcWbUGQU
         kx5pjw+NOD9ppTZ8zSaZhvXBJybOZ7nHyUFkSilnOlkHgW5Nwd1qmgDJorS3HyZKqniP
         aa/X+6hWFZ2DJjIR+oETz9eP8VKnjwyfkaxpuLeEIZ6c7nnmExIBlWef1TttSDkJRYKv
         +cd80Eas1ZAwbBWOnmOEXtnXCtqG5208O9LRMR6cfAGelEkK4yk659NtvmwOTB9YMK9Z
         q83Q==
X-Gm-Message-State: AAQBX9eNkLxXZcXAfUc4YSTNd1I1aw/bmjDBI0PA5TF0woZtSWcxz1Mp
        CWfuzk/jm2hwWmLZwcscJq8nTg==
X-Google-Smtp-Source: AKy350ZqidUHyjPQD80Bc29Ag79Id6JamdaJKo/GDVtXZWIbJCCdPv1oJ91ZQrE1lN5Pz694+gaH3Q==
X-Received: by 2002:a05:6000:10cc:b0:2ce:ae57:71db with SMTP id b12-20020a05600010cc00b002ceae5771dbmr2503166wrx.33.1680631976920;
        Tue, 04 Apr 2023 11:12:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:abb6:73c6:c885:345d? ([2a05:6e02:1041:c10:abb6:73c6:c885:345d])
        by smtp.googlemail.com with ESMTPSA id j7-20020a5d6047000000b002e105c017adsm12898526wrt.44.2023.04.04.11.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:12:56 -0700 (PDT)
Message-ID: <f68a0713-3388-aa3e-38d6-04b8a4bb9d16@linaro.org>
Date:   Tue, 4 Apr 2023 20:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 03/11] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Sujith Thomas <sujith.thomas@intel.com>,
        "open list:INTEL MENLOW THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-4-daniel.lezcano@linaro.org>
 <ca4e9523-0d12-c29f-6de1-365d1713ec84@linaro.org>
 <CAJZ5v0iYk7mC0K7Tsv7Dh9N=dQW151YhVcphvLm7T2vEY10tMA@mail.gmail.com>
 <b0e158d4-5522-821f-d3e5-abc6f77509cb@linaro.org>
 <CAJZ5v0g7Smzd5sOJ9K1sSF73C9sRC-GmDvAEV629+bYOa7F47Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g7Smzd5sOJ9K1sSF73C9sRC-GmDvAEV629+bYOa7F47Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 19:18, Rafael J. Wysocki wrote:
> On Mon, Mar 13, 2023 at 1:35 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 13/03/2023 13:26, Rafael J. Wysocki wrote:
>>> On Mon, Mar 13, 2023 at 11:55 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> is this code removal acceptable ?
>>>
>>> I'll let you know later this week.
>>
>> Great, thank you
> 
> So it would be acceptable if it had no users, but that's somewhat hard
> to establish.
> 
> As I wrote in a reply to the RFC version of this, I'd rather make
> these attributes depend on a Kconfig option or a module parameter
> before removing them completely.

Do you mean we set the default to false and see if there are complaints? 
If not after awhile, we remove the code ?

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

