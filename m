Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495FC733051
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjFPLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFPLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:47:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73E191
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:47:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso789146e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686916021; x=1689508021;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDRidZeWtbMLH7b4xJ98NwS0EsAG7cnBvb2BCw1AnjM=;
        b=VWlsqATPjp+PX4I2BpqLbs/LMcoBT2rm66yWyrxf55NP/aW6sy9m883MMVJ7xFIZS5
         +7JRchws9XdfMTvQgC3Ljb0kaUpZSrZpLGHJqeUzp5wiGB1mfO6ziCaDGRSYA7h4gJrT
         g8pG2T73w4Ga9XjpbZeub5Y7X+Mj8yF8qIal8gwf3/M6EKGdwejxfi3+7vND1ybbkMAG
         15rNSrCW6a6PCPenINu+ubmOjHPFVoeDhxTk+S3xshjjDM3N/n0ofRSmqkJkoPhnytl4
         64lDsxsWRZN/NKcxSoDJEiWmcxe4/zokGDcReN86sNKJz6TH+u0Bn3RxwO23APP+k4lh
         xouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916021; x=1689508021;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDRidZeWtbMLH7b4xJ98NwS0EsAG7cnBvb2BCw1AnjM=;
        b=fLC7B+pJdgDLspfOiZa151Iz+/DxwACZGj+jA+y4KPpkB8Nn1xgh/pz2qomQ37YzDG
         9WKxQQ5p36s4FwdkVkbHQMOsniM+CZUkm8vOgiVgpFP8viunVzM7RLmeRJ44r3VAzkpC
         L5DVOSGTDFtTBU6tMR/sqabw6PEwZZpOMvDPD41O0Q4uDLxZK076Ph5GRl489ESysH0r
         L8p+hmT/mBM/FFydVrixNl4FAcjiR+LTVIgelyPQeY6FqWnRTYBq/X4ExhCQVEWpr9NG
         qrPHFP4E1Rm59sZs6F6AhbRcByFXSIFIyT+/TtmIo/C4rEUyPL6yRqJxSAlIJuVlg7to
         PZ1w==
X-Gm-Message-State: AC+VfDzpk8Msewv2pzFBSTQO25AJZa6KRVhs7DkmvUebHj9oRqg1CtR0
        N+z4KnDt7NevYQxC9Js1oko5juY/SsPtCFJfWxk=
X-Google-Smtp-Source: ACHHUZ64iumPvzc6aUZ3U+tAcPRG9WNR3r4G4IbfFjAZiqKEj1u1RVnpjJObusYbcHP7VRxlUPPX/2E9OURDjzJ9hiQ=
X-Received: by 2002:a19:790a:0:b0:4f8:4aee:1fac with SMTP id
 u10-20020a19790a000000b004f84aee1facmr1074471lfc.66.1686916021120; Fri, 16
 Jun 2023 04:47:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:505b:b0:229:e220:750 with HTTP; Fri, 16 Jun 2023
 04:47:00 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <sarahtage24@gmail.com>
Date:   Fri, 16 Jun 2023 11:47:00 +0000
Message-ID: <CAK7Gz5yn+EONFHb8SHeUst5J49wp8dRrXuUug9rRK8CGXooqSw@mail.gmail.com>
Subject: From Michelle
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

Hello, I hope you got my message.
I need a quick response

Thank you so much.
Michelle
