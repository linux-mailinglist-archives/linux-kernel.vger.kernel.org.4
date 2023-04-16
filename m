Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE56E3548
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 07:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDPFzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 01:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:55:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862B2D52
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 22:55:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f0769b0699so4454815e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 22:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681624534; x=1684216534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QCSqWDW+qJYJwIe/lPu0QIUfnGCKktR+2GZI90qNM8M=;
        b=Ch79Xe6mcOjCx/3/DfF1n8lf7h00E09ao9g3jmzY66+EZwSvKIzWV5nX3bTxXLOCMz
         ULIejoKYbV7JnfZLcKQltZsV4x690NMO+bp3z5BtnxZVJcV1DAKSj2c237pnnIK8OklT
         r/FRdGh/EOft7qPAfHtlt2Ui1UiistF5ml6qHDxYgdeD+g3ZOZz47Noasx9SmHr+2On/
         JIJzNU04Qf7pjFfUxjnXyO/9cUs7ZUVsDqDsSo3aZc2U9SV1AUx/+jvVVF1RtdKJS+07
         Y/1BMEvAdKIYvbEAXvqE3bhHhhljCHGY7g48KLdoS8xqqMTogFajIUm41h09QJhfrWk0
         x8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681624534; x=1684216534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCSqWDW+qJYJwIe/lPu0QIUfnGCKktR+2GZI90qNM8M=;
        b=Awl6peGaYpOXUQF6Qgm1DoHdn1NNXL4QH5Jq9E+RHx0Wlznqv2z/cgqL771egjTpEf
         c63xJuDDTJIXlkJY20vyc53hhtYwxmIhVZMfhCEtQ7PgChdfiZTPgi6HKCRk+jB6psVv
         8Un5/8OdMOJH6UVX0B7xUKob2zYDMjSbxxrPqupBcPjgop4pZhJP+ujkcVICUAAEs9ha
         gdwOidT39exXPoskEw44oEq/euvY25ADASf52HA5TjU3rBgP7BHsbKCdDlIMyJVlSyKr
         ns4Nip/Jq3uzE2QMsFiD2J/PTqFhf2rpCtjU0lt90vyphIN7qmMQGVMFpKlsmGRQC1vj
         EOJg==
X-Gm-Message-State: AAQBX9f4bRh4KKfCrFSig8NlcXkhuqS8Hsc7uHY/u3om9mIB41M55Rbp
        +VUj+SLp6jE25KwAIAJce18=
X-Google-Smtp-Source: AKy350aKqPcuBbL60uRffrNjEK7HJFtXzv2BNSXJcFsCjwI17kNXcNfYLrD09YCR2hohWko3yPbniA==
X-Received: by 2002:a05:600c:3ca0:b0:3f0:a845:f215 with SMTP id bg32-20020a05600c3ca000b003f0a845f215mr5228353wmb.3.1681624534454;
        Sat, 15 Apr 2023 22:55:34 -0700 (PDT)
Received: from [192.168.0.105] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003f172ec4022sm370187wmj.18.2023.04.15.22.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 22:55:33 -0700 (PDT)
Message-ID: <18cc3a02-dd57-787f-4c99-cbae259e838d@gmail.com>
Date:   Sun, 16 Apr 2023 07:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: [PATCH] staging: rtl8192e: Fix W_DISABLE# does not work after
 stop/start
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230414183452.GA12295@matrix-ESPRIMO-P710>
 <2023041515-overhung-grime-d9fc@gregkh>
Content-Language: en-US
In-Reply-To: <2023041515-overhung-grime-d9fc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/23 18:02, Greg Kroah-Hartman wrote:
> On Fri, Apr 14, 2023 at 08:34:52PM +0200, Philipp Hortmann wrote:
>> When loading the driver for rtl8192e, the W_DISABLE# switch is working as
>> intended. But when the WLAN is turned off in software and then turned on
>> again the W_DISABLE# does not work anymore. Reason for this is that in
>> the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
>> checked and returned when true. bfirst_after_down is set true when
>> switching the WLAN off in software. But it is not set to false again
>> when WLAN is turned on again.
>>
>> Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
>> above described bug.
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>> Tested with rtl8192e (WLL6130-D99)
>> Transferred this patch over wlan connection of rtl8192e
>> ---
>>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> 
> What commit id does this fix?
To me the driver was introduced in V3.2 and the issue did not change up 
to now. Have a look at:
https://elixir.bootlin.com/linux/v3.2-rc1/A/ident/bfirst_after_down
https://elixir.bootlin.com/linux/v6.2.11/A/ident/bfirst_after_down

 > Should it go to the stable kernels?  If
> so, how far back?
The second issue that is related to the W_DISABLE# signal is that the 
connection is not reestablished when the signal is released. I need more 
time to fix this issue. When I have fixed both we could backport them.
> 
> thanks,
> 
> greg k-h

thanks,

Philipp
