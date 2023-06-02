Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5609171F87D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjFBChR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFBChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:37:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA0194;
        Thu,  1 Jun 2023 19:37:13 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6af8127031cso1339888a34.2;
        Thu, 01 Jun 2023 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685673433; x=1688265433;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLZcQ99Ho3580mjuJ5CWs1tHY6kZa+CsdXChVbXnF4A=;
        b=psulVz7zBKNYrfCozba0IEsN4CJOuZmf3U6tMgv1pbOfQ+pmdFKo5Xdcwf5EI29L6t
         yX99q7m5obkC7tD1XdZ6oyYiUZXJSJOG7bAnvAcJU8G0UA/WQd6a1wyNIUnpfA88W9Gu
         BF8IjT7ZT6HMmX0DZFVhke6FuAYvx3DFQzCmWtl2vZGo46RdKaXX2vGZ+PMy8RIKB9ej
         knHTzmwq5QGoF7ZcaR9Tq6CRoQfYNa8J47CyxMi3un8L355mGxSH2TgSY3MMhbp6qM3/
         WPJhv3etRYs3mSY9knv5jNFQQaJbAlyCMG6RPti/MHK+4YvF990tlUAcRAY7IRdnoghZ
         BzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673433; x=1688265433;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DLZcQ99Ho3580mjuJ5CWs1tHY6kZa+CsdXChVbXnF4A=;
        b=dD3zQk3sMr5/VB6r2pFXD7dJIEQ+bFhIfwLPmsVIiL80AhA9+h1qeI7J/NtbmPhhLR
         JGOFVUl4x1ouhCrWEBL6wXtIhEDN2dYfrmOdNLyVz6bBHxMi7qbHnQU6FY2Abk8UD78f
         Wle3Z1InJLa+/hCyFoJG/q68O/gBr3zLmqHTSCnEAYL37zqfXrGJ6IrTY3RaaA/x96p1
         4DMse4ezMzkmz/o8vMjJeVH1l85UlzUzKgHLOgUIppF3A2qwtBXRTfO2f88ZtMEnbip3
         poyc8DpLKFn+IOag5FR0A6Y3F8Ke5O79ZvmxxtR0a5SqjRMasNpktYtJBhqyLpvv9sUs
         aTgw==
X-Gm-Message-State: AC+VfDwlXbZppDFwx9N8MrqxNesx7x0i4QUJsItLkPoOpbujFq2sQw8N
        A0SZT0OGLm/mSVQtyN2YrusLAw6kmyk=
X-Google-Smtp-Source: ACHHUZ7TSvI3mc6wX5hxklZq7lCO/C8L/tczNUi88qS6bTKxGKNstpBAbJC93GUNgnAltBTwqqiNcw==
X-Received: by 2002:a9d:7a98:0:b0:697:ef66:e7f4 with SMTP id l24-20020a9d7a98000000b00697ef66e7f4mr1140605otn.24.1685673432965;
        Thu, 01 Jun 2023 19:37:12 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id m7-20020aa78a07000000b0064f39c6474fsm808203pfa.56.2023.06.01.19.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 19:37:12 -0700 (PDT)
Message-ID: <e6124947-bc60-660b-a41f-e09256bc5232@gmail.com>
Date:   Fri, 2 Jun 2023 09:37:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
Cc:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Null pointer dereference regression introduced by
 326e1c208f3f24d14b93f910b8ae32c94923d22c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Null pointer deref
> 
> after reverting 326e1c208f3f24d14b93f910b8ae32c94923d22c the problem is gone and the kernel does not crash anymore
> 
> See this discussion for details:
> 
> https://bbs.archlinux.org/viewtopic.php?pid=2102715#p2102715
> 

See Bugzilla for the full thread and attached journal log.

On the other hand, from linked Archlinux forum link:

> Hi,
> 
> I am running arch successfully since a couple of years on my Acer ConceptD 7 laptop. Since a kernel update on 24th of May I am having strange issues (never seen this before):
> 
> - sometimes I cannot even login (using gdm) - after entering password just a blank screen
> - if I can login I can start working - after a while commands I enter in the console are accepted but do nothing (i.e. grub-mkconfig -o ..... can enter the command but just no output - it does nothing - happens with most other command then as well....)
> - Reboot does not work - stuck somewhere - have to switch the machine off the hard way
> - this happens even when entering runlevel 3 (so no window manager)
> - same happens on the laptop of a friend (exact same model) - unfortunately I have no other piece of hardware which I could use for testing to potentially reproduce the problem
> 
> Managed to trace this down to all kernels after 6.3.3.arch1-1 - so 6.3.3.arch1-1 it the last one which works without any problems
> Same applies for the LTS kernels - not 100% sure but think 6.1.29 ist the last one which works
> 
> Currently I have marked linux linux-headers and nvidia to not upgrade. LTS kernels are upgraded but the latest two kernels (latest from today) up until 6.1.31-1 do NOT work
> 
> Problem: Since most of the command fail when using one of the latest kernel - it is almost impossible to debug - at least I am not knowledgable enough to know where to look.

Anyway, I'm adding it to regzbot:

#regzbot introduced: 326e1c208f3f24 https://bugzilla.kernel.org/show_bug.cgi?id=217517
#regzbot title: USB typec quirk for Asus Zenbook UM325 triggers system freeze on Acer ConceptD 7
#regzbot link: https://bbs.archlinux.org/viewtopic.php?pid=2102715

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217517

-- 
An old man doll... just what I always wanted! - Clara
