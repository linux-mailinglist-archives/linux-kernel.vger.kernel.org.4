Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52098605B80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJTJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJTJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:49:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835E3CBF8;
        Thu, 20 Oct 2022 02:49:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1910739wma.1;
        Thu, 20 Oct 2022 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsbgLwtXWAZeUoPBDuirRh8cmWsDoeYMrYLPa9qkP64=;
        b=m2QbMSEZSz2NvNgQoSppIW5IjE0GNFw7ivno2OsayVLigqErIbVT7EP9JtEER/Rbw8
         T9fU6zIKtD0aFOx76KZyRUMbBtnrP6GZ2wXg5ju1XI97od8DKKqiXiXja6iAVyqp0ruu
         lL/PzZdlbWPLox8TPyra/WPOJu8SjQIr7/9NLZVy8MhSRIAWTEBMYxM2ElU4Z4espQ7/
         DRA9wPBe1wuVmnlTrKX0l2bZvYfhA9oSO++xcfKkHFFMvxMMxeIgn7vYTKzL9v83QOvY
         GqzJEqjHBH7NHmd4nSOtqMzyOthQsiPdgaU1856lGjHVIVIggYbsHSePicLcxrHfS0EM
         xDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsbgLwtXWAZeUoPBDuirRh8cmWsDoeYMrYLPa9qkP64=;
        b=RO8EZVuzKMMiEEaPD+cNmMLE4k2CoAExpPepgUIojqUuu3vwWZxoKfBVZ4WF8AEgDC
         KvB3E7INGYFfyh1USCMEsGW5P3qiKdXJcwqXs9+WYq1WkbU4dVDfYrLzUVPZYoAccTkR
         mdiAprNAXs2U9PlJjR1P/xqi0SxrMB25ZggPa3d0FhevisuPaxS2RLRhLQONjzU71v2c
         YSaHM1kcSPvx4AYwl3pI3J2C/0QjTXMbkvF4fVqO9nunPRJX3kV+8FNgfYntsN1bQAiw
         OO8XfJRHCGb5UOYVZDwcNopJHnSIoGZaBDbtbl935cVA0+HCb/d5i2+FxYsK0H4QE3Zi
         gMWg==
X-Gm-Message-State: ACrzQf2qhkepbDD1O7DVx1HKoJHXIpn4NEW5Z2E13GrD8FCh/+dEtEoL
        NvewgMWDIwEtsRFCXeskwgeyM3Bweg==
X-Google-Smtp-Source: AMsMyM5PnEwHsYtVW6F+MfMxslZN5E9p99Xey7UPtA8ZlGXhkZk06DpopANU3VdWyETee4Fl3zt91g==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr8927478wmb.89.1666259387545;
        Thu, 20 Oct 2022 02:49:47 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.126])
        by smtp.gmail.com with ESMTPSA id c26-20020a7bc85a000000b003b3307fb98fsm2314939wml.24.2022.10.20.02.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:49:47 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:49:45 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, torvalds@linux-foundation.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Jason@zx2c4.com, akpm@linux-foundation.org
Subject: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
Message-ID: <Y1EZuQcO8UoN91cX@localhost.localdomain>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221020000356.177CDC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct p4_event_bind::cntr[][] should be signed because of
the following code:

	int i, j;
        for (i = 0; i < P4_CNTR_LIMIT; i++) {
          ===>  j = bind->cntr[thread][i];
                if (j != -1 && !test_bit(j, used_mask))
                        return j;
        }

Making this member unsigned will make "j" 255 and fail "j != -1"
comparison.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/events/intel/p4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -24,7 +24,7 @@ struct p4_event_bind {
 	unsigned int escr_msr[2];		/* ESCR MSR for this event */
 	unsigned int escr_emask;		/* valid ESCR EventMask bits */
 	unsigned int shared;			/* event is shared across threads */
-	char cntr[2][P4_CNTR_LIMIT];		/* counter index (offset), -1 on absence */
+	signed char cntr[2][P4_CNTR_LIMIT];	/* counter index (offset), -1 on absence */
 };
 
 struct p4_pebs_bind {
