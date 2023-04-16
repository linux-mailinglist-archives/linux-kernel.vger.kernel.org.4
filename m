Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677616E3AF4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDPSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDPSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:01:14 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20668B3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:01:12 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id dw14so2307689qkb.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668071; x=1684260071;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuEcBNI44bQPUlx25Dk5iSkVIfTfkFa2bdyje0ZPA4U=;
        b=VjlrMuzrRbyu4HtA/Y62cfOQs6viPosvk1nltZdMKCmfGWAR5E+Ae0ZAgPamk0VHqj
         aWRtNOvwacHPSb+4OYzx1dH7UdZzfOgC2ZeIgnHiD9SsSOo1/UI2NxsHQ/zg/C7FazC3
         w43xCdIO00nCun3oUvTWz/sOGgfwuq4hTwy9KXkwHbCgaFsEYYS7a4pzeLL6SXlk0EHw
         fYva/+lQey/XLzImRHHXEe9u25ewXmV/DsfrDHtaZ8oyfXH2DOoC0H8rWWd0PzSF2bho
         0wy9LjWqagQKlKLVst8ZiffPYjyyPUZvCQoBzL/NgvOm1urmwu4TDcFmbWGbaJZAd5b9
         hFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668071; x=1684260071;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuEcBNI44bQPUlx25Dk5iSkVIfTfkFa2bdyje0ZPA4U=;
        b=DIdck5kI530PdAwW3WvLH2tlpwbuDVld+M1SXLcAL6dLxnQyaSJAu+G2uO1jc1mcDL
         8VN0M2TCnJtu1usXLHU5/IWHzIeexfUOaaeXwgtMiVqQHP0tF3kWbqT02UhT4e6atAoE
         XfiWyDsdJnwuXh1x9ivbWPKmE1WMT3omQuYiDuGf+LDp1NvYOqD34KZgJh7/WZjcQc1O
         9q6ROqunXwcIrETczRNHDloD0Ov9S9BJl4OOwT+dsfnLkQnjYlVg5NPWADvS6S3LoGI6
         Srqlu6Vwf9isUsUReQ36b8W4DBVNy1lDohtQwxfrN/Qy3CSnmXwGokQlkxV7LcFH2cBk
         CwrQ==
X-Gm-Message-State: AAQBX9e/A/6QFHQud5tqJBykzP6jRTvTqXlrpvLqxmZjDUP7q6gfg/tK
        W9Qrfzeuz7RBsLNENyt5YZcKxM2VihCsdmmDTvI=
X-Google-Smtp-Source: AKy350aQZTuS97Yj6bwa5X8h1gnfLK1tdBM4NQN5DBLajjPCJqX98eNT6wiYsTJHCDjl0cP377eUuP0yaz7BW6nTzgY=
X-Received: by 2002:a05:620a:140a:b0:74a:cb51:c508 with SMTP id
 d10-20020a05620a140a00b0074acb51c508mr2163016qkj.12.1681668071268; Sun, 16
 Apr 2023 11:01:11 -0700 (PDT)
MIME-Version: 1.0
Reply-To: lindwilson141@gmail.com
Sender: ibrahim.kabore1985@gmail.com
Received: by 2002:ac8:7c50:0:b0:3bf:aa97:fefa with HTTP; Sun, 16 Apr 2023
 11:01:11 -0700 (PDT)
From:   Ms linda wilson <lindwilson141@gmail.com>
Date:   Sun, 16 Apr 2023 11:01:11 -0700
X-Google-Sender-Auth: XKhQO9pPWOQ_RESkeVElxKJXyG4
Message-ID: <CAMumKknfJceB=+UiSMfKt-ZPJatY2P903eomrzMEc9qC2U3BXw@mail.gmail.com>
Subject: MY WARM GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dearest Beloved One.
good day how are you, Why I contacted you is because I have a Very
important and urgent
for you, awaiting to hear from you.
Ms Linda Wilson
