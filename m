Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0C5BEB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiITQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiITQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:29:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA5F5C963
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:29:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 207so3161736pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=pCY2dsWEnlkJ24Q4dqYo0dolvJl1kAzHK5ytFx1FqSm10Kn+vfMiPNwIe5cbnRVwOU
         NVGcJKuP2r5EFnhwatkRGmTr2ZBYvngiCa8f3nFtxp9EOGkuQ/wqIISxYHKoOHK7ciCR
         qoNl5NuVZ3XHNCn4AGQ38VWb/cuPNsFqKxNyAIM2AzeTEsv+j6GJwVWUMN1HyDEr6uww
         ft9EusrQbVHYRxvAxffmw5RPEtyo4XcHswsGQ5QtwviCH5l4sv4xQOarA4z1/M7otUkV
         zbAW5l1UIHL8B2dGVBgpdltHicVeB73AMijo9PZ/igBXDKMp6uzT2tyKqYFl0+TrENHL
         KWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=PN2P4lsgC7kvuGgkHQAny54LPpLWAnQLW849pcX2kXoVQDbwv9GPR7xbtUEI64LbFl
         stwTspBKJ/cdFcUMCYexxwGDRisuWrAahc0vjIKmChALzWfs/Xmx4fc0fz5mTZ3z+3bc
         0N2yfZTffJM/TILNd1dR1KsRwhtFYXm8MCunaZ5lCu78wdOGLP71Vo20yThmjvRgxNrB
         +t5rtPu5qiPROdLgJzp2vgg23lwfNlwhZCUmKMVbRrLECPKWzCGxjYLBFbcdkzXJgjlO
         pqm3vsL8+BtixGobXc/3Bxp/uXh0wKXDdc59NMuZAvtLaEBq9TJkwhF67PIEVx4AsaPX
         CWzg==
X-Gm-Message-State: ACrzQf1JfwqeYCI9wlFWRVlz+vPr/KbGHyZgC9TS2fM0naPF3Xo6MzTb
        oe0L+XpWAUjFXwUL92ldx1r89nKpVXLaVCga
X-Google-Smtp-Source: AMsMyM6068Nzj253R/+y8ut8S/Wve80THEEyILIqZE9esKWqbp1uh23E0F7s6T4uWPrnqLpQNK3Egtc4Y6adNvRg2rc=
X-Received: by 2002:a63:2341:0:b0:434:d9b8:cfdf with SMTP id
 u1-20020a632341000000b00434d9b8cfdfmr20632430pgm.446.1663691339680; Tue, 20
 Sep 2022 09:28:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e896:b0:2f4:3ded:66bc with HTTP; Tue, 20 Sep 2022
 09:28:59 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <tinaeevan@gmail.com>
Date:   Tue, 20 Sep 2022 17:28:59 +0100
Message-ID: <CADEuEs9XEmPeuXtGSBY+Q7AfHdyopbfP_TqnsNm2E-ps5i0oGA@mail.gmail.com>
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
