Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A4614845
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKALN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKALNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:13:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00E10E9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:13:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g7so23113926lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDB5ezW4+6sXLiqpzEKi5SRHMOOxuike7Ppi2PFiGsQ=;
        b=HsGMMStkyjYZ+5O9MMh5D/AnccE1466rSH/qC0v0W53hLoRFnibE0BCd+I3tuR7X9S
         JSsLJOgo8YtBtfpWQTb+hLB9fqlXWrmGqyt2/rWp1M5eAPjEs2WS51dKC2T/jTYOluJz
         iWg/Enz2DZ1JyawxGMoh1hbJtQCZ6z0mpjJm9k9p89DD1zVeK4y0KAqdLC5yyYpgKfVv
         b4bI5GJoYPvvAaBZgZt/hbzwjpoHf1WBTqE2abfHxLbgpEUrm+ilpmv/UIisQqolAHhs
         GeLEUJjjtg79vDXo5OEzLcoImoQbE9Qw8eSOJc9KH6AskZF+cLeqF2dAAkV+07YTXFLg
         HF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDB5ezW4+6sXLiqpzEKi5SRHMOOxuike7Ppi2PFiGsQ=;
        b=f5LTDzFsTphT7rWP2ru9qcbI2A/dtu9GTmRwkT9IxvvCU12lv8R89sxhfjNanITq66
         /bKUbOUbAKMUqq1W+RrxIIKlV6q65Jy5pXGmRW71skro55TV0la+XQJ1MMi+UWNPjZax
         tPQjxwgQNf2sw0IevSbd/6ex8aWvVZlI9vQ4h4/bXd3Aqk5pX+mjP8mfNr2fRQkTnju2
         JpvoRMoyFBuYxUmRMYN6dzmvwwaVKxGC4v15Csnu2VDamsgLz2CS0AFzYa8T68XSoP1Y
         fAmbR5BdW5tJRPCRg16SFAEMsanYg17GMeOvPgZDRaNJSo+GY5zImNvYhFMU74v7z9Cz
         EJ+w==
X-Gm-Message-State: ACrzQf2p5kx47R1MxFTcPLkhFOjlY5iZUyU7UnD995j1aMXPpXNPkrdG
        542UGdIRXTfALCU+F/Z1xWQ=
X-Google-Smtp-Source: AMsMyM5Nh/2vQN06PYkuQd40IPYt/6Zh1lnhaF7bQmhVDcO2gVKWTNaFx2sinpk6uH7JeKd/6A/IKQ==
X-Received: by 2002:a05:6512:12c8:b0:4a2:cc20:d51b with SMTP id p8-20020a05651212c800b004a2cc20d51bmr7433507lfg.474.1667301232849;
        Tue, 01 Nov 2022 04:13:52 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id e17-20020a05651236d100b0048af3c090f8sm1629472lfs.13.2022.11.01.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:13:52 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 0/2] some checkpatch fixes in the file rxtx.c
Date:   Tue,  1 Nov 2022 11:13:25 +0000
Message-Id: <cover.1667300134.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes are focused on the function s_vFillRTSHead

Tanjuate Brunostar (2):
  change the function name s_vFillRTSHead
  Join some lines of code to avoid code lines ending in (

 drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

-- 
2.34.1

