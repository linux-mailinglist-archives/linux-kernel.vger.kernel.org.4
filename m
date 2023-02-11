Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEA693336
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBKTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:07:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FB1423D;
        Sat, 11 Feb 2023 11:06:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w3so1195302edc.2;
        Sat, 11 Feb 2023 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWWLFwjwXxaSFcUV635NAOtQG8/udwOIXa9FG4BJ85E=;
        b=otZuQrVb7TFjSTbAIfCKtzLgQEIsq+6/ivb+xqO117HQpmaGlcbIXGw6o5C8D9UEgm
         DKPZd651TxMQIg/DMFyhY7LMXx58/eWQFtCQV6NuNOnJztriBUb8QdttdvHL+MKFf1TG
         zZKqXYJoWWFY3yedN39B53LbgZOaoFk7DrwK05y2lvgcvK2tY3JqBu0bmCsA/aRpK7EE
         vpDQXOk8IrxTSmGn3GCKPCd+C7ZQiSCj5eJffhvF8uATtW+pngNIZCEmKUtST3cMIzfL
         J1WjUojanJvQtELnDZqa2yfqxLeRh4sL5QaAhE7lRERa0hNrcJ+AYbP1Au8EC2jdxLbG
         NtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWWLFwjwXxaSFcUV635NAOtQG8/udwOIXa9FG4BJ85E=;
        b=oLrbIxIvvyoa5vNNWfjAHj0/odysCAfo42jxwtUfdeda3PYlWqxnbdKOtX6dmQBlFg
         ExgB/AjDIAQonnrn+aEa+aNbfACHUpK+9qRj3YGU8EHGT1vasjsjnmjC7VOQVoVpw8eY
         Wk/qTvl8YqgrECGFpOTHn8rDpjgV6Tg4Ag9GU7+juXgxzZEXwXvT/pPuDvM39uFuUNak
         jejnjiF6akD4K3D8h1GmsN/VFXPZ73Hwpr3vM0sCkasK52gSc4dU3mElGDEX35n57yk0
         GC1pfp/sLaJdqzzEPHwhPD6vXDHOF9OwxDj2gVUv8Kr8QRdjqkK3GgILnUhJQ4vAjlxz
         7yLA==
X-Gm-Message-State: AO0yUKV4pvY+VEqxtBtWbv90ylciRwl+zb13KRc75+vT0xt3KWlIRZyp
        BURhO7JZEdeL6hvjvu7KgCs=
X-Google-Smtp-Source: AK7set8k+CwM5OCEfLGAME57ZvTwoOl9TFBiE24RWY9+zmG2mnBLIBkTTeOBH81UI7GW0p07IHLHxg==
X-Received: by 2002:a50:9352:0:b0:4a2:4675:2162 with SMTP id n18-20020a509352000000b004a246752162mr2078207eda.3.1676142414076;
        Sat, 11 Feb 2023 11:06:54 -0800 (PST)
Received: from [192.168.0.22] ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id t2-20020a50d702000000b004a236384909sm4137637edi.10.2023.02.11.11.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 11:06:53 -0800 (PST)
Message-ID: <ffb7aa61-20d1-e4be-1c67-e1d3cd7a15af@gmail.com>
Date:   Sat, 11 Feb 2023 20:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     savicaleksa83@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] hwmon: (aquacomputer_d5next) Add PWM mode control for
 Aquaero
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-hwmon@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-6-leonard.anderweit@gmail.com>
 <ef64d9c3-65e1-636c-1cb7-8721b1e8746e@roeck-us.net>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <ef64d9c3-65e1-636c-1cb7-8721b1e8746e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-11 18:41:52 GMT+01:00, Guenter Roeck wrote:
> 
> Adding the capability without actually supporting it raises the expectation
> that it works from those who don't know better. Please only provide the
> capability to set the mode where it is actually supported.
> 
> Otherwise one could argue along the line of 'hey, let's just "enable"
> all attributes no matter if supported or not', which would lead to a
> lot of confusion. I really hope that isn't done with other attributes
> in this driver.

(snip)

> 
> ... and it isn't even mentioned here that the mode only works on
> Aquacomputer Aquaero, and only on the 4th port for Aquaero 5.
> 
> Really, please don't do that, and I sincerely hope that the driver
> doesn't hide (i.e., claim to support when it isn't really supported)
> other similar limitations.
> 
> Guenter

It doesn't, features are exposed if the device supports them. I'm part
to blame for this one, I didn't create an issue at the upstream Github
repo to track this. We'll try to find a way to differentiate between
aquaero 5 and 6 - the aquaero 6 is basically an expanded version of
the 5 with more powerful hardware, firmware seems to be relatively
similar.

Aleksa
