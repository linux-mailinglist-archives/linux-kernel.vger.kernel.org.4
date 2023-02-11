Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE08969331B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBKSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBKSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:54:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E04193EE;
        Sat, 11 Feb 2023 10:54:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cq19so5423448edb.5;
        Sat, 11 Feb 2023 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQilzVYvGI9FErjP5374cx23YQpTQrZLFOEiYvclZpg=;
        b=EW8Ig6xfjGwrXgjurd+dwrxjBE8obvY6P/pLIzwDJfCBhZCKEaHPHYdPl0g/Lrikl4
         1XwdixE/Zjb7BHJp5tehvK6Tx2GiMjmHn5ltazzbVU3wfVOt2cgfh2tUzTYLknMwhZvz
         r23lUPe7HcY3CY8kZYUnEbUzlX50givr6h20zOiTLszJtUnabrFtOjC3k1CfIg0cen6Z
         h9MFrUHgtTYlmQktMZ88H5qfllHST9QzsYnL2g+ZGZN07TXDjYwI8gVoUZuH33gQQWi+
         7BFYwCvOAbaj83bYotI6EssvCUTb4V5CX3POLt0sZLIdQNgMUxeMRSieWLce40dwKxGB
         lDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQilzVYvGI9FErjP5374cx23YQpTQrZLFOEiYvclZpg=;
        b=v6smk3hP9LvclqeMR41gzuT8j89XEMNH0pV+F8+Pjs4pmZjQ0bCUmOhl27MwXS2mIZ
         3p0Bc2AcSjZxe97m8xvOq4IjawnjV+pQ3HGOL6225MFeCt14RQCcOmb1brBoBn5rst+u
         AbVsyXt1gv/xwFKOSMY4dGDiHYtMs3X603zoEtpMFsLOJ6gfDjWUUCtsGyeYvqtcCVjP
         ZxBxrT0/v0lygGyqXeWuYeBtK1EoSunNqGMf410kdWiS6vjrTRE5rY+5HDy6Z+3sMt/l
         F+mUn02h7OoCL/JN/M8WdOmQhspvTdJNTfi3oty2cC4adVOD9mP5oqfPlTcV13BT9ehU
         0xIQ==
X-Gm-Message-State: AO0yUKWOuLf+wVbXxLQ+EsffUiixTdWek8k1Z4pG2brxp+bitV/leSnu
        VWG+e4H2Vwvz4ImDLbmDQqI=
X-Google-Smtp-Source: AK7set94rpGvGlXmQuz0W6b4tXTpKCBBYMNLk5z2yIdqtfLeBWaBMud6rjJFCtzg2tAegUrAAlDSwA==
X-Received: by 2002:a50:d756:0:b0:4ac:b7ba:3d58 with SMTP id i22-20020a50d756000000b004acb7ba3d58mr2401860edj.12.1676141647232;
        Sat, 11 Feb 2023 10:54:07 -0800 (PST)
Received: from [192.168.0.22] ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id o8-20020a50c908000000b004a2666397casm4006188edh.63.2023.02.11.10.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 10:54:06 -0800 (PST)
Message-ID: <00875064-0407-b114-56c9-87aecb0d3ee4@gmail.com>
Date:   Sat, 11 Feb 2023 19:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     savicaleksa83@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] hwmon: (aquacomputer_d5next) Add temperature offset
 control for Aquaero
To:     Guenter Roeck <linux@roeck-us.net>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-hwmon@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-4-leonard.anderweit@gmail.com>
 <0664b935-d201-419a-3f1d-3df4226a8db1@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <0664b935-d201-419a-3f1d-3df4226a8db1@roeck-us.net>
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

On 2023-02-11 19:08:27 GMT+01:00, Guenter Roeck wrote:
> 
> aquaero is already supported, and the checksum is so far generated
> and sent. Is it ignored ? Also, is it guaranteed that _all_ aquero devices
> don't need it ?

Reading its sensors is currently supported, not writing to it (before these
patches).

The checksum is ignored and not needed for either aquaero 5 (which Leonard has)
nor 6 (which I have).

> 
> If it is not needed and ignored, does it really add value to selectively drop it ?

I think we can indeed remove that check.

Thanks,
Aleksa

> 
> Either case, this change is not mentioned in the commit log, and it
> violates the "one logical change per patch" rule. Please split it into
> a separate patch and explain why the change is needed.
> 
> Another change to separate is the introduction of ctrl_report_id
> and the secondary_ctrl_report variables, which is also done silently
> and not explained. That should also be a separate patch to simplify
> review.
> 
> Thanks,
> Guenter

