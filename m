Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C97D728D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjFIBvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbjFIBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:51:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E301BF0;
        Thu,  8 Jun 2023 18:51:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b01d912924so3412145ad.1;
        Thu, 08 Jun 2023 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686275477; x=1688867477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ExVnv9Hua4o/9LiKX5VT7Fy71gRUPiGtaPQt3M65gPA=;
        b=GH0olp1WNnT01+7hnipCcJFY5OLfsyFib9DXZAFXvfq43mC1hkwpeznMfCxaRCNXzo
         bSKoXYZwoYgZbXbJE6GI1+S7IRJ3/phkBZ3jtm7baCfBaxEbY0aqIp0JVeYxl8K6Xk/E
         OthxNwNN1DovkMeQvSQ/mX1etlF1n2hSjf8/tYSOPCbnXIspu0VxygGb29q9RERF4Y8w
         4g5/lpu89BGSG0DApjJXzLCU7mYL0I/lGGN6Q7wTVM1U4Jpm6wmdwISNqGJQZxxTui5q
         Pkm04oNXg3MRiF/qcaGMPXolIOgs8lXLmsKBQ/AtSUj9Ll0D7HLzSSkx+Ieh57FVU4DL
         4hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686275477; x=1688867477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExVnv9Hua4o/9LiKX5VT7Fy71gRUPiGtaPQt3M65gPA=;
        b=AFPBSooOqmDqKlCKn5uBFyoIC9dEDipa2ytvzx+VNYrOO26vCPUOSYOcvlUr1+tcYg
         qAIxp3/VFDNYceefSOc1ZX4WwKpf2RhnQLbDyJ8E/GZtJIw31tp0fQu6unsYi7he45ta
         sWbNsAsWoHGwsbDGcRhhtF8h5cG8OaGCVdHql1jZOnO4wTSfw/09H/RkXLQAgE5WpaJc
         Oara+OAM3+lVdl0OoI0qP8xK8cn3qyhx8xvgjkTHGjezf1XNL14wKn0XsA4fniWAz3oI
         OzekDiC/rR2UcsrHKQFGTqsVNT3cDrqPj7BwvPUgf9Zi9pI1iXVjZs0HTgMFQe3Nrf+5
         XU2Q==
X-Gm-Message-State: AC+VfDyaikUpXrHoqiS/wPLnUVauW538ZsZtAKy9FM+SVJox90lODNxI
        yVgJ7zXHRJCve6JkDS7gZuw=
X-Google-Smtp-Source: ACHHUZ7e91JfKHjzsGMwENeW0HwPaTbbf5BtDIz0MJm2h8tnRZT9+voQ6NDMPhDWJMMIK3aZklhBtg==
X-Received: by 2002:a17:902:c949:b0:1b0:5d15:3132 with SMTP id i9-20020a170902c94900b001b05d153132mr18482pla.58.1686275476683;
        Thu, 08 Jun 2023 18:51:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b001b01fc7337csm2006329plo.247.2023.06.08.18.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 18:51:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e1fcbb8d-c9b3-868e-8053-6ebc33a3e66a@roeck-us.net>
Date:   Thu, 8 Jun 2023 18:51:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Documentation/hwmon: Fix description of
 devm_hwmon_device_unregister
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, YYang <iyysheng@gmail.com>,
        jdelvare@suse.com, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, YYang <iyysheng@gmai.com>
References: <20230608224231.1156-1-iyysheng@gmail.com>
 <ZIKA3MNR1t2HvnHo@debian.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZIKA3MNR1t2HvnHo@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 18:31, Bagas Sanjaya wrote:
> On Fri, Jun 09, 2023 at 02:42:30AM +0400, YYang wrote:
>> From: YYang <iyysheng@gmai.com>
>>
>> Use devm_hwmon_device_register_with_info to replace
>> hwmon_device_register_with_info in description of
>> devm_hwmon_device_unregister.
>>
>> Signed-off-by: YYang <iyysheng@gmai.com>
> 
> Is your SoB address gmail one (sounds typo here)?
> 

Looks like it. YYang - please resubmit with correct SoB.

Thanks,
Guenter

