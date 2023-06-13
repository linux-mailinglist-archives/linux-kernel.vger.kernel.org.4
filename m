Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE072D806
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbjFMDMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbjFMDLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:11:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881E1BFD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:10:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-25bf606fcbfso311174a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686625822; x=1689217822;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=o21hhPFI2C7x8MmkIJp324pzCYdODeDUSOjY5lJVwPn2X8uLrQWtOC391q9yKiO6Bw
         dSXq6WwaR2tXABOcmtQ+RYDX6FhFgDCYMQaB1SnIq+PLQu2zy7uesNZU/Map8z1e4+J3
         mNk+a5QNNGOrAlK4ur4hTJDRgO6Me2WL/TeHc2zYeW4ehOPw3FiQ197TH2/TOusmjJ1K
         Kwr1D5rJAPt2JndlGxhQDnJ+VdDUX4WTjPHV81u8UHhH4UBn/UO8eDw1FcwtxizfJw6I
         U0hs/ztuqe1oSPZGNen/sEef976p7BqFujRqEWjWGO78JXABb4Scsgr0sg1CrZ3zQB8X
         n1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686625822; x=1689217822;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=ToOHEx6iIWktGq1eQiCBIygl0lW4lxG2e8i0+80j8Xi3BlXYd5aA1LKzJubTfPMIGV
         WKaPQ4JbljfgFz10PAtbhHaVEBxv2mMPYx2/sGh4PYIh9F4sKC6HxAGG5go/t7jEKFTQ
         0A+Gc9y67kb74HbYyDnApsczxFSHdGFiVBG+KuROoilXVxHpxG/HYaKJLhiget8mFWRk
         jDC3EZ3+Zz/ZDGoOrgoB5MHDL0FOZkBPDwlEBBIE0WaYEhjncO9Ofkf+OmZl8g1TzRCg
         lXI/xlGIGLQypRdoyoq5kJhCrvIanaWvWsPkn7+iUYXkl1n/LZAeMz3xwd7MWYRjneq0
         kcNA==
X-Gm-Message-State: AC+VfDybYILaA5hTDJNyj+A3qeHR6sVaqQfM4tkMFPucc2jKBvicDySy
        bINvlYyWx6MqlotMO1VH0C2hfC2sO677WGeb9HKR0x79opx31YFN6LkzyCtm
X-Google-Smtp-Source: ACHHUZ5qgzPFLld4kQf0WeILf90CRF6XTkOBEbWB0G2OZPT9Xo7z8EtFAzC6TeraF5iElKcqA0t/TSuqhWdJLejzWbs=
X-Received: by 2002:a17:90b:1a88:b0:25c:1ad3:a4a1 with SMTP id
 ng8-20020a17090b1a8800b0025c1ad3a4a1mr342839pjb.1.1686625822346; Mon, 12 Jun
 2023 20:10:22 -0700 (PDT)
MIME-Version: 1.0
From:   "R.F. Burns" <burnsrf@gmail.com>
Date:   Mon, 12 Jun 2023 23:10:11 -0400
Message-ID: <CABG1boMoG2vM0pFWCnjP3GBrxQcwNiBBzxR=O2++WWDH_bJDcw@mail.gmail.com>
Subject: PC speaker
To:     linux-kernel@vger.kernel.org
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

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?
