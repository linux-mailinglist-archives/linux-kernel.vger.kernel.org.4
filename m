Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9698648386
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLIOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLIOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:14:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EBC4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:11:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so4978092plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=Tfu72UvOjOGaRG7hU43p4pu0RW1Bc9LFNnGEJyXtBa2lp1rcmbW2dl8m30RkSsWnLB
         92e26ewKGlxP+fxzc80yEnyL2vZ00rb0Lq3kf2vhGGjBm12dJCf45pd4XwcRefeRMrTu
         hMC2SxHFFDv23CVbH23p1SBZ/rZwBrv2jiXQGQ7d3CEStvqa3YlQM12/f0nXnv8vHnth
         UmE12PhEzMxGsZp9dBgPMEhO8i8vOP3xhin24uak2v1NZGctsN0leKiEVuK0UK1afrdT
         ZwFGAtNRPXr+gLAblifH5w9OpTqRrnkJQpEH/iu+0qvYZN4tz1z51T7NLYlyEyaovarm
         zggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=W/XpHTeVHwIkOsID4lFtF2R+rVSQHKcFLe/i4ClAFBtIn6sdpUEW3FnxeiK5Gavsna
         u5d3++M1FfVggqZploSJWvYKNknPG5LuDOMRU5zGFds2eNagNw1GrxX2OdgadJqXvIwl
         T3KR1zZZ6e4Gqi1ENVUsAXVHCW9GC8VpP91g/WkAEOMRD6hI61p5RaPh2ArF9l5ZtuKR
         zLrJWAzOd00zSenyW1AscmFZJx09HvzaYNrljSM5Rlu7WQ8Y0ny38zF/gjOs/6nKgAkU
         alFw3ev2lMqaBlAufATNNyTWkTkn7ZlV5azmGLATzvHkPz9DWOM+ITqfc0v0TvOfkmtZ
         bW0g==
X-Gm-Message-State: ANoB5pkgjrMqATyV227g6jm2nFJVUVYw0ljgcrt2Q6BAwurG1gNLyYgu
        6nVxrco4cTfSWDK240qm6vHKN0ky+Hxh0m2N2C4=
X-Google-Smtp-Source: AA0mqf6/RrmuqeVLbP+iDN2gPB71HSXDwOWdPM3onRyhP4QGL14/V7trHAowkQB2OT5L47jSuodPwWvHEOoAzrwbuF4=
X-Received: by 2002:a17:90b:4f84:b0:218:47f1:b473 with SMTP id
 qe4-20020a17090b4f8400b0021847f1b473mr109429221pjb.140.1670595101773; Fri, 09
 Dec 2022 06:11:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:b317:b0:89:61b3:a182 with HTTP; Fri, 9 Dec 2022
 06:11:40 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikarm <biksusan825@gmail.com>
Date:   Fri, 9 Dec 2022 06:11:40 -0800
Message-ID: <CAP0wf6yXOwyuBOab9Ph5LD8Ayq0tiJhLgU6r9rxYehoM=6LCTg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
