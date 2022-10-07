Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55395F7499
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJGHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJGHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:12:53 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6A33437
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:12:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p24-20020a63f458000000b0043cd718c49dso2463035pgk.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD2QyyEYPUnjnfZd5KlBttq9+yeDt7qD9jNTNzib9dk=;
        b=sSoyhto2Qk2Kpg6HqPAneYQnnnmxccFxFeqwMKLrFcryCjJPMpI73mSTLc6/L3ER6k
         Qdhvk8g14MHO+V1tm6z7iE/fLy0BlMHekDqSRz7MrNRfqmTDmcX6vlKi0s4uOUtpjaFB
         y5ij6gVzF54ddthXP5Fej8wOdsYIlWbtV/EsawWbEYN2MaG4q1yxQu2PNPSx2PtVKQ9R
         lnow0RCrHaB6ifX9xdwBX5SxWaMFTcvGzihMCnZJSIekezzixpsqINi5Wqk5DvSVhugs
         sJFJfajqvicDWE/aeNz17g4Q/3BKjmXhrutINa9LKIIj2SAGM/OsyzZv6KozUg+O+JyN
         ValA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zD2QyyEYPUnjnfZd5KlBttq9+yeDt7qD9jNTNzib9dk=;
        b=a98QIVz6A20MMnWQeJ/EuaB5skwJmMTWTnRdUXxshKeRr7WLyP3xYVBdmlVzU0V+GG
         WY+yQlCG8bZPA2tW2lRUlYkvlALkyjt/1XDlujSbWC4GBi6p7MdHyploVxm/JR5Btikn
         rtZLfGF5r079YugwFqJ4/jy+jJjv9FHM/5vjHKIND8BDvJFtCunnCsY/Gs/ilGsB0bSJ
         ZOAwT0sknf/MlnfHATJq+TPjDS5lzC74w/kj7+KcI6eVANoVhYs9LYXUU8gZ/KuSifKp
         nTEj0WpUShF4kM8KOsVTyN/7lM90d19xzkVYvRdVInXipjxaZnEoUAyPCt38AUa0YYcm
         bRXg==
X-Gm-Message-State: ACrzQf1i4YYGoF1Mtdqmi6r/M4nIb4mCmdYy24Ap+EWMFeclUNsfLm0T
        3JntI2ABTpiPnFPoJEeho6HdVuDlw56V
X-Google-Smtp-Source: AMsMyM5oEThtlITNWKR9bOiEmeTojRuWczoWkPZmH3K+2RmRxCZ0jYn4s0trWQbemg/vJjtZFbKFbM+qvBDv
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a62:584:0:b0:55a:a7a5:b597 with SMTP id
 126-20020a620584000000b0055aa7a5b597mr3819065pff.71.1665126772257; Fri, 07
 Oct 2022 00:12:52 -0700 (PDT)
Date:   Fri,  7 Oct 2022 07:12:26 +0000
In-Reply-To: <20221004115516.5ccaf9db@xps-13>
Mime-Version: 1.0
References: <20221004115516.5ccaf9db@xps-13>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007071226.705169-1-sgzhang@google.com>
Subject: [PATCH v1] review comments to be complied by
From:   Ray Zhang <sgzhang@google.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, sgzhang@google.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

Thanks for your review comments w.r.t [PATCH v1], which will be complied by
in next patch version [PATCH v2].

Regards,

Ray

