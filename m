Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7766D38EB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDBQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:00:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DDBBB9C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 09:00:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so108164322edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680451205; x=1683043205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6lbVzylHSD1bkwqF+EEh8vp3rCF+fULXBoCye8hbUI=;
        b=oT3hW/sIwwMuZlR7SThF3UUX3oUtfKDo9uiBq3hqWEZJ8TBfOfLq4pkxl1obxYQDBI
         OseLrkQA/pUcaiPM/nwn2FK5a9AxbTkcy63hrcdQa7Kw1AeLpZ0h+RlQtbbnt2b5Tshm
         WGbIeWLGsu/cI0O9EJ6xM//TLbCcWXFMpMvNBjwiw1rpVk7LEroXiZZX5Ku22aO0Fxcc
         HBLdPlkuraleN0fC0khsQ+yblRFJqoDaJ0XSwORO4R9zIXSQA5a6YlnLYT+k7dGh9Kd9
         mgbkZBTw/xJh+nmoPozDal+wl/zqzDY5vAMvRh+O3rUiLjQX0ChfGKWsgcPis8XfzC1L
         OvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680451205; x=1683043205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6lbVzylHSD1bkwqF+EEh8vp3rCF+fULXBoCye8hbUI=;
        b=bRTYWI/fPHLB8XICcLd0l/2QVODFF83JZNZISOitAYD7g3qV+9TdlTv/qA2Tkl31Kv
         Bl/tGKwiGIZZTNjTy4u4oZ2UU0sWeDm/wkN9nCiLWCp8T9CwogZk72J3xcekEyLJt/dh
         u61hbetGTIgIjxNY52zKkLOKo7zq5repW4BCx40bRC8HzGOiuFS/iPPtUdoidCOolsQz
         KY5tLv3zAfmzZwA5nax4nfEiDxBcF2JEx0tkLzl2X+1+3JPkt6Bf/sdpaABmaFdLenCN
         hiWg06RCYbGuvqm2B/l6pRPU11MolWscCcpYVtGTNhht3Q5Ogy6FoXYX28WX1mhEbSSr
         1xvw==
X-Gm-Message-State: AAQBX9cuckAwQTp01m2aAf9MTjU3mPFjzBTZeyoQHQGcvo5XNTHc12BV
        hWawtKRxn6LWQdeCmJbzjyuelJJrdB0=
X-Google-Smtp-Source: AKy350brr9ZcZTZfYr38J1LydLHUvz8vf6PleV3OLbnjTdr5uVSjVgjB/czCAO0bqxm5nTG8iwvmJw==
X-Received: by 2002:a17:906:1c4:b0:931:5145:c51f with SMTP id 4-20020a17090601c400b009315145c51fmr6452359ejj.4.1680451205506;
        Sun, 02 Apr 2023 09:00:05 -0700 (PDT)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709065e4a00b0093dbb008281sm3354798eju.130.2023.04.02.09.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 09:00:04 -0700 (PDT)
Message-ID: <91cc4474-8991-6762-841e-8936d3bb66d2@gmail.com>
Date:   Sun, 2 Apr 2023 18:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/5] staging: rtl8192e: fix checkpatch issues in
 rtllib_crypt_ccmp.c
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1680445545.git.kamrankhadijadj@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1680445545.git.kamrankhadijadj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/23 16:32, Khadija Kamran wrote:
> Fix several issues reported by checkpatch in rtllib_crypt_ccmp.c file.
> 
> Changes in v2:
>   - Update variable_name in PATCH 3, 4 and 5 to dot11rsna_{variable_name}
>   - Remove comment from PATCH 3
> 
> Khadija Kamran (5):
>    staging: rtl8192e: remove extra blank lines in rtllib_crypt_ccmp.c
>    staging: rtl8192e: fix alignment to match open parenthesis
>    staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPFormatErrors>
>    staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPReplays>
>    staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPDecryptErrors>
> 
>   drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 32 +++++++-------------
>   1 file changed, 11 insertions(+), 21 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
