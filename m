Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA8637823
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKXLy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKXLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:54:55 -0500
X-Greylist: delayed 630 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Nov 2022 03:54:54 PST
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EDDBB9F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:54:54 -0800 (PST)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=T6sMIfDF2JhfYNmS9ABIn9Bgsu1lIFdnbjOsRdEggeN8UQfekcstHJn6Aob4f6RlrwEJ0rqjWlDlnGLVgCVJ8DzDSYaDUIV+sKKrx9MdkrVNnY6pxKGOZk4tKFmEHVnwUj4Cf+y/mTAAEjUjjZfGeUdFMx+2Ch8JujWgzQ4cyOJAQKSWfhONS9b5DAHHdV2gSTx5vhuZYJ2HYnfk6cBGJX/RlM4PJCCPPlZtzC/TUqPOpEk8rw0rykmPSBCjrxmsfdkcEhrDtz6DQkDYEclD7N93XlHdAa1PeS/i3RW6h5et46+Tz6JiAfXDMgr0JSRmgXfZXJspglotOT8oY62liQ==; s=purelymail1; d=iskren.info; v=1; bh=TG0xDH2+izdYetTRfts+U9kkrDQ7c1/PbY7tTcrLXls=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=FxFY2s3LHsLx5ojmzZzRayV7pG/LryiMwBIkPuStut9ElGTa3w6N2CULAsa8pqrTOZ0hAWcBONJdwcBfeUxste4kJPMM0jEda3X4Wz476dZxbkl/AiOQ/D3YhPgeWXIZkB+98CG3SRWG4NegC3WU6LxQt9A5yLftqGTTaHNe1CkbXJLMn1pvR6ajf0F4GVSSml+naplB9tLfgJxngnUk+iY/S36ilcuPOtdlRmfvxR7um9OreVHSjPzuYc+VoOdKyQjCc3/7JoVFeGG4FrXy8PyJVdVa6z0ceAjEGMLCqAW39YzmEo+6lNul27eLxVZD1rw/WS4XcT12rvY19+dJjQ==; s=purelymail1; d=purelymail.com; v=1; bh=TG0xDH2+izdYetTRfts+U9kkrDQ7c1/PbY7tTcrLXls=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2076108170;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 24 Nov 2022 11:44:15 +0000 (UTC)
From:   Iskren Chernev <me@iskren.info>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Iskren Chernev <me@iskren.info>
Subject: [PATCH] mailmap: update email for Iskren Chernev
Date:   Thu, 24 Nov 2022 13:43:56 +0200
Message-Id: <20221124114356.2187901-1-me@iskren.info>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sunsetting my gmail account and moving to personal domain.

Signed-off-by: Iskren Chernev <me@iskren.info>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 4a14ece4cdb7..ab20bdb07656 100644
--- a/.mailmap
+++ b/.mailmap
@@ -228,6 +228,7 @@ Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
 Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
+Iskren Chernev <me@iskren.info> <iskren.chernev@gmail.com>
 Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
 Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
 Kay Sievers <kay.sievers@vrfy.org>
--=20
2.38.1

