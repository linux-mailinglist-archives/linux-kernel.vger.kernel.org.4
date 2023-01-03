Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F765BCEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbjACJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbjACJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:16:52 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F485E00B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:16:51 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b12so19719071pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bsv6sMQmC8jnqT/6rqRjPIfpOBvg88+WOYXR6wIOiQA=;
        b=L4QCsZXhT0TI4pII995xIoC8oBcApkNjMLwIlf8yMRg7zzO3FrzwFQvMLGolU5OrE/
         86c9067Rl5c/xwReGcY3Beux+Bxn710Ps6H3eQbBD4wSoLKvAjcEWyOe7rd9JIP9KhbH
         UDU7ailCRql3J4cwjVaNlpAB3iGFS03SeexT6hHm40q+ChO949CQhuS+6Lf/lcQjpMkR
         p2p84FbAzvkv6f842OaQbZ3AIAnFPStoLQmj8NBubn0gCPSqKKd68IIl5hYByZY01ciC
         YV6LJUVYuebaot6nsNgnybAbzO+cnPsw0f481H8ZWwMajHwB8kX5+K5gEVv2POyh+Xhb
         JL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsv6sMQmC8jnqT/6rqRjPIfpOBvg88+WOYXR6wIOiQA=;
        b=Xvk8L3MjGnSrCX1SPETn3bV6tqx1Gaj2tFtCmIPOc31RXelNnwgPRiTpkswiguybe4
         rqaZXwyQzV6LxLPqk7LC05BxdzINRnCc1eYL+QYL2lTQ4LDkxAe+E4sSetcyLMpN5khO
         BwdhmzJkneDYO3IqYMlHDQYUEoE2qcTZe8HddqYzq/T46yvmgkVoMKV3YxVLFld9oYzv
         U4ZS6d1uZf3NQFJnpj30+aMZBLfZPljp9t2F2x+sXd0Td8vC7+Ymf/BIWcwvB0DPyIRt
         h4Q/nt+oco7yymn9cA24z448oVpbe3iL5iK/R+Sj87atvonspaokSiMsCI7UUp5ffJ7A
         RBQA==
X-Gm-Message-State: AFqh2kpnQA1owifkZBlTTiCv3a6CY/O/NkF3CweojVW6lEU+7eWuZkAV
        FJpy98bbBC11cbBdo0sjdSCVjC6K/9FF83ZpNLE=
X-Google-Smtp-Source: AMrXdXs3E68GZbSTpVJkQcuR2Jiw3YB2ske2uQ6M2uucmDEpw0b2yOcpEVWmo4neMh8L+HEa4/sqK7BdvOzsdBx9h1s=
X-Received: by 2002:a63:3cc:0:b0:496:508d:6e43 with SMTP id
 195-20020a6303cc000000b00496508d6e43mr2590938pgd.245.1672737410584; Tue, 03
 Jan 2023 01:16:50 -0800 (PST)
MIME-Version: 1.0
Sender: lilaeric8@gmail.com
Received: by 2002:a05:6a10:4a14:b0:3a5:cad5:78d8 with HTTP; Tue, 3 Jan 2023
 01:16:49 -0800 (PST)
From:   Aisha Al-Gaddafi <aishaalgaddafi112@gmail.com>
Date:   Tue, 3 Jan 2023 10:16:49 +0100
X-Google-Sender-Auth: JQo9s1OrlFTB89OmOF8Xj9T6B4w
Message-ID: <CAPA+_mKV6+6bLCGxY390HRMmBwTD18-R8AynMdYm1fLiS3C9ZQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

I am sorry to encroach into your privacy in this manner, There is
absolutely going to be a great doubt and distrust in your heart in
respect of this email, coupled with the fact that so many individuals
have taken possession of the Internet to facilitate their nefarious
deeds, thereby making it extremely difficult for genuine and
legitimate business class persons to get attention and recognition.

I am seeking your assistance for the transfer of Twenty Seven Million
Five Hundred Thousand United State Dollars ($27.500.000.00 ) to your
account for private investment purpose.

I look forward to your response.
Mrs. Aisha Al-Gaddafi.
