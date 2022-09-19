Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04CC5BD5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiISUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiISUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:20:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669B5481CA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:20:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay36so369654wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FWyWHD71T9hAwWWYq5d0qFKEdIZn5y5bu6+nFTnlJ18=;
        b=hgBacRkq3ArZclC2AkYn2gaCdnEgnA6budJG0eY+2zqqZ/S4xQA/Mw17bX61E/XJg+
         9KqmY+35daVsIUzLH4/TkyGKlTaGRPxxQnUJdH6PhoepK1ff2a2rcC2Xso0I5a9aJPPz
         Hkn8r/ipkh38ZhfCKOAlYtpR5d3BrktrLv3krWwa5UeE/U2PQDRaEpI60in9rY2K9vXQ
         EhZzrnSol/3Gf64uvDiF6SNoQwGpytLqelrTNei9bSWPW8EDur8AFgZq1foc2CfYMx5L
         toqYpAPANl5pzm9fQriSZyriGEHGN/Kq4DG/dCSSLGsSqbzOdSDmLi/LRbo2MokM/e4B
         InAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FWyWHD71T9hAwWWYq5d0qFKEdIZn5y5bu6+nFTnlJ18=;
        b=26npMy/lHtaXS2FkuFbklrzHdjzvTBe0FaDuwJb+ZgAyaDeuKDq2zdE7314FriBgRt
         sCSQtOQ3s+KooucyIFMxV8R+iFoEJp9qH2g+O4ZR1r9uS0JmkIqMl3NaM5fQLVuRymz/
         PmCi7dONqIys3EOTW9tCArC/uC9mu3UYZq4gXf+Ic7VzcFlNcCsqqWYFNX2fO+KQk6OE
         FvRPMqBTpRtMVCjgFBSTXHHR7WCXMPhcc8yJlkC21rIertUOpAIQYbOeZubXaCvjrEJT
         2nMmb5eEu1itPE5pWix/fWlqZFrD7ooRqON7e9nE0THTAJ34a1WM3S3pXCdTzX3aGflm
         vZXw==
X-Gm-Message-State: ACrzQf1aHM/wgOX/oiUEbmV0bNzNp8W50fHgnqk5zflBXI+xejD6CgSP
        Yzb1begWRcXNlqvFRdlyIs2RH0Wpcx19v2SU
X-Google-Smtp-Source: AMsMyM7birQYVrRfSnQfrNtoIsmDQfe5J5LG1IWer0w1g0P11BZbr84r+SJ3X4bc0gChCwFzA89WKg==
X-Received: by 2002:a05:600c:4f55:b0:3b4:b687:a7b7 with SMTP id m21-20020a05600c4f5500b003b4b687a7b7mr14028458wmq.185.1663618807653;
        Mon, 19 Sep 2022 13:20:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm17342849wmq.23.2022.09.19.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:20:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/.gitignore: Add io_uring_zerocopy_tx
Date:   Mon, 19 Sep 2022 21:19:58 +0100
Message-Id: <20220919201958.279545-3-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220919201958.279545-1-dima@arista.com>
References: <20220919201958.279545-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: d8b6171bd58a ("selftests/io_uring: test zerocopy send")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index de7d5cc15f85..e17b4f1ad770 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -3,6 +3,7 @@ cmsg_sender
 fin_ack_lat
 gro
 hwtstamp_config
+io_uring_zerocopy_tx
 ioam6_parser
 ip_defrag
 ipsec
-- 
2.37.2

