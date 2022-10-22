Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAD608449
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJVE1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJVE1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:27:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33422ADD35
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:27:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a14so4960311wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wTRjTAb+Dn/PubQ/TUfBx07LsQmk32BnHRn6hJn62Kk=;
        b=kCH4lJz1Kar51csBTCctPr1uQWZwZfNbT7DyY3puiRuYDHZgat8H1K2aiNvDuqUTrC
         mPqF3fi1A1aQFVLG2jrMOvpYmYibQGJY/jIl37Qgn5K1iad5YEuTYfFh0rarZpFDIfK2
         a50JgZlG5ZbVnHuFcXKsCzLAwBMzheQi9dLaoGOGWWRTy2Q0LBDSNqzVUP78MeRdvzig
         /ZQqF3vOgzjCh3e4uI+kL9b+5o4FCmhUT4Wk7SgslUg7Ma/yDNvayM6u/FWdTMeBLZLB
         tZw9xs3hi+eu7kFP7ayuHvejy1EVoftL5vUJ3GJWmcditeJypB9+SrDi0+n6WBgkfdCO
         nMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTRjTAb+Dn/PubQ/TUfBx07LsQmk32BnHRn6hJn62Kk=;
        b=yvyzwCCiWhHpCe3VG6Fkup3Sn/RbuDq10/lJLqUcZIppmIbRI996ex8Qmv98Arhz1d
         l1wQLsn0Tn2r4BQBdhnZjNzTWxV/3VMXbeApyGVo/TOwjra0DrQ2T3L9+o+hqXy0/58H
         L0/8B3ctRSPFKZ7HmalSdUSisc7TfPNiowwquh1PXTEFjz7OZMFbqUJgg94dPeC0O9kY
         Iwm/m7da0LSRpu+2yK0EDNSSI4h2YgUmeP3nqiTHMIVWinX7h3g81lcbjhHPsQoV+hrB
         SlIRL3aOv7CfhaSQsSLWMi2wFwNqZCPxDfaVJOREyGFf24U+2u97KSdUKKOGFAzK7g85
         xgPQ==
X-Gm-Message-State: ACrzQf3j1uB35X1Ky54yCeDJhRJ1eC80XBwERmTN/f2/Y404p+DVCSig
        Js0KBMskwPKAj2rEwi7Sr7PmxIzvg6H1LcblKXrIIaP0
X-Google-Smtp-Source: AMsMyM7zmm2mGlsdv0IA8Gd3ZoAbDmJPJY2NLIhpZU76Kt8AsskjLU5iM7SkxLTKSR79nom57utZi6IVwTYFILiEcrQ=
X-Received: by 2002:a5d:5a96:0:b0:232:2e1:48f7 with SMTP id
 bp22-20020a5d5a96000000b0023202e148f7mr14671791wrb.694.1666412849625; Fri, 21
 Oct 2022 21:27:29 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Geery <geerbot3@gmail.com>
Date:   Fri, 21 Oct 2022 21:27:18 -0700
Message-ID: <CA+mLQwDG0LZYW+fROKcn6LMNu8yNR6ei_BriU93J9fik7aPmuQ@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel tpgeery@gmail.com
