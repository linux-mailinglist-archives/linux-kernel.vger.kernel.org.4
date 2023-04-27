Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE286F0439
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbjD0KdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbjD0Kc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:32:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67A4ECA;
        Thu, 27 Apr 2023 03:32:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b78b344d5so6552442b3a.1;
        Thu, 27 Apr 2023 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682591578; x=1685183578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DVMLhU0hiYSd+fr7Je0IleGr0eMFrfhOsxolYP3fJaU=;
        b=G0zUEGkAaKc2HlPFV4pY3YsdQdEAP1FtHnsGJUZeupHeXr/HiQL8rmwXBtxeQHy4Kj
         7sv1E7nPjROoGOtWTJeFLeSQbzjGVylWOsnNdPqw99AgbLh1Oo70SWsGnXCzyLhWVFFU
         loeG8CgFtFxTY4V2Je1IqLKfLRn7fGmcGvf8hchsljk8gRcGfa6qkmm4kvzdOOj4Xl8m
         s7qYfGQQN2LxzAX9YKExmeNWXB/EUAt78QcjvT+piah4U5Crrc09IH+zYe+eZ9GPkbQX
         U4w+MoZPGEO66bzFlsAKEr6zWwgikN6tW8/wqEhPUunpq5dFYcyeAKAPOfoJkxzT0xTI
         qXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682591578; x=1685183578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVMLhU0hiYSd+fr7Je0IleGr0eMFrfhOsxolYP3fJaU=;
        b=ZLobZXpVQJzs+Az/vj774IGgnwpyoRML4zVoE6k2Qv1tkPkyr6DLKvUDg+Q0HxesAw
         BMZLqS7+/CWxV3i41bTc48zvNU4a/g/pkb1SjsXVGaZWQkomAQ/o3R8R3+KtRsm1lwiH
         FDkcTh3asdjCJC8CILgiYehSmPKY4wXTfP/KN2i8Z6/DsT22txSRPc10Ymw1rIQm7hg9
         J2t35GBBjkzEYMGJdeXeRBI5bL+12q2tNCPcNRJ1CFasSQUn/45PUV6ht9g4tQqnIX8I
         pDiFNXocFqyVc3858u4rh+4AZZA4opljk7UxIeqOUsXoJkXGpV6WMqbvrVtLDJiwA9lX
         c41w==
X-Gm-Message-State: AC+VfDzfnpo2GXngzvnyY4YnH5GhZo727GDOq4OaoFXFIJ7naF6GNvYs
        T/5IpbA9MrshPw2537Dh7YONyA7yekk=
X-Google-Smtp-Source: ACHHUZ6h2JThXBDqhO/KGL11JzIMOttNSgTGB4+kgT71CaSPY5QgWg5nhOBoC8ogaNGCMGh4GrGbfA==
X-Received: by 2002:a05:6a20:938e:b0:f8:8879:747e with SMTP id x14-20020a056a20938e00b000f88879747emr1292896pzh.59.1682591577960;
        Thu, 27 Apr 2023 03:32:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l18-20020a62be12000000b0063b7b811ce8sm12815072pff.205.2023.04.27.03.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 03:32:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <406dbcfb-7a08-8067-d717-3472e42e19e6@roeck-us.net>
Date:   Thu, 27 Apr 2023 03:32:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hwmon: (max597x) Add Maxim Max597x
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
 <2579ed08-b21d-489e-8a40-8310efdfa1c4@roeck-us.net>
 <5104bcd2-4203-e4f3-ac58-310fa4d45c7b@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <5104bcd2-4203-e4f3-ac58-310fa4d45c7b@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 02:50, Naresh Solanki wrote:
> Hi Guenter,
> 
[ ... ]

>> Again, I think it would make much more sense to add hwmon support
>> to the regulator driver than having a separate driver since there
>> is lots of overlap. For example, the regulator driver already
>> sets and monitors limits.
> I agree. But the chip also has led functionality. I got review feedback to make it MFD. So when rewriting as MFD driver made separate driver based on subsystem. I'm not sure if it is ok to use hwmon subsytem in regulator driver. Will once check with maintainer on this.

LED has completely different functionality. Overlap between regulator and
hwmon is substantial because the regulator code handles limits and alarms.
Sure, you kind of bypassed (ignored) that by not implementing limit and alarm
support in the hwmon driver, but that is really just avoiding the problem,
not solving it.

Guenter

