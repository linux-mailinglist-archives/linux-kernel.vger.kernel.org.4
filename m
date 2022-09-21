Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E905E5BF633
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIUGWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUGWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:22:06 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5266132
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:22:04 -0700 (PDT)
Date:   Wed, 21 Sep 2022 06:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663741320; x=1664000520;
        bh=JHAN8hDUmY4TwhCUSIq55m5KCjYi3PvCUIVIHO3aZnA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=ry0llVw4fUrQm/mo4xrVmZjwv3uWuXKjovpZ0KCJO/Jo2Lnrxj+Maz7AK2wEzy2Mt
         83uZz0OPyh01ccrVVz121WO/zFlAoOTqkPFOLz5yH/RjcPIpTX831LUQ8iJHWdFVKu
         MpKuG/oyzq0cav+dHBkHUFEOh/bhxLLjZ1bslGoYNvxFWY5BltiTRB6JJo9ULN07Y/
         +lToU7bi56NX2ioiQY+YYXORWB/kGhUKw6M96XLa4g36HIxOBgx40F7UObY91AhjNs
         kBR5cwRm6Pbd/qqYbs1hvDZG3iyzt0RrqA4qIyu/Ghb8/tI79/pliuMh1Dbzn4iUyB
         YNSePWD9O6ELw==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Upgrading Linux Kernel on Red Hat Enterprise Linux 9.0
Message-ID: <CpKl8X2IcDl14oyMpvu33FVZonDe4f-R9k4sHlgFl0bA2KxrGGiXGqRZwHc3pnjNf3wKVZtLiC5qjtkd-a6Yzj-5YHIgsXRAQN8TsfVCWyM=@protonmail.com>
Feedback-ID: 39510961:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_20,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Upgrading Linux Kernel on Red Hat Enterprise Linux 9.0

Good day from Singapore,

My RHEL 9.0 has Linux kernel 5.14.0. Can I manually compile and upgrade the=
 Linux kernel to version 6.0-rc6? Will it adversely affect the stability of=
 RHEL 9.0?

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
21 Sep 2022 Wed
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
