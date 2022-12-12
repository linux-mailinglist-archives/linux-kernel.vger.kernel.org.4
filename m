Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F076498B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 06:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiLLFww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 00:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLLFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 00:52:49 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8478F4C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 21:52:45 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id p18so4680805qkg.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 21:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud2Qp+0j+JXG+xzOTKtAs0iVLtO4HhzSJ3v0hgygifc=;
        b=gvk6DqrKtvGepHlcs7O17mtE5Z5AOGxsQsc/LmKEiFpGNYIPnH7gCeGa/JEFOz8ysP
         jtG2cu/9DmugTZIGcgizcxBUn3C+CPRCH8wEcTxOzk2q8PckUqznJhjUYWOJOY4feocn
         zKdrQ0VCJxdDZpcOmHoYgjfGZyds8P90TwMj2OVgp0iGtTDWheFjZB8CBvaehhZOzl1e
         CoCtplma18IMSyPxDl5T97whk3wKsPRBXJMUmvq8vP1QtgoAZIc9AmLBWwvaLuXOQMVU
         Xg1L8F1ijBopeGlD2yU110g8GxFHIaN0bdYaPsyWYNrKVmnn/NqZMZq1ZmffAQMkoK5l
         +gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud2Qp+0j+JXG+xzOTKtAs0iVLtO4HhzSJ3v0hgygifc=;
        b=ePdR/NgO4SArTlBimNtkqQvv/CzZVwzvoBrd4rGvHxvrLuY9C5Z1zMlOcJh7YTG6cG
         ycdVNGCpyQVFWUxDaSVWbPI7PkbyxDGBJ/ekIw+IHSG11EIgUW1kGJMlB0cW5JcUz5oE
         l9rTqej3XhlC/5pmzHaVZlEJ26guzX+R2To7jh4vcc1xbN0Woxetk2SmdA+omkIVK+x5
         7tBdmwuqp7hL3cypDfWtZAOl8m0eS05/7ptWDM1lzme1CeK7cbCnY2Q3mGGBhLsP7sI2
         hqeOf2hL0wEXtHdOJK4p0rvSRcsq8ubGp5X7Ns31q0eVKTp/oH/yb/Ks8GXSnnV68SWh
         296w==
X-Gm-Message-State: ANoB5pmxYUsQqb/79LMarRxpORrA/lbjKog9x+KPi1eysedL0Hxl+htp
        OTJ9+i2Jip4fIluEQQU2EFkT0ySaQ1HCezSlo2bDQ2DscixtaUND
X-Google-Smtp-Source: AA0mqf4WHV7XwF+Xq8iBrJgszx/PP+zsPtqJNxmer/bZnsOI+MilEfCUEK/D3s1v1Oc6W06NPdBLpjcYy0BctiUVFbo=
X-Received: by 2002:a02:2281:0:b0:38a:6cac:16d1 with SMTP id
 o123-20020a022281000000b0038a6cac16d1mr4014644jao.263.1670824050116; Sun, 11
 Dec 2022 21:47:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:1d82:0:b0:38a:3e09:b257 with HTTP; Sun, 11 Dec 2022
 21:47:29 -0800 (PST)
Reply-To: akiraharuto@yahoo.com
From:   Abd-Jafaari Maddah <victoriastevernson1983@gmail.com>
Date:   Sun, 11 Dec 2022 21:47:29 -0800
Message-ID: <CAF46jtd6wkhbNoFMCdOsNXFxrdfZLRPHRz7Up9qBy5D8d0mfQw@mail.gmail.com>
Subject: Did you get my mail
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
