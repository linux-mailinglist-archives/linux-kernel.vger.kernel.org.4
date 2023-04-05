Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903396D88EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjDEUo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDEUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:44:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B883EE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:43:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id fb38so24528812pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680727435;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4H+bNpp97fNs0DJvfrKKJ7SEqIL0C336vSLgUyHuDQ=;
        b=Om68ZyUCp/ZkLZwC3LCoeW1h+be29f6OJ+AGs+AJLrJDvCTr0mxAtCl5v8tBaMPAzd
         hXEenKg3f12YIrEjd0N3epUP0kwEml7Q32pkavC2HL2nx7ZRxQSqrRBnLilf6m0h8i+O
         WNx9AI/GK1b0tldCyeTy6Lr3hvafXgqi8lmsH2DM6/h9SSsE2GKddty6leIZHegLxnnf
         Msc5hjA1xonNwZt10iUvWc5bN756U1NSJPdCFZdG21NGF4oF1pkQkBlIewj0VUoeKxpp
         gzQhwHgDQEd/ebQoTUw9tSnq+WE3e6itdZhCnN/F6NamjiY8hhln9ieytA11gKq+u0Cx
         aQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727435;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4H+bNpp97fNs0DJvfrKKJ7SEqIL0C336vSLgUyHuDQ=;
        b=3ddLZxWmE2083e9IEN14QAq0hDcAXovom4Pq4MJCnrEv9MbCb4mF8RlhCpvwKuUeU7
         SLMupt85k1SUbanlFmz7ghSotGxEhqtiUthvgARJksu7HvEGfuMc2ioJpOx9FPylVDER
         0J1krf4Vk8+ZY2YUT//Nglvyldh+E1mc4zN0tfOjibEunPRaNglVe5F/hK2iWZWq5cQu
         0tl873xkN6F0iioMUpysXmxcg2eVwyEPzpvs1L8444pPwJLv8xZSlb/BLcmqqgH0DAfx
         JdUI0G+I1nImczbkekR1wrWPca7ZfHNJLcDkzjlw9ruRYCGvnlVeWSa5CexuiIjzZ+Zr
         ktAw==
X-Gm-Message-State: AAQBX9emaQuFfXcekaHtYFh4OYKPg7uWfR7vzLLCNEFog0jJe2KpeaKP
        KS36PklX9CWdkIGAxX+zvpEdATkPXUU7w8ZlIQ8=
X-Google-Smtp-Source: AKy350YWncX2ZEW9kTDSPMWqqfCbXYij8DvJcnJq0eytmiGQvp+K8gk+xynAQXwJcDTJ6tBxx61AhbxSEx2pek+SnMU=
X-Received: by 2002:a05:6a00:14d1:b0:62d:dd8d:56ac with SMTP id
 w17-20020a056a0014d100b0062ddd8d56acmr4048144pfu.0.1680727435118; Wed, 05 Apr
 2023 13:43:55 -0700 (PDT)
MIME-Version: 1.0
Sender: zinsonnigerome@gmail.com
Received: by 2002:a05:7300:a21d:b0:b2:a95:be79 with HTTP; Wed, 5 Apr 2023
 13:43:54 -0700 (PDT)
From:   Mrs Aisha Al-Qaddafi <aishaalqaddafi3@gmail.com>
Date:   Wed, 5 Apr 2023 22:43:54 +0200
X-Google-Sender-Auth: 4Aa0HlMgFUWJsoGTuBnwNiIfZqs
Message-ID: <CADkSFbZjkm7vsnA1h_XqC-ATYyCf+TQm+MR2Q9A5X44s9c6Qog@mail.gmail.com>
Subject: Assalamu alaikum,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu alaikum,

I came across your e-mail contact prior to a private search while in
need of a trusted person. My name is Mrs. Aisha Gaddafi, a single
Mother and a
Widow with three Children. I am the only biological Daughter of the
late Libyan President (Late Colonel Muammar Gaddafi). I have a
business Proposal
for you worth $27.5Million dollars and I need mutual respect, trust,
honesty, transparency, adequate support and assistance, Hope to hear
from
you for more details.
Warmest regards
Mrs Aisha Gaddafi
