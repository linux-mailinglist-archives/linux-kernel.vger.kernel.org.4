Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0691727CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjFHKcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjFHKcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:32:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09042103
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:32:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b04706c974so2863295ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220335; x=1688812335;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=UTvshyRJS1peMESRRNo58zlegJ/ZkcCR9tKUB16JF+T/4kwGlZtuSkKYvxj04ZZWQ0
         BnfSZJBtdgOLoUwxyWdm1EY2qZVfD0Lh+t/Vj1VmI16Ly23sf5tdAalVSNiC62we4D/L
         dLkuaOGLsvAMlGjFhDlztaj4D64LijY3y7eAotCgnwWeho8CB8a4FvvSim+Aq0VDPAuj
         T4bfQ/c0MQ4Ao1cXrkgGlmp0BCqwDtGIy908fWPJzHvHX2wDorGwKDOrrmANEtTPyRrL
         nSduwzTKN2TlzhL/mOM9EQA3hmNR+HThc8CdsAi+r1OKXbYaBYeH9Jl4+m09jbCxH5TC
         xxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220335; x=1688812335;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=YoiNunbAH4ERywpjx0qJUn8WHbBbmJKeXnJFORecoyDBYeveCPN/lv54Qnk73PqrEf
         VeAVydRlchYy/SPJtEIYprz6K/llLwiJ71FmMscZDo8hBy5AQ0y2ioldUDjkvIXn4C5o
         mfjll9Wu2HgZMKu/CN+BlO9yidnOCCb1ueryNnfneN7gIm11A06O1L+E8dJOTOyYuqmX
         ENhp6QYTfhhNokFd48zaHmt5mS7LgtFn0T4cm8qs0wp1LuQoZL/39M57a1X7aZAU8t6L
         GAIy89hoNKE4EWMYxDAGEzmvZYCSw/kU3pluK0egBPjDq3OdB2QGAYKVex1WHsMWomQe
         zMMw==
X-Gm-Message-State: AC+VfDxxehPHF9H5ys1oa1lbZm81p+X8tvq3OLsMZDWpCNzk8A0Wt66e
        QttqfZGsfOcBRXUwK/4QhcSD4ejyGNc88Lofzkg=
X-Google-Smtp-Source: ACHHUZ4W0e+EaCZzzfxgr1kc/z7LQR/TWfu7CwC8cfwnlbxwmPUv3klpwfE0HU7f8JdE0k/7nh5bf5JS3qoccNXZCCo=
X-Received: by 2002:a17:902:c101:b0:1a3:cd4c:8d08 with SMTP id
 1-20020a170902c10100b001a3cd4c8d08mr8104648pli.38.1686220334828; Thu, 08 Jun
 2023 03:32:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:d1d:b0:be:3b90:66ae with HTTP; Thu, 8 Jun 2023
 03:32:14 -0700 (PDT)
From:   Jessica Ella <ellajessica495@gmail.com>
Date:   Thu, 8 Jun 2023 03:32:14 -0700
Message-ID: <CANFL213mDsFiZnpcZS06cRDSJMFLHicCwtq+Y++2E2HMEV4k3g@mail.gmail.com>
Subject: mrs suzara maling wan
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


