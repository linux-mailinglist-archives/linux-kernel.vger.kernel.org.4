Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1B6E102B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDMOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDMOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:41:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF74C3C;
        Thu, 13 Apr 2023 07:41:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l16so8243372wms.1;
        Thu, 13 Apr 2023 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681396893; x=1683988893;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGGoYKbxWkMy+yAyRRbPOAvuFmowVBSZKJ7Gz931Puk=;
        b=F/huq0ooJSEHqJT9WfOHndjq9zpC11qu90u1BPAWqrELhBG8tdwRyEJLvkqcJtiGaO
         d0q+pU9yznj6xZSsXQU/81jwFOrjbDE01DQx1q1OiAkf8VYvzvnTeKiIPp4Rti908oL3
         fWmg0qXf1FFWdzqg8mFSx/vaS7K9o1eHc7ZXzi2BYx+LDvrt8hD3aqrenDh6/KcKCBXJ
         5uC9zavRCu/RZ0tI+NUlCLfU/uVZG+aBl6D4/D6vdS9Vt4bqNHSJr+tW2gEvr2/XZ3Q4
         djI69Zrz067gWj4Y3/PBb0H2MJWVM8OWhIZ+CxfkdCUATw1xxt+eyc9RtlikNCM2+w8O
         aXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681396893; x=1683988893;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGGoYKbxWkMy+yAyRRbPOAvuFmowVBSZKJ7Gz931Puk=;
        b=IHv+iQqzqLQtEAAINDlk0fG85+HYCYDKDWgpjbBLtrC41/e7DyJzzK5xaJ87x4WX9F
         +jmgN7GHml8iX/fUQ85r2/lvrVEef12+dr6BhooUYR5cXNuD1dwbU7hyCH7KFYntT0M7
         jMkCUFWWdKq9PZnyq2xr3leWxd3v6pNU0d0zBFUVs2CAzo9+QOwe7OBFvSXoLAMishj+
         YvvKX74lnU0cYg0e/rBMc9f6X94knlPkzC+nbdaXVYhvOlJb6QnHNnKJfl1YuCDz0n3q
         TorXluhLo+htNGId/LDdL10K/fNwE+Eqh0t0w5opbUSYNxrTUOnbU1iUlC+DkltsTThi
         deBQ==
X-Gm-Message-State: AAQBX9fXSLCeHozh3bloKM+gQkw79KrJ7uP5YHUVQzIVQcbH7pgdrYDg
        v9IWO/1qZXK5ZyB8v9UQPbk=
X-Google-Smtp-Source: AKy350ZbqJ5bWa5cYv9CC7e5p+ddl8jNr2E7cZsF9uwQaXkZpYUWcK/uhYIyXxjjItA4CApD+jtVZg==
X-Received: by 2002:a7b:c44a:0:b0:3eb:42fc:fb30 with SMTP id l10-20020a7bc44a000000b003eb42fcfb30mr1976459wmi.32.1681396892661;
        Thu, 13 Apr 2023 07:41:32 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id n21-20020a7bc5d5000000b003e91b9a92c9sm1995217wmk.24.2023.04.13.07.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2023 07:41:32 -0700 (PDT)
Subject: Re: Motorola Droid 4 -- Stopping charger when battery is full
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, phone-devel@vger.kernel.org,
        maemo-leste@lists.dyne.org
References: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
 <ef4409b2-abd8-0eac-f66e-6858c3358cc1@gmail.com>
 <ZDfMlfVDdSm8mXs0@duo.ucw.cz>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <6f3eb1b9-f6b8-f980-8fac-27b32bc1b7e6@gmail.com>
Date:   Thu, 13 Apr 2023 17:41:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZDfMlfVDdSm8mXs0@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.23 г. 12:34 ч., Pavel Machek wrote:
> Hi!
> 
>>> I complained that "battery life is very poor" with leste. It seems to
>>> be combination of several factors.
>>>
>>> 1) I was using very old battery
>>>
>>> 2) My charger is detected as "USB", not as "AC"
>>>
>>
>> And this is because there is no working charger detection in the driver, so
>> initial current limit is hard-coded to 500mA.
> 
> Aha, thanks, makes sense.
> 
>>> According to my measurements "CPCAP_REG_CRM_FET_OVRD |
>>> CPCAP_REG_CRM_FET_CTRL" results in battery discharding and 0A drawn
>>> frmo the USB.  "CPCAP_REG_CRM_FET_OVRD" is phone powered from USB,
>>> with battery more or less disconnected (<12mA), which is what we want
>>> in battery full situation.
>>>
>>
>> What will happen if phone needs to draw more than N mA (N is the set charger
>> current limit)?
> 
> We may run over the limit, AFAICT. I guess one solution would be to
> only do this when limit is high enough...
> 
> With current setup, phone will not boot if battery is empty, so this
> needs quite urgent solution.
> 
> I updated my leste, and now have:
> 
> user@devuan-droid4:~/g/droid4-linux$ uname -a
> Linux devuan-droid4 6.1.9 #1 SMP PREEMPT Mon Mar 20 15:16:53 UTC 2023 armv7l GNU/Linux
> user@devuan-droid4:~/g$ apt show linux-image-omap
> Package: linux-image-omap
> Version: 6.1.8.0-1+m7
> 
> Where can I find corresponding sources?
> 

https://github.com/maemo-leste/droid4-linux/tree/maemo-6.1.y

> Best regards,
> 							Pavel
> 
