Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F26E5C45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjDRIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjDRIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:38:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A1903E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:37:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v3so2082277wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681807055; x=1684399055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMfE7rmp8en6Ue+2YarFEhjc2EXzKNSiQsK48tdZL3g=;
        b=KTHvCxcyFRavnZh+TtkAnLFyC63UoIt8bPFbsiiGG5VQQK9LIcL8I5V4SDUM0CsQKc
         qdPyFLPP547u06Sm/9/jJsQkHmjfqj0BrPPgmfjkzAvy0zOL9gFiO/SfG8Bk0SbYa2yx
         +YmnRhrGXaHy/4z3nKg0NgUwDUy2zksPC2RQF7ws6E3QCJ9Awdw30ir3m4RalNwFNHtg
         kXIP6Ls9Jffae41AfOY3elkJd7m5VxXZ4Mpl85c9Ub/3PIruzhkLQUCGOCXC5ITIrNRz
         qCP6mLVKv1MgbuaQRN6AxXaSn6CUsCIR56HEuJnDEIolRs3Ieo/iE+ewt6EuFwXoCYbY
         U+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681807055; x=1684399055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMfE7rmp8en6Ue+2YarFEhjc2EXzKNSiQsK48tdZL3g=;
        b=OnyGGP2NcuFpeGQa05Yr/QnDQh1s8K8NEYJCqbYUu8l6bGG34RwUuon/B4y2E17tiT
         Vt5Jr3bMZXcrEsFXMqqsfjvKJnOB7iiMehJ0A5hq0ymrPIdhZ2TLlthJGrHVtWGl1Fns
         KSBknngTRugI0FAx0ce7Md3EgIUOJggvphBctIn70jGwLyGLMnNPP1TCtHddvMuo64kC
         CZxIKTch5okS0Xd54eJCDUAWhC1KASW0EiRbo6vbuv/nH1oQO97jTHdSc9OoVlaxDSaF
         sk658UaNQiGHh/ox4JWIZta2/amTvanM2uwujY0/l006yNkJZrM5j4rk34CJK1uS268f
         aGtg==
X-Gm-Message-State: AAQBX9dz/jezwjJoX0yGrHOHEB4S+mO9p806Hma3mkKLi3aPsga3Nw9b
        izE06lnErb702YbyYW86rg+ZXw==
X-Google-Smtp-Source: AKy350asbUvnrVe64GhyVH8OJKKgZQ86HpGyF8VsveMLyD/u+MKWKm8B6stB16HtRU2sl0v6krMsHA==
X-Received: by 2002:a7b:ce91:0:b0:3ed:e4ac:d532 with SMTP id q17-20020a7bce91000000b003ede4acd532mr14027831wmj.36.1681807054658;
        Tue, 18 Apr 2023 01:37:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm17904388wmo.10.2023.04.18.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:37:34 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 18 Apr 2023 10:36:59 +0200
Subject: [PATCH net] mailmap: add entries for Mat Martineau
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net>
X-B4-Tracking: v=1; b=H4sIAKtWPmQC/z2NwQrCMBBEf6Xs2YU2VVB/RTxs4sYumBh2UxFK/
 920B0/DezAzCxirsMG1W0D5Iybv3GA4dBAmyk9GeTQG17uxPw5nnItVZUqYueLfJpJXotKyYnQ
 +8ng5UQgO2o4nY/RKOUzbUutttihH+e7Pt93d1/UH4eCUv44AAAA=
To:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=DooUmpOSM3A9fZVXC1DAL5Lt7oTsYSx1ahnerLNxkYg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkPlbNq8A/WHHC/NZHHhVbVO2EAxIBydUCuNlXe
 NYNnC79l9aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZD5WzQAKCRD2t4JPQmmg
 c92VD/96fI9l78DUXZovCVHtg5dAd2W4sHYnQyrC3uuSjOEml0vuaVgsGdm2XnQjnuz8+XUHjym
 fJCWQ9UHYnlfDN8nkOk6NlMr7OTJDbMTUkZ4egIIf6dMdGRDo+uqKAizmzg5Ji9hDOnYdjYanLj
 NcAo4KSrKOTwC1M9qShEXpv+Jksl9fOEOKRq3f7RJZIxJZB05U9dqiiclSMNMCSzibfMPG5rH6y
 42SMwyrrnQnwyBGE65obPEGf5TJhjmp0dO6NVKkShU2cctr+q0PWnJN4FWpNdq+uQLhAdyCjs4t
 oGiKjZ7OhVUpSFKi1hpeA+55CxPGAwShRLxPraYv3NVdYDD+oIK5UdnfonJpBP4XUTlU0tsYpj2
 p5wmVpP/BQTMLQO3MbNkVX2sxNSl99EYZFhiatiwikOp2INaI5yWloz7eu9gAafbsDbsAsXjIPj
 MDZUngML6+BOTJML3V77XOEB9+2rf9TbNWFNKFG2q8JpUnz9glGDandnspF6TRTtLgTecqWslhl
 +ZTXXKWLAwzf1lva3qrJydcXUbuoJOssWk53pOVg16fCCRwFQ59Niqhwb9nR3PB7YGGthRGqKn7
 vZtdq1BJfsyieELvZy3olbeUxitHwwfbbdWJwCdEKo7q9Gh+bGA2SnFzuTJ5NLPFbGyIMIe5O8H
 KmMy9k0Rfhp1miA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map Mat's old corporate addresses to his kernel.org one.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e42486317d18..69dae9b6ec95 100644
--- a/.mailmap
+++ b/.mailmap
@@ -297,6 +297,8 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
+Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
+Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>

---
base-commit: e50b9b9e8610d47b7c22529443e45a16b1ea3a15
change-id: 20230418-upstream-net-20230418-mailmap-mat-f2bfe395acc2

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

