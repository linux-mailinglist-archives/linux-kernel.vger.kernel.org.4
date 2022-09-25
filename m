Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3F5E95BE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiIYTyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIYTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:54:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348052A428
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 12:54:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c198so4755377pfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=jwEIe6YkPgtX/JOQmpaIhnWs1lb9ZgB4de3iiAY8MmQ=;
        b=af8qHLnG48E/+pYQ9+rBvY/yJVzUnNpXMY1kp8WDA66nrpAm6JrxexQ3xnPh4SEDBR
         g2CpwltsSD5J8q/rq+Iq4Dl/vvVsVyvv1M2H0X6hQENomIGb8p+FQREgpGyKWhE/ETAB
         LuOYVTP12X6d0QQG46XjAbge503VG66bBWxkfoC9oPSUs0Zxi857r3r+WQjp9j8MWE/p
         0P68owh829a3IgWL2gLYSwbqt+MugrZWOStzxWJv8cIEpGfDF3dm6WqK/MLMI4hgoIwi
         V8iOgISko/wCH2uFa1z5zMMXZMrZobb9pzqlkKp2vo1mRPCEnci7gDCAk/Nocu4iDD9x
         zD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=jwEIe6YkPgtX/JOQmpaIhnWs1lb9ZgB4de3iiAY8MmQ=;
        b=QxlbnFBa0Wf++tPGEnEvSR1TO881TR8v5FyBEpcZWWLiQNt1myCJ8tcoUL5dcQxkQZ
         P7z5M0e34rmPK/TlzBCwSJm1BcTWoM5YWkk3WziWI7nI24d1L3vIz1ymzIcBFbXK5EH+
         zQz8ymRS9E/NUFYuSJUwUI66rHmnzy3aWhAIP7OvsSumrMRVQUWZIEBJto/Tmsf7TyqJ
         dlEfGHa89FmdvB/kPV7eJdsTjsqnyUt7bMA52IpUPaJTcPEbT3GTCeenpdIpGrfO9Dgt
         WKWMQ4MVKZtttRvKfzrB8iF5j9bGQAFxeaBMTXN9Ms0hCnMvVkCNhE2F2iydZo/Pw6Xz
         wASA==
X-Gm-Message-State: ACrzQf3oEfWzkVOVSfUZ9KBvY0p7ZmrXt7d2tAeB/B9t9jQV92yRUGr+
        bDcZ+E+dSs37kPYajBNJXG4=
X-Google-Smtp-Source: AMsMyM4WlUcSsKZSsSPxRVAsXDtRCNKW/JGdJ0jiVKdGBZPb02KNh+S9HPi0H+OcSF2BLvzfDP0ZMg==
X-Received: by 2002:a63:6c84:0:b0:43c:700f:6218 with SMTP id h126-20020a636c84000000b0043c700f6218mr9043083pgc.420.1664135656659;
        Sun, 25 Sep 2022 12:54:16 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902784d00b0017887d6aa1dsm9626142pln.146.2022.09.25.12.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 12:54:15 -0700 (PDT)
Message-ID: <8ce72b70-d1f0-8ff0-e44f-fea41daf40a8@gmail.com>
Date:   Mon, 26 Sep 2022 04:54:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
Subject: [GIT PULL] extcon next for 6.1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v6.1. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.1

for you to fetch changes up to 08099ecd9216219f51cc82637f06797cf81890b6:

  extcon: usbc-tusb320: fix kernel-doc warning (2022-09-26 04:40:13 +0900)

----------------------------------------------------------------
Marek Vasut (2):
      extcon: usbc-tusb320: Factor out extcon into dedicated functions
      extcon: usbc-tusb320: Add USB TYPE-C support

Rong Chen (1):
      extcon: usbc-tusb320: fix kernel-doc warning

 drivers/extcon/Kconfig               |   2 +-
 drivers/extcon/extcon-usbc-tusb320.c | 232 ++++++++++++++++++++++++++++++-----
 2 files changed, 205 insertions(+), 29 deletions(-)
