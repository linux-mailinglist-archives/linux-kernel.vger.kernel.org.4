Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E57615383
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKAUwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:52:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D618B34;
        Tue,  1 Nov 2022 13:52:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z14so21748979wrn.7;
        Tue, 01 Nov 2022 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWn69+8F3B4tQVp2WbYf/f8oxP5n6T+Dle+0PyaHhYM=;
        b=CVG+hqdWcdMPoUMYwvDkUnMfmbxxghIWgjYSIbwCvPK1QzlDSH8fkPdzfT2F0OHBSR
         2TW2Kl4JI5x8sfz0ukoJF/yr2XYOE3o/wBML6Vt+0extJrn5Id9MCyAK3aR4dDPcyAbW
         2cSu/lts749QlSKgMXeQqBwLIGO9xwqnfwQq/DvVCMPD2rwVyiEX29bRqABajjq2IrPi
         qXmMdSVw5QsjhCFbRU07mzU24vSE+3ZtaJVBTNm1uEnKL3l1qWHxhJJbeya4Y63C/IOB
         ym9Xuv91w4Q55/CPXtLjtQlc3uQEsvPoDW2PTfYbXuBoocMnbSs9L/bLqkXB9Hg5vVl0
         szoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWn69+8F3B4tQVp2WbYf/f8oxP5n6T+Dle+0PyaHhYM=;
        b=o18PZRVYscjsoaadBywaXPVZ5O4zUr3+oWgBUw/cTkJDsgQKCLBJ8OyOCVPz5UjugH
         amIuRzXWwDWoGnyLOva62Mbll+7ZieAMiqSD2NijP4Du96YIbHbdPCgaIUV2wKVbR380
         Ba1uIP8+uqmuGUoIF+oCodrcqSAow5RLd98RVrEI7ICMdPLz456WGDF2NXSwlKtPpFaL
         8Ij0Ygb8s8VNh09JpkIiZocUyAAS+BA15VO16QzG36OWxgZf1vIArn+QqihzbeHUYld3
         d3UI2swZ8qsC/MWU5OAI2ldyRlhB7l2LPvZ6b2Iw4hI98jH0OE7m/X5ZeCgru46pb51i
         z1kQ==
X-Gm-Message-State: ACrzQf1Fi3xw8fxPPK/eQsGcn41YPq+9vza0oWURQ05mCqg1+h/DAZ7e
        HxRhyvSIuwLz6Pi4ThHBjqE=
X-Google-Smtp-Source: AMsMyM7MxtU+7v2SLAvOGA1h0ocsqzFAlGdl4ThjL6RcLDg+H2dcfqU3l4XQHc0yqN8SZhwgAYCJEA==
X-Received: by 2002:a05:6000:104:b0:236:a6f4:c67f with SMTP id o4-20020a056000010400b00236a6f4c67fmr12731466wrx.82.1667335960131;
        Tue, 01 Nov 2022 13:52:40 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id jb1-20020a05600c54e100b003c6b874a0dfsm11854413wmb.14.2022.11.01.13.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:52:39 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs/pinctrl: fix pinctrl examples
Date:   Tue,  1 Nov 2022 23:51:57 +0300
Message-Id: <20221101205159.1468069-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document has some typos in the examples related to using
pinctrl_select_state function and out-of-context variables.
The patchset aims to fix that.

Siarhei Volkau (2):
  docs/pinctrl: fix pinctrl_select_state examples
  docs/pinctrl: fix runtime pinmuxing example

 Documentation/driver-api/pin-control.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.36.1

