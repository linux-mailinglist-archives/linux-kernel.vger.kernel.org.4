Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADD5B3F65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiIITVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIITU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:20:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82069BF36B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:20:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r18so6220508eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=MHmrF1Sw/U7VUEwFmT3i0RB0l9J+zANvjLRv3Fr0HmQ=;
        b=TaBxdkdsge+lH++jWC+CNikaw11zC2EYHR1HdF0WX3x7fF0LGK26spK6RBs8Bxyu4m
         AdA0BKPT9flLl4uhac5RzVZoCNTUDWiXle9ByEIt5ZmZtcm5eRD8vLG6Xf2vwUWSXpEO
         Flx4ZpBDgGj3tdHiCwMu/Wey3PrT6afahoJRqxP0VaSUfL+JfZgSvRkN/lRnmt1pd+gz
         X0FCLoOWvZo+mmCLN7haj7LEnYN5QXTXcW/p0BAwDByPUSbeu+Y2lqQc99+tXhgjlimD
         7ArLOlUPx279pfeEpXmqSQg03miOznIghJ1jHvMtxQJnxOrfA4SJPz+11R0zlHxUp7b+
         FYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MHmrF1Sw/U7VUEwFmT3i0RB0l9J+zANvjLRv3Fr0HmQ=;
        b=4dwp9mt/xNM5eHxaqJi3uLAq885p7kF+estEe1886de7fpRyyXqW+QEyczu9S/N0rA
         nUNcKjwbXAvVTIMg1uwr39kwmb6g8VEZ/7vKBTMZj0ya8rsPargKw3GQqnhv6XIDoTCc
         UhsQ/+FHXCuF8H0vX3twNidk4FQbTFk2f31P1k/MnmUxSkFGMuuW2PE53GbHUKCmGOzK
         dWBPn09vakShmNHPvlV5z6+iEKpD8sg7jBTlt0sHhKmWKlsu1t5ZKe6zyEZytjLbs4kx
         E2k0bbByIn8o4Ws8JpZ1dVzQ1sRHQpei672TUPZWwnqUekMWIclI55WyPV1hMUAkb8im
         A0VQ==
X-Gm-Message-State: ACgBeo3FNJOMM8BoAqCmQGtOkBmSB4ClsqbSiBpAs4xaJCHS/qitfrgG
        IAl3V+y+YIxRkgT2ui2X/ak=
X-Google-Smtp-Source: AA6agR5VqJvuVqPtbdaaE3HZTSmO8tOo02U06O7SOaTjXytv97qivUE29EplyEWXTGtuqckHnXx2gw==
X-Received: by 2002:a17:906:9b8f:b0:773:dc00:d4a7 with SMTP id dd15-20020a1709069b8f00b00773dc00d4a7mr7266689ejc.118.1662751254953;
        Fri, 09 Sep 2022 12:20:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090626c900b00775f6081a87sm621425ejc.121.2022.09.09.12.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:20:54 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:20:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rtl8192e: Rename CamelCase variables in rtl_core
Message-ID: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename CamelCase variables in rtl_core.c and friends to avoid CamelCase which
is not accepted by checkpatch.pl.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (8):
  staging: rtl8192e: Rename ChangeSource
  staging: rtl8192e: Rename bActionAllowed
  staging: rtl8192e: Rename bConnectBySSID
  staging: rtl8192e: Rename rtState
  staging: rtl8192e: Rename RFWaitCounter
  staging: rtl8192e: Rename RFChangeInProgress
  staging: rtl8192e: Rename bHwRadioOff
  staging: rtl8192e: Rename CurSlotTime

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c  |  6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 84 ++++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 10 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 22 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 52 ++++++------
 6 files changed, 90 insertions(+), 90 deletions(-)

-- 
2.37.2

