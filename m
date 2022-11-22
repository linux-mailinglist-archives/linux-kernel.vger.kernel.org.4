Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A643634219
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiKVRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiKVRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:02:41 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A06443;
        Tue, 22 Nov 2022 09:02:40 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q83so16446028oib.10;
        Tue, 22 Nov 2022 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JOuzCYe5JVR4ZLts5vfYmS05YHJ/NHXyOkRd7+N9iSk=;
        b=c0iBCVhw4e2P1A8oMhM2mNmckPzQH1kr7QRdtmzaDdTCd8Ai1FfOMFg9qYijWIEGSk
         b1YiFpd9xRZ3PAzuDDRAbwVo8ji/1YaSfNgU8pAfsBjXek8Dmo46m6OhlfeM0swdjpdl
         6Qsf0FD79mCMKqgyovm2qzZXvjGXg3HFjpKrPg2RzFmtxTOpi3M8QUgg3I0BAPNTehSY
         NJoTPlED4U8l8rYlkdOGbDIUlvdT/RpgnKmNZOlvXqFhrZ3EBMG7n22GTOEj7juKtIOG
         RU5dFlW0eZ30qbNAhVFv1ejMEKLbbfhrw5I0X9fsADh/kG5CGI8WgAmJmUCTqONmtTHl
         gS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOuzCYe5JVR4ZLts5vfYmS05YHJ/NHXyOkRd7+N9iSk=;
        b=nwsBR625nEI1uSFWyy3p1A211vuKkVPjWj87+5czva2zb/yENGtR9mC6XgL/LpXu3M
         XAhDeZaYx9a8zdZpUUeELO7OhKH0Z1oVwOi3LN1C1sDrM2xaffjDAFL+GXvI278ltT6W
         iXkdqJXAjbtm0h0heMyZ7jAqpw7qZS0cFOQjjJ52XnaS3EdtBwb4i+ar/s+g1MuWt56q
         ykbX9SLEArMRRngWJqcrf8Ikd8Dp27u6/0LSmNG9pqIhvmDqnz4iTFafQrGmgWl1zagy
         cNxvB1payKSgFn3l559TRNBwIVqvvW30y/dOtFnAJMQL86PR9imUzDW2Z/Jh/cMp/BmC
         tsvA==
X-Gm-Message-State: ANoB5pmrV5AzOFwknGDQdrVw4pk/EzoBq/851FXJd4EhDbZgYV5FXZ1J
        QMY0edakhStmQ1qV3UJIFlg=
X-Google-Smtp-Source: AA0mqf4v7XMVztXelwAGg76/2n4TGcurmOcj9GtHRRIbfzuZTgdXH851XlyjAB0I1RNvvMaX4i+iSw==
X-Received: by 2002:a05:6808:a0a:b0:34f:bcdf:b08f with SMTP id n10-20020a0568080a0a00b0034fbcdfb08fmr2626869oij.71.1669136559509;
        Tue, 22 Nov 2022 09:02:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9-20020a056808054900b0035acd0a6eb2sm5585858oig.41.2022.11.22.09.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:02:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1724dbac-024a-2758-a030-c07352b536fc@roeck-us.net>
Date:   Tue, 22 Nov 2022 09:02:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] hwmon: (pmbus/core): Implement IRQ support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221122135014.3504094-1-Naresh.Solanki@9elements.com>
 <20221122135014.3504094-3-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221122135014.3504094-3-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 05:50, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement IRQ support to monitor PMBUS regulator events.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Adding a PMBus interrupt handler should be generic and also handle hwmon
specific events. It should report any status changes as sysfs attribute
notifications.

Guenter

