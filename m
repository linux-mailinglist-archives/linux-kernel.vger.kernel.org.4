Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666DE6274FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiKNDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiKNDe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:34:29 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9330D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:34:29 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n205so10303616oib.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fusFIcCpb+Y7vuLDJAT9v6AmZkAUfgzc9tjnC7J5mB4=;
        b=Af2rg0ZPGm8C0x/mbGcm+fiPRUbPxgOM2EfrVZjEQ/Bvx4XiJdedk0WGYible9xi6h
         VUSjsKZ13aCp3vqmn9RQy5VsNh8NSE6X4ZFvscaMLsQfcqtjjtFgisNE+G6MDQyy+h+J
         qtcOtnBnOOFSlnqPmOiHoBNrrjDhVicK3nR+ZckkWDoN9zd0UwDIHfXhCIVFnLUWtkjK
         0xpNJaGOCjFMN+RWgfG+2Z9azku3b2FuAbH/r2oh83r/W7/izr9SLOA/2Zbgcx8iPan1
         d2R75fJxprg8h+0y+9IVwsEoEa22yqKBh4oqHs7OjILvNlR0FB+8bM4z6nsL4/6C4l+K
         /wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fusFIcCpb+Y7vuLDJAT9v6AmZkAUfgzc9tjnC7J5mB4=;
        b=3SDOCqT1cscMVOgTf50uNkpvEGcRmQd1RszYUWD2yTqvutCUmnmPUUuqIvSnhh7IAO
         bhdstWReU95SaGmQNH1u7DyTVmb++GQZhiijdwDtsV2SVH9j7nqm/QPsMGhdpcEDifd/
         qSFPC69ECdal+to0B4HRJFhG+EkrnFgoRJUd+CJAtYL2f1kLrfSl0tTuZwz2/L5TmCBT
         bl+buiB1+rLcNMT0P77xWRzxttSdTzTwSE1bay44r1MrOa4ciUCWxbesWTgn/nyiJTNM
         z+3CpRsF/lqKDrBCetWdm4A6g4kNm0QEbDoWap5CRqCcbbnutSDZfZkXZohU9ickEjp5
         kDjg==
X-Gm-Message-State: ANoB5plOYR8iUeE4p1M57ViGd7e30lsiBDkvP8U37F856A81+yXWVq2I
        WxRNVJpNxZ1uJX+XQwWMNMdpd48wdvI=
X-Google-Smtp-Source: AA0mqf5S1w5vWRoh84RrU0s/PvnALOKJVTtk7tRR8xW2pyPimt6X6v72AwoZFci8U1j9DlSW06bQEA==
X-Received: by 2002:a05:6808:48f:b0:345:d571:88c8 with SMTP id z15-20020a056808048f00b00345d57188c8mr5121036oid.133.1668396868338;
        Sun, 13 Nov 2022 19:34:28 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q127-20020a4a3385000000b0049ef7712ee5sm3190034ooq.11.2022.11.13.19.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 19:34:27 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <97819315-bdbd-147a-f178-71860f00679b@lwfinger.net>
Date:   Sun, 13 Nov 2022 21:34:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Help with YASM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am the openSUSE maintainer for VirtualBox. A portion of the code is written in 
yasm assembler. There are two sections of the code that refer to external 
globals that now need to be referenced in a position-independent manner. After 
much web searching, I have not found a method that works.

The first code snippet is a jump to an external location. The original code is

     jmp     NAME(dtrace_probe)

Based on a reference that I found, I changed this to

     jmp     [rel dtrace_probe wrt ..got]

This compiles without error, but I have no idea if it would work.

The second reference to an external variable is

     lea     T2, [NAME(g_afParity) wrt rip]

Trying to emulate the above change, I replaced this with

     lea     T2, [rel NAME(g_afParity) wrt rip ..got]

This one generates a compile error that there is a missing "]".

Thanks for any help, or pointers to reference works that I can read.

Larry
