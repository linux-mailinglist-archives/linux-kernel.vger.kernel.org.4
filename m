Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C632160BC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiJXVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiJXVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:23:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB0E9850;
        Mon, 24 Oct 2022 12:30:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z30so6683358qkz.13;
        Mon, 24 Oct 2022 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PblChHtfw1S0go3t7WQnQiBCMoL2Al1+nyURPxA1TFc=;
        b=pVgwI/qNobIFyNsTNyK1DM1nXPNJKIJg0NQd3DSCBVXEDuGq3PSRMiBcrOmUmgNC2t
         r08RlVIreaIsjJFLehRvmZghm0dzS/xKGvp3xn/aRD2k9m+7ymCUTeBxbGGQ9YkY0iep
         Ebcou5EMVqjiWqf3djGIWhIOm2vNGzhOTnsCO3Y7kWLSsT7LUy6UgRhQKcTkJoMtv+B0
         a2L7a986B//XhylsbOADmew4tsadzzn+XrPG2fEfjAnp4azR3Bg3YPXqc0SAQUMzsuum
         C1FuSaqyda5y8RaCivnahNU1TuLkoMDt0pPpiOMo5wVa6k/f1zEmdtSJjy5H/zdL34XH
         MWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PblChHtfw1S0go3t7WQnQiBCMoL2Al1+nyURPxA1TFc=;
        b=MOsyfeMf4B/6Zwgk9Ytm9V63QS9WOo9xynwRYRdGZoZioQnEK8c+RVaopKL5R/CKXS
         /ODo3+I7wTHRulRe7snU89RzetlkX+sKxKqz/Yz4ilBFhefH5slgLq4PqFhHsLjI6poh
         W1lAFhNt6NWNd5EAAbX47umYrs6RHd44PWJH2QtnGVyt/Ec9ObSGqU/XadIu95EirUwn
         mtcbVEEY8+wECsofJWhDA2vFuvzrGZNluqLnMz7oHrhgZRSnL6uNDjhAYCtB5xwcacRh
         c4k6BjIw19A4/I4krAuWKNCojHJf/RkzGqLw7eRkRBX11VmtPAZoNDlFp6SFZRQoPRYy
         VfeA==
X-Gm-Message-State: ACrzQf3V1EXYCSp1xbd0LhQL8cprruXV1RzUoRiRIsir08fjJfJWFjAC
        KZmA3FQBo6AgkIiL9xuB2Nc=
X-Google-Smtp-Source: AMsMyM7QmKJLyxQqYLHdF1N2eaPHhvOCUXQoyoecmLGObHbifNpUoWsjfMl3upC4fAgtOMENY6GFiQ==
X-Received: by 2002:a05:620a:c4a:b0:6f6:3b26:1576 with SMTP id u10-20020a05620a0c4a00b006f63b261576mr2820579qki.410.1666639713282;
        Mon, 24 Oct 2022 12:28:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon3514w-grc-28-142-114-225-85.dsl.bell.ca. [142.114.225.85])
        by smtp.gmail.com with ESMTPSA id bz26-20020a05622a1e9a00b0039c7b9522ecsm422650qtb.35.2022.10.24.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:28:32 -0700 (PDT)
From:   Serentty <girpoole@gmail.com>
X-Google-Original-From: Serentty <noname422@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     Hi-Angel@yandex.ru, Michael@michaellarabel.com, ak@linux.intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        axboe@kernel.dk, bgeffon@google.com, catalin.marinas@arm.com,
        corbet@lwn.net, d@chaos-reins.com, dave.hansen@linux.intel.com,
        djbyrne@mtu.edu, hannes@cmpxchg.org, hdanton@sina.com,
        heftig@archlinux.org, holger@applied-asynchrony.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mhocko@kernel.org, oleksandr@natalenko.name,
        page-reclaim@google.com, peterz@infradead.org, rppt@kernel.org,
        sofia.trinh@edi.works, steven@liquorix.net, suleiman@google.com,
        szhai2@cs.rochester.edu, tj@kernel.org, vaibhav@linux.ibm.com,
        vbabka@suse.cz, will@kernel.org, willy@infradead.org,
        x86@kernel.org, yuzhao@google.com
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
Date:   Mon, 24 Oct 2022 16:28:16 -0300
Message-Id: <20221024192816.11527-1-noname422@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
References: <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Trying sending again since I am not sure if it went through the first time. I’m not used to the mailing list.

As someone who still regularly uses hardware from this era, and often runs Linux on it, this would definitely be a blow to which machines I can actively use. Linux support is a big part of how I use these machines, since I usually have them connected to my LAN and the internet, and networking support on MS-DOS and Windows 9x rots more each year in terms of support for modern protocols and security. I would be very disappointed, and impacted, if Linux dropped 486 support.
