Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE474846C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjGEMvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGEMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:51:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D0110EC;
        Wed,  5 Jul 2023 05:51:46 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57722942374so81284317b3.1;
        Wed, 05 Jul 2023 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688561505; x=1691153505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4TI27rCidWfDrTg//jli+vwhntyHlTcbniPH3pF/oFs=;
        b=K9XRyruMZJQkMx3rZPrVX8w6LdJkA87VWurC83c6F8gl4iuk87S2F8/uHyd8Fq3tA0
         3GRLA7GQ1F1+1BhrK5Fq+/zjnTCVBEhD2p7vPkSzj4ii0gyOmJfjbFdfrxVdOBF5/9QQ
         aJ+h1Rk+K1Mfj3XxU7+wEK4wSyUXFoynxPs+uufPEMM7zynHFTmy3OSLD7QmkS9H92/T
         X5W4mO9mdpRCOHKO7BPjw+Z6pYEowQWWCSefQ/F9+jsk+d/97G6smeTN4T0boCeYOT8o
         OaJpMlVh1hE/YeQiuqbYcQ/KROqNHhVwxfdSk+EathWrC6ahbmlkWBNKBzunozOcEtai
         U3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688561505; x=1691153505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TI27rCidWfDrTg//jli+vwhntyHlTcbniPH3pF/oFs=;
        b=RbLt90BvG1Kt8Fi8WlldNDTHS+K9/EMt9CmkG6aV95nEatRobMbQkD3FLVoGvd2iJZ
         KFR9JqteYN4Onhbc4gk1MxP7PhJ1YOCtQ5eTgIVNA/26BMCpWgGY6QH/o18CGwsZ2mKW
         7on7zruMq2aEQ4RDkf1ruLXrJru8aTclJbmJyv3pIdSZGJZxrFiDzK9yvJksg79rMcuV
         tZkjXLZOVY+RijMN7Nxd9yfB60oVJf4c4O4Ub0KWy8eeytulIOkeb+jpNr2pQR5/CBXK
         tM9ymjVuLKOeAilma0oVpKly8fn3gnj3ISHqDVEYVCQG4CGIjvLBixYnt+tJdIneOXvy
         FuLg==
X-Gm-Message-State: ABy/qLZHdSeYy1fkXlucxOogx8CmHJopp0OzaDTyDAtTT8doqegB+AAQ
        35roaiH05VVNgBpiF2ipP1A=
X-Google-Smtp-Source: APBJJlHnCbIk0q/1dfWa+mjZ7vkiGALafRuPrf4kVThas3u/z9NR4VybXSSpeRW0QabXz9d4nbCQvg==
X-Received: by 2002:a81:4c8e:0:b0:56c:f68f:d824 with SMTP id z136-20020a814c8e000000b0056cf68fd824mr13630800ywa.45.1688561505495;
        Wed, 05 Jul 2023 05:51:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x185-20020a814ac2000000b005771bb5a25dsm3795474ywa.61.2023.07.05.05.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 05:51:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7f1ddb5-a4fd-f79c-f870-8fa7410cd0c7@roeck-us.net>
Date:   Wed, 5 Jul 2023 05:51:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] watchdog: s3c2410: Fix potential deadlock on
 &wdt->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705090951.63762-1-dg573847474@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230705090951.63762-1-dg573847474@gmail.com>
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

On 7/5/23 02:09, Chengfeng Ye wrote:
> As &wdt->lock is acquired by hard irq s3c2410wdt_irq(),
> other acquisition of the same lock under process context should
> disable irq, otherwise deadlock could happen if the
> irq preempt the execution while the lock is held in process context
> on the same CPU.
> 
> [Deadlock Scenario]
> s3c2410wdt_suspend()
>      -> s3c2410wdt_stop()
>      -> spin_lock(&wdt->lock)
>          <irq iterrupt>
>          -> s3c2410wdt_irq()
>          -> s3c2410wdt_keepalive()
>          -> spin_lock(&wdt->lock) (deadlock here)
> 
> [Deadlock Scenario]
> s3c2410wdt_probe()
>      -> s3c2410wdt_start()
>      -> spin_lock(&wdt->lock)
>          <irq iterrupt>
>          -> s3c2410wdt_irq()
>          -> s3c2410wdt_keepalive()
>          -> spin_lock(&wdt->lock) (deadlock here)
> 
> [Deadlock Scenario]
> s3c2410wdt_keepalive()
>      -> spin_lock(&wdt->lock)
>          <irq iterrupt>
>          -> s3c2410wdt_irq()
>          -> s3c2410wdt_keepalive()
>          -> spin_lock(&wdt->lock) (deadlock here)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock, which reported the above
> warning when analyzing the linux kernel 6.4-rc7 release.
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave()
> under process context.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

I am sure you know what you changed in each version of your patches. I don't.
Please provide change logs when you send new versions of your patches.

Guenter

