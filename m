Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9565E608557
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJVHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJVHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:06:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45E2A79C9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:06:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b2so8746749lfp.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKp0vNQJo1Xjancyd+0lhoBs/j1rOPyn9CnjbmCY3h4=;
        b=N9jN1oR4Tl0T5jyg3x5iKJa8xLdEYKinhrjmzufnw2qDIQkR0IyFYM8zNzqDa0qehy
         0BAtdlc7B+C7OdpATs/zbuwdvmcSg4+Se6//Ew+twkb0zuZagLdT5l7440NWSHLuCFhU
         yn74RR+sEaZPXt63syylA0d7yl6WcuzRDs29/geUfEq62kgVDW3iyFYX/r188kmx+m/x
         v9p2h+DK460iYGJYdqxY+AJNFOcf0txZauXuaq7TFJmlLokNqbtudpL02sun7IJOAtLt
         ExT/wPX4TiEPhS11wmGO2vCuziIGdm6an4kBARMZay/R99V8COaSteWoZ4/Tu1/NR++5
         MyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKp0vNQJo1Xjancyd+0lhoBs/j1rOPyn9CnjbmCY3h4=;
        b=SePCde4P5L5wcyqOacqXaJk/8OLgDLG3e5nF8GNqqrjh7q96Sk7dwv0JYaDFDNDeSU
         wFZXEGYwANkUXt2qOokoJBYoATrctLReaQ2xY3PGmK49ZWtKm7An4cUqTQGvT1nIEDGr
         0qQcm+nbyL0KPlfbcHOyyT7FnVniQNrYsBsvv7FItBUjCAel6/hxu47qmN4tVLV4Yl/i
         2W46XOaeI7thHS8XoRAqsAfC9RzpYuGU9J4gv+h9wwvNo4Rs7IbKCzDwnyXCAZBjLhZC
         TYe/QoYwiEv3P5rxiW1iECaOYUwZGzZ8V82ueACrC2ijTad8UJPvsz7zBRJ6y9OEGnaJ
         M+pA==
X-Gm-Message-State: ACrzQf0ox2H1gMImHfpmp4f8p74RUt/BGnIARke5ljCXEQ5eR6IzPNUK
        HLyQNi7WMFfFVD0VMMr0APQGCqtqFjeo4QXw
X-Google-Smtp-Source: AMsMyM5i8jcmTVSuJJsemiVoGPbJ4DVnYIne0FheNXPwydmvxdU908gexeN3q6ZPBOj0rv/rduiDYQ==
X-Received: by 2002:a05:6512:304e:b0:4a2:6c66:8355 with SMTP id b14-20020a056512304e00b004a26c668355mr9101117lfb.238.1666422381725;
        Sat, 22 Oct 2022 00:06:21 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s5-20020a2e1505000000b00276d2537921sm390404ljd.59.2022.10.22.00.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 00:06:21 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v3 0/6] a series of checkpatch fixes on the file: rxtx.c
Date:   Sat, 22 Oct 2022 07:06:06 +0000
Message-Id: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixes are similar, mostly long lines splitting. I had to make
serveral patches to ease the work of inspectors

v2: fixed a compilation error found by the kernel test robot and
recompiled the code

v3: tends out the error persisted in the second version. this version is
a correction of that

Tanjuate Brunostar (6):
  staging: vt6655: fix lines ending in a '('
  staging: vt6655: refactor long lines of code in s_uGetRTSCTSDuration
  staging: vt6655: refactor long lines of code in s_uFillDataHead
  staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
  staging: vt6655: refactor long lines of code in the rest of the file
  staging: vt6655: refactor code to avoid a line ending in '('

 drivers/staging/vt6655/rxtx.c | 532 ++++++++++++++++++++--------------
 1 file changed, 321 insertions(+), 211 deletions(-)

-- 
2.34.1

