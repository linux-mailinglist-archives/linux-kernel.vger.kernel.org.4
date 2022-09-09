Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BAB5B3E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIIR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIIR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:58:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09469146D04;
        Fri,  9 Sep 2022 10:57:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so2272351pgb.4;
        Fri, 09 Sep 2022 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=oRK9XtWqfauasrSqs9Bvo7rEqJema0+dTVJMCkyrs+E=;
        b=khxs6iwgzmX5GSvyHGYmf4oiAn9d9VQqcixcxeMJlMBhdqopM0IBmCZsMq7ply5ll3
         Rosx1JlYWx7PE2xVoD0yTm/qWm3khCFs8hNqcqfotzUazQx4X6Nqv40ubpis5Y+CYzbD
         946jhr8LjZiCXQ/3AgDWATMxiIWciHQT9Z461Ir3BtAWvJ7s8BD0m2+JibQ7pQzKMQPS
         mESe8mTTbwUk835KlEod/FQQOyYWas/MNg9DYw2ICoRvpVCDqZMUQfTudTbk1vGSW1vt
         571QE5I5REv0U57YDF3XAh+FHw3z+DGQLiEYM+sjCi27bD+Dyf/DkHA1N2iR5yF6+68K
         WcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=oRK9XtWqfauasrSqs9Bvo7rEqJema0+dTVJMCkyrs+E=;
        b=Yvub5BaPiUpDtjgU8DgckCB0LvbVuDtUVlbKTdzjxl/qCx7gYblEEzdmQ1IMue9X3d
         1TMC+ZxysHfixAE1oXayhYr/bKLpdydx/HWf41gXLEST4rpztg1FBBHl4pElb3gHwf8N
         AuG9eqMvwDfOkP8Gn7NcvcDTkYUxNMBf0MW6WM8nbZmza2hj7NUYH8Q4+NNBEdwy+ISE
         oiVSiP9OS04Irw9BamdGErLztd6m5YiwUmYA77etrlj/Kt1AaRztsB0EBSnAZQck2B/6
         BNrp/AUxSRFKtmTuHNbMoGD8pahVTw7aWdzLTY1+I9r7pTPfb2/Xg+nOu4APuS0dQzpL
         IUjw==
X-Gm-Message-State: ACgBeo2YeaYr84LMMDjthjlmdIJYvwnu8BNb7bnH9WHWw/QOFoCPzGL9
        pMKDrRl/dxwUqvn0nC34Aw00mWlmasO0CQ==
X-Google-Smtp-Source: AA6agR6IF25SC/qnMvJ49Eimtq5GY2oNq0+HShl+pa0lv2Aco2awoDabC4QEVnAP75/lhq2yFmgvRA==
X-Received: by 2002:a63:2b48:0:b0:434:eb45:9c6a with SMTP id r69-20020a632b48000000b00434eb459c6amr11697853pgr.508.1662746214742;
        Fri, 09 Sep 2022 10:56:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l72-20020a63914b000000b00419ab8f8d2csm814537pge.20.2022.09.09.10.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:56:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <63ba9b53-b4f8-9e35-0bbd-aa84680e795c@roeck-us.net>
Date:   Fri, 9 Sep 2022 10:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] hwmon: (asus-ec-sensors) autoload module via DMI
 data
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909155654.123398-1-eugene.shalygin@gmail.com>
 <20220909155654.123398-2-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220909155654.123398-2-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 08:56, Eugene Shalygin wrote:
> Replace autoloading data based on the ACPI EC device with the DMI
> records for motherboards models. The ACPI method created a bug that when
> this driver returns error from the probe function because of the
> unsupported motherboard model, the ACPI subsystem concludes
> that the EC device does not work properly.
> 
> Fixes: 5cd29012028d

Please include the bug text in the future.

> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216412
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=2121844
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter
