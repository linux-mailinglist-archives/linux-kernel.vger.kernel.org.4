Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9706E173B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDMWRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDMWRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:17:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D882B6A5A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:17:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f4d0fc8df4so182479f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681424248; x=1684016248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bZnn8054aG3h8CA+Zz1uBde378B1drLJz8iS5ab/Aw=;
        b=hBje9yK2+SX3bOttkXIzpp/K0mnsn4jtaaxMMXugNhRwvC5szwkr61hM7XshL99FYl
         s1+XfZrxgsbe0lRubiPaWIyVR/0xDG6BJcyrIP2c3dSvBPBLBUlFqCIcQmHsDBCWSYNE
         pWcwEVzEWxj8ozsmTd5HK0gIp9KtUbpIumquach+JBH/LGxEv+W9vEZzrLSJ+xl0p0l7
         P2y9TiGU/Q1jmYDMTvZnFB+huqAgtAk/ibT9gij+GKcuhuse6Qu9CEmQC/cTuWBgthTA
         LKeIdP1mJpoj9qhKVxRDQuhPR296JgevtqP+g3fV7+mEHljHFFJ0A+SgaNu9PORDwbp0
         upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424248; x=1684016248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bZnn8054aG3h8CA+Zz1uBde378B1drLJz8iS5ab/Aw=;
        b=Lw7UvYtRIpmlyDFRJPnKLCRvx9PjmMFX8xxLTurEPbGvpgJh5veVmhjB9cdiOKh8oI
         0BQ2mW4oUomivSxqAFVtQ78ztWW0bvGC7bCfIJBm4Sremo6jl+8v82yjOARyU/gongRR
         wfXxpd8abWocvb3kxtiB/6wdBiNeSjfNs0TwKSPVxBj8MN8+DKKg5cUY+4PcWi52Ht6w
         covBdusUncFP51o7gxEqsXTRH0acX3QnTaynA3EDVwBXoG0q1NYBbN7xdm7uxsHtYgDB
         tD36TR6fkha25w3QerfjhuMxKiK4FMSfbdHZDyWmMNJmDSkCEBBNo70qz/8fZNQAKVR9
         Gr+A==
X-Gm-Message-State: AAQBX9eEYrMUbMSAiEX+b/aythh687XkDJQVDTMvk1Zq4P0MSv1YFEy0
        wepN9ZjbYsiZEqZvSu6ap6E=
X-Google-Smtp-Source: AKy350ZB3ZtVsMxXN4uA54BlmCPeTcGuCXD8pjBkkfMzJJrcSVIAuNQ4LnuNeoFv0g5wsoRMbrSjRg==
X-Received: by 2002:adf:e546:0:b0:2c7:940c:26f8 with SMTP id z6-20020adfe546000000b002c7940c26f8mr175096wrm.5.1681424248276;
        Thu, 13 Apr 2023 15:17:28 -0700 (PDT)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id z1-20020a056000110100b002efb5ef9f07sm2124516wrw.82.2023.04.13.15.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 15:17:27 -0700 (PDT)
Message-ID: <5f2275ce-c62d-9363-32ad-58b25848119c@gmail.com>
Date:   Fri, 14 Apr 2023 00:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUG] staging: rtl8192e: W_DISABLE# does not work after
 stop/start
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
 <248ec330-b4c3-aa7b-61eb-69ce8d333b69@gmail.com>
 <3f71b782-e52e-48cb-9a41-4097a3329ae3@kili.mountain>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <3f71b782-e52e-48cb-9a41-4097a3329ae3@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 11:34, Dan Carpenter wrote:
> On Fri, Apr 07, 2023 at 11:02:05PM +0200, Philipp Hortmann wrote:
>> When loading the driver for rtl8192e, the W_DISABLE# switch is working as
>> intended. But when the WLAN is turned off in software and then turned on
>> again the W_DISABLE# does not work anymore.
>>
>> Reason for this is that in the function _rtl92e_dm_check_rf_ctrl_gpio()
>> checking this every two seconds is an conditional return.
>>
>> 	if (priv->bfirst_after_down) {
>> 		priv->bfirst_after_down = true; // PH: useless line
>> 		return;
>> 	}
>>
>> 	tmp1byte = rtl92e_readb(dev, GPI); // PH: GPI for W_DISABLE#
>>
>> bfirst_after_down is set true when switching the WLAN off in software. But
>> it is not set to false again when WLAN is turned on again.
>>
> 
> Is there a question here?  You're like the expert on this driver and you
> seem to have figured out the solution...  I'm confused.
For me a bug report is always a please to the community to fix. But when 
nobody likes to start I have to do it by myself...
> 
> regards,
> dan carpenter
> 

As expected I am not even on the half way. I can set the 
bfirst_after_down back to false. Then WLAN recovers but not the 
connection. The os is asking me to enter the WLAN password. I can do so 
but that does not fix the issue. I need to switch WLAN off and on in 
software. Then the connection comes back again.

I need to find a way to reset the internal states of the driver accordingly.

Thanks for your support.

No response required - will work on the fix on the weekend....

regards,

Philipp

