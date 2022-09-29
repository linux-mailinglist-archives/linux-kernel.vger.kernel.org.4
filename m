Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D55EFF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiI2Vy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2VyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:54:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD42126B72
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:54:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 3so2602687pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=6VJEdRuAnZMaurhn8E94wnhY51Zn54NeRR0vh4+82g4=;
        b=ePFQ1ierwJ6FjgiOitss43F5wTpMNy0TAkSzHek74RdHj6eqPGO4UBZKuHMk/rYbF3
         eUfD6Au98n2XITK2l2lVA0OWSVlvhV96Z2+xxN20+R2n6hYsTIVDgHAvyNWB/L7IHSuM
         kUpD4SMRXgWXaTWG7+evVhM9MHh9OhBu/dVWTT+y8XhBEmdNDl732Q8db8BJvWsuPZEC
         8ALwV2/EmpsxuFx2HvgFmDA19Gc82c1UrI1nk1kWGBZeAQw0ska85t1Dlm2sFFB9fCO9
         a7d2/snZ5eLHt6GY1v6TliLdieYY7oDtXyFUnZx817HMlqXwJ4khVZFU1plnP+I2wk6G
         gDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6VJEdRuAnZMaurhn8E94wnhY51Zn54NeRR0vh4+82g4=;
        b=ZcEw6Hly/XBENcByjjbIKh80hjpyojvK79szlwQQL560L3Vfk6nlfjTiONWrlQ+R8z
         ganH6BFzVt0sUuJzgZycknIjxvJik29TU5wVx13KQAOiQpz2xpKYnVWIGMyX3GJ+VxHp
         ZbkEME0UmNalcm/or1jX1IJ3ZI1sk5keVYofOWCi52tbBP8QMkbZg6AcsLFtVzrFmcPN
         W7+8eOXzqqGF2RXDBf3OCDZ6ZylC2KlTkX1C0Bp9o+wTJexztLPLuGxO/LlJ/hkI0q83
         DQM7/qVMddvlx+uxDC2HA2X3JfaeT9veEcySlAhUOswfLdkZrEqdf83DNuEiWbqgcLO4
         Iaxw==
X-Gm-Message-State: ACrzQf18F/OG9CIXvU6Ly6fNYcMyM0Ei2GCROploBaG01K67TnC2s2ZL
        GVl81BQZKaDfDD59p778A7wvXp90xDvT+90gKvdLiYQoZf0ZAw==
X-Google-Smtp-Source: AMsMyM7d3VBgob6HSDmPHbGU2dcKlX1Q8PGJV2P3+Mgcp8+nkpRfJ3bDWggGJpr4BxBIEgCgoOlO/yKFN/IzIaMKyqU=
X-Received: by 2002:a05:6a00:1743:b0:548:8629:ceab with SMTP id
 j3-20020a056a00174300b005488629ceabmr5297404pfc.23.1664488463053; Thu, 29 Sep
 2022 14:54:23 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Sep 2022 14:54:11 -0700
Message-ID: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
Subject: Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'.
To:     linux-perf-users@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I recently moved from a dual-xeon box to a zen 2 based threadripper
workstation.

My usual incantation for measuring profiles for compile time isn't working:

$ perf record -e cycles:pp --freq=128 --call-graph lbr -- make LLVM=1 -j$(nproc)
Error:
Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'.

I've already set /proc/sys/kernel/perf_event_paranoid and
/proc/sys/kernel/kptr_restrict to 0.

I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
Is this a known issue, or am I holding it wrong?
-- 
Thanks,
~Nick Desaulniers
