Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3980F6C2091
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCTS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCTS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:57:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7948E04
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:49:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso13462743pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679338161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOWcdyXPT8M0PxHg7MbsafQZlvl/9KAEi40X55nQKaU=;
        b=YLHlsMWVTj47uWGkKK162sw/F4/HR8xt8jBP/uW6Nergm5pMysKRyKoQUJooEyE//C
         EvPvsv9BEB857ex0xVF76HWl/U7vvT/9KfLJB2+F2dT2mWNkfrGCYqBHT9W1DfWhkeTv
         n7d2+MozaGQL0/ksiVwlcmJgrt5UsZbazTVxyz+jpg+sA47QgHvi02z25Q7lFe9Sizrk
         erxiA1ViEakiJZYSA3zxrr7Ugg36/Q+6TbKcX0x6JIRAbNG5zCb6XUxAIKutTAeuS98g
         v16UxBybxQ1gVh8qBtgqBxXcPbcU8veXnibRiSslWFJcuImo9pTaClcwnWgpFA5UJP5B
         xBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOWcdyXPT8M0PxHg7MbsafQZlvl/9KAEi40X55nQKaU=;
        b=219QM47YUL8CeT9ZsMMNF3o+R0N+k6YNXBrPfjaG+0/lojfY2AX4jAAc+mZAw3DBgQ
         78X4LffhxQ0wi1IYnU9tgPbtetUKISAf0Wz3/RzQ7jy7aCf5W3Y18Z1AgxMgHakdzqI3
         JZc74ULwn7pax8v4v/X/uHZKR8GtcXatvAjGljmoDIcI6xzAwe28PfVmZY+eiQNjoDfe
         UtCef+pOEdUaubGX1CEPaUyG0Qflwh0M54c1FuWeoqAUTURI1ktiKRuaq4oLK+AzjtRZ
         EQrP0MxYfPg/hOoTw3rMFVKFgZQxgdlWIxKCaJ8OSEsWYZIo6f5r1FPNbU16I0l76kX0
         JZ5A==
X-Gm-Message-State: AO0yUKUxWEiotdVHKLffpzD1F9lJGDyvbWQRlEl9C7Z0My8tsW2N4Lyq
        q3JC2OSi66f2G60gp4HqBIEpPDtjTQgMWA==
X-Google-Smtp-Source: AK7set9UW2SK0NlF/rHSqpGt/ZWFi4bkoR7RKcSNHGxBq8Fl66lwZAk5BQgqgCwOkVlQ44gHPNt9EA==
X-Received: by 2002:a17:90b:4b4b:b0:23f:44da:208d with SMTP id mi11-20020a17090b4b4b00b0023f44da208dmr55417pjb.47.1679338161067;
        Mon, 20 Mar 2023 11:49:21 -0700 (PDT)
Received: from [192.168.1.36] ([117.255.22.226])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090a7e9300b0023d1855e1b7sm10071145pjl.0.2023.03.20.11.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:49:20 -0700 (PDT)
Message-ID: <6ac3f7aa-c829-f514-6cc0-eb505d7d1ab0@gmail.com>
Date:   Tue, 21 Mar 2023 00:19:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 0/7] refactor file signing program
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230320184345.80166-1-sshedi@vmware.com>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <20230320184345.80166-1-sshedi@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21-Mar-2023 00:13, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> This patch series refactors the sign-file program, like:
> 
> - Improve argument parsing logic.
> - Add few more easy to remember arguments.
> - Add support to sign bunch of modules at once.
> - Improve the help message with examples.
> - Few trivial checkpatch reported issue fixes.
> 
> Version 5 changes:
> - Addressed review comments from David Howells.
> - Framgmented the patches into further small units.
> Link:
> v4: https://lore.kernel.org/all/20230221170804.3267242-1-yesshedi@gmail.com/
> 
> Version 1 - Version 4 changes:
> Did some back and forth changes. Getting familiar with patch submission
> process, nothing significant happened.
> 
> Links:
> v1: https://lore.kernel.org/all/dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com/
> v2: https://lore.kernel.org/all/20230213185019.56902-1-yesshedi@gmail.com/
> v3: https://lore.kernel.org/all/20230213190034.57097-1-yesshedi@gmail.com/
> 
> Shreenidhi Shedi (7):
>    sign-file: refactor argument parsing logic - 1
>    sign-file: refactor argument parsing logic - 2
>    sign-file: refactor argument parsing logic - 3
>    sign-file: add support to sign modules in bulk
>    sign-file: improve help message
>    sign-file: use const with a global string constant
>    sign-file: fix do while styling issue
> 
>   scripts/sign-file.c | 292 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 209 insertions(+), 83 deletions(-)
> 
> --
> 2.39.2

Hi David,

Please review this change. I missed to add cover letter in my previous 
mail series. Apologies.

--
Shedi

