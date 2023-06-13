Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7672DA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbjFMHSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjFMHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:18:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA236C0;
        Tue, 13 Jun 2023 00:18:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6563ccf5151so5650681b3a.0;
        Tue, 13 Jun 2023 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686640690; x=1689232690;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzYgRwPg8JdhQnyUV5Bio3PSnpDcesnn2dhxw0518hU=;
        b=X59i1meXqceIJ6FIRQ3ILbDdePHsBE0Meei/edDAk/NCfHqwxa3i+vhce+X5R53Qe6
         faxALy+SAuvgLVyR2B/f1MPTXvqLqrzYlmyESImKpHwISf47/PaFuY7/ziWrJ56nTAbq
         waDeXiZfHQOTysI/NruMGJeWgqXqZ3l8xe6nFPjeR7UJWFebGIv9m50id8rFHsl9X/KK
         EM9sKNqTKuVJQTEYwBt3h10xQeAd9N12o1x3V/alTNzEhOe5T0508qjrL4s6UTODnUq3
         nAdQq1L8xw61zaFTlue7RoVUQtjOyCcCLOEaOr+fyGKXbq6RHhv7E6eMs6WX2XgF2LUY
         NxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686640690; x=1689232690;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzYgRwPg8JdhQnyUV5Bio3PSnpDcesnn2dhxw0518hU=;
        b=hxcOfDGQk0ln+UmhG2+O1N1soE7LdvOGkEKI441fmC63g9uOgnmNUXQaa49wmJenKR
         Xhc37eyu0NbhF9pJSPGMidnxPfMIiGk36ICsw22yjgKV8rstUfYAt1zcOZnYjwoGWxGk
         5JxNnQi0G8nY1tuQWo3dZ1XtMJW9amTvu6KGkONNFXPU5RQhn6HL2VPeS2CApyryrLNa
         5jUwPYuUdQY1kZOd4lbA0cj68t7R7+WYLl5P/fBMErrgqQfmnt6N4EEBaqZBWwDTKIYW
         t0XP0DHkGN3ScE99J0VgASkNY/LRkEi1R29t4EBIk2O9/1ughPOIgXxPdqTUF4QgdEor
         Sc4g==
X-Gm-Message-State: AC+VfDydNMCpee34bhFch7pmCYW8htWO8tzzxKeeT1HNvNM+ud32U2FU
        5wg/Jxgsh4W2RjaspynsQ+Y=
X-Google-Smtp-Source: ACHHUZ7eA5qSLxLN6ZD3No7BDlDBzevOn6H5x6Cieo6LR6pJPR5ME/H54n78yei+hUpBtccIq6GRjg==
X-Received: by 2002:a05:6a00:24d3:b0:64d:4a94:1a60 with SMTP id d19-20020a056a0024d300b0064d4a941a60mr18423345pfv.18.1686640690156;
        Tue, 13 Jun 2023 00:18:10 -0700 (PDT)
Received: from sumitra.com ([117.199.173.64])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79190000000b0064f76992905sm7944423pfa.202.2023.06.13.00.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:18:09 -0700 (PDT)
Date:   Tue, 13 Jun 2023 00:17:56 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v2] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
Message-ID: <20230613071756.GA359746@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generate_test_data() acquires a page with alloc_page(GFP_KERNEL). Pages
allocated with GFP_KERNEL cannot come from Highmem. This is why
there is no need to call kmap() on them.

Therefore, use a plain page_address() on that page.

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

Changes in v2: 
	- Remove the kmap() call and call page_address() instead.
	- Change the commit subject and message.

 lib/test_bpf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ade9ac672adb..70fcd0bcf14b 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14388,11 +14388,10 @@ static void *generate_test_data(struct bpf_test *test, int sub)
 		if (!page)
 			goto err_kfree_skb;
 
-		ptr = kmap(page);
+		ptr = page_address(page);
 		if (!ptr)
 			goto err_free_page;
 		memcpy(ptr, test->frag_data, MAX_DATA);
-		kunmap(page);
 		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
 	}
 
-- 
2.25.1

