Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599B65767B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiL1Mey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiL1Mev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:34:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F25710040;
        Wed, 28 Dec 2022 04:34:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id e21so1063831pfl.1;
        Wed, 28 Dec 2022 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Frx76nYEfOImaf2Qpg6M0j5kIFUXt3fVGDIGwcWIJWU=;
        b=IA3i3fizu8ALp34ROwZ9WX/+jBZBtGBaQO5fyEOdNT9zSLHY93lCP9CKm2HYX3ndID
         JeUmi/sccAQAZUNqrLgQG46eIgp5B/EQL4DtATOXl9bMITfhSYrp6KIZCUemJHGOUTrW
         WzLvSZuxVsdKoWKVa/3c5kea+lwdO0VNHENzItLexxYEAln9CbDkttN7bbyxIijIw9N7
         JmkxeY4N+CN9Wk1y3tsGdS0CdK0WNhQXHv133lTPPrGXDgdiAVrn1FUUvwKXca/l3fV8
         A5shyFZ3xPfraqqWCxFYboVKDaf8sU5au/wlApa3HNjZh9v3ZywfbagIPYVL0mF2fDvp
         qjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Frx76nYEfOImaf2Qpg6M0j5kIFUXt3fVGDIGwcWIJWU=;
        b=FThEbVb+ISXvEG3W8w5W2q80LgSzS1wf5AnN5LifdY9UfQVHpbDbXHbGhKTcebYTNI
         v3EOoaXkK0jhhioxRhV79w42FKd5fIAoDrkoAz/J4j+qz1udSOy/9LMjJoPmb3YCzbbW
         v34Wm5K5MQ9WPX0SpuMna1Ms8paLU/MNN87pIDcNQujBbDuYne01WnxniRGmFl3KG6Fl
         ZEERQgXtUrA/2jZDcCwbkekFlTPrxKgCAeUFCoH+beqW9tOz5GiFxNb0O70zDP1XNsf6
         spETUELopS51/KRgLZhY6iRyFNr4hnHoANjPsJrmCb025NqDKZv+8/ozRCh6faAV7vW7
         FPUw==
X-Gm-Message-State: AFqh2kp+0lhCPXfX+HpOEw1Hb60FIhGTTJpISs9fYPszuiqTOprVZJmR
        WkanXMMj9lAMoDtWPFdhVVI=
X-Google-Smtp-Source: AMrXdXuCA1sVh9R+K43kQWAzkRUlycUPMWUwLCzkFFdGSyeXG/PJ2jtylsFq7g8tsp08ks0YsGrMIA==
X-Received: by 2002:aa7:96aa:0:b0:581:3b0e:803c with SMTP id g10-20020aa796aa000000b005813b0e803cmr9683672pfk.7.1672230890621;
        Wed, 28 Dec 2022 04:34:50 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id w66-20020a623045000000b0057fec210d33sm10171449pfw.152.2022.12.28.04.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:34:50 -0800 (PST)
Message-ID: <32a201f7-fb1a-0651-6b82-b2593e56e759@gmail.com>
Date:   Wed, 28 Dec 2022 19:33:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] Documentation: process: Document suitability of Proton
 Mail for kernel development
To:     Conor Dooley <conor@kernel.org>, corbet@lwn.net
Cc:     Conor Dooley <conor.dooley@microchip.com>, broonie@kernel.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221228000330.3971104-1-conor@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221228000330.3971104-1-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 07:03, Conor Dooley wrote:
> +
> +Proton Mail
> +***********
> +
> +Proton Mail has a "feature" where it looks up keys using Web Key Directory
> +(WKD) and encrypts mail to any email recipients for which it finds a key.
> +Kernel.org publishes the WKD for all developers who have kernel.org accounts.
> +As a result, emails sent using Proton Mail to kernel.org addresses will be
> +encrypted.
> +Unfortunately, Proton Mail does not provide a mechanism to disable the
> +automatic encryption, viewing it as a privacy feature.
> +This affects mail sent from their web GUI, from other mail clients using their
> +mail "bridge", as well as patches sent using ``git send-email``.
> +Unless a way to disable this "feature" is introduced, Proton Mail is unsuited
> +to kernel development.

All mails sent via Proton Mail SMTP relay? Also, why is sending encrypted emails
to public mailing lists (like LKML) not a good idea?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

