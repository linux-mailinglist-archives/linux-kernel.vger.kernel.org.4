Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB9F747A88
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGDXvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:51:00 -0400
Received: from mx5.ucr.edu (unknown [138.23.62.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CADB2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688514660; x=1720050660;
  h=mime-version:from:date:message-id:subject:to;
  bh=wSdyC5891jJbFmTuKtYjfgMjLQS/fVpwoPNKrqoId3M=;
  b=d9+7b8F48Bh1CHuO+nvKxuAlfIuzvWhl4ddX8MA0b43BnhYSR6u2nKOP
   VQeDVPpNKcRi90osiHNiz4tmoOlOsmUXv0y6QvpixbNaVbmTGKs2MGeKt
   pbn15fx8o5bY4Tskv65xu2tLWGGIjMw6+ukjzL0JTVzBzhZDOabhzpP41
   2OOl6rGWEanm1+FtOTfNo/oAdG++KMUXfdN140ORaTYvqsmboXIRHGw5W
   VN6XdNzsl98rljfsjL+EckAlUJmVp39X33WPEoVpT+uCkGMhkfyVWyIZD
   Xp843HkoHkVRYhApvrga1UJ3XZ+Tks0Q9Lmrv0sW3wq1OHBbKyB0YKcaQ
   Q==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 16:50:59 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31286355338so3487055f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688514657; x=1691106657;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mXMcy887qPFqnoPqho388ScuVrFV543nUjedX0tcHQ=;
        b=bzV6Rgax6AZfFeVKbuPFqnvFeBXJEjwMahX2psJdYDuKMlY4Dw92ZLBWN6XXHX1Xq/
         aZdYx5Hluixt0Os3s0kds/ggce1w/hGlbUNWkWecszOUKx3vFI0mcKzME6KbKBA8pnlL
         DOAen/gLefwSU5jiBe7Z+0IxY5DivM2BptD28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688514657; x=1691106657;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mXMcy887qPFqnoPqho388ScuVrFV543nUjedX0tcHQ=;
        b=a3GW8IN9tougolUZQ0mAkv34oWB/bhnex6SrWdbGOteoG0bmMnGcbCItvS1VO1bS7x
         LaJ8BIYnDZgMiiDiAALSWJa41WVuHVuewB1RGVGk1p/f4xqWLBqK+9Nuu+b/ULWPSumA
         lU2ilblwH0XDwcKPoa1XK9Sy2G6UV9BQQo4YuPozX6cAWFkfcQcg63YV83gM7n4iCuYt
         e2FRR8UEtdTaRg4oURag9eHeTTJCTTtWVczAFsJvkVGzZU3yjoaK31F1KtqYppTcrNUc
         8MTIGTN5CferOQC4UrUh5ZtkKRETfiWYCDYo5+jCQ74GJ6xfoCk7kSjez9kMV9g+P379
         yPfQ==
X-Gm-Message-State: ABy/qLaCpTg73p4VGo5vK8SMrSEdaeRNhGmjpWCLSfjEprjZPrNJdCmc
        hS0Ej6U2Xdii9CfoP0s8QbrjtXIBdIlN5H9OUlniR0CXk/8UWEUod7nKOjPW43arCTsBQjpmo/X
        TI07FOcVDCCmecf4VBF4dsloCB9XKY+BGsvahShD4hA==
X-Received: by 2002:a5d:5148:0:b0:314:3c84:4da2 with SMTP id u8-20020a5d5148000000b003143c844da2mr3793307wrt.13.1688514657474;
        Tue, 04 Jul 2023 16:50:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFopcbRFlM/QXxH3jqxO61w82vcVsCVkdkO//2H4gliBuit9v82WgR6YBumb+o9c6O+3lD56vmkqTBlRIC1K6Y=
X-Received: by 2002:a5d:5148:0:b0:314:3c84:4da2 with SMTP id
 u8-20020a5d5148000000b003143c844da2mr3793298wrt.13.1688514657217; Tue, 04 Jul
 2023 16:50:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Tue, 4 Jul 2023 16:50:45 -0700
Message-ID: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
Subject: [PATCH] net: wireless: cisco: Fix possible uninit bug
To:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct cap_rid should be initialized by function readCapabilityRid.
However, there is not return value check. Iit is possible that
the function readCapabilityRid returns error code and cap_rid.softCap
is not initialized. But there is a read later for this field.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/wireless/cisco/airo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c
b/drivers/net/wireless/cisco/airo.c
index 7c4cc5f5e1eb..b3736d76a5d5 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6950,8 +6950,11 @@ static int airo_get_range(struct net_device *dev,
    CapabilityRid cap_rid;      /* Card capability info */
    int     i;
    int     k;
+   int     status;

-   readCapabilityRid(local, &cap_rid, 1);
+   status = readCapabilityRid(local, &cap_rid, 1);
+   if (status != SUCCESS)
+       return ERROR;

    dwrq->length = sizeof(struct iw_range);
    memset(range, 0, sizeof(*range));
-- 
2.34.1
