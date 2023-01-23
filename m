Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CE677C64
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjAWNYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjAWNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:24:02 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE2C20058
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:24:01 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4c24993965eso170820427b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LMDZbYXBQXytLxY5tSrvJ1R/QC6jpiHjbMo6Zuxl8M=;
        b=Y+wOUHN/utPtWxuOVmJqQgZMkwhsscT05eNxPBGsFSGQlMpgxlABNDq5wFa9xKXgw8
         Z/C7MXFQ3sRu2mFEZqjkSoxShYC5gtSFGAIe1nbHnSHFJeRFzxsAwUmc3mjyyyw5Diqa
         XK/cdWGmbDSFjXP9OPmmr1GL3zo75DF/0Uqc/jaiXe9+koCmc3pg8PV0VwG5VLbuT4NK
         ueRXdi1uiWSBUGSgV3t/HbpR3CD14F1vMCf12H0OOqFUpiarupsAkQjNJzCq3Al/3/Gh
         /P9nAP2scjdLU7Mf19BBhTjWHkkUOzmdPfagMx66wL5FVvh/B8YOrmIfMgDU7L8ZV90h
         d9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LMDZbYXBQXytLxY5tSrvJ1R/QC6jpiHjbMo6Zuxl8M=;
        b=mvVlHSdJEsSbtNECVDYBNrg6JmCeH1jvjkK8CgV/xIASbnrx4TxvI6js2y4jqlMRUo
         Zsik8Wpf+TWTodXnB97Egto8qkSUu3HW2ku4u4XMLx7JOJUo8LbsVIKMMhE9i0NlKxas
         7+6ioy4CXTf05vT6s0/ZR2MMYiJTibB4MKPNDfC7TDhmdfGmT5rZlXTjWxSz3RL3w4ot
         0WDvp2H7JJ829eittK8MAU8oDuIwvkgZD+nRs8SydMoOSGLvwcGTowQVvhnOUjdqMWmR
         MxANQIRmjFhxmYLjJX0CraMWlIu3Dpwz4kBtaB+56M1KkZsGxe6WShKzpVFDjLVS7rdI
         g9cQ==
X-Gm-Message-State: AFqh2kqXqtoh49YncEgRfcNC61Xzw2iwOdwNyDxsokj2bl2f62BbN7fN
        vxuYE7wAARnz7sBcaUqlJDClgfjjbLhvPhBccWUFI41OdOF3FX1G
X-Google-Smtp-Source: AMrXdXvINsaW5dvlkIH8lo6AqE6gVN6xhpdQlbMf6DDZtEbthJivP3gwDvI1J0J2kzY5Hy6IhU9lQYFcWx2+JYhmhPE=
X-Received: by 2002:a81:8412:0:b0:4af:2061:d896 with SMTP id
 u18-20020a818412000000b004af2061d896mr3130866ywf.432.1674480241200; Mon, 23
 Jan 2023 05:24:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Mon, 23 Jan 2023 13:23:50 +0000
Message-ID: <CAC=wTOhYyxKJpzaRDqEFdy=e9XgGm4yqcqM5WSQp8yAhguyfvg@mail.gmail.com>
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
To:     linux-kernel@vger.kernel.org, Chris Ward <tjcw@uk.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5.15.0 kernel (built by 'git checkout v5.15' from the kernel.org
torvalds tree) fails in the same way that the 6.2.0-rc5+ kernel fails.
So it seems that something Canonical did for the Ubuntu 20.04 kernel
causes eBPF to work correctly.

Chris Ward
