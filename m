Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9E5F639A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJFJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiJFJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:25:39 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14C8FD5B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:25:36 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-349c4310cf7so12424657b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Lc3wAimhB0NV3fEZnKSiGf+iaWHiRr2Q0Yml4bXTw=;
        b=GhyCANsVCMv7Xj5vPzTJQ8C9eAqFcljvOZ/qHwD0VVG8KmDuQcjuVDGjBhUed/apAA
         bGPxBqBZM+fy9NCtISAzU/iT1uS03KxTmh1h3Ncm4MYYUJSHgDUxeNFh37zU4uRa7VlE
         3vzqOQgKHTc96cHwqaMZyzZVagsYbV6XO7f6/Zp0FkMdtierYqbESMOaKu6Fe0cBkKmd
         e4gsZy4tU1wGTM7UIduND1fNxY1ddVpTAVfxG96G8YFFDp6AMwPT3uaoLFy3DyM8KFPH
         mywARYQ13/MDzfyqGLGlAvXurMirF+vOnWV2zliFQwWuTX/MAAdOC0aplQbqjEPM/14o
         cXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Lc3wAimhB0NV3fEZnKSiGf+iaWHiRr2Q0Yml4bXTw=;
        b=HwqdjR6L/S2iB/O57lyeV7Zp6fxv50jCHecnp5z+tuFVIulVP5G8vWK8XPmqhjhbTK
         eySDdiFen43uTT3daDNyD8Fm+Z+aWfLaBJJ+X8i5NTN+UdcZlYOUvsdRQiJxLLuPEX63
         4XGcplzB+98XF6PrzPVvRP0S+0ZreoLpTYTfh4JqSzooYuRXTpZEgT+Wt3GJLRADp38c
         xBXMHGrhscz72VM/mIaEB53RPgivkY84jZUwVqzwp5JZVR+aBZsJJU8dHyqAcqXyPFvN
         6jRUKwzljP5qHKO01AZ2rTCblHbS4WdCEeCy7FSbkNhzVgNi75OrkW/Nprb18ASN1Bzp
         xLEA==
X-Gm-Message-State: ACrzQf3UAapPXLk1Ee6QGKoDiHLJAofLdVuvHYWiAo+MkMfuHzXHlC06
        zT/4GnFEShVpdMqNUZW35McpM7TkAdLebSm1YUk=
X-Google-Smtp-Source: AMsMyM7r14qx4ru1dSw1/Srb9sosmlXg1OK/JszDtOAHtqzxbICymHhj9hgf9aIgACsX1Rp4Lso3kluqu2ZbVnhDc2Y=
X-Received: by 2002:a0d:cb4b:0:b0:354:473f:a431 with SMTP id
 n72-20020a0dcb4b000000b00354473fa431mr3571651ywd.463.1665048335591; Thu, 06
 Oct 2022 02:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:a002:b0:3c0:efc2:48c4 with HTTP; Thu, 6 Oct 2022
 02:25:35 -0700 (PDT)
Reply-To: financialdepartmentus69@gmail.com
From:   "Financial Department U.S" <antoniogarcia26b@gmail.com>
Date:   Thu, 6 Oct 2022 10:25:35 +0100
Message-ID: <CAP4MGN1MXabj0UEymO9MWYG_tAMN_Pt77PPR1A0k+4BoueoZFw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message just get back for more details.

Sincerely,
Mr Jones Moore
Deputy department of the treasury
United State.
