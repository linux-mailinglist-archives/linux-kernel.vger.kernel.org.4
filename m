Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F560C4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJYHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJYHMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:12:41 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752D810558
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:12:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n130so13221830oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVsjvX9QTgWqx3TcHjmOWTUukyYSKSsRm9lqaHY3Erw=;
        b=mO+scdApmdS20VWvpKtVxEiwwOXnHB6ggUlY6xR3AJ+/YewFnCzWi3cevz9GoQXroH
         DfNRFt/ZFB2ypE8yCzyi9TV1Y2l9Ei14psnC3DxxXXMV9dRq0iShZj59hIniu7WDPqjd
         8rX6B8MnC3/ccMBZ6IwcIfOeBoX3iL62XYNzJGqhxvlKif5a87YxtJaWrejjbic44UuS
         y/ffaOp6STv5+bFpXSJGzXbpNcBDpghblgtHh0K04GnfEPnnTQ3V9fu4l4Ot9xxVkQyn
         nDJRadT71wGEqm+Y1auLaZqityE0dt4ZPYXrRWC981KcaX7UArp652syiDvka3Kf9RGq
         nhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVsjvX9QTgWqx3TcHjmOWTUukyYSKSsRm9lqaHY3Erw=;
        b=R8rscS1tiLpMNM18e3y6dmLzUnXEmR/iDsqOV7vyZ4Vl5XLsUxiY+lsRuYqUkWzV0z
         XasoGlN2aXh9AH41H/1tik4bAP84v5cfqPN8ZcE/70YyUBDCXPdtaE3OW4jGe5rTkW7A
         vYQuevy4mVLdiVvtNsjlxyi1tKq2pMQY7t3RrWY21+SaPMMn/7f+fAxdw3u4GpadA8iv
         eGlGvW9MGfOHqgv0c1IgSKxFPrrY/T6yk1JAPQAspeygKaM3ElbudFFk0BbIyOXoVEqi
         o1fnk3jvIdg73NFp/GDPGiVvnCeZ7u3XTaLspdppddns4+61/ev+SbMxuiLwcInXKVxp
         GEcw==
X-Gm-Message-State: ACrzQf2DmueeDqVd/fQdcszpdNrhkLy92e+bkRM9GirFfr/gMUQ0xuLu
        RDfrj/BjYHx1jaKQxMjkmIQhNF30Afhdx2UyldOcsh04dWA=
X-Google-Smtp-Source: AMsMyM5aF0xoCWaPin++JCLa2nxjcF1ITzx6W87/P/ZkFZ+uywe2Ok5/X0Xb+s2JN53Wmd1XUVWRNv2CaStydpmC04Q=
X-Received: by 2002:a05:6808:2021:b0:354:9a79:2f5a with SMTP id
 q33-20020a056808202100b003549a792f5amr35553789oiw.276.1666681959675; Tue, 25
 Oct 2022 00:12:39 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Maser <jonmaser8@gmail.com>
Date:   Tue, 25 Oct 2022 00:12:26 -0700
Message-ID: <CAF=mWJNRzy2xgA=qxLWtAc4cWMkYVwMmAy=txAwrE_z-LMHysg@mail.gmail.com>
Subject: anyone want to put time into adding sqlite support to kernel?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we can use it to hold all types of data

imagine this
/proc/db or /var/spool/sql

we can use it to hold kernel data or data that the kernel needs to react too

what does everyone think?

we can even make a sql shell for linux

id do it but i dont know much about the kernel
