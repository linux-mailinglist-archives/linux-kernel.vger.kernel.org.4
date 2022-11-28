Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76463B5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiK1XJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiK1XJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:09:22 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D32DABA;
        Mon, 28 Nov 2022 15:09:21 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n186so13341005oih.7;
        Mon, 28 Nov 2022 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FqM5bfz9gbIFiU39mN6Loti0vzFECvEswxLH6CDy5KY=;
        b=LfwE/3O+Q7mpkz/yCwDyW3R7ricCxIUHFFl9KwAl0DoHTDQYBfS6emxXdp4Xb3RBXL
         Xq1QDIQrFkvo/7DXfaA5k0dwDRrj6eHijK1VCr7VXgIqqc/QaAMVs5YviutkRpOBt6OB
         QdLy58JCCFKwf8wVPsciUAZ4sg+FApByOnMSVtupEvmi6Qk/ysmWS1WUpPgFICJ3QLTD
         F1OjgWkda/kzHinCPqy1dCXsPw5yZPZHBwzlUCLaOnyGt6Y4LOOJVOyhBDmsh7+Wmk80
         HIGfgZkBGmmL0ukvZyDEtrO3wJkI/Rrt4ch6RXUSFqtN6kkLgYiL65ZNPLjH38J/JqvH
         O2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqM5bfz9gbIFiU39mN6Loti0vzFECvEswxLH6CDy5KY=;
        b=fhtKUdkC8I5HhVMpYjhBIDa0rNnjugPqxV8V638XLF7fNLat9qpXL7tJyWC6EyMgwC
         zyp7qx4GY+8aPWG3tG/DktC3RyVtMdwzUNl123rjcH4IuB39SR+UHX8S8H2fNe3Wbfdd
         Z2xwFfGR7PSytPJmhy2fKMDIiGpJGXHAcOZWqmyvtGEdBGtreBfNxwHsMQ9D9Wxd/8I8
         Dlqqy9xOiQAl+4MMtZ/cU9N0+ff6/lc2WF1TqoEbOmTDCPoTCrygZi9qd4qn2fKAzijS
         4C1oMkwkUubxCvgeTPoWOh+QAHpIDjkKsAu6yvXbaRx1aVePHF/1gpFxVcpC6b6KuWLQ
         zF9g==
X-Gm-Message-State: ANoB5pnAUdYWdsy0IBJfSnnD4X9A4E6hbv7VqwGiuUY3X0jePiEsjJLs
        5x3Dyjfhc6gJPcre4uQ240s=
X-Google-Smtp-Source: AA0mqf5nyYVdMtOih7vT3trcOoiAr6JmT7LlpmWa+6UtlTL//h1Ex10aesZJ5FcZIiktWEWt7MviOA==
X-Received: by 2002:aca:d0f:0:b0:35a:2c2c:9a37 with SMTP id 15-20020aca0d0f000000b0035a2c2c9a37mr18113710oin.79.1669676960456;
        Mon, 28 Nov 2022 15:09:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 68-20020a4a1d47000000b0049fd73ccf72sm4791675oog.42.2022.11.28.15.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 15:09:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bda19726-74f3-b76d-c30c-eb2543979690@roeck-us.net>
Date:   Mon, 28 Nov 2022 15:09:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] hwmon: (pmbus/core): Implement irq support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
 <20221128174715.1969957-3-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221128174715.1969957-3-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 09:47, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler to notify regulator events.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

As I am sure I have mentioned before, this needs to primarily handle
sysfs notifications to hwmon status attributes and to generate kobject
events. Regulator events are secondary / optional.

Thanks,
Guenter

