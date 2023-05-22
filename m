Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251E870B2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjEVB6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:58:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC38B3;
        Sun, 21 May 2023 18:58:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39815ce6db2so60062b6e.0;
        Sun, 21 May 2023 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684720684; x=1687312684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w53tuVYkQ3NIiwF4ysenFUwUX//u9UgrVqJVmePRgAc=;
        b=qFBV+uZmMh3f+CsK3DX+2aomi8ao8R83J94o4UuOTgtSN73Vmq+QoMqzNlNUGAH9GJ
         894clhKA5Dkb3tENP0raG1YIh+RPcaBqD3AKD+sXYS0hP68Su87ACfRqLyCPXkN9GX+4
         nK7eKDGsT0yxJ2HX8oiAa4fD5vB9hZFOC/kzllnAjwJHUc0P5kGW4TNYIr2suHCOBGuD
         pE+5Zek9CQ6EjH5P827dnx74dIDFvn8/OqmK/7WXxI4rLDbuJfkxiRY2sRGoMKWq8FSN
         2Dh/AbuJUtKRdk2BGx5o2VVX/f0ftudF9VIOcLNTUL0YLmO6ziCmh6l4L47lvapQ117A
         HKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684720684; x=1687312684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w53tuVYkQ3NIiwF4ysenFUwUX//u9UgrVqJVmePRgAc=;
        b=Wvlyg5tLSco7vbYyZ1vHP5bZgna309nTecfG6BNrbjs6XtrDheq7oXHfOSkWEBXGls
         ANVQWxSj+Fc1ObDY9ciNSG51rVhBOZGw+eSRnkpK+VT67t2PFFj1+Sy/wCKjB7HCN/Td
         Aa4f10tmSlUBpeGCAwu9dJ0WrL8DQMJNI02EqU+GXdVQFt6iujwETAmdBXQH7HRLz5J7
         /xVRxfJnWY7piDeUJhA0uRHoSDGLEKHCyXubXRzyKWRe07AbPUNq1KYhXnC7Ks7r9zQD
         1+p6Yq582lUcsOvwPYh7cm0X88MCNQ+mbQ7pCtY2x4zVVJETPOeR14nJu+enMGvLUJib
         9DAA==
X-Gm-Message-State: AC+VfDxOk/QNAemJH60qqGsdKZMBNqpKDgEa4z1CDlFGBfKz+El9wmNp
        W2XEea9KH91+5DFH00MQc0c=
X-Google-Smtp-Source: ACHHUZ7S1THM9p1SfxTUWfP3RrYTRHSUgpxGTHaJCQ2ZfkwYTSFXSa849IoFn0pdU20IV7xd3pRr+w==
X-Received: by 2002:aca:1e04:0:b0:394:4890:1421 with SMTP id m4-20020aca1e04000000b0039448901421mr5095174oic.8.1684720683790;
        Sun, 21 May 2023 18:58:03 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w81-20020acadf54000000b00398031b1014sm976545oig.26.2023.05.21.18.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 18:58:03 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <88e0c4a3-eec7-e44d-6f95-6f2e7f7cbbb5@lwfinger.net>
Date:   Sun, 21 May 2023 20:58:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the
 SDIO based RTL8723DS chipset
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
 <20230518161749.1311949-5-martin.blumenstingl@googlemail.com>
 <c52c11c712e24e1fb783c2ce1251aba5@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <c52c11c712e24e1fb783c2ce1251aba5@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/23 20:49, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Sent: Friday, May 19, 2023 12:18 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; ulf.hansson@linaro.org; kvalo@kernel.org;
>> tony0620emma@gmail.com; Peter Robinson <pbrobinson@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>;
>> jernej.skrabec@gmail.com; Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Subject: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
>>
>> Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as well
>> as the existing RTL8723D chipset code.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> I'm so surprised that this small patchset can support an new chip. Nice job. :-)
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

I agree that this is a nice job. This driver has been tested using my rtw88 repo 
at GitHub.com. I do not have a device, thus a tested=by tag would not be 
appropriate, but I do have a very satisfied user!

Larry


