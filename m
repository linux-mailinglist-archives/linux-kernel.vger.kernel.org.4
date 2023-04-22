Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550426EBACE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDVR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDVR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:58:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218726AC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:57:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so25617561fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682186268; x=1684778268;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud2Qp+0j+JXG+xzOTKtAs0iVLtO4HhzSJ3v0hgygifc=;
        b=QOcJnMYcD/qv+CTPOgP19182WbC+VbMPl+ZmiqKksT3+d+l/6jKQjF3OXP6DldB9Uw
         dALFt+b+bEHUP1PxxW8FTjdIJ4QidLB9LkWvhTWcHqZhk/aWA6TqUP+07TnZIPpsVskU
         b3N/CFrzyrhtGjtU+XAqAlIoiUslFzJP2HcXXjD6crTnRrhhjYdwnKOd5ojYVK/yZ1hu
         7DW4dBY8A3KTAVV7x2vB701r8N0LBrfFW1I/51v3vrCxR+JMBnpHEvbBR/TSXhEmaGtw
         shEXXZvbAxPqMhn5YgH0yb+/spq7/iXfEwHo1w6eElVRvCeQN4Cxz2IHAIyaogcWyowy
         YTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682186268; x=1684778268;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud2Qp+0j+JXG+xzOTKtAs0iVLtO4HhzSJ3v0hgygifc=;
        b=jXRHrIGkQrDKMdbe8zaSHnP5PoKQve2PVmHnWLLn1ZPJJO/3NNRATu3P4zD2dWYEjz
         N0/w8S+QZLhNocGTGMXRZdxsakUFX0lAh5sr7Vb9J3VEiToqjzvi3cH3ynwmBnVujOfH
         /1vB0v8sgzvjuvO+opXhCOxN4a3ubJqfrOlJo8bxKCuQYsOu3OpFEA9FILgig/jxM7+F
         CGQltm+UDah6N+w7snwNw+Tr/Ca/1bYVH8eeJNzjw8DndTQHcWiwdetlbcVFRab0/GmP
         zT4w34vUiH3v7Vev/wHlf6QRAyxdcoYRHAYV7uEYqF8GFsJOAVFzmSUYe3/x4KN3h3sa
         y1tA==
X-Gm-Message-State: AAQBX9cPAyO+B6bcw4onfFfpfc1I+sZWin7P77g5KNgpbctH5bCJhjex
        jeiAISm0USA1b4J2v+0BRe4xkgfDnjJImO2c1q0=
X-Google-Smtp-Source: AKy350Y8QVLee0g+OaXal/sS+O1sKc4S/7JBhJVgpl0alwdt7R12D5j/IUpxFUaUSb3PhCx5W07odD1o0cSUnn6BZ4k=
X-Received: by 2002:a05:6402:3ca:b0:506:8da7:fab7 with SMTP id
 t10-20020a05640203ca00b005068da7fab7mr7759899edw.10.1682185917565; Sat, 22
 Apr 2023 10:51:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2012:0:b0:20b:da13:9ec7 with HTTP; Sat, 22 Apr 2023
 10:51:56 -0700 (PDT)
Reply-To: akiraharuto@yahoo.com
From:   Abd-Jafaari Maddah <dongy7442@gmail.com>
Date:   Sat, 22 Apr 2023 10:51:56 -0700
Message-ID: <CAGnEuTvjzLi61+HVQ+6UT=YaJ44NLsrBqExtdJ39R2FPPK0zJg@mail.gmail.com>
Subject: Did you get my mail
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you can.
Am waiting,
Abd-Jafaari Maddah
