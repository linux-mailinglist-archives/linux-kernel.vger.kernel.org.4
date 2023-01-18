Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8E671280
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjAREQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAREQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:16:12 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277354134
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:16:11 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 207so9125004pfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMqnHryIcAuT3eB/jbSwJcaJrQAYWyhU6LUk5msEBw8=;
        b=ZoMQR4WvgRowoR9N2P1r/0ixGJAuT6ZhcK2L3SUjcQUasY9tBXTYoiYsQFRcQNOQn8
         ZxvtOC8k9CwtTkc+/hypw7HBRPD0KrQQukkKYJQiV8Gg7iXMvMP7zLLuN+26nOTyao3G
         4/jM/aKTReT4froZz/qZmKm851OEeZ+N4J6hMdgSMbfQp/D1SiyimJbtZJCdteuU2CpE
         dwsywwiRj0Sfs+VJkXYdyyvpiBE+Cj1T+3bC1ubFrIjT1WVzHwufmt6PKWdrSFhO1/Ef
         rwmUEYX63CbVDMqK0bIBCjYrGMpcA62hecxbATIjQ9epoYTrgkgeFD38J2+YRgLLnhX6
         Ij2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMqnHryIcAuT3eB/jbSwJcaJrQAYWyhU6LUk5msEBw8=;
        b=rxXvGpSXhmQNa4KBnqCt5513xYnS98YvbJT5ujqrsDpAlr4Cf+QxaIfMpouel51EIu
         TI42+YjwxJukH1CwVO4NLCo3gviR1rflfWDRYF+VvhvTPUC4/+BfxH1l9EZnvCMK9sFa
         k82e8+gfWubMpvCKyGS6h0ouGe2um8UOGraqItor4Ir6x56K5YUlgFdsnty33Ehgras9
         tEa0o4DGDWdri56EHujDQlg6+EXsM+/+CVzSpG/uFdN5V2uNkmFU+YXDMVcvISGrt81o
         PdrhP3xWq0zG0CFv3HDB6veUHg4/IgO/KRFlg0TEU+F02pSeWyo9FII+zMRiiPzbEK9c
         TPMg==
X-Gm-Message-State: AFqh2krYXuDK5ZlN/fOnLxZqhaBsLkaxJL6ZngzvV66WNVHPy7P51jAy
        RjDbqYrUbq8Xf8x6JXmEWgYiZA==
X-Google-Smtp-Source: AMrXdXuqeLrKNak5BRqvde4pIjKaWHVVwo0RXLn8neGNEL4JTBRPY/xnvacLE4LeWkeIQpptEp/W6g==
X-Received: by 2002:aa7:8a0e:0:b0:58d:9850:d55f with SMTP id m14-20020aa78a0e000000b0058d9850d55fmr5788059pfa.21.1674015370673;
        Tue, 17 Jan 2023 20:16:10 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id f127-20020a623885000000b00588cb819473sm16575532pfa.39.2023.01.17.20.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:16:10 -0800 (PST)
Date:   Tue, 17 Jan 2023 20:16:10 -0800 (PST)
X-Google-Original-Date: Tue, 17 Jan 2023 20:16:07 PST (-0800)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20230118151028.1602fb47@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-6c9c7bc8-98d9-4a1a-b7b6-7279e3ac9ae2@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 20:10:28 PST (-0800), Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   632a9d999162 ("RISC-V: fix incorrect type of ARCH_CANAAN_K210_DTB_SOURCE")
>
> is missing a Signed-off-by from its committer.

Sorry about that, this should be fixed.
