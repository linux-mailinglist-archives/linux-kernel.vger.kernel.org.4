Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3B5BEA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiITPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiITPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:39:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406E6437
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:39:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e5so3128681pfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=P4hApzSTN3ig+5xyoF7nxNpV8DASBdWOrcEBJEvuwnWRXN/VAOhw3+ZFui/SSZFR9E
         0kvUzaohqM5H7Hrh/L6+UOaa+NNpZrOUZCW/XmLXBPSh563R/MyyOMQEA1kRHwFugn90
         koFxs2V0KMVaYHTEUwf/9mjqEyWYKjjRy3vg6Z9VL0fs+PmR7+asdC/q6KjIHZSuIS2f
         auXMzMW7pH+9Rhgpz2u49P31TQS/DRJfaO0Du5qZ4ewuYJNMB8H5dUX9gZffddVcG3d4
         NKcS+E/PYtiyuN3s4U5tFEJpwiIEeLgmpoZ3EHcDg0w9AJO7w2whODOHLqMSDHkcZME1
         GjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=RWPRZgWI80WFjyU2noOAVK3W0g4ZdW8+U3dgPORmwj43Mnuf8RRf4BYshRQNCSjo+w
         A5wnSQtho3vTMIYsQX2CP9bDgOI1D2Hofiw1P0/8dCJWDGoCxOA+KncbU9sUtjS/qFbi
         Z1zoJ3TMEhY4zoJTXw5jk7uhYMR1q3HbHlCcKAbH9kqkiHyKEhwoRBGoSqtqNslpk3fw
         BAKT8XzhQTXyl2P4bE1xOHBuK05anM797VSiq2SgLyQwEnsvU+XeVwU0Ejk+3Wufy+xg
         zmdv6Afa6wfX1WgSYsr5q7LU7vjNQERg6/y4YUaMpQbp7G5P34VnTbvCN/R7jHL5dNpy
         8z7g==
X-Gm-Message-State: ACrzQf0jlbndqQCAH2Pt4Gi+46xhKjttyz3pQkEg11rpYnI57JFKbb8W
        PSHfnitYsdpsdGEkRrH8wsTrfix/fG4IvZqH
X-Google-Smtp-Source: AMsMyM6tc1rip55XKr+bTYv/3hiun3E1G52JH3SeK3Dt8+D9sn1TIQhYA/GRuHulG1xJkp+YWiN2kyYi17R0yfbep9s=
X-Received: by 2002:a05:6a00:cc8:b0:541:5de7:fcd2 with SMTP id
 b8-20020a056a000cc800b005415de7fcd2mr24546129pfv.25.1663688374615; Tue, 20
 Sep 2022 08:39:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e896:b0:2f4:3ded:66bc with HTTP; Tue, 20 Sep 2022
 08:39:34 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <tinaeevan@gmail.com>
Date:   Tue, 20 Sep 2022 16:39:34 +0100
Message-ID: <CADEuEs-z1o_5dYLE8SfwsE0d9+_kS2w+MuduJOd92DUZ2zHj5w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
