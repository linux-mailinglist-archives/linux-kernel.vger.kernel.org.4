Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B712F6C4DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCVOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjCVOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:36:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A365473
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:35:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n19so1437545wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679495741;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jbu2BN2MD8AK55tD9gpgYxyseZXeFWZjpylUucgmVfA=;
        b=RTxjz04u2joRaMa8uHBz15dktbHzstCpvU9PFywh/OWufVAARCdIRUNsZOqAfNF0Sp
         tP+FWIiyM+nMp3ifRvMx2FR1IT8ox6ec7hjs7YiU9FYldJ9vDrhXVJyX+d0d3oqiQ8yU
         2DH/5GrvlDAD/kkN0+f9rgXZ1njd3pyNvk4ZRVQ+wKf9s8j6uLvkGcJhkdm2TyZnvnhk
         uae28E3kIBC46CTQvzNKdCQxICgqy8I5Jar9lAtrAwdD/sd7tFq0KZNsBWnfwm/1ieLv
         Bp0CyJ8dmX52IHD2ald6Ne0wQBGs7h9bn1MwxMG/4jYoDYQb+Vu9LHiuM16Fn7ErrU+B
         IhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495741;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jbu2BN2MD8AK55tD9gpgYxyseZXeFWZjpylUucgmVfA=;
        b=721rXfr8VUOKC96PlJZBIEKskiI3O6t0oDoEmsgQMFqJkep9MDogluINs2KrG0iN9z
         xhgmgdnn32Mr3iUAmfE4bfPdjqbplMytKbU5giLUwbvRyAClvV6D/V22Ofa5C4ApugFe
         gV+o2uWWobQtaVamICqyFML7ZnWYYhimgYjExWIUjCNzGkGvj/2v5e/jrMibIqDKdxX8
         GYSrI3opAVrh0B/REUa0lCKNFyVqTpgBTpVo7UNCoMD93EIRdC0EILZdJS8bjB2JDw5a
         HrmfFeRCFXSk00lqFZVWT9mj7ryXqF6O8P+e1okQ41L8WphEZTLV0bmiZwy5uMLsZgI+
         CShA==
X-Gm-Message-State: AO0yUKXEqHPPbQFZjck3ScKHw53YRkOLEM/SnQID4Jrw77kwXSncappQ
        ncyiXu3Z3jPHvJFrZlYhBLvhHTgcFmm1vktV
X-Google-Smtp-Source: AK7set8yQ5eD7/ltB13mgpr1e1WKh4RWcGOKdlu7FReGb/WBxCtTBmnEEUc87II/zaXtfM1sIO6b7g==
X-Received: by 2002:a1c:cc1a:0:b0:3ed:711c:e8fe with SMTP id h26-20020a1ccc1a000000b003ed711ce8femr6167710wmb.2.1679495741101;
        Wed, 22 Mar 2023 07:35:41 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b003e1202744f2sm23535000wmo.31.2023.03.22.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:35:40 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:35:38 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: fix line ending with '('
Message-ID: <ZBsSOlPbaGZcAaSY@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the first parameter right after the '(' in the function call line.
Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/most/dim2/hal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index a5d40b5b138a..6abe3ab2b2cf 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
 		dim2_clear_ctr(ctr_addr);
 }

-static void dim2_configure_channel(
-	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
-	u16 packet_length)
+static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
+				   u16 hw_buffer_size, u16 packet_length)
 {
 	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
 	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
--
2.34.1

