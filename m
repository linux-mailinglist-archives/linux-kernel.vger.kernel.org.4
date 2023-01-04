Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0E65DFF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjADW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjADW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:26:22 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7D1CFFB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:26:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g20so15700610pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIgokSFORIKySFY6m7tmTjnwpgLEJc31TKVV2WohxQk=;
        b=k/zWL17knzlSo7mB3DThdqrV9Sai9s+S6GLcTIs+nxQLVB/S/3uvYnfoz63+REvG+v
         59N4XvM+4JQZvniUqMAfqsd3r2TQ3yapHNBLpOikK9OxZQukVOinpTL9xyHGl6JDKA8d
         k8oaQz0IkvGSztZocmF3BVy68FljpV+fskL9M+E5uBJ6NrMP/IvMz8JwpR4hKW0rC7Fy
         o8qZECqhF5rJTiPtASNrRtv1QLSQMRRTG0KmQlPpsyQo+6F2djwcQlNRdJLVfIztay6s
         EcU/4W3Uywmxvj51GUKUf+6xi+KtWMpsoSJ5vFe+yn2iGdytmvPlEIFU2HIPuHTPsKVG
         3stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIgokSFORIKySFY6m7tmTjnwpgLEJc31TKVV2WohxQk=;
        b=lAM3TiSaFlawFDmxTy4VdZGZXznIreUnDrdJkDQKIgVHamDOzRnEj+8PyzuoAuKfle
         Np+VrVSR6veF487+DXPppQ15eItemAK2HAdtcAZ7dPTSyMgWIEpeJJkr7BJITboK0flb
         0uafjShqlEQz7hkN3aKT28JIFfkT7T4zPZU+1aU/Zdz/ktjbnalkb6JtOtCZoHBTDR2p
         gXp7ntJx7BIReAY12aNmYMwuA8hUPiJhaPyuWQmBaCvrMlgsqb1JzsIXlEB1MGDS/wzP
         SFmCVSCygJb/i83WVSHjgsN1W4Ev27DLxxWtC3iw0au2/bLkurCtwxu4zlddcr3oq6Ti
         h10g==
X-Gm-Message-State: AFqh2kodqGjrKI9Dz4N3Ldv8UhQwO4vV1JF9OmFQ33mkhpDqUwDO3PBc
        XC4VF1JBDRrKTpTz4FBIFDY+qZ23O+o=
X-Google-Smtp-Source: AMrXdXsUUiE30xfyD4rfqAmn3RuDAlpT95GjaNC+IrK3bwlS3OPFB6SmumXRJ3FtFeQgEVpJqqGG7A==
X-Received: by 2002:aa7:8c46:0:b0:575:ff07:cb1e with SMTP id e6-20020aa78c46000000b00575ff07cb1emr55248731pfd.31.1672871181506;
        Wed, 04 Jan 2023 14:26:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x29-20020aa79add000000b00580fb018e4bsm19083746pfp.211.2023.01.04.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:26:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 12:26:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Richard Clark <richard.xnu.clark@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Add a new flag to spot the potential UAF error
Message-ID: <Y7X9CwLpuV/M4I+X@slm.duckdns.org>
References: <20221213043936.6345-1-richard.xnu.clark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213043936.6345-1-richard.xnu.clark@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:39:36PM +0800, Richard Clark wrote:
> Currently if the user queues a new work item unintentionally
> into a wq after the destroy_workqueue(wq), the work still can
> be queued and scheduled without any noticeable kernel message
> before the end of a RCU grace period.
> 
> As a debug-aid facility, this commit adds a new flag
> __WQ_DESTROYING to spot that issue by triggering a kernel WARN
> message.
> 
> Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>

Applied to wq/for-6.3 w/ whitespace adjustments.

Thanks.

-- 
tejun
