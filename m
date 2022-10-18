Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E3602706
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJRIfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:35:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F70A8F959
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:35:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so13364677pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEe31S7OueGkq2ATsUWNgeMPrSgw0rLvjqo2xewOoPY=;
        b=n0omaL6hS21R8l/phMUF9jY6xR7fhPqREWjC2oG2B51o/rj2Mpu1tatt4o4PF2nd/K
         I2osJfdM7OmnocKcxnlwakiPoCFErGVROE4qb2PwzxMFKzSF+linGrJ+inqTc517Cgwl
         fUgR12cS5zQmS2MY2Kd+u0swoep4JLojQK39p61ouF1rwzU6Yfy/qOZvf5YMi4rIrUEF
         E5nryaZ0FWfVQbiQiLBwDpZLFzJCClDJepxouekIiYyV800JkHgLOlDf/uSlre4lKQB/
         dE4Uec+qEyVeRa2yVV0Dk+vhs924cOIB2qtJ005eYcMs5AGpjcBfCZ8cs0QHc6CANqop
         eClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEe31S7OueGkq2ATsUWNgeMPrSgw0rLvjqo2xewOoPY=;
        b=YRc4CmSl/Kp0eJRtnZFAH6QP8gF2pPyi0E9Q42Bo+On5h3wSYtB5h0V0qka9Ottd87
         WM+Dnv4ZqSMkoYOTbjwPBo1TU+dxzXhU5trM3RoVbkpUSJ1L/wPc6pjz9+Dgq2FJ3qZc
         rQNfjfBMSGLJ81Cn6lZm9QgGzhH+/5rHKGItijmllV0raqCzwEi2pEyjbI7vFdgCQGJ+
         SxdTOjpiykL+ksdteiZQGneXmV9i8mIlbaXeRJJDVvkW8IsYjw4sVAhd2mmW/6d7IS0t
         SCTleiY60Oah/28euUQh2W0cwYyT/B6sgXAxwi6Ays/Tei0hECN5i+jLYcjb9sg8tVdh
         szXQ==
X-Gm-Message-State: ACrzQf179ybPxJbUezjwvOd6mPmQdbCkAYUCg33DshHNAsEyuZlO6+bn
        tilQS4PNviz6sPtaY0SUgOU=
X-Google-Smtp-Source: AMsMyM4RxVuZxAP3xMNpqCjeZKVZLVRruTKutnEPI6ngJu2UocmJu9YAzfuDjOP4IgCEEMsD5s81ag==
X-Received: by 2002:a17:90b:3d85:b0:20c:8f6a:8298 with SMTP id pq5-20020a17090b3d8500b0020c8f6a8298mr38901757pjb.242.1666082123190;
        Tue, 18 Oct 2022 01:35:23 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id c7-20020a621c07000000b005619afb745esm8613725pfc.113.2022.10.18.01.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:35:22 -0700 (PDT)
Message-ID: <608e2363-1e51-7aef-746f-e93aac583a13@gmail.com>
Date:   Tue, 18 Oct 2022 15:35:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
 <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com>
In-Reply-To: <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 16:45, Bagas Sanjaya wrote:
> On 10/16/22 19:21, Bagas Sanjaya wrote:
>>
>> No Verneed warnings so far. However, I need to test for a longer time
>> (a day) to check if any warnings are reported.
>>
> 
> The regression still occurs with this patch applied. Let's see if
> reverting the offending commit helps.
> 

No regressions with the offending commit reverted. Now I have to
try the proposed fix ([1]).

[1]: https://lore.kernel.org/lkml/CAJMQK-hgQEkhgpO9VFOCgn-cKtVsr7Hb_58pAYiGoDi5SzGZtA@mail.gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

