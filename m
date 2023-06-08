Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3539A72804C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjFHMnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFHMnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:43:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCA26B3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:43:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94ea38c90ccso15508966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686228216; x=1688820216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kF14myJ9coZ4lMq/FbV5XcnhvclWxzYZwqJzREvQWY=;
        b=WKkEy3Q4+ewVvNCmCIvX6aT5c3OVhyIXQz9HE+qi+rUrQwcSqx+AuMHmCu8wVkupcu
         2jqaH0XBQuD67KubFyPpnCFIp+EYLfKy0OfFuE0Xhwf3mDQocLcx9aEzsu/58Yc/lkz/
         vhnrLU85DQlSxlLkFL/KRVRuLbpcW6zM4K/HZb7/qtNf2nLceu2wivUT8C7v3gQroWeQ
         0P1r7sCa3v5Oee5buRIWWmlmhPCTMfKqzL0p55iq19vqbNHuV/yximZDrkAliL0h/EZQ
         lzbJH4k149D3I12R8+q7+OROC10vmMwQWyNbSXT1upnp+53m6r6RdvPxokuLqvTgjPO1
         QM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228216; x=1688820216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kF14myJ9coZ4lMq/FbV5XcnhvclWxzYZwqJzREvQWY=;
        b=iWK8HuJz2GIpSijP3vW9xPS3G1vGscy316en7GaLh95Bk6dWEGJw42OD16eGOw+3UO
         IWHQ+OX3ApX5CKbCjoHQpjlTR2nVK+hDdRe4012j16hwxnNzpVTPCWtaB6FbTgp456L0
         KKWBBSybVmYO9IhDzurgPTmECTLNeDuRRewon4poOy6jXPWzJB61FriO7Y+HCnP2OylO
         pGJSqXceG4r4N5ije4UCWMYuurZM+ZPFqYY6nPWQ3kvfJgsGWbh0L81kMCY5K2xVUQBB
         1kIfR1VkHgwUcA8/Z+Y0KuZP2oIBOQO/k39KwxaNAXciYxaE/yN9c6jTbIi4HJyIOnMY
         cC0w==
X-Gm-Message-State: AC+VfDyd62Iz82o+M589Ycn78uHMQwxc40/3QFwS2Y0j/g1dbvsSSckH
        xIH+7lqtotb4rf/OBl5r3Mc=
X-Google-Smtp-Source: ACHHUZ52cbzXPOGxsnd9kqnQxzY/ckFBG6Q9SQKeEbtINPN+3gclg7J/BnPytMoAdBRnwdumtUmkug==
X-Received: by 2002:a17:906:51d3:b0:977:eabf:c103 with SMTP id v19-20020a17090651d300b00977eabfc103mr4943959ejk.5.1686228216172;
        Thu, 08 Jun 2023 05:43:36 -0700 (PDT)
Received: from [192.168.0.105] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b00977d0f1c5bcsm647234ejc.69.2023.06.08.05.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 05:43:35 -0700 (PDT)
Message-ID: <b0480060-a7df-255a-4965-a48dac793960@gmail.com>
Date:   Thu, 8 Jun 2023 14:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
Content-Language: en-US
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1686149467.git.yogi.kernel@gmail.com>
 <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
 <01a162c5-f0de-47b1-97e7-8a451a89df80@kadam.mountain>
 <90813181-02a1-b54f-132b-c68e7b797bb6@gmail.com>
 <20230608095938.GA598514@yogi-Zephyrus>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230608095938.GA598514@yogi-Zephyrus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 11:59, Yogesh Hegde wrote:
> On Wed, Jun 07, 2023 at 10:18:28PM +0200, Philipp Hortmann wrote:
>> My compiler does not compile this patch:
>>    LD [M]  drivers/staging/rtl8192e/rtl8192e/r8192e_pci.o
>>    MODPOST drivers/staging/rtl8192e/Module.symvers
>> ERROR: modpost: "rtl92e_set_wireless_mode"
>> [drivers/staging/rtl8192e/rtllib.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:136:
>> drivers/staging/rtl8192e/Module.symvers] Error 1
>> make: *** [Makefile:1978: modpost] Error 2
>>
>> Did this compile on your system Yogesh?
> No, while sending the patch I partially compiled it
> `make drivers/staging/rtl8192e` but when I fully compile it `make all` it gives
> me the same error. It is a mistake on my part.
To build one module you need to use:
make -C . M=drivers/staging/rtl8192e

> 
>> But I think it does not work because this driver is divided into two
>> modules.
>>
>> To load the driver I am using the following lines:
>> sudo insmod drivers/staging/rtl8192e/rtllib.ko
>> sudo insmod drivers/staging/rtl8192e/rtl8192e/r8192e_pci.ko
> I was not aware of this and assumed that ideally the driver has only one (PCI)
> interface so all the files should be compiled into one `.ko` file and loaded.
> 
>> So this line is required:
>> priv->rtllib->SetWirelessMode = rtl92e_set_wireless_mode;
>> as one name is used in one module and one in the other module.
> Yes, this makes sense now.
> 
> Moving forward,
> Dan, Greg and Philipp what would be the best fix for this issue,
> 1.  Patchset to combine both the modules into one module
I had a look for this and it was not difficult at all to combine. But a 
patch long ago divided the two modules, to make it more like the driver 
this one should be merged to, in the wireless subsystem. Please see TODO 
file.

> 2.  Revert back this patchset to v1.
> 
> Looking forward for your response.
> 
> Regards
> Yogesh

Bye Philipp
