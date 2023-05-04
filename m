Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30946F6F58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjEDPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjEDPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:46:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926C9524B;
        Thu,  4 May 2023 08:45:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso765712e87.0;
        Thu, 04 May 2023 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215144; x=1685807144;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql1gN5dWihOw+5TG6T+xMv/WIiRQPBQvtcPm6Ww/rps=;
        b=d3bK4XKUJCbgcrB3Yoi5kYDf+89GfASZw2C9SbctmLIm0SWQiPXUH2QsyPOUtoHx/O
         PjziLZB0Bz80u+3FgZedbgDucGHAMU3tNXWxBEfxn3EhBGzw1xaLcVNr+e47kvMnz1Bo
         pGganRv+NE9ANk4iGdKfzjVbNmg3EgHr/KNKg0uJYYIcfl8N6JOB0G9AHRGmYVE+R4qk
         AD/ImzUOvGdUK7OuMaEo0q8X0jFewalsBj7Tk0GzL2KV8aGagsh58sNhhsVOiurEeVOF
         DD4SEHng7WxMZDdNgFIU7wTqUZd2u9Js/jB4diJJKVxH5RQpAS7W6Ts5t0vddw2GYZs+
         dtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215144; x=1685807144;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql1gN5dWihOw+5TG6T+xMv/WIiRQPBQvtcPm6Ww/rps=;
        b=RfM+nURdWqj5pDanm1cKJYD9tFF3nmnsUCGkxXlcIMDZwFhPMuMm3jIyplIRd45qEf
         N4ovRu9L/y/rn7euO5feYHCVvIaJaNg3iYFWIgpTL2q8yLnqMYE7xKGSFUdG5/QBk3fs
         ic/nRcsiHQle/sKgANm6TSNHP8ATTENiS3q/JukiNfg8n3+OC2JsTt4t4shlFAX0wfNv
         OWobXzsOMIXaR8isBjJ3N2qwEfh53CbzlO15VW0ytCtfwNJw9QtJe60pNcFnkN5a1S+f
         iRBUQwB7wiK7GrL6ef/6qad9uRr5A65f//gSI56EWgx4XNVHYzgU+cXgSWROk8dAX8ip
         v92Q==
X-Gm-Message-State: AC+VfDzJSWOKdZ7Yh5FxDNNTJWGp9ho/7VYRh/b2Fcs6ytXR97Kgm4bY
        mgI/mvAjZfLXL7P8cR+n4WT0io3cO2s=
X-Google-Smtp-Source: ACHHUZ4n3Q8F3ksvB5Ml8d+DnxqnFXgfiZYHqWAyHmrLx+8x04Ze/owDUC9uaUe5b8z1qM3ZzHGOPQ==
X-Received: by 2002:ac2:5455:0:b0:4ef:e942:b599 with SMTP id d21-20020ac25455000000b004efe942b599mr1977955lfn.68.1683215144472;
        Thu, 04 May 2023 08:45:44 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.84.204])
        by smtp.gmail.com with ESMTPSA id w14-20020ac25d4e000000b004eed8de597csm6543605lfd.32.2023.05.04.08.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:45:44 -0700 (PDT)
Subject: Re: [PATCH v5] usb: dwc3: core: add support for realtek SoCs custom's
 global register start address
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504034423.20813-1-stanley_chang@realtek.com>
 <96706396-7023-b895-169a-788aad11adcb@gmail.com>
 <44451716afa541e298b2e5640fe3aec9@realtek.com>
 <747ce0a9-a629-e3f9-c59c-388333d3d911@gmail.com>
 <59143dd6704540eda26b56a1ecf350e4@realtek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ed78530f-55b2-9152-976c-d13cf19407ad@gmail.com>
Date:   Thu, 4 May 2023 18:45:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <59143dd6704540eda26b56a1ecf350e4@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 11:36 AM, Stanley Chang[昌育德] wrote:

>>> I can't understand your meaning.
>>> Do you mean I can't use rtd1xxx ?
>>
>>    You can't, indeed.
>>
> The namr rtd1xxx is represent the name of SoCs, for rtd129x, rtd139x, rtd16xx, ... etc.
> 
> Must I use a real chip name, example rtd129x?

   Yes but iff x is not also a wildcard. rtd1290 would fit iff that SoC actually exists.

> Or can I use "rtd" only to represent all Socs?

   If you have a fallback value of the "compatible" prop, you can use it...

MBR, Sergey
