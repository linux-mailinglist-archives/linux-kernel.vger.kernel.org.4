Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30BA608B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJVKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJVKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:19:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72332AA179
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:35:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso3154890pjz.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rggtGs9F9HdIZ3XJoyK0KkYkbfdufgIdmWrXX7fIUbY=;
        b=cap0fKjNvHJLxCMt/fs4tSu8jPh4Zp0w9cHAVfH9L6FQ86U1d3GlalbTg279FH/+yK
         wY//tOG8eOESxqqTe6HV8VSU6l1GNu5+KNUGYzfOHME+GHvrFHsB7IbtpyHtkwXXeb9c
         eqdqlRYjlxE2eQ977z8xu8M5vQQPWKvynM9WpgXsUNCK51h4clnlC8DvHkQQJhurzOPa
         2HXyKw8YMCLDIS/7YuaYjiLt1C+d+6u2xZ1SAEFLCRYWHvQWIpV3iBdB95A0aID1LP9X
         QnOsB4aDa4AWSZHszzxyom4R3RHGAUMwKP6KGcqyEpSteiTvN/I+wyziUN2KrMcKlplf
         +C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rggtGs9F9HdIZ3XJoyK0KkYkbfdufgIdmWrXX7fIUbY=;
        b=Lkc/hPlwdrjt5XDNRl2cW2o535GQV62FKMnonaQRA4+BSPgkK4TmcAIoBw1b/K5/1Y
         PRW2DS0es3yi87ES61lSe8aAY5MyEGvwGY4ftMp0ez5AQKQvCqYLdVt4RJHdKYc9CK00
         QLiy6D/hBIHAsoM4o3ujzh4SEtWC+BCvOD0DNINWNjzjUN0mrzP1Fz1oUuuRL0cAbTqJ
         ZXPLirdigU5RkGOs3f4OmtHMsQo8FRaNDeCrlkYiRYNVDISXmFMnDSbXVz2vGOVEYUi9
         LzWZRRBpfmZaEqFSAw756BwtzxMaxmTZ54pqseBsiOtRVlxBf6gf/UASci9pwrN74wUU
         dIDQ==
X-Gm-Message-State: ACrzQf3pF5JhdvVGh8pu/PNRl/COCVXbry/poAXBXFkGZ91bjydQfXYa
        hQDDHgmvBR6IWRfAFEmlMECSq3JPTr+0vHKQ0ONC8QfxczaqI90sg+4=
X-Google-Smtp-Source: AMsMyM4Go+5Kt+TUkyRlqj608ncsA/C6yBkRGUPNX8mBpP+a5pyakdLGlyl6X5q6zpmCF7utoQBQYxZ4/MM/4RhwHtU=
X-Received: by 2002:ad4:5d6c:0:b0:4af:b5e0:63f1 with SMTP id
 fn12-20020ad45d6c000000b004afb5e063f1mr19499506qvb.35.1666426305215; Sat, 22
 Oct 2022 01:11:45 -0700 (PDT)
MIME-Version: 1.0
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:11:33 +0100
Message-ID: <CAHJEyKVi=Bw1=-cH8dbJratKw3Lk3ubh_9bcBB=iKPm5H7P1Yw@mail.gmail.com>
Subject: request for assistance
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a portion of the Outreachy first patch wiki I would like to
edit. How do I go about doing this?
- Should I just go on and edit it? or
- Do I have to make a proposition addressed to someone or somewhere,
stating what it is I want to change and why?
I would appreciate your help.
thanks

Tanju
