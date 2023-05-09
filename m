Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905846FBC70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjEIBWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjEIBWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:22:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036F46BA;
        Mon,  8 May 2023 18:22:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64115eef620so38799625b3a.1;
        Mon, 08 May 2023 18:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683595360; x=1686187360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au9agmn1fAuoWBQtARq17AEbHUZT+qsMcq+Xb5cLNzo=;
        b=X7RgVwL3v5eZwAel21m1GADrylU7pxTYwYAbeUz0i+OqdQ7EDkvsvrGjwb2nX4KAuG
         HevzDBP25xpEFqkAcaQND3xyTYg0e+dI45oLGjsA14M5QNsVI3pCBfaQchWiqFAYi7L2
         TcVBR8ZDrmYWVsiCOvly4ujN6FkqEyxaXKUmPl/5ihYlZ+N2E/6rS9W8fdslRNgn8BAv
         ph1ryHBu/tAM7n9fES9W58FSqzzLTXWddmnrtfGl2LMPGVsSCCjosCzLhx3+3gl660hp
         qeLgurWYE+UeaDnPwFQNkh381G11FzWqzjqxB+3IOrFii/nyV71QOsOjmb3VDlFZoI97
         DMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683595360; x=1686187360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au9agmn1fAuoWBQtARq17AEbHUZT+qsMcq+Xb5cLNzo=;
        b=D7bdZXs54yGYi3FuzhXdj+uyV7IaS3LTfvaKj9hjJOkQwaMGq9e0Wo39F4nQgj2tvz
         GQ1e/5niPLCIgQvzx6OPAxX2aV3XZc1nEM3Wz6ZMBx0U+1ca0IG+hDYvXMYxUEuds9LJ
         sh7aQg2LyYm2TdxlJSrCbsbL1K1pF+CQBc69gzmaAXJEYQ2fYihb6EmzLXhytASQE17F
         MlOfps8pQvuolk0VXztU4WJ8IVIp4+gcTERx45CRc8h+ks8WFKbP6G6z9KebYFjYo5b3
         LY6PM440V7OQUuZsJDP+W5+KxzUImMK0jvdsGji5Qh6iziEnjpSS6ibiLLgyT4K1Jepg
         nEqw==
X-Gm-Message-State: AC+VfDz25SaT0aPcRD5t/s+tkvJuhvPDmkLm0Qkgrirz/zCwF1AQ1aXn
        YvVGpLje7onnibKoZGQKJk8=
X-Google-Smtp-Source: ACHHUZ7W13EJUM1P+PLUNr3IIAIDRFzJWLHkdEj8grXPNYZ91UoGrP/4BSqjLbd1oCaLf72OdDn9vQ==
X-Received: by 2002:a17:902:da92:b0:1ac:94b3:3ab4 with SMTP id j18-20020a170902da9200b001ac94b33ab4mr859171plx.27.1683595359795;
        Mon, 08 May 2023 18:22:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001a6db2bef16sm98287plt.303.2023.05.08.18.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:22:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 15:22:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 12/22] scsi: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmgXcSadQpizbwI@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-13-tj@kernel.org>
 <ZFmMaraKKz8D_YGY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFmMaraKKz8D_YGY@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 01:57:30PM -1000, Tejun Heo wrote:
> Applied to wq/for-6.5-cleanup-ordered.

Oops, strike that. All scsi core workqueues have WQ_SYSFS set which means
that their max_active could be adjusted upwards through sysfs. The shouldn't
be ordered workqueues. This only leaves NCR5380 the only remaining
conversion candidate; however, that one only uses a single work item, so the
better thing to do there is using the default @max_active instead.

I'm dropping this patch and will add a patch for NCR5380 in the next round.

Thanks.

-- 
tejun
