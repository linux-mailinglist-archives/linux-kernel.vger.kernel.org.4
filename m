Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A8704855
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEPI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjEPI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:58:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B9A4C2C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:58:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so12790165a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684227492; x=1686819492;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=08Txk6+15+tOs7UKXZhJQ/aGya5B2czq1+BRnc/Bf6s=;
        b=n61jWnMvFIBBLtbS/zqfD4LL+7IhCzsVPZtEDNfgemSmUIvKyXOn2ExiPKOGqbR5fy
         zTj4eAaqpzY3gc+5gpGpLi4kxCTvjhLk0CYQNW7n81S9uVCqF4THIyaaV5oYoEA28O8G
         dbxrhDjEUQjxGXMKrP1Sr1eY6I40/bT+OcTnO85a0xngve9meUiVNFxS725wGMuil0El
         RaO0EBcDCa78Ehc2uMAwQcmsUwp5aC0HWXIwOpsm+uf1ha7mWvSqbUfQFOmq0Y05Mb+I
         wmafzEePf8G4Yqq87n6vlOPzXp42OXYajJ4z9gIWwEg5Pe0oyNMIYa3/eK6Z7hHmYFCU
         mwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227492; x=1686819492;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08Txk6+15+tOs7UKXZhJQ/aGya5B2czq1+BRnc/Bf6s=;
        b=V5wzdIDXtQpcm8hzLj5dwSChYQNyrDVl33O3rt0YaOKn2PEuMge9xhOIZ5idNwl6E2
         a2JaoBzxhwcP74JFrsVvLmVY6cbsqulI9fuN8J4800DIe+hxBebW19RhTjfMaPSf6jm9
         g1o4+8h8pYAu0GD+IbIVxoCt9O/8xFMe2fhQmX/prVMM8xcgoyA5o/Dg/ZHAReKfSTn6
         RJxuN70FZzfegCJr1ac9E79kzBvyPXbQTcX3fRjnDUhu0pudPQ7xrkoHx4xfB/TDjA5U
         GK9IjspvPkcbOQuH9Q5PUOVuxpTOqqMjBJPjsuZPBKkHZEsnDT08sIINGkNJZuNwSCwm
         qhSw==
X-Gm-Message-State: AC+VfDxVfojzHMtnHiluI19w9e6TD5niXKRqrSo5pwAJR59iEUGwBHV4
        OdtXKzOVCkxf8cL74nnB13QCTlpgeLda7pKAUDWIwf4ljzP6mlwP
X-Google-Smtp-Source: ACHHUZ6yQPWpeyYO6qhe3aqswAA/wvL3GbdtZ2dnotyml65K/4a+5pWrQecSsYSbe8ARv03clxl2U9UtwbOYKcDl11U=
X-Received: by 2002:a17:902:d2c2:b0:1ad:cef8:f916 with SMTP id
 n2-20020a170902d2c200b001adcef8f916mr19315622plc.1.1684227491776; Tue, 16 May
 2023 01:58:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:1305:b0:1a9:4258:48f2 with HTTP; Tue, 16 May 2023
 01:58:11 -0700 (PDT)
From:   Logan Cole <logandoghi1@gmail.com>
Date:   Tue, 16 May 2023 08:58:11 +0000
Message-ID: <CAM_6WbH3Bgsrmoi2dGJPojaNsNr6O=vK8AvoitMaG9WSE4ZE1A@mail.gmail.com>
Subject: Bernd Weber
To:     linux kernel <linux-kernel@vger.kernel.org>,
        littlemiss86 <littlemiss86@pantiesparadise.de>,
        LittleMiss87 <LittleMiss87@pantiesparadise.de>,
        lollipop69 <lollipop69@pantiesparadise.de>,
        magicalwild <magicalwild@pantiesparadise.de>,
        Marylin <Marylin@pantiesparadise.de>,
        mausen92 <mausen92@pantiesparadise.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,BODY_SINGLE_URI,
        BODY_SINGLE_WORD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SCC_BODY_SINGLE_WORD,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bit.ly/3pCwNAR
