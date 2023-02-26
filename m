Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B56A347C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBZWO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBZWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:14:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02158CC14
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:14:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l25so4375016wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9LDfmpxLF7vyo0GaqvxWDbH5DEQ/yPbcVvYtKz93Ik=;
        b=Bv5oT2BRzb9KaSfbFATSE6cOZiBB9jhbUQzi8hvOSSnXx0Mot1CwWOBHEFHB3/6vUL
         bT7FqCYaYqTnMcHz0IfF7ySVczaXq6/iz/F6JVM4ynNTN21MjLqO4sdgBX/6cRmU+hxl
         0d5QSXjP0QDH2vdfjduaa0bVxzHF5KGCEDh9NiDx8XFNdPReeVNkw5ox+DBl67VP7ABa
         QG/g8I7ChydZwEddjdLwzwgSy2t3f44aVUWC8DFdC+cJZua76Evb8vm+o5tYiVkPZEFk
         1GjuHEG3MK3J18uEwSUl/gZLm/3sTHZn2GH10QgfTjbdXCujEdo59UQcvMO+Dtv9aOPd
         wkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9LDfmpxLF7vyo0GaqvxWDbH5DEQ/yPbcVvYtKz93Ik=;
        b=H+jMSqqw7TI3TSir0sI4Bg8ZWKszbw3LsfkogxPAVteE0Kei7jVjQRQb+74wUxeQ4w
         qvT0FFqrGfKxZtFPv1iS4eLb9XaUw0Zo+LHQAz5nTsCRhILhads4cQBPsNpD3qGrufuf
         1x5tdsNL2NyGl4dFS2QMaVyxaIEeQ/Pzx3IgNh1H+BP7vrBHST68J5ycB9X2F7gOJ88F
         xNc/aXSI8wUNTsxqwTO+56BWbm0rIHMZJHRUwpo25F0+SDV6b3TvyvgUFIghHVoeJy7R
         YfLEMyW8X8vmAoUmbNlsf6dkI8+SJ8BErX48T5vooXe7dJW2FzcytJRplpy7N/KAYGXO
         K4hQ==
X-Gm-Message-State: AO0yUKXYvSbbFaRD+JmwiE/t4NtTsHAQ8kZ3G5oUW1E3MTCOlNRIg3d7
        XCVI4dDy2g3StYY+AzSH8StAGw==
X-Google-Smtp-Source: AK7set/0jOhwt4UZjZr+Aphs9Yb+xJh9rAB1AGcEcFvC6dVR/0RCluyRg6ELo5b5O36QEO/1d5QCMQ==
X-Received: by 2002:a5d:6b85:0:b0:2c7:3ee7:a44c with SMTP id n5-20020a5d6b85000000b002c73ee7a44cmr6551781wrx.65.1677449661517;
        Sun, 26 Feb 2023 14:14:21 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5309000000b002c70d269b4esm5302176wrv.91.2023.02.26.14.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 14:14:21 -0800 (PST)
Message-ID: <d6e3ec43-895c-6768-14cf-6ebd1fd83d65@linaro.org>
Date:   Sun, 26 Feb 2023 23:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 07/27] kbuild, MIPS: BCM47XX: remove MODULE_LICENSE in
 non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-8-nick.alcock@oracle.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230222121453.91915-8-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/2/23 13:14, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: "Rafał Miłecki" <zajec5@gmail.com>
> Cc: linux-mips@vger.kernel.org
> ---
>   drivers/firmware/broadcom/bcm47xx_nvram.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


