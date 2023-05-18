Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DD708B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjERWQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjERWP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:15:59 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969DE189
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:15:58 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-ba71af5f164so3627070276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684448158; x=1687040158;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO9f5CT2ia7GU8VLCzu0lYJO3bSIv90+u4wCloaZT54=;
        b=XM2SfLi4Pm+ES+a9RcLoSeXxUr+QaLIdry6U0/dRzDQGFeAM3eFe3RvfgesXJDZ/0l
         nt+IEY8KYjreMvHxwmkS3uZya3njimpxxKv+lxggYUW9JKsbbw41lzJbrMlAcwLALX9q
         OBvpuTPq7aDAYCnkRuWUFot3r0v+heja4NcHf0Ye1l9qKou5EKnAP5eJ+KE3SRi5fsW0
         9fZbAenUU2UY/iCIkblaIwL0ECxMy8QYKtS9Yf2sJ6p6th5KWjUHxhD8ThJffIgo6jqv
         ZrusDTEN5HTTuqc3+eMYZ7kjrxr04HoKrTQC2qPJ8KOjMxJ+TfsG+CF3IND4rQan4rVl
         X+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448158; x=1687040158;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lO9f5CT2ia7GU8VLCzu0lYJO3bSIv90+u4wCloaZT54=;
        b=Qq5CwXPCvqFQyldJ+NQI/zS1KXYu0TcXiZ0qzKMZZeLjkTJiCK0TQ6o/EY0nIMHp8D
         e0kUgEHST3siugC9vSrn5mMi/ayYt3r0oLGkfvg3UloktgLxX7m2p4yrSP0NUZ45UnBh
         0Il0TW4TntsDKGl0Ykq73qTCxwuFDEndTS60TsrvPMUNow+ieH114rP2+FgSri1rwyqe
         G2+Fz8lrCPSbJZeyT/qGYpbpjdmAC54FZCn/f4sMAPJpiS8osvcLtx2AzqAszaCWHvRq
         M/Vshm5u1h4izRDQe+vG5+3diajGuhLJRhK4LKpaza7ntKLantaylscdQOdUzgX2xo3Y
         5UWg==
X-Gm-Message-State: AC+VfDxB5a6NOjED785ib8uH1qDJZkdxjRLqT1MnF3E+rjjhc/A79NZC
        v6byqPezmPEHluLv6gW9A/qjYSxeZWTWQC+1ljc=
X-Google-Smtp-Source: ACHHUZ50+zBaRx5Uam5bIfinHflOpTLKuyh6fVFo93B9d8HUBEnvymiTpydH8nKWULpek7LINfcd5LZG775JuUlnLko=
X-Received: by 2002:a25:73c5:0:b0:ba5:e465:9df2 with SMTP id
 o188-20020a2573c5000000b00ba5e4659df2mr450835ybc.18.1684448157637; Thu, 18
 May 2023 15:15:57 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dr.ava.smith2022@gmail.com
Sender: msaminamohammed2@gmail.com
Received: by 2002:a05:7000:7655:b0:4c8:34a0:1b2c with HTTP; Thu, 18 May 2023
 15:15:57 -0700 (PDT)
From:   Dr Ava Smith <dr.ava.smith2022@gmail.com>
Date:   Thu, 18 May 2023 15:15:57 -0700
X-Google-Sender-Auth: U1RGyq9q8dz56-qBYAyUee5Wyks
Message-ID: <CAFJAnr-H9uuifhv7g+oTT12Ast__qPP40U8B4=fZ_B9sF4Cz7g@mail.gmail.com>
Subject: Good day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you today? hope you are fine My name is Dr Ava Smith, Am an
English and French nationalities.I will give you pictures and more
details about me as soon as i hear from you

Thanks,
Dr Ava Smith,
