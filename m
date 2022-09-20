Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17655BDE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiITHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiITHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:43:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100B61D43
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:41:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j24so1452277lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=675CvuSp++zNLeIUZybBsP51nvc83dY+2bSGb3FYErQ=;
        b=NldqLNNc9LwbZVJ34LXYNXA8Vpd5tV0/PS17GA+W2mWPvQSkX7/L0OuVA14Spa6E3o
         otHXGdi2RPGtkN4r73WzqYoxlsOWDzapyylNhTESk+m+2LeHSZZOAD2ZBKS767Wz4SD2
         GFKrJyRuvzsfLgsHleAw7h7/uMl39Gj/OCExpDVaBCG0VF4Yt24gtCWOQnmupW3QhzIu
         YG+yfXTpeGmxY/hLlsLZImBKxyof97u5JNni+IWM/SRKixDflNoG3zNAB3b/4Gk6C3ka
         fnokKyuN2FCGJP4xZy04HvvL23KSWVwSfx/d4FKENhNDDCQ8mvDUJKvqkhOsPc9OeRta
         PVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=675CvuSp++zNLeIUZybBsP51nvc83dY+2bSGb3FYErQ=;
        b=oyWHlMVPYxg/1HDab0ANPldjydiYDESQ0Bxy0xFd01PvpksG6D8C6HObV6h2rDpZDH
         oPY1gs+MYzfoA2NgcdrcmdRrW2u1/yvM/4qUgOYcuwd7ihBMd1aYGiC2fLgjda790+bt
         CMvV8MTDlX+xfhhaH8QR0+C+qLOyCbAkgvqbmVfSy1CEPz1+wbVnVBDTq77VNyFD0L2I
         +W/XjSrnjHPBksIxZ5muRgr2IYNCI2dhcTIyR5yfEyyiPbOuNjvQuBSTyajB5cAIPjSZ
         w6bEvBOThRH7zZolydzcXXg2iR3MALMSMbk179FUOwSDwL5i5YpGkQt1gC4GEoUV6YRP
         Ieaw==
X-Gm-Message-State: ACrzQf2Ul9ZxkKS8m+Q4+bFcH/lMi0XzVPaumILCAf/9dJ/QEunUcitn
        bl1wZ++4t6FTBABz9xU3+hagH6nNVIo171QIOGQ=
X-Google-Smtp-Source: AMsMyM6+StWFkoQghKdSJWCK2y0fw/ngVv5iNMob4f2IaPjj8ePPqjEVdPP0NU5sQ+1t8znzipWM/szT/ly8DQeYWRU=
X-Received: by 2002:a2e:98c2:0:b0:26c:5d10:63dd with SMTP id
 s2-20020a2e98c2000000b0026c5d1063ddmr328232ljj.326.1663659702570; Tue, 20 Sep
 2022 00:41:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:d8cb:0:b0:210:bead:96eb with HTTP; Tue, 20 Sep 2022
 00:41:41 -0700 (PDT)
Reply-To: chuisheung001@gmail.com
From:   Chui Sheung <chuisheung002@gmail.com>
Date:   Tue, 20 Sep 2022 08:41:41 +0100
Message-ID: <CAHNzD9nrkLCoqJZBX_=iEs7HCT-scJQuXodSk8qxcfSEJ7=V_Q@mail.gmail.com>
Subject: work
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:234 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chuisheung002[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [chuisheung002[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [chuisheung001[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you work with me?
