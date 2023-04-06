Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E086D9392
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjDFKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbjDFKD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:03:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346883FB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:02:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so37051879plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680775372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51dk4V7q9yVppshkNgoq8UhQPElca6wf9AjH1vSaU/g=;
        b=QWL2pIsdxn0JHIWyHIshNpcxhY6RgzyEUPXac2IR3BKKfnoK4S+q7EX7ohyfPXpG+u
         2pkWXfgCjIf9lz7t+MWkwMqj/iu3dyEjk/oHGAU0pOA3hzEdHJ4PWtNvzyt9OsOWVdCg
         MOPuUCDOuXIXia6X61+/d8ywfWUNYWSWa8nszCXyLgbTuLq39DhfUN/Ohh2YSYMR9btL
         Tdw02ZKp54Twl+3Jkh5M4egdJ8kTO7+ns9whBsUnKECe1Tq3q9mRDGC9KniNOCWf3D6n
         KFfWhXH4O+DbxFEvzDMb2ddHcGNpb/rOwgfVzgNiDPKaDP4SyZ9d/S0rx2Yb+RcOUfTB
         dbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680775372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51dk4V7q9yVppshkNgoq8UhQPElca6wf9AjH1vSaU/g=;
        b=dVUk7aR7uU1KxBd1Ogw6xbOazM8wJNmlV0+VySZQ78WImyay6/YTt8NcaM64N801j5
         5fcSrBFnGjhqHSzW47uJYbWgru1a5mmcPZMEtMYjJeKEAI67VoqSwGSCg4lT+f1wmp2l
         m0F93GmnBUrpVm2KHztYQz1m5KxKVDju1yNzbv/wlwoXE77JZbcKsFSJvV0tL6PHZDjf
         MDyQhtLXR9FgSaz+DDormEkiUbYuxendaZpwS9xv8G2FbEEt6q8amT3wj0AR0TKoh49W
         wGcZjyRBWmT6k4/4Ciq0QF9htjSMONlGQW2i/eC8RfFJ3MS2yxydZAvqr6vDYlLYUnKM
         YamA==
X-Gm-Message-State: AAQBX9ekjSOOSnfc25C01XtKLqSUQOx9kzCpPYtCujvhwsYOWtJ7sQhA
        jGYj4UxkGMFQ8iJYzdY3aqe/VQ==
X-Google-Smtp-Source: AKy350Y6RClDsI27Wj5dvmPGKfBWV1+XtTPQKj43ey4K92DzPQOTX6meov+Vo9jnc8Bn6DVqrIjpGw==
X-Received: by 2002:a05:6a20:8c1c:b0:bb:b903:d836 with SMTP id j28-20020a056a208c1c00b000bbb903d836mr2389740pzh.54.1680775372099;
        Thu, 06 Apr 2023 03:02:52 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id n19-20020aa79053000000b0062dfe944c61sm950371pfo.218.2023.04.06.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:02:51 -0700 (PDT)
Message-ID: <024cb364-96af-b2c6-0b60-73d0de112312@bytedance.com>
Date:   Thu, 6 Apr 2023 18:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [syzbot] Monthly mm report
Content-Language: en-US
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzkaller@googlegroups.com,
        syzbot+listf2f28c8e4d5809654f88@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000032660805f8337db1@google.com>
 <4e345a16-bdc9-6f1e-9bb9-0ba35fa69e3e@bytedance.com>
 <CANp29Y6uoTbfQArtcR=K-i_9TT=74PSZqV-kxr1kRZLdGfiedQ@mail.gmail.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <CANp29Y6uoTbfQArtcR=K-i_9TT=74PSZqV-kxr1kRZLdGfiedQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/6 17:53, Aleksandr Nogikh wrote:
> 
> To find it on the web dashboard, you first need to go to the specific
> bug page (click on one of the bug titles in [1]). E.g.
> https://syzkaller.appspot.com/bug?id=4ecce7e55e02002f794e28cbac1682346d423737
> 
> At the bottom of such a bug page, there will be a list of crashes. And
> in that table, there's a "C repro" column with links to C reproducers
> that have been found for the bug.

Oh thanks.

It turns out I opened a bug page where the repro column is empty.

> 
> --
> Aleksandr
> 
