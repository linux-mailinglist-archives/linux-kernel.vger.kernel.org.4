Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1B639B34
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiK0OCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0OCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:02:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E4E64C2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:02:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so20085085ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf0lCR+u8PMB9vsCy2CzoVh2AzQlmbXa7mTITxhx7k0=;
        b=WoXB25Ziw2M8fDduSMN24s0eC3kQjea/ss7ETaO/jesndmxTMn11FEkdFSc00S86ZQ
         YXU74qAw82LQsBzBCr/yP6/nKswIwm4rcilATt0gaRY4/h8l0eb/UdDHzPvHFAeyGIxn
         +KH3FHZFvru2k/vSfxQfuveudzh6g/NRQfK/qH1YXO1pNuazrs7uAZZVtY6ETEMOnL3g
         mOWanZT66OzUXW/OJ1cTTvk54KUl3jacTPHD1U4Kicoq1mKdmRnoyRXTRAqc5AMrpHEw
         6oFUcLtnhq76+sSP/DE/MzpHr40CAJswSlS7xXq8wOD1sKMDqz9kRLF754OKKp1uPg22
         NAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf0lCR+u8PMB9vsCy2CzoVh2AzQlmbXa7mTITxhx7k0=;
        b=Cuwt1osOhQ3wvBW82lEOvRDPtSiVrzxv8gtIJoEHy/mvPfrZEr7ZcZBApNOmn3K4oD
         Gn03IrjL7+tTTiWyLr7elsHB2b/axRgpnd3JFRp83PBuQ2qinXB8rSMa9ZxZzSf8QdDm
         x3fW8urbihiO8xEkLAEdhonC6NPiWg7eFogn81DxaQDYJ+vrjMC6RvwjznBD0H4AFijj
         3dz74zB2DVEmQoHEE5Iaz3Ow9GIl1GN8orEz+YHuhXfLQcPKQ20zlPyS1Rcr9Qr9JnQ4
         eg8bp+S7nIUy2fvCLdKQ5EXlvE1EHfu46m9LzLW2ax0KLk8uhSMBqbAuxu2Obkn2c/zx
         nozg==
X-Gm-Message-State: ANoB5pmZsDpKS1z79lqP7gEKzCFvdSy8Y1AuYH7dKiUWPlYOVcwMoRDd
        BavkvDiKJoExOM/GnEtZUnHd7creEtbZ+pHODYY=
X-Google-Smtp-Source: AA0mqf7Kbv8wOzqs7zxKrH2p7CMGeG7YXX+/o06CrRVbAvqb5gAZ3IRv8nY5d3pTMNnX+iN0YyUU4wsGHvuyu49jnoc=
X-Received: by 2002:a17:906:3145:b0:7b5:665a:fca5 with SMTP id
 e5-20020a170906314500b007b5665afca5mr24939634eje.10.1669557738201; Sun, 27
 Nov 2022 06:02:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:40a3:b0:27:8ca1:d68a with HTTP; Sun, 27 Nov 2022
 06:02:17 -0800 (PST)
Reply-To: n1a1t@yahoo.com
From:   Lucinda <rita.lerouti@gmail.com>
Date:   Sun, 27 Nov 2022 15:02:17 +0100
Message-ID: <CA+9Q32dMk0HkZ7cRYhS__5=NmphR-g0N0JkRU3TvS7S6TbDKPA@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day
with all due respect I ask for your permission to have a talk with you
of something very important and urgent.
