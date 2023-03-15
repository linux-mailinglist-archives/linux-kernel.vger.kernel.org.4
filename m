Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524846BB5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjCOONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjCOONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:13:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6484D5BD84;
        Wed, 15 Mar 2023 07:13:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s4so720895ioj.11;
        Wed, 15 Mar 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678889580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iKv0HvoQWJrP86iQJwPJn9bEBkh3EC6q8vX+meuj3cY=;
        b=cF8H3YQevzGnqBCCT30wMigo3LRlJAQiGu17LKUVIuB06uuah7RuIiQ8xDB8S2uHpy
         3DBrULOIFmIm68msXD6tIVcxseze2zOo2N6DRHndLUSTusi5VE5qYpklbJdgGLOiBLoS
         OjXmkKrDh6+AtFlKmzkkQWRlvBuaTnLgoKQn4XWlVrZxRsILAiajeCz+6EwoDOfOTS2Z
         aNqzyzfpd6T8uDt5fvscw2Z3yQHMhlvtZYgzezHosnQ5/x24YwPTlxHU0Ycibaqf/Zc1
         Z4u4aU9d7X8kV7Zf53c/qBUL492iP//+ZPh6o4GpaxgZOjXVAe0pLlqyp1Lvu3AE5EHI
         zbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKv0HvoQWJrP86iQJwPJn9bEBkh3EC6q8vX+meuj3cY=;
        b=NEMG8H9lZo52tB/ekyxCJyxXj9Yjlas1kqPaMYeAn9bhfvxB9ywYOCtiMScbQflKDS
         T8xflMxBwL2lUa1OYZ4B7GZvGx6tRXO98uB0VpAgR+GBuB9YytopNJJtC+V2v8LYt3IR
         LlsE33TKbVT/EuqWlg5lt5UU6+w3fj2VfG39aufRrf8FiKKYpSmT+1mN9X8+zrt0V59Y
         FfHk7DK1DGFD5YFIQvZOIGRQMVmiIEWHYCRHwYcRUAkfoZsVxFdVqUAXXnGiEwf6cpQo
         8p5bLe8uC2dQ5oyLTDvDhr3CKBRsehbmUrRojo+dEbg+odsAcPRWUxuWraFbHjKY4um5
         baWA==
X-Gm-Message-State: AO0yUKVuck5NISikWbWocA+ANFvVcNPf5q0eoNYuiUbt4/L6XHjgiu4Y
        dhZW4CKSjN/V95MsI92LyCnbkgR86wE=
X-Google-Smtp-Source: AK7set/Ar8JZgtmCrNofRoZfXvFvYLH/PNlW2mqCPh+6UMWFkuUBjN133d2jUtmo0ncn5heDact8zw==
X-Received: by 2002:a6b:f617:0:b0:74c:b8f9:651b with SMTP id n23-20020a6bf617000000b0074cb8f9651bmr12147814ioh.1.1678889580169;
        Wed, 15 Mar 2023 07:13:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s25-20020a02ad19000000b00401b9f59475sm1671239jan.107.2023.03.15.07.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 07:12:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d089cd3e-4115-a984-d1ce-599e0dd1160e@roeck-us.net>
Date:   Wed, 15 Mar 2023 07:12:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: FW: Patch for supprting thermal of using drivetemp module
Content-Language: en-US
To:     Phinex Hung <phinex@realtek.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5aaa7ad83da54b0fb3b9fe9740042e04@realtek.com>
 <e9115cb68ae44b9491bc8a11fee3d989@realtek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <e9115cb68ae44b9491bc8a11fee3d989@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 03:49, Phinex Hung wrote:
> Hi Jean,
> 
> I have a patch to support thermal zone so that we can just rely on dts to describe a thermal zone and do the cooling operations.
> 
> To do this, I first modify drivetemp.c to support platform driver depending on THERMAL_OF and then try to support multiple sensors using a single thermal zone.
> 

First of all, this is not how to submit patches into the Linux kernel.
Please consult the documentation.

Second, the driver registers its sensors with the hwmon core using
HWMON_C_REGISTER_TZ, which should already result in its registration
as thermal zone. If that does not work, please figure out why and
fix it instead of re-implementing thermal zone registration in
the driver.

Thanks,
Guenter

