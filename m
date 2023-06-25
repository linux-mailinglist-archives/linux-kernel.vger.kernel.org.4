Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFD73D2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFYRM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFYRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:12:25 -0400
X-Greylist: delayed 1422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 10:12:23 PDT
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159D197;
        Sun, 25 Jun 2023 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687713140;
        bh=tTjSzPD0ZS2M9E/b1QdCa1lslVGibpuk+ySp3PiCsPY=;
        h=From:To:Cc:Subject:Date;
        b=uXQuhdD1RXCyqIMRuAC6RNawiGWrScmqgmWjJno5ItAyE+Dnw7y1noRGvvG+MxpcL
         abjSR6EqHuSDIbNOeTTMAU6om7JWft0pOFA1UhWcSvH2ieY8cjWoCrOkKcBe+s+NPf
         aPeKZIfikzf44ooCLha8oqnyv6+nsm/bPA8P0/oY=
Received: from localhost.localdomain ([122.14.229.236])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 31025411; Mon, 26 Jun 2023 01:12:16 +0800
X-QQ-mid: xmsmtpt1687713136torclcipj
Message-ID: <tencent_D1B05B6060451EA10A64A88E122E37EDB508@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTCXLSPHqXFkOFtDq5l5WMN7KQPSK3Qla6k4fZpvTjFwGb4uPpC5
         L1Iy0qFC/oiONC0AmcaVWvRi2dYw7WMLJPmNgk+7Tk+5cKrn0aTrTNk3nN9Xr6Uynd/g1QXTt8WG
         yU4/IDQr+rex9eoP6IJx2T/wJ0/yoSNDvXNEnjcQ3q4Fj3AEAjxEZRYQFz8kNN65GlxaUhH5AWoy
         jnimiFAbQrB4JGW54GeeNyxyt4xrfi/zvr+AyPJ894sb/un+hCVKyD5cIZOGc22PxzTr3D+j/c6H
         /Li57Ui0RNzASHuya+tAJhcSaT/dBXp6f+Nyz5lfa2X8qBZmc7AVSmE1DUl2ndzEAzUqGYtoKQRC
         I7XiopOoXJ5apnoyVAyXiHtUEdXzfIiEh6nEPHWTmb8ezbPu/a4fGhz1hcyjO8mGcYHdH2iVl77S
         Sp2gzSOJHQOxMYp8ble/U+aPdx8R1kDP4klTRxzyrR9LAWv/88J+03iazIWtHr+rBMFzqaik9kjh
         tIcaIZ5CgrWChofpU404RTwGRsSyGTLkBU55G8TyKea4Nwn+ZrLFeU2v0swyY/UQwHk+2CWDCPsa
         WvPSw5BuGlhAlpT8XK6C7DimzTUnsoBrg3rriLR3Tq9LvZtPjj9ZKpnp8vPaWhqYP7iNfvF52qdG
         2LViA68tR/188qJfgUlPnlspSpFV9HpEWzK4CE9QoSdRrG/n0BjWA5pUidNYvpUa8k+acK+Bx3nH
         zlUOPp2WGwUA8lrno3IWK+lNyAVQL7gKKxsXnpkr5vJHiVVdFJAcqkH+dtx40ecgISbbWYmlt+82
         utcJ3JGeEMrEDRyJ7qEJeMBQsYx83wyR9qEboP4xq7dkuoK18hzXBZf1gox3yo2VBWGGKdlnM0Bf
         aKjzyU97UN/h+bWU8tYs1Y91trgRsUr+HX1tav8CjAlrvjbsqi/h2+nnH61HYzFzrHxG8PLbluWI
         4cvm0XCmQVkhnoLx2ItGOQ7BGjIQMS7J2WJ0wudmgFUeg/oxgIlYSI4wpvEB9w/5w1/m4GSGduIs
         uCAiIXhR7zhqRCC5HlFerBZbvauxsj2y969HFFOxrdC3sdHcSZeuiZh27H+swoPveFWJ3xZQ==
X-QQ-XMRINFO: M0RWTeBkoNRBR1Uh12iQNRvA1CSLhD8+1Q==
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     gregkh@linuxfoundation.org
Cc:     mark.tomlinson@alliedtelesis.co.nz, krzysztof.kozlowski@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] usb: max-3421: fix potential shift out-of-bounds in max3421_hub_control()
Date:   Mon, 26 Jun 2023 01:12:13 +0800
X-OQ-MSGID: <20230625171213.24014-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential shift out-of-bounds in max3421_hub_control()
ClearPortFeature handling and SetPortFeature handling.

wValue may be greater than 32 which can not be used for shifting.

similar patch:
https://patchwork.kernel.org/patch/12162547

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/usb/host/max3421-hcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index d152d72de126..035cd6abc2f6 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1688,6 +1688,8 @@ max3421_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
 						!pdata->vbus_active_level);
 			fallthrough;
 		default:
+			if (value >= 32)
+				goto error;
 			max3421_hcd->port_status &= ~(1 << value);
 		}
 		break;
@@ -1741,6 +1743,8 @@ max3421_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
 			max3421_reset_port(hcd);
 			fallthrough;
 		default:
+			if (value >= 32)
+				goto error;
 			if ((max3421_hcd->port_status & USB_PORT_STAT_POWER)
 			    != 0)
 				max3421_hcd->port_status |= (1 << value);
-- 
2.41.0

