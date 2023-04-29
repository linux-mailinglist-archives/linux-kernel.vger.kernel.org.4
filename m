Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6056F269D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjD2ViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjD2Vh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:37:58 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2128D121
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:37:58 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-b9d87dffae1so782299276.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682804277; x=1685396277;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEzM+W+OEmpHfEeEaAySJoGydPuqhtpau7d10u77fwA=;
        b=a0w3KjBdydoP1Z+EqSKq71RF+df5fILRoj1ymQZdJRZUrmtpMpfYjsexqh3mudBKUT
         QdPOE41qlzDk0uu/L0uaif7EzJ9vol1Im9z+uRPKWhWknrRwGEVzxDjGacwaGWgTeJtz
         DHKMzKRVgB9w7wo2pp/x74Y2NDyD+KLd7fOKkbM0SvQDE2ycUbnRpUDWhUvyJz38uiKg
         4k8q7iom8qewROXpe5wVsvzSO6sMQHaYfBhREsN+lCdnOYdJCOOt87bP5rABmEsVmq/A
         etXJFwVs3cWO+8DVzlyV6vT32CV0mLSGTa4dPbN1ofSgKCFRggQ0OolkQPjp/pPiZFM/
         UnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682804277; x=1685396277;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEzM+W+OEmpHfEeEaAySJoGydPuqhtpau7d10u77fwA=;
        b=VVmBbycXf2H91gzTz1kq5duKk3caNFsAsY8X5oVuainSeIDmvstrHg5Q/jhmERGR35
         XGlT2Yx+Yz3hhcHN3dWAK0Z0h1EnhJ6VY/qoRa5SfpdWnf09k2lhqUArSMFXUUPTnBQh
         p5Vy2oPSj/VPuJ+eJV0ToXvvM1vSoD6mByWe0YrpFIImnf2wVRiKwRkyxl4LEAUxERBl
         /zakRfX/FL/raNZqOFd/vlaMgtz+LtgOkyBrSvBqOqA4MxFO8NFKfCdpmJCzKDvJshYp
         YCmqasyK5YRk4YligEouypoXcm6j2ayQWHH41RdVAVD+UzG4caKIP2t7fUQnRmwH10Up
         xNMQ==
X-Gm-Message-State: AC+VfDwu3oxQ+/9dg3xhIEbJbdydeDVmZdTF+Z6gus4gMUtcUWwsN2Fj
        BvH2ObLA6mgHk8QjGRbRJlbVa2BjdN4xWapGuacO30BvY3t7Ew==
X-Google-Smtp-Source: ACHHUZ5kCWNoeAvvmTCerX4TR00fjpbqxCWUaO9nMP0EmfcYu+Z50E1UrhVMhZo+RLiyD9WPD1Wk1GcHUzDfdRkpZiQ=
X-Received: by 2002:a1f:6419:0:b0:443:b924:da82 with SMTP id
 y25-20020a1f6419000000b00443b924da82mr5230777vkb.2.1682802795768; Sat, 29 Apr
 2023 14:13:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c321:0:b0:3ca:d75f:21c3 with HTTP; Sat, 29 Apr 2023
 14:13:15 -0700 (PDT)
Reply-To: ava014708@gmail.com
From:   "Dr. Ava Smith" <smith191919smith@gmail.com>
Date:   Sat, 29 Apr 2023 22:13:15 +0100
Message-ID: <CALs781XtgCAZ2tx0ZMtnRHCLoZWTpuhXMvd0rZPLecSgwjZ+7g@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today? I hope you are fine
My name is Dr. Ava Smith, I Am an English and French nationality.
I will give you pictures and more details about me as soon as I hear from you
Thanks
Ava
