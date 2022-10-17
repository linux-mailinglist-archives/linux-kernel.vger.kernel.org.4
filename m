Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8760131B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJQQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJQQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:02:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240836B8FD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r17so25964533eja.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBpMeWVqrECTd7MIwzJ6hbW35EOOSdT3Rt1Nl1wGKTk=;
        b=VQ7iMauvRu76LwahgwWBUXMAXc1PN0rzJ4Cff2quZBRTwNirKJc8gKV1l7H7o167i/
         UGGUA75V6Wpwlys3W/zJ664H5uokBnNmpQvaY+lJhOZOIDJpV1BlzmEIfqU5M9GeGY1q
         uwWrm6RnRtA3RrMwpTW6nLED9eT/O+MwkcJh983kUYEoLuGGszaJ5J+lLAmPC9J011v6
         HXTIRuU+zFfd1CCBd2MP2QZfF/U/Hwda1NWbvYawgLWYVSCJzUZfCxDGwgK5HaKRBBWD
         4p/aHOkY/zaPhU3PnnynMvnhA+vA0BUElwcF9dsxb1XYvrksFMI99FwJE5IreHTXIyqC
         GGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBpMeWVqrECTd7MIwzJ6hbW35EOOSdT3Rt1Nl1wGKTk=;
        b=O2phBgMpIuzdYAJwlLdiGIr89RZOYtO6jMm8aiyq4wffgeVrHFjCHdM5i9xJ7XxYW/
         VuKbKVJcMqBNG8Ll1bnsBMPbELnz1hDtG5KQshFoz3gKPRE6yS3cPHPS8Yk3VFddbO3S
         rdwCFuf8+yhom+i4WUCCd973XcBqEY0n+BkR1iotGtAK93PORotQ4dYlPFo6Kn95+0AZ
         rVFZvg6Cz1Brp3337ulH055qyzWtJcSdQL2hOxTjbRXCa2by/3IcHzU3HFdHSNEm/zMD
         3AG78Qc9WjO8vocMDm5k0EP70VHtRwI/bDmlQsVj9Sx7jYuP6AQCTH6+qr2T6ptgLf4l
         MGcw==
X-Gm-Message-State: ACrzQf0EVxQfux3ZOpLuQl9SzA5o1ZhLcECHGBbowBVnEh7xfEVZ88pc
        VgWMuS/jM+4FR1nGKJOJ1Hw=
X-Google-Smtp-Source: AMsMyM5ym613dCcu9j7Kbfb/McRZx1oIriDV2XEUlyuMLQBsMPySBHhqtZ2tBFy+ZrgWWvkme9WjoQ==
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id wz5-20020a170906fe4500b0078815a57495mr9536269ejb.633.1666022556502;
        Mon, 17 Oct 2022 09:02:36 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b0073d5948855asm6389629ejo.1.2022.10.17.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:02:35 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 0/7] Add basic trace events for vmap/vmalloc
Date:   Mon, 17 Oct 2022 18:02:24 +0200
Message-Id: <20221017160233.16582-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. This small series add some basic trace events for the vmap/vmalloc code. 
Since currently we are lack of any, sometimes it is hard to start debuging
a vmap code if an issue is reported or occured.

For example https://lore.kernel.org/linux-mm/Y0p8BZIiDXLQbde%2F@pc636/T/

2. The latest patch adds two reviewers for vmalloc code.

Uladzislau Rezki (Sony) (7):
  mm: vmap: Add alloc_vmap_area trace event
  mm: vmap: Add purge_vmap_area_lazy trace event
  mm: vmap: Add free_vmap_area_noflush trace event
  mm/vmalloc: Use a trace_alloc_vmap_area event
  mm/vmalloc: Use a trace_purge_vmap_area_lazy event
  mm/vmalloc: Use a trace_free_vmap_area_noflush event
  vmalloc: Add reviewers for vmalloc code

 MAINTAINERS                 |  12 +++-
 include/trace/events/vmap.h | 123 ++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c                |  20 +++++-
 3 files changed, 151 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/vmap.h

-- 
2.30.2

