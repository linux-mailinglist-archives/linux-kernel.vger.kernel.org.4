Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274267098A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjESNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjESNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:47:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED58BF;
        Fri, 19 May 2023 06:46:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso208119b3a.3;
        Fri, 19 May 2023 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684504019; x=1687096019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wx/EigUiLPdkmDFCtrc7s+gWm6j0goDpXSxzDYLHIZg=;
        b=dzTfTmyDFBKejCgCWckgX2Z5PgmIhjznf44wRaca5hLftJt4U9rBrKkgT+qGbDWBEg
         o2lgjjdjCAhzdPGkpQFEl3TO8feFV+5RhpC1nKUexVgdu3do0v9HdXXuDDbaRJT2pOfi
         xWql5xJfPsDY//uJxPDP8WdkVgG1OeBWS4LWsazdm7ugkGLM78NXbblXd5c8veMRkg1Y
         0r9x5ph2qlDFKmVPgNAmIBaE+PSWFs632YOEGbjn9SGZahersSoMztGJ0eOmP2OJNBRr
         rEsKmpfEXbsZvUauwTt5wFWNzE36EmA8iFjUljdu4VNcQkEV9q2BFRi3Um2xrk+0B1Rx
         euaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504019; x=1687096019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx/EigUiLPdkmDFCtrc7s+gWm6j0goDpXSxzDYLHIZg=;
        b=It4Sh8/dWfIW75lmqx1gimeVXwmTpy/PvThFes5rrw0Jtb+idQrsOX0mC3sHWKTGXM
         GMn1gbWupSBipkkoBbt0L5nKTJLvUB/jU0NIdgeN0zPvUt5FCfPxoxWSrvpkTE/v7r3h
         Rm63mCM26Eozbiil81Rp+XSMeuX4u67Ilb3rQgMuGsUFAveFpY59qxU5pDyDHABYMLWX
         j1lJZf7aALYwbq66BvQW1Gb6Wc39SPwJCmGDagn70npTuJO4Oa1bIydUbfIc7jGdjol6
         xwAYQZRKgBoU0Vwjp4dsvcJQA4Bk7Cza3JJcazRHUezRlcUXCLqt0XaZf97pz7xcvhkZ
         w+HA==
X-Gm-Message-State: AC+VfDxmtlbdAoQyv0ijKF3g1TLUQNSPtv8EQ+y60Z1TAIFc6YtzUmu+
        ywD68pDjZxbsdRldF4lujV0=
X-Google-Smtp-Source: ACHHUZ5sikUTpFACM5X1FwlPzBoZ1eTtmkWQC4dkupFmbbQaFbUzgqKpW41OSAJ+WiXLXJShmFVplw==
X-Received: by 2002:a17:902:ea0f:b0:1ad:c736:2090 with SMTP id s15-20020a170902ea0f00b001adc7362090mr3178938plg.3.1684504019137;
        Fri, 19 May 2023 06:46:59 -0700 (PDT)
Received: from [192.168.1.107] ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001ab0b2dad2fsm3422257plb.211.2023.05.19.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 06:46:58 -0700 (PDT)
Message-ID: <bac9f57b-7a4e-40a2-5006-9074109a50d0@gmail.com>
Date:   Fri, 19 May 2023 19:16:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517042025.16942-1-llyyr.public@gmail.com>
 <f7b24380-cbb1-410b-9507-006c142c41b0@roeck-us.net>
From:   llyyr <llyyr.public@gmail.com>
In-Reply-To: <f7b24380-cbb1-410b-9507-006c142c41b0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 18:23, Guenter Roeck wrote:
> On Wed, May 17, 2023 at 09:50:25AM +0530, Gopal Prasad wrote:
>> From: llyyr <llyyr.public@gmail.com>
>>
> 
> The above is still wrong. Never mind, I fixed that.

I wasn't sure about it, but I checked and I'm pretty sure pseudonyms are 
allowed [1]. Is the problem here that my online handle not have a first 
name and a last name part?

* 
https://www.kernel.org/doc/html/v6.3/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

