Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39072ADAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjFJRYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFJRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:24:44 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B373589;
        Sat, 10 Jun 2023 10:24:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6260e771419so15016086d6.1;
        Sat, 10 Jun 2023 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686417881; x=1689009881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk1WLJV5QkFB4QM7WPYN5iwoIW9xxUosdBEEitZ4V5A=;
        b=ZIp6jCT06zpNehaXWiaJDD5KCKoT5CThszCmRg4veyX891C8qsjnRr/S7UdOFdsfS7
         mwqzyHMrE/Nu9XC779XaSG6zncWapMtwdZUUuZ5Yvzk4Hef9HbhPvQfPNdamIZ/UQ/wF
         YJjUKjAvVAGrnYvUGmAstrF1qnFk/bob36UWeWpiZrq8/YSh5uoebAjVCKAQnm6ZqOFr
         D+ZsOQTIqM38LEFrwTjIbdNqtHFDK+2pyiX5gW3jnLFmPJtleutQsuoi8KDUEd6aMmp/
         XTmOxS8yqt9Jm5W1tPCpPkhoRWCS4uRbtr7qyR0fhsN2Yp1riC5woor5Ro2jMsebHHpR
         Pz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686417881; x=1689009881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk1WLJV5QkFB4QM7WPYN5iwoIW9xxUosdBEEitZ4V5A=;
        b=g5uEesN1FibHFj6VzUCO76atJknUelfte9sJ0F5IiahE/HMeMGp4gQtdsf0FNWNGyI
         v5fX+y2bQRTBHc4UxpBij+hkwJZH+tv3LSuzP7ZKBimOddkGI0OKCAoWa65KoS5aFMa3
         IJsDHmwrfFFGMSECo0TlrJb4/7RXGIFAK1qNhx9gmLJDzg1x/bEJdTty5hIExizXKOsX
         kd7Spp7tldHH2HyMtHF/tJ1iI6pqRWgalJk0fxSYbG5xYhX6CRgdxoqn6kVeT+4a/jhs
         HrSLVqvktcN8Q5rmJVqN2IafinP5TFUppIAjMWEPbjx6ZTxjmayDSq/BICh6m6EZm9L7
         fZYw==
X-Gm-Message-State: AC+VfDxCK3yYxE7oMlDGQJ0Tnu5UUGOtd9NSrbcYda6qF/vSnRusNzi1
        6HJ4FOvg6TqwPRBPlnp+e54=
X-Google-Smtp-Source: ACHHUZ4jvqgsA1HufGLT8w1uSy08WFo0kLcE1pb0iEUMiabgGNfL03a0nPDs7x0qTX/ZxAjqEpnrow==
X-Received: by 2002:a05:6214:2488:b0:56e:c066:3cd2 with SMTP id gi8-20020a056214248800b0056ec0663cd2mr5967750qvb.2.1686417881293;
        Sat, 10 Jun 2023 10:24:41 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id a20-20020a0ca994000000b0062de1ed9d15sm196600qvb.102.2023.06.10.10.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 10:24:41 -0700 (PDT)
Message-ID: <f6d023e4-c22b-32fe-f7c6-51a988c43864@gmail.com>
Date:   Sat, 10 Jun 2023 12:24:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     eduval@amazon.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
From:   Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 11:38, Eduardo Valentin wrote:
>> Can you elaborate 'the timing requirement for the governors' ? I'm
>> missing the point
> 
> 
> The point is to avoid contention on the device update path.
> Governor that use differential equations on temperature over time
> will be very time sensitive. Step wise, power allocator, or any
> PID will be very sensitive to time. So, If userspace is hitting
> this API too often we can see cases where the updates needed to
> service userspace may defer/delay the execution of the governor
> logic.
> 
> Despite that, there is really no point to have more updates than
> what was configured for the thermal zone to support. Say that
> we configure a thermal zone to update itself every 500ms, yet
> userspace keeps sending reads every 100ms, we do not need necessarily
> to do a trip to the device every single time to update the temperature,
> as per the design for the thermal zone.

A userspace governor might *also* use PID or filter multiple samples
taken at high rate. I specifically switched my python fan control script
from the Intel coretemp hwmon to the x86_pkg_tmp thermal zone because of
the coretemp driver's annoying 1-second caching behavior.

