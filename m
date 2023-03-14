Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A46B9ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCNSmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNSmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:42:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96253C36
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:42:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so65906410edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819369;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRp0G9zV+IpJpjwrbya06k2MCshxxUQ9b9AfNFz9fbg=;
        b=PqSrTGTaCHhNpWzFEzre5RVXgxXSJ/fTDTZAutXrOiSj2pWds3GO1ZA0ux3kjM3ccQ
         ClUikDiQ/+vUNKaoHBiMJ8cUgVaWEzJPf08i/+yrXsqIdoxDrS8+HMVT6RQnGWrNDjwk
         KJQQ83/dmNBFydH+dOW+KhBnhQzOepP1saS+4+ttTK1ZKxlTkqlnpvaluBXPAIHbgp9L
         rHDsSZoHMsA0nyipaA/FTZNRYIPC6BwH8gyDIumbMJknzGZ36e/3Vn1qoR7i4lW9TvNq
         00R3gBbjk6mbhH0kIktI6x7cNj4tTRQ0N0rhOHEgRvf3YBaPaktUrmt9nO5mNQo/8Vx2
         uXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819369;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRp0G9zV+IpJpjwrbya06k2MCshxxUQ9b9AfNFz9fbg=;
        b=kNQkOHwkgtqGc07lAoQJlIzos1jnLqA+X35RGBABDapk7qe7tA026GeIEVrGBwYLmD
         B7INmsdpCh1uiqjZat9AF1LkiXZXXTDItdrHDotPfLVJI3d29z1ziOuLSy71ODyhXzwf
         Xf769X+C1urRThBolYezBACrWAio5VKPVR4rMbXNYQwg5z0ufM5w2jwLm77Cvrm5733H
         6UbiOgvbPqli7XUVPSOK2mPgNWrGjiayOJZH3yTOnHQirALxezR/4c9XakvMXtEJfjPW
         6fsziQ0nCxF6eyCRG7uBq63dsps8wUfKETZNUV4z1TRDE4DYVeH5AMaHH3W03B3RB7f/
         mKzQ==
X-Gm-Message-State: AO0yUKVel+Zynk8GxjM8dDOhtFCGwSwQo76Kesj+a7zmgfyq4N9R1/Qg
        h9E7OaxDxAtW/GCWeqsAdJCYt1V7Ugo=
X-Google-Smtp-Source: AK7set9rAFO1c8caKsEvbn6MuLyhvNmf4LXQZHYxUwsQzyfL7MA606GRESVhYZLUXkNSDgUPwbuafg==
X-Received: by 2002:a17:906:5349:b0:8aa:f573:4ff8 with SMTP id j9-20020a170906534900b008aaf5734ff8mr15251442ejo.4.1678819369291;
        Tue, 14 Mar 2023 11:42:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id qk28-20020a170906d9dc00b008f398f25beesm1471489ejb.189.2023.03.14.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:42:48 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:42:46 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] staging: rtl8192e: Join constants in r8192E_phy.h
Message-ID: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of constants that change the name with a similar line
like:
#define AGCTAB_ArrayLength AGCTAB_ArrayLengthPciE
This makes code reading very unconfortable as there are always two
searches required where one should do the job. Renaming the two
variables to one to increase readability.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (12):
  staging: rtl8192e: Join constants AGCTAB_ArrayLength with ..LengthPciE
  staging: rtl8192e: Join constants MACPHY_ArrayLength with ..LengthPciE
  staging: rtl8192e: Join constants RadioA_ArrayLength with ..LengthPciE
  staging: rtl8192e: Join constants RadioB_ArrayLength with ..LengthPciE
  staging: rtl8192e: Join constants MACPHY_Array_PGLength with
    ..LengthPciE
  staging: rtl8192e: Join constants PHY_REG_1T2RArray.. with
    ..LengthPciE
  staging: rtl8192e: Join constants Rtl819XMACPHY_..PG with
    Rtl8192PciE..
  staging: rtl8192e: Join constants Rtl819XMACPHY_.. with Rtl8192PciE..
  staging: rtl8192e: Join constants Rtl819XRadioA_.. with ..RadioA_..
  staging: rtl8192e: Join constants Rtl819XRadioB_.. with ..RadioB_..
  staging: rtl8192e: Join constants Rtl819XAGCTAB_.. with ..PciEAGCTAB..
  staging: rtl8192e: Join constants Rtl819XPHY_REG_.. with
    ..PciEPHY_REG_..

 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 32 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 14 --------
 drivers/staging/rtl8192e/rtl8192e/table.c     | 12 +++----
 drivers/staging/rtl8192e/rtl8192e/table.h     | 24 +++++++-------
 4 files changed, 34 insertions(+), 48 deletions(-)

-- 
2.39.2

