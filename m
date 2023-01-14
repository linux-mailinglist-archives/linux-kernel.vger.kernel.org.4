Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76DD66AECA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 00:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjANXdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 18:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjANXdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 18:33:52 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A2659B
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 15:33:50 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so6463188ooa.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVa7tSg34V82zc9uv/ppXuqPU5ZR9rqfF3JA312hlp4=;
        b=0nOK1+r/a//WJZYFo1KepaU9LsjzllNZfU6wFeBZeH2Iz9q234acLX0cO62/wpFrZn
         W3Pz1fIHC5ndFaS/pnzQdU9xQbpYbmlS5sfMr/E/34MBRgfE+q0Tihq/O/Ul9mUtOKDr
         hLp1iWNpB6cAky0tXXxbAP7MOBkB0uahINERuAST32jEVSvzkTk2LOawn403UPcqjvB8
         YaaZDBL6btMGnrDAlLSv6ZlXTigaPHh+b9wyYFRzTvlBXeYe1JPvEfoqK9hze81Ax108
         oylQHqb26hucx+iiK59iUAdTZcr1pS2smwOtXHgYCkBOa3Ljpudgdb4GsfBCSLaqRNT1
         AkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVa7tSg34V82zc9uv/ppXuqPU5ZR9rqfF3JA312hlp4=;
        b=2+e+qzA32MRCDopyAVZtFeCecC4xqXtQBkCm62vAZej6SZEzAu6C6LySgLmdqnZ1QE
         4IIWVlHt/J3ADRDamEzaCzP5YV+hz1LbR1adb0QjcHxraEAsVnyK1DsJWI6iOa2RAZ4S
         SrN1srkTBLX3fkgCrHJqwtqGCztFk0mRapRt43zVnIiheLuiG/OpEV+6c+MAZ87BsFHY
         n961KbailfGOMlZs3XE1nBx7dt7q5v79xPv0yXXa5FlA8dC8R336PngviOBHdliweVC6
         XrrW87ezGajLceShSmMnyg1z9IPI/iRVWQ8IHEqpY3SOx3GBL/OoJXJQhRt6e9xQ5TdD
         BCnA==
X-Gm-Message-State: AFqh2kpDiFtU3JhTEKGk3jJz9ZDJZNezv6gXinjSNrjoKcjxtbTPvEYt
        +Z0OewmIKlXl410L09OSg6iXcA==
X-Google-Smtp-Source: AMrXdXs/Kns4HT9KFpy3hijA+mJsCvDdjv2Pt3sAGW1afqj/X9X0Q2SN6FycBE9luLkcBBrJY0zLpg==
X-Received: by 2002:a4a:a845:0:b0:4a3:bcce:5b56 with SMTP id p5-20020a4aa845000000b004a3bcce5b56mr41919914oom.3.1673739229264;
        Sat, 14 Jan 2023 15:33:49 -0800 (PST)
Received: from [192.168.86.224] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id g31-20020a4a8962000000b004a8eb1d8f1bsm6770438ooi.39.2023.01.14.15.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 15:33:48 -0800 (PST)
Message-ID: <15573018-32df-b67f-fc37-44da0ed7afde@landley.net>
Date:   Sat, 14 Jan 2023 17:45:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru>
 <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 12:38, John Paul Adrian Glaubitz wrote:
>>> The patch is against Linus Torvalds' 'linux.git' repo.
>> 
>>   So, this patch hasn't been merged... may I ask why? :-(
> 
> The SH maintainers have been MIA which is why the other maintainers want to kill the architecture again.

To clarify: Sato-san was only ever assisting Rich, as in promising to answer
questions when Rich didn't understand something. (That may not have been
represented in MAINTAINERS but that was what Sato-san agreed to when we all had
lunch together in tokyo however many years ago that was.)

> I’m seriously considering adopting the architecture.
> 
> Not sure whether Linus would grant that though.

I'll happily endorse you for maintainer if that would help.

Rob
