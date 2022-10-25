Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121C60CA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiJYLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiJYLEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:04:08 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA28180580
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1666695845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e9ey0KHZoREvDvjOAPwKHYKH0ajm7TTYQlLzrgFDqig=;
        b=iO2SDm747bgDYpnPFWXP6zu0F65cwyxuU79WOZ+nc6tmpQvSPw7Nnl1m9szyKvly9h/FHJ
        C6nSA4nrG3OHTHN9kLcMnI5/8JWlI1ZksmS2phrE9rKEJK+l9NXsiLU7mw1rlAysSn5fdP
        riTtPyYa9yeKTllUIqcv4ul+ZiOvqJE8saXW+0GNiokj2/9JIchCBEDlcZp3pJbykhStG7
        UXZjWeYV7McafeihRIYZx7U7JzX7Wqm7EJPdj5wFFnuZ+y8doqotIzDlifmRZM5xFyx4rb
        UuN1hqKQgaaNrI7aBmwbHSWK8RKm1JRbAjOfhqvlMNRE8yNxiDJyOxNjTCIsNg==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-126-FSWmC2tZPhidqx7gP7bzrw-1; Tue, 25 Oct 2022 07:04:04 -0400
X-MC-Unique: FSWmC2tZPhidqx7gP7bzrw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Tue, 25 Oct 2022 04:04:00 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <dan.carpenter@oracle.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH 0/1] clk: mxl: Fix smatch static checker warning
Date:   Tue, 25 Oct 2022 19:03:56 +0800
Message-ID: <cover.1666695221.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the static checker warning reported by Dan Carpenter.

The patch is created on top of clk-next branch of below clk git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

Rahul Tanwar (1):
  clk: mxl: Fix smatch static checker warning

 drivers/clk/x86/clk-lgm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.17.1

