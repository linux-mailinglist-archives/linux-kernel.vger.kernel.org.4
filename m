Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355556099FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJXFqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJXFqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:46:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8938219C31
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:45:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y16so3957651wrt.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsOVnHocupjow06h4aYGVD+YUccfa4nu40a5vDm5gb8=;
        b=Xllt/M3nsdNbj4L24wmJToogLeTeIdK7sExQTjqdz3RllhlOHP0ff+0id8g30093up
         FxVRTqYEYo74l8+JZD7J9YgN7AlRzcgT5RDAkAVtmJp7kbeBtK0a0XI9ucmP7HSh8ZJd
         KEv/5kR8s3Abuxbo2BrvRy/lpu8mhKt5jOgZJxcZr0Uim7yXC6flzlORbIGw+IOS0Y8i
         gGxcHhh9dyxHbN45fuZPc+lsgIReywD84JFM4llGyQNEP7adDWpOnADiLjZIEUNbOkUJ
         e/yGHEkVhlfZ3oZDmZxouAGlliOp8QeY56bE8MmF5vmiylCldGKQO3FctpGQLoiJFYma
         16+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsOVnHocupjow06h4aYGVD+YUccfa4nu40a5vDm5gb8=;
        b=WAunaETooqZn+2QA2r+uQGQ6CkymhLJ9jXJBBp15SHRC9IbgpYV7diqwW/n2XFUyvZ
         FGgk6E1u9jElS9tbvmojQj7FARWekpLyj6/P2+L/zuCAiyL5uZhaQuB2DaDPhXZJKcXs
         K3rpDFFx0LRo+p7HWzI9YG6wL3vEBisFyxc8bAaEcgGvTAw3rHhqrdJeHXA1NiQLKMW2
         wlIZtA4QIHdWJn8spUgvnYkd6hR3ElgNXB77+ADe2EbbOdsRjcEbu6J6Zgn4Y7FaGUxG
         DqEqBpfrAPVX0qoLNQwLf9W0gJPliFKrSHS0kj96adRq5k+6avcvzU1GkUNMWH9i4EY+
         Gr1w==
X-Gm-Message-State: ACrzQf1d0zPrvMAuDGrsA7BH2laquCqYDKex3+hDbsvKmcqGmLxoc3w1
        JPfLc+8JeiZuxoLlw3MzO7s=
X-Google-Smtp-Source: AMsMyM6axIKc+z5+wGkyXMZMMiUzQ/GVEkDxkSBT3QXb+PGfzjHjUhElQ5lE2vkfq2bCMwiAf90nmg==
X-Received: by 2002:adf:f609:0:b0:236:680b:8c65 with SMTP id t9-20020adff609000000b00236680b8c65mr4678943wrp.615.1666590358040;
        Sun, 23 Oct 2022 22:45:58 -0700 (PDT)
Received: from [192.168.1.101] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id s15-20020adfeb0f000000b0022cdeba3f83sm24811600wrn.84.2022.10.23.22.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 22:45:57 -0700 (PDT)
Message-ID: <e4dae7d6-9e12-247c-ac17-f35226a8c600@gmail.com>
Date:   Mon, 24 Oct 2022 07:45:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] staging: rtl8192e: rtl819x_HTProc: code cleanup
 patches on the rtl8192x_HTProc.c file.
Content-Language: en-US
To:     Aaron Lawrence <t4rmin@zohomail.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1666502177.git.t4rmin@zohomail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1666502177.git.t4rmin@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 11:40, Aaron Lawrence wrote:
> Multiple patches regarding the cleanup of code in the rtl819x_HTProc.c
> file according to the checkpatch script aside from the CamelCase issues.
> 
> Fixed patchset email format in v2.
> 
> Aaron Lawrence (3):
>    Staging: rtl8192e: rtl819x_HTProc: fixed missing blank space
>    Staging: rtl8192e: rtl819x_HTProc: fixed alignment matching open
>      parenthesis
>    Staging: rtl8192e: rtl819x_HTProc: fixed unnecessary parentheses
> 
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 38 ++++++++++++-----------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
