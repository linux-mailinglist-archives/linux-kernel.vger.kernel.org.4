Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A8F72CA15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjFLPaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbjFLPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:30:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0319B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:29:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3cc77ccbfso7283985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686583799; x=1689175799;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2QgIS7pLD4XVIlZGs/jDBse1MbhCO8Plvo0pYCDiA0=;
        b=oAGceFVsJBvfaFdtGWoeorzP3AExgXR2vb1mSBpsqhC5Vt0kbHv/dbbKUq4Pty+7zT
         QyuiJOVPnIA0ZpXWUC/cNDYiKc7M+yHGcRfiVAIeNUil0brxM1FV8oRp2ZRiXm6jC6x6
         Dvp5+ri+nQ5uWXiPgY3FBo6KSkNj7x9cjsitTlIkrs8valkmCKZQ9oBuINLI5o3k+rTz
         DoSw5pyKgD4GWTqiBtBNiePPRokrI+jpOAilQ6IwTCeAXNnHyhYg0M5qon+Kp2wDCf+V
         kh5QZglg5SBW/sOVqqGeAvEFX23X0In/F6luFn42tLSk8V6KPWiJGH5+hhNR113jWYcs
         SK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583799; x=1689175799;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2QgIS7pLD4XVIlZGs/jDBse1MbhCO8Plvo0pYCDiA0=;
        b=kaXTmfXqXUfu8DTmNp/RDB5JtdUJE6pHE16/5Qza+NeEGrwJrQVXbePIJMnx2Etf/F
         LdTpe/ssq2IOsdMnwxarq8Ax1+XsT1IKsB8W4m5NFn9OpIDyYCvVPR6eyOgVIXXxnaL+
         ideVN9pDAa+sP5sTE2wRUni033mpeV4D+Biag96OA3Bg5kYlLcxdQ+TJdqidcwMaKmdP
         iIa8TGn2CYR69N6sj/85lrV1pBRgiY/jajz7kaUj0HmyMd0Qc6+tW6ICyRAp2Y8CyoBg
         GBTyz9zySGQDzc9b+58dSaw7WOci2WfQ6r6do4EyaamSXVifZw2MbCI+umBvGCMxX7o5
         sjvg==
X-Gm-Message-State: AC+VfDwiicDPzCjLFh6MjyU9D0p3HPdZU7ge2nX2sOSbqGLUyuB904uk
        jBmCS7eI9iXZ25GNhpBLb9JiInc87IOxTPqeb/U=
X-Google-Smtp-Source: ACHHUZ4L4iWVXXe1or3PU2wONN9Kqazf7OhVFiJ7H6uIGKTF+ykqCpuO7EJOsOWzwEeW2DrqPh+vopnAmNImgFqsex0=
X-Received: by 2002:a17:902:bd94:b0:1b3:d6c8:7008 with SMTP id
 q20-20020a170902bd9400b001b3d6c87008mr1693346pls.57.1686583798888; Mon, 12
 Jun 2023 08:29:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a44f:b0:47e:dbbc:5b45 with HTTP; Mon, 12 Jun 2023
 08:29:58 -0700 (PDT)
Reply-To: cynthiamatanga80000000@gmail.com
From:   cynthia <cynthiamatanga40@gmail.com>
Date:   Mon, 12 Jun 2023 08:29:58 -0700
Message-ID: <CAC2w+jJ-o4hpLQqOAObPH9PtxLHYmcFT0=CziL7mMsyyJ5O6KA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Friend.

I have something very important i will like to discuss with you
reply back for more details
Cynthia
