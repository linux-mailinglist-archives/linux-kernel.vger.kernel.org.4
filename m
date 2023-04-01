Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E26D325F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDAP1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDAP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:27:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF74EF2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 08:27:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id cv11so3852665pfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680362835;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28ktjE1NMsXfKN9t4WPAwEL52FnPF3RT3R2lcaspUbo=;
        b=Y2w3La3N+45UykcFCG/R5KWGhKFWQd2f/csxahJNTEGPfLyYLIlhPK4wpSqRsQP2pp
         sfEPFtsjthDb+cCUlM9OaKXxEJ8wwP7QDk+piZSdQ8CvMYJvgIib+mGBREGsdT4Hsdxq
         Ia0kL2TGqYd2r4lxx5bJiMp5IM+DIO0qF7dCygbblw0j7qHp5F13EYEQhhAIGRYuHF32
         h5pQKQx82DHqLn7WkQINCud2JIU+w7kE2mMsKTlE2Nih83Hk+nmwSVQN6J4GWWMMtgZj
         hVoJCOwPaa/vK9FYL/VBARERFwfe+/ULOXBLLpuKLv36Q8vcmMyqCfI0elUFZnmxHt4y
         QnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680362835;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28ktjE1NMsXfKN9t4WPAwEL52FnPF3RT3R2lcaspUbo=;
        b=GBugWZ21WKes/Ro05BzUP/DHUk1E79ukGdTh+uFqHt9lVtFYEr0nBbixdl/YjZUzgm
         HG8/s4y2hvWlDiXQwUHk9dEXvOuP2XIoGwsiTlb4vOYEroj8QYtyUKSGsOC0+4fdtPgX
         Wif5vnMz0hL6UPofBtrOEb/Qzhe7XI/nUD/FdyF2xxtEdrYyXi+df+z50FBygaZfv0yf
         73oTIM3k++0hmHtIxWNi14tDtUAaiwyZziQFsUysEjEXx06UJQ23A7S6hTRJD/wtoA+F
         o7Dg66SKJReJT8Ooo9NXaRhuw2kajrvnDn1tB1GO41MBvs6zMOvESZjYdFeEfgQDHNvS
         cVlg==
X-Gm-Message-State: AAQBX9faXjKXMPNAs7xP8zIFK0FBRThJEvZCNwQDPFVHUEUjmbmkBqby
        9ag5yYR+CG7hDnsCoVUp+7a9U2ok720nMXY4n38=
X-Google-Smtp-Source: AKy350YPtslOF0qyakoutQbeCY0Hfa6nu7a4ZrbjfRWlpNT8pa0gc5UxE8ArzwtI41fbPLc+Qkvus6EwwWWVPSjC0do=
X-Received: by 2002:a63:5516:0:b0:509:4ac5:7f3a with SMTP id
 j22-20020a635516000000b005094ac57f3amr8436193pgb.0.1680362835088; Sat, 01 Apr
 2023 08:27:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:3609:b0:5e1:afc7:f8e6 with HTTP; Sat, 1 Apr 2023
 08:27:14 -0700 (PDT)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <ekonambroise.tg@gmail.com>
Date:   Sat, 1 Apr 2023 08:27:14 -0700
Message-ID: <CAJRNscwp3KjFAzh4OVjkYp-3msgVey5cd=pYHHs9NbFT-TmXCQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
 Hello  did you receive my message?
