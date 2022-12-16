Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414D64ED57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLPPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:02:10 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B528735
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:02:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so6807358ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/bGOCyr2U74G8JrDumnZakquFNkr7cJkIvDVURxj9k=;
        b=hms42lLTCYuxcUThnU/6aUWYzZOHEV5cYNX4WglixQWkfEhy0EPEdoLDTYF90esKiM
         8y/wgvPKWBjweiycEAqf2lgwEcqGv+8Iu3i9zbphpy2fnlTSyHStoFDp8kT2vt8/X/Gm
         kMa8p2HbmwI4fh3vA00p+KFyXc7dEzmYVVcgJ7cC2BCFbOfrDPfJVEPXxu9koKBvowyX
         hKpfoMSqB48NQmSCS+1hWSMwi518Tw62CP/LdL8bFO8GTn4ZG9VgT81OZX/SMPmcszaI
         1B6YgmqGw2hvp6i7RpF3sMRL53AktYGXBaTZcErh9++317zTPr9wxSUjWQaT1rKxa+Qv
         cLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/bGOCyr2U74G8JrDumnZakquFNkr7cJkIvDVURxj9k=;
        b=BVQLYpCnOg3dq5T6wRgJ0HGu6/b4RwlTcyW5NfnRwPpVPgmbfsoUZ1B7cLRO7Ion6q
         GFYjGuO3WtsV6pLiTbCMTtYF5YiHJg3z30taVoqiGaChZDYn6oJbnjBZi9RvTwzEj5pO
         ruBYzUN+91w6EEBmyKZRaBeZ3YPOy5BPxNV+HEwHkAsB2ZpFJnRLWwDcpDRy6hEe3Bpn
         K4UsMSsozOWTZw7Mxw5DYZSom6ZjNFxkIthAqiK2cO6j8JkXMEPCfh0i0Dr6eNDjU2Rp
         5TcG9C58tTat/YczszQuU8UscjP4JbQ2NyBHls/UWZIQSIx0bkp7vDoV8NnN18XxITMI
         vuUA==
X-Gm-Message-State: ANoB5pmTI74J6frao4oRzX6AGblCD99d4GMJCeJvDMl7b/eiAuPL1B3W
        SK50Fc41p1MHFe5c1Htf6nPiQqlH9drwDK0w
X-Google-Smtp-Source: AA0mqf6b+jYXmM+d6czWXobm1jeVPL5F7HFVFvYjaRMSdKrQbaYDL36jwhDffkmH/aTEzzYQ7z/VzA==
X-Received: by 2002:a17:906:25c7:b0:7c1:8ba6:6eb3 with SMTP id n7-20020a17090625c700b007c18ba66eb3mr18327115ejb.35.1671202927203;
        Fri, 16 Dec 2022 07:02:07 -0800 (PST)
Received: from localhost.localdomain (p200300d9973eac0005dbc67c2510e9a9.dip0.t-ipconnect.de. [2003:d9:973e:ac00:5db:c67c:2510:e9a9])
        by smtp.googlemail.com with ESMTPSA id z19-20020a1709067e5300b007a4e02e32ffsm946924ejr.60.2022.12.16.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:02:06 -0800 (PST)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/3] various irq handling fixes/docu updates
Date:   Fri, 16 Dec 2022 16:01:52 +0100
Message-Id: <20221216150155.200389-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found three patches from two topics in my outbox.

* 0001-lib-percpu_counter-percpu_counter_add_batch-overflow.patch
* 0002-include-linux-percpu_counter.h-Race-in-uniprocessor-.patch

  The percpu_counter code does take interrupt into account properly,
  this could result in corrupted counters.

0003-kernel-irq-manage.c-disable_irq-might-sleep.patch

  The disable_irq() documentation does not take threaded interrupt
  handlers into account.

I've not added cc stable, the races are not really likely:

- #002 is probably the most likely case: UP systems that use
  percpu_counters from interrupt should observe corruptions.

- #001 is fairly theoretical

- #003 is a docu update and thus out of scope for stable.

@Andrew: Could you add them to -mm and -next?
Especially #003 should be in -next for a few months, to check what the
might_sleep() encounters.

--
	Manfred

