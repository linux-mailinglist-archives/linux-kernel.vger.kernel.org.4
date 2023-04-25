Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D26EE7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjDYSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjDYStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3017217DE9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51fdc1a1270so4418141a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448561; x=1685040561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8Xj/oeiXnD4kmgpkyXSC8mlxxXKJhPbUA6HpQ8+6nc=;
        b=bkWw0YFGDi9MqapaJ8sTfAkpsJtnOXj2CxcU3/hUz18hVHIuk2ZQdN6kOPtSfYByic
         MZHeeufAy+SD42u3xqZlQANHxsUIOI7RXohjDgfw4nRhftmhHwDJb4SbmJpEPqsS38zd
         c+WyTfG2w0GomG//mPy4ncrWbPj7TkLjE7eVEqQqk1shd4LMjMeP4OgOsC2vZ4Pu1uDa
         uXLqVT0m2b2R2hojIwcvTOLHQ/FSlOTTFoDxmlFYeMlWemLFe6zFESD8msE5H1tQ94HI
         xJXspJUaedex4HEGds0x7t7hM3krvAT3zRunnUoTpE5PHEtgSUdAIBEAUre7G2lMvyj+
         qRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448561; x=1685040561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8Xj/oeiXnD4kmgpkyXSC8mlxxXKJhPbUA6HpQ8+6nc=;
        b=QeGxoY+5oEzH0XVrF0AaAFH+5U641W8OAd4hVpstcTLs5lA7gZBNX6nXB+XEO1vBDP
         eB4TsGaeDKrdC0mldH5XuQPoay86Mu6ktYrGlCr80cdc/9EWTvms2ZjiAScHzsPPlGlz
         5EwrFpseHGnOSbIZmwWE4VyldlOKIVPk2H84EOYXUXRYEIy780mOFlwyTUDwMVQO925r
         M9iVV/AO4lGUrU7ZN/ogHtm7duV2O/mev/aWRZDASHo5FDiDJfVFK20m4FvPL2wiRdOD
         dyrfVaWP/wmPSE/G2Cj68eq9IImqccthd66XZ/AI+EF7t+oG6cmeMgsnGOMAzmMdAe/H
         Y6sg==
X-Gm-Message-State: AAQBX9fQ0+cJ3YLP8lSTJDusvQd3pN0CkpNwmF68rWUwmFCgTiJMDeIs
        GRltSSbnB3iIY86Tqur1ssM=
X-Google-Smtp-Source: AKy350YU+WbUi1VoN3j4IGCy3DXpR8wHImKXKwXHKwJ5Xfg4J3s24tFe2T7vWSJ1l4cD1ct7jjo3nQ==
X-Received: by 2002:a17:903:234b:b0:1a6:7ed0:147e with SMTP id c11-20020a170903234b00b001a67ed0147emr24676236plh.33.1682448560896;
        Tue, 25 Apr 2023 11:49:20 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id bd2-20020a170902830200b001a68d45e52dsm8573417plb.249.2023.04.25.11.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 11:49:20 -0700 (PDT)
Message-ID: <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com>
Date:   Wed, 26 Apr 2023 03:49:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] extcon next for 6.4
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
 <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
 <2023042544-cargo-reexamine-ed86@gregkh>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <2023042544-cargo-reexamine-ed86@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On 23. 4. 25. 22:22, Greg Kroah-Hartman wrote:
> On Tue, Apr 25, 2023 at 09:58:47PM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> Gently ping for v6.4.
> 
> Ouch, something went wrong with your first email and it ended up in my
> spam folder in gmail, so sorry about that :(

I'm sorry. I'll use the @kernel.org account on next time.


> 
> Is your tree included in linux-next already?
> 

Yes. extcon.git was included in linux-next.

And my pull request edited the 'class_create()'
Thus, it might have a conflict as following report[1] from Stetphen Rothwell (linux-next.git).
[1] https://lore.kernel.org/lkml/ZBhOTW9v9jzJVY7e@kroah.com/

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

