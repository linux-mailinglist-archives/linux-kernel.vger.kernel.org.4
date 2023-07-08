Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD56774BBD2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGHEmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:42:18 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAA59D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:42:17 -0700 (PDT)
Date:   Sat, 08 Jul 2023 04:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1688791333; x=1689050533;
        bh=SGHmCpIwY38l448lM+eKMAiekmq1Di2RSHE3CHCAzUk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=HSmP0U2bl14DMa5m3CMDZMhGU7lO7DqfnqUE2HPGJmTJ6svKKA2QRErqoo5dFkK1P
         foFiyLeJ3yLCqDAvko3Lk61mZTwscFmGyRpiWOyYOhpXwfUL1mRViJunMtVv4DOn5V
         xT62iP9uuZm1LrRV6WAePdsObMf9Dfd8z/wZ+CLD4wvYUdN8A3s9w8UeEOJ0AaucnZ
         vgOYAb01uCGmNAEa0dEty+jVyrcFQwn5qBcHK7JhW7rQNIW8Qt4N5nXSdoU5YtothS
         Et7zKK6mfuaPpBxNgho7weCOve6qQ8hDPytoWYakCbWTEnlIzAF4nOaqpcBdltxj0w
         asl9vXZmp1sSQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Turritopsis Dohrnii Teo En Ming <tdtem@protonmail.com>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: New StackRot Linux kernel security vulnerability allows privilege escalation
Message-ID: <eTammZ0M-lzdwQHmfZcc_W15gczvWxJwMtIqc6tFRyFF6Az70i38QtIlNovisYn_ZrNCJ3DbvlNUdI5jzpZaoBbQ-TWSLRWG0l0AgFXcZJg=@protonmail.com>
Feedback-ID: 80245632:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: New StackRot Linux kernel security vulnerability allows privilege =
escalation

Good day from Singapore,

I have just read about the latest security flaw in the linux kernel, StackR=
ot. I think everyone should be aware.

I am sharing the following news articles so that you can perform remediatio=
n.

[1] StackRot, a new Linux Kernel privilege escalation vulnerability
Link: https://securityaffairs.com/148231/security/stackrot-linux-kernel-pri=
vilege-escalation-bug.html

[2] New StackRot Linux kernel flaw allows privilege escalation
Link: https://www.bleepingcomputer.com/news/security/new-stackrot-linux-ker=
nel-flaw-allows-privilege-escalation/

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems.




Sent with Proton Mail secure email.
