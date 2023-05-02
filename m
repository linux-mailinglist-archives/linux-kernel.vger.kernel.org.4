Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28016F4BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEBUwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEBUww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:52:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB771734
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:52:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4efe9a98736so4960135e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683060769; x=1685652769;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxSZ5HWiRzoGYWLexaqAjBCEITiYObIFiQevUjVdyLc=;
        b=GQZRrS7eQXqRP9OXC9feaHdl2+5I6D9Aku77/5Vff6etgiWJBft1KHjFh4dk/N5bKP
         2ZOp9OA7OuD4X6mnNdGZblgZ/cWKN4byXe7BRWGkPESTTRF37DGHqV40wJdsjGAeCJuc
         HROycDC0qMI3DMpyCdsTWMMOb+quFV86xAEh5NcK/HIhSZYrYjTdE25o/U3p0YuVzxwl
         4WfF8Zrby27xav9r5pyVoFgBQLa5hqCH/H0W0/JSeSe6mkh9Ht+Quz6XeEGBWL4q5Jb7
         V8ub9sju0VeIYRfDtDTiPna23c1KOcyw47koz5q1Ui3CgtEb0VzOIZODxSy51xExZv5r
         066Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683060769; x=1685652769;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxSZ5HWiRzoGYWLexaqAjBCEITiYObIFiQevUjVdyLc=;
        b=djpur1N5uFxEEx/Yh/5y1iPf5zfMTElGTaMGbZ9KUe47Q0uA507pQvronnEbTX0R1/
         EtxtpZ7+5kTRZriCHk0BUNOv6hNqRtDG6KHupyKCdSDHFbOtJQYQvSoI2DjeCAuBwCGM
         os79rcJvaxFXWHuSPX81p9uSUPHhDCCwpV8AwYrNEpxU7NJIxVJ2p5oNMrvKuQyitaqu
         RcITbcndflHOi5ShFrFw12wL9fz5LF0M7gOwJitUgg9GSJEjZpUTL0FsoNBHryDQdNhS
         FdNqmPUAbV8mFSbi3JtjfOY/fRJiLxqyTu+HPs3OVG7NUKqPAJXaANmHpNNpzMmL9UY2
         VqHw==
X-Gm-Message-State: AC+VfDznNchiO8K0zmj7Hc/Ac6Bj5U8MMWvsY4+uzAw42+uKw9sAZHWr
        BTVurdtOPdVJ7wb1ahVI7mgVW3UhIpighSwRsSc=
X-Google-Smtp-Source: ACHHUZ6yCTO4qWaZ+elCFgZsYDwva29nPWDed2bqNBmuq05XgsEOe/kiAjaGY7XMikEplfBcTy1qpg8otj1A0ml0zpQ=
X-Received: by 2002:ac2:4d19:0:b0:4e9:b64a:b87d with SMTP id
 r25-20020ac24d19000000b004e9b64ab87dmr266324lfi.9.1683060768962; Tue, 02 May
 2023 13:52:48 -0700 (PDT)
MIME-Version: 1.0
Sender: affoarimyaou@gmail.com
Received: by 2002:ab3:6297:0:b0:229:e329:a0c with HTTP; Tue, 2 May 2023
 13:52:47 -0700 (PDT)
From:   Kayla Manthey <sgtkylamanthey73@gmail.com>
Date:   Tue, 2 May 2023 20:52:47 +0000
X-Google-Sender-Auth: 1_3GgLnvnmNzcNMdBqRod3KrcE0
Message-ID: <CA+erknwkuw169uQcdf0fudoHkvE0ptPK411MseMej+4Y+78oUQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Please did you get the previous message? thank  you.
