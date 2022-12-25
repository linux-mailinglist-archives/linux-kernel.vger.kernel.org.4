Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20989655D41
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiLYM4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLYMz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:55:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50B267E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 04:55:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n4so8846001plp.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 04:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=EKgBkKeDgsw7n0UbF/PGSr3NaJkGxOFxRG2SXYI6WiWPNuj+ou79vD9oXQ2g/EPcBq
         T5gcSBZkepIhn5u6cs8DKjrx+5MRvSgFTK0Xw+v+oloJDSghZ4qbEyoyoZ3lAj9bbFqj
         wyx1474noUagg+43t9MBcYjjw+pbS4FVZoXAGLSTrGZaH72cJyvU6l8sziu+XgiepQM8
         qxHcuJ2SHHvR2G+JEvRR4rKevtl8dN4K4Q6P8g9nOnEAZQDx1z1xf21AuftuJ2Es2s81
         T2liqHeazJqig0QfwKtqVRzqk4rKRqvugZq3p4KkyT+yosBkwUi+gh4BQ6+rJNayPriV
         6twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=n06opQHI5FaAdvbZGgQEMbRZXQMUU2zrpMgx13L0h9YCOA2S9IcUmROdzgJbhhk2eH
         LRJIIqhfa5D7y28pWbvEU4LIkn7dTkmA420570XJ2SoWONFESN8n7Trw9nKv5bCIBR75
         KU9aQu4wrsGYAiOoAiqsUjeyB41PjF8xFBgPxo1owdfn0oG4/bMMYUD5Uw8OprgIDIx9
         jFTz+OTDDc9TJ15Sxk0N8mz73gWgO3B1ILvGfiZJFPx+8JwZmgXWni6K31AwRYE8Xx7Z
         ciPx5vYmL91CJgXiGIebZKo9R/WKIEh/qnf3PSexn4gyKgfo+7/Uw/JsSEehmGTMooof
         6COA==
X-Gm-Message-State: AFqh2kqeDHzzX7ziC1caVjoXqPO7fIte4JqvAZ5CGwLZ09c6GFMS7meT
        6y0amHKOAa4zwkykd9bN6K7YQCr5B0lyaGCHdWs=
X-Google-Smtp-Source: AMrXdXsRriTr5Kupfjg0K9mJy6V6B+MG6UqE703kdEODs0NaPqjtYnnuqPfGr9JhHzdam4fsp5EQjK7r8fYkE7AWihY=
X-Received: by 2002:a17:902:82cc:b0:189:efa1:2967 with SMTP id
 u12-20020a17090282cc00b00189efa12967mr695988plz.146.1671972956161; Sun, 25
 Dec 2022 04:55:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:426:b0:355:aee:3359 with HTTP; Sun, 25 Dec 2022
 04:55:55 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <boiatoaka@gmail.com>
Date:   Sun, 25 Dec 2022 12:55:55 +0000
Message-ID: <CADjH9KjroTqOuSFQLHT+sKbgcZSFWHB+i34UTmMcRwyxx6u3Fw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good Day Dearest,

 I am Mrs. Thaj Xoa from Vietnam, I Have an important message I want
to tell you please reply back for more details.

Regards
Mrs. Thaj xoa
