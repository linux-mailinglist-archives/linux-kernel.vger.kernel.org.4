Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DEF729D05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbjFIOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbjFIOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:37:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5753E269A;
        Fri,  9 Jun 2023 07:37:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b246dd3390so8215305ad.2;
        Fri, 09 Jun 2023 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321431; x=1688913431;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWIW6qqJd51uSzlmPSBiiIp+Xswi2pR+42bNT8oGIsQ=;
        b=pxCWtpYRge3pwe27XGgdApJPJ8Iw7aNAl2IqLBDtpki1gj+vpMsBbZMSodkLyRk3Hs
         xwDqhju+KmMxSv5E1OdnS8FuZkPtSqEusAP1yAG3vlV2aOEOq0I4mHEb7gi4em2/mhJ4
         /o+60u3n8p1wSH0I4K3LA1miyRlk0ne/CzkQef5Y6lf1i1uN7WzSB3UU3SaU72hjquvQ
         7c/tB4J65PHAwVTlIxLw769W/YeFB9hHyV8thAAPM/h8CjPI7CTnP5RnM82fVc9C7Tl9
         9kS8U2x5fjIJAxHpdKdxVnYrjZifyVaK2aePVrdjSZ0PFRr7Id2jsV2x3kOCwqBFcfz3
         SVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321431; x=1688913431;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWIW6qqJd51uSzlmPSBiiIp+Xswi2pR+42bNT8oGIsQ=;
        b=D0htRTYbpoUet9vffaus/w2XmBu17YgnUK0UUsneCJ9dpvJSGX4OwiXohwQUMBFXoJ
         fOuazBzVaFWu/+Eb22B7NNIOCp+MeSH4Fhjg7wTLcAtVOml3jLlNLnWm9UixZRz/NyoS
         rRPeIKkYGOcLorg58ewHU8PjlLSnhTbQVUHssGw0bW+aa1go2Rz+rtcTPwgMXC1N4qyx
         NpR5H4CWEFCg+BP1/kmMyZ9fOVRj7TzdzlsE8PG2v/zVix5Quh+TFl0r9ePeHQtrURIE
         QLVjUPDPpFGxLWwdalgk4F/1OqsaccwWhY+1GaoAo2KZn4UllAsV1vUfRNdU3mYhB7fV
         6wlw==
X-Gm-Message-State: AC+VfDz/SNfsuCGHnQCW3TGuyz0WnIe/PxOb/kXr/6PhOfb6KkPJsq2D
        lXaLGCA5r+bwSJG5kzzIE54=
X-Google-Smtp-Source: ACHHUZ5deXOSS0HUy8LZ8fKjZooRMCA/p/ysVl9XgLfbmmifLolNcr7GdZcEMRNdi1IlHXxvnSDiVQ==
X-Received: by 2002:a17:903:120c:b0:1b0:3224:e53a with SMTP id l12-20020a170903120c00b001b03224e53amr1607974plh.20.1686321431215;
        Fri, 09 Jun 2023 07:37:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b001b23eb0b4bbsm3352652plg.147.2023.06.09.07.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:37:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <363c1fc1-5ed7-8a21-a627-58d1338c446f@roeck-us.net>
Date:   Fri, 9 Jun 2023 07:37:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Joaquin Aramendia <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230527012206.133464-1-samsagax@gmail.com>
 <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
 <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com>
 <820cef00-4768-46ae-c5a5-ea7c0dff71c5@roeck-us.net>
 <CABgtM3h0KMsOzZZvYKZLsFXn9A81V59ygSKizoF3TTkraMWr-Q@mail.gmail.com>
 <94f78001-13df-8c39-4771-7842dc94195e@roeck-us.net>
 <CABgtM3iOyCDgDY1gj-gJ4DXaXCY41FKzy-=miz0iiT8ywjbMHg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported
 boards
In-Reply-To: <CABgtM3iOyCDgDY1gj-gJ4DXaXCY41FKzy-=miz0iiT8ywjbMHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 05:50, Joaquin Aramendia wrote:
>> Why don't you just attach the attribute to the platform device as I
>> had suggested earlier ?
> 
> You mean I should do something like this in probe():
> 
> static int oxp_platform_probe(struct platform_device *pdev)
> {
>    ...
> 
> switch (board) {
>      case aok_zoe_a1:
>      case oxp_mini_amd_a07:
>      case oxp_mini_amd_pro:
>          pdev->dev.groups = oxp_ec_groups;
> }
>      hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
>          &oxp_ec_chip_info, NULL);
> ...
> }
> 
> Would that work? Or even be correct?


No, that would not work, because the platform device already exists.
It would have to be added in the init function, or if done in the probe
function it would have to be added to the platform device with an
explicit call to devm_device_add_group().

Guenter

