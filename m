Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80F60325C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJRSYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJRSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:24:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42411A3F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:24:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l28so10221885qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=OMLZySaKL/pskdCuvqdShNx1OMtSIFtfQiHNYRn/AWGPk61iQvjKMAMVuf1be4xwd0
         RB4fhpukkU9svy04u7RELAR1Ll7S9HS8S+VVUosDEqtosED+kwjRZVn5lDkBSXiTjuZO
         Q8pof/7ZIuExOk2WMtDaxR2XK+Y92rZWdtIVdYoT4cEVZaZMJD1Ewc8YBeMmZDKvPzbR
         lIA/l7lf59YxLjQRDykcKGg5NkYzBa6xhZpargU28PJeNJc4oziO3j9CSOcwJzR55IdW
         HPqSa/mEc9mZSUL1Cck+cwr6Ap7q6OmJmn297N6Hufz7e+GDVnY4LhzXD8BcC1Yc0I+S
         PmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=4jYCahzEpcnNQZ6S63Tvb3Vx4fPTna6ILm63lmvbwAlOdt6ZIwzv1uGhXyb1H+OKQF
         TaeZ1xeEue3b2EJCyYqNxxDtpo7eNcilsYR7xdk/yohvnAoCIfcaEW1KQn8I7YJAFBMy
         Hf/kuaHperKklFW8Mb0LwQyH1UGST/RVvh9kj61ZPh13xg0rPgCvFYDuaqvG74HrGUcv
         XaCv9fXqs7FHeRLycQbPbCtcsJkgSqlShQz778vv381BR7xpS/GrsoRz5lB8ngP8y6Ea
         DKKufSY0PYaVujtma6pO8ZYFc4wcXChru821Qr7fcdoY6dHZ2xsa7N7B3vcp/c8zhBoZ
         k89A==
X-Gm-Message-State: ACrzQf0K0B36ljIQkSwXLX/xL7734xKXJOhrmh0vNzEo5XCS84z2GG8Q
        GZz5/qr7JFWvFYM9pY84Q1Z4DfT5chCVWRrZhXI=
X-Google-Smtp-Source: AMsMyM5wmyjZm7WAwRym/bWnywZM2tuLCLmL3Gq0pYk+rnP/C98mI2dzp542bB5f0mKjJLjuQPWaDWjAW4Tyng4EX3Q=
X-Received: by 2002:a05:622a:1649:b0:39c:f2ad:52d7 with SMTP id
 y9-20020a05622a164900b0039cf2ad52d7mr3225409qtj.219.1666117465972; Tue, 18
 Oct 2022 11:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:511:0:0:0:0 with HTTP; Tue, 18 Oct 2022 11:24:25
 -0700 (PDT)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <powmrlee@gmail.com>
Date:   Tue, 18 Oct 2022 11:24:25 -0700
Message-ID: <CANT8MmdA3ZU+PKyz7+274Qn1ih-FKqHFC94wTv4=TzuCgekxGw@mail.gmail.com>
Subject: Reply and let me know if you received this email.!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear, How are you today and your family? Want to believe you are
all doing great.

Please reply to me as fast as possible. I have important information for you.

Kind Regards,
Mr. Stephen Melvin.
