Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E66C32B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCUNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCUNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:22:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2322684F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:22:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id cu12so3726015pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679404926;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21T2ruoV7Hb2byNjXRrKdStLSJ9N1tOpZrLYkVqWI4g=;
        b=Huli5rHB8xjZ/PvuKC/Kxl1vGQ/ACUbRM7LSmVzGard3IMne+90B36HyDOmD5XhUbL
         Yoq8kVKaLoMctiQ7nT9eMSYPwO2aBScOz+EaFN+7MLWSqEnK5CHVx6bdNsNAf+SnrdqC
         S3ONVUFNj0FVNVrwmNGOhLz7OrEsZEnCCXvWW5Yn9AL9Z0LK4BQ7g7ewB/PmHTCKMms4
         fvyQRW2t4RkomJkBdS0fVk8AQHO93G0NdNnu1NegIZXYIg+2FQgDL41LEWPtAGSh/yVo
         ORJV1rsg4OdyUuDssywd/TFMn5fDyIaUEmaaUK4EW8t3O62HQrB7kozz3WJtXCulPGvo
         tnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404926;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21T2ruoV7Hb2byNjXRrKdStLSJ9N1tOpZrLYkVqWI4g=;
        b=4z6FKCQHE5pJumT0JLm1WBUAyCt7fQrk2gX5TG5QT/o+2Z+0nU1eV8ftxAe93Kl8sZ
         fi3h0i8PHztSXcGTv0VuBmewcAXyEdljfzYJ9vjszgYruNk2byDh2Qvck32nVOd+7uW/
         57DirVsKFtNyEa6vkq/3nqzPQFaHwV2mwSVHXLTyr9d24wXPVWviY5KQ1UIiv1f0Gn6d
         RTcuW43njPZL7L/o7YZhx7uHvOHgIJd+TD4cqoBwiYqjRXhpFLy2sjfMm9RsEAz8JqEz
         +TS6QW7rOHbp93eqGtpZxWmk20+2ORaQ/qjiWKkN75+V8+h3BC3q2YYqlj4NzY9EtJlM
         1LaA==
X-Gm-Message-State: AO0yUKWgzotV5t68+uzfurFnr9CxTe4E76bj95XRL44FBCBr7cJUv0F8
        jTrqelhs0h15T0jFf7Ayn49ZfqdM3CtmZsJ8L5UcKG7pT4SvVQ==
X-Google-Smtp-Source: AK7set8BLwETHu9BGegnVixuBn2qniIOtF2F5lXu9Sfb/88AoPZz1I3Rpd8VIle1R2CcZE+10lyJBo7v1pyp+RIK5OA=
X-Received: by 2002:a05:6a00:3214:b0:625:563e:7d17 with SMTP id
 bm20-20020a056a00321400b00625563e7d17mr957231pfb.0.1679404926558; Tue, 21 Mar
 2023 06:22:06 -0700 (PDT)
MIME-Version: 1.0
Sender: abcdefjhigklnmopqstuvwxyz@gmail.com
Received: by 2002:a05:6a10:d5a1:b0:46f:e435:8630 with HTTP; Tue, 21 Mar 2023
 06:22:06 -0700 (PDT)
From:   Mrs Suzara Maling Wan <mrssuzaramailingwan12@gmail.com>
Date:   Tue, 21 Mar 2023 13:22:06 +0000
X-Google-Sender-Auth: hCqEeUqPtuW_QUJdy8gxpZnyzL8
Message-ID: <CAOcMXG+ZhPJFvzW17hcQ3+ge=wYDNN0s-R-Pw8Ztuf0A6umQeQ@mail.gmail.com>
Subject: Mrs Suzara Maling Wan
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Suzara Maling Wan, I have a desire to build an orphanage home
in your country and also support the poor and less privilege in your
society, I want you to handle this project on my behalf, I have $4.5
Million Dollars with Ecobank to execute this project .

If you are in a good position to handle this project, reply for
further details of the project

Regards
Mrs Suzara Maling Wan
