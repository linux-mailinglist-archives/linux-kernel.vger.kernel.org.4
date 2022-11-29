Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68D263C929
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiK2UR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiK2URi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:17:38 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6292B270
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:17:13 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id x6so4401668lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=V8rSLb9Cs+i68CS6FbNcHSzuXpNa7yfMGlgpB/hYq17dea7RA7JaIcu5YagzJ3Md4d
         +CgVOFn5+lvnglvRT3zxVo0NuhAUY5ynUvmMAQio8IEwlte3rQ7SCjUw7xj3g/X9vHQG
         sSiZ+hg09gyOQnZrqLiKcSBrteG/r+fx/2Hx6ctl78XXZhNMRYLlMcq0F6iWf9G20VVT
         hg9BijPXqej0Mltas3xYw2m2Z3GJPTW/rTBcsNdlctk+6UVKnS8pYu1E2NM5QrJzaDqu
         XrfFFOnwPSioPweSHCvTDmEgI6kBRoS4wCGs0qoZ8oh9CkqCFHbnjTbBBoEoVMVdrh1K
         JlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=xMCehfj6UTOXd2yWN5cIV1FjDMDBz9tipAhWiFsJTPtsQddkl0cXsaze1guiqW38ov
         SrKte0hKH0+BPbVBRzqJfL85PvBIAWBqwJgn9DXUnJPgC8oQBPlaIj6LAYNtJdV6o0AW
         enwQiiXneh5oZlujINiufa2C1WeoejUITNETUCd38tEWxrFALfnpOsII0L/LKmTK/1ha
         9i+0mvDDQzxIFweAo+S6Ccl3imhmYIRkmf8UWXexJoWqsU77j4pwfDloisNlXKiEsenr
         qFuEQrHszdOl+oAnC+doxdANqHdV12nee3IdLnqSCSVofk4KqoKeVatjBjkO6fBf4H8m
         zT+Q==
X-Gm-Message-State: ANoB5pnzWmqKKa43/TDWDn0QAxSwQzf4JBEFzNNBmcKubj2F2rsid3G/
        uVYwoVkcNqk+kyTD4AZRgdngdiMraasi3vy9ARI=
X-Google-Smtp-Source: AA0mqf6evAEGpcOA9vXKkbNNPl0sac92/LC/9JJzWJDoQuLJYtxxZ53MbWtwL2p+WTsHqoPsUyU6tRZbHt2evArZ/gs=
X-Received: by 2002:a2e:2c01:0:b0:279:926e:c9b9 with SMTP id
 s1-20020a2e2c01000000b00279926ec9b9mr7205661ljs.170.1669753032468; Tue, 29
 Nov 2022 12:17:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:a0a:0:0:0:0 with HTTP; Tue, 29 Nov 2022 12:17:11
 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <chiogb00@gmail.com>
Date:   Tue, 29 Nov 2022 20:17:11 +0000
Message-ID: <CAAtWbkGWPPXRSpGX5T1vKAteDPKwR6CfGc1Z4UATifQAqhUz6g@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
