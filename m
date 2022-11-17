Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF862D547
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiKQIm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbiKQImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:42:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE471F2B;
        Thu, 17 Nov 2022 00:42:35 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5E356E0;
        Thu, 17 Nov 2022 09:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668674553;
        bh=GesO4lDOfgoAFgRLJP+AnBfnRtub6PScqO3q3Eoh5Fc=;
        h=From:To:Cc:Subject:Date:From;
        b=k/hcRzAK/hevcw2go0xjSnhiKGfFTksQhC6CxeNCTY6wPis8Xz7sqcbvXXGvqDtp2
         brFANgU1Mdg9KlXnd8VhYI7wSEg8TJSE1hdBoZZFp1cExQQvKIP/ZlndeVdCr9mE3/
         XP8RFoJnXxK5v/de9NQ0C09DgPYftPr3f0mlqDkM=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] media: rkisp1: Miscellaneous improvements
Date:   Thu, 17 Nov 2022 17:42:14 +0900
Message-Id: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds small improvements to the rkisp1 driver:
- Add NV16M and NV61M output
- Implement ENUM_FRAMESIZES

As well as a small code cleanup.

These patches have been sent before individually, so really this is a
resend, which also bunches them together.

Laurent Pinchart (1):
  media: rkisp1: Make local immutable array variables static const

Paul Elder (2):
  media: rkisp1: Add NV16M and NV61M to output formats
  media: rkisp1: Implement ENUM_FRAMESIZES

 .../platform/rockchip/rkisp1/rkisp1-capture.c | 64 +++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

-- 
2.35.1

