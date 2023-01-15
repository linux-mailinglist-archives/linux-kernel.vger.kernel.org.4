Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1566B033
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjAOJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAOJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:47:44 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E3B46C
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:47:43 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id pj1so12935620qkn.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7m5UdqDwB7t1NnrnthxDoXKdh27h3gu20ETW4b3CRI0=;
        b=SUP62oYBofBeJN7NYC9zeFQuO7jTqrY3S/4lR20c5ZMEAsxCx+KFHGCYY7VC/lfza9
         vc72b3GpATSyVUwDPFe4aNigJdLT9y0CkAThgrvejx02lzNrqhhZK+3o+JA68NA9fR+k
         ngddImndbwPxP2NCznLjjnhlsPHwAXWogzg9o9VJ7U28rY1uxS8sXdlDac06yTm0H/wA
         1x17p0Nqmp3Gaa4uvm91LS6M0kXWhkDBVAiPpQDYgmWe/afAbKIrgLKSas6eml6DaJo3
         wNy/OIMTbrErmx4yE+HX5+q+oVGd14ftPG6hMjrpkP+vKIjJGxJV0Ovq07V0d2/AO8ri
         qXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m5UdqDwB7t1NnrnthxDoXKdh27h3gu20ETW4b3CRI0=;
        b=MTV/cLjvL/lwE6ljsggP1CuFDMrGLuc8NnwbucjDxIdJDaPaOBebiQ+N/zpdTNQjo0
         GOfnASbakPqffJpaIFJ5O1sBXBV8ILuQVzlTilsE+jU6gb8lLSZMo1wI/p28ZGPn79Ww
         9zeflK8taT9Pr3L4PWvuBdllpRba90xZUgQS6etmwRduwrYdxNEbBarj771Ae5L4zVjQ
         zcWTakD0RQjeM31dZYjqtSIDxCvnJiH06BgEb1uyO1c/zIc3kHnOAwHlSw7fh/1txTjm
         xOWPka5RXMRu5GYGeyxFrA28vkq2IjWpddR7nof7IcMO4t3I271sPV8g4pmw8kM/eNS0
         1PIQ==
X-Gm-Message-State: AFqh2kqVvqomsvxzzdVAXBGTlVW7buygAy4EPrtUjXSMNAWViKk+CoWR
        b5znHsOU6+aMAkQ+6B8WVln6cp3pOsDR4U0apYU=
X-Google-Smtp-Source: AMrXdXsa/rFC2xU0tajAFrNxnkYCoMX9kTirBNB2BA171R47NuXScmvsmOE+GsVrObGC9qkcJ5PcFZS003UDsEwxGLk=
X-Received: by 2002:a05:620a:c96:b0:706:3283:f106 with SMTP id
 q22-20020a05620a0c9600b007063283f106mr112040qki.510.1673776062862; Sun, 15
 Jan 2023 01:47:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5150:0:b0:534:252f:6822 with HTTP; Sun, 15 Jan 2023
 01:47:42 -0800 (PST)
Reply-To: joejess2022@gmail.com
From:   JOE AND JESS <gloriousmike64@gmail.com>
Date:   Sun, 15 Jan 2023 01:47:42 -0800
Message-ID: <CANW8Q-Etf6rZc1sEYiMA9i0wDNdjUMNc5fd5+AAK5_8tA=aG1Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Einen sch=C3=B6nen Tag dir,
Ich bin Mr. Joe, wir haben gerade 184 Millionen Pfund im Lotto-Jackpot gewo=
nnen
Lottoziehung. Wir vergeben eine Stiftung in H=C3=B6he von 1,5 Millionen Pfu=
nd
jeweils an (15) gl=C3=BCckliche Empf=C3=A4nger, um Gott unsere Wertsch=C3=
=A4tzung zu zeigen,
Antworten Sie mit Ihrer Referenznummer f=C3=BCr Anspruch SG6745:
joejess2022@gmail.com
