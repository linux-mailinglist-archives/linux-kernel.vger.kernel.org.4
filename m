Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577BC6B1E96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCIItJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:49:07 -0500
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFE74DE4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678351742;
        bh=I8/QTAP2wxPZCgd4AFae/zKk8r+YiOAkySUNLPMR6n8=;
        h=From:To:Cc:Subject:Date;
        b=u7fI149rCMpGTd25aXaZepU37QOqGzOYXlcxsPheR8Y2r7twcMXqpiMoZxEECfxAp
         8HPGPQzKEoww/vB2K9iviuD9vJRQTnWnoDaLbrJ0LTIW3+DeekP7H3IXnXi2YCHay1
         G9BUi5uSEhfmc7RtpEPaCWZ6C/4D7nRXqxOLVvXs=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id AB8B944F; Thu, 09 Mar 2023 16:42:56 +0800
X-QQ-mid: xmsmtpt1678351376t4h0x8ssq
Message-ID: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No0SEQ81HMmrzk6Gkh+eQwyK1ePoqWDdO6LuGgjeWrXsvV5QeLyf
         5sd83VA/b95h4k+61ySA7xOZCoiBArShx5IHx+bmUw69lXnudlu4fQ+qLakkYn3BPVRdRt3ElHbB
         gNucTHo29QE9muhyIWihyql8SqP+Qv2dhP4mZD2EGWkAvXBZsbZLaZ1geWy5w0hwSOW7jNGw/XHx
         4vZ/1fqArrIVpTmivSm2VMU8Bg+mh1uUoHpJjAl8tECAyH0+zyPO4MgJGk9CmFiHq/yQPDk3FYSk
         E4Zqbo3JCQMdRPa+WygtquQoEIqrta9LJAG9BvqZLh3MWv+DAynpiKUTyhgHMGOTP/JpUU/zuJAO
         etJCRgupguxmY9ET/kLHDUehq/w/iagR4h++wfTxTHZgkWCjiC4BmD29YBPxVYY6hMe5iSx1RlYJ
         p8F2+HkH9aI6UwhGxkeGnnWFnL1DygxnI971b5pEpZREnBeS6NkIPNCkPut92AKP+xv8m73dRaeh
         5PSD4oB7CztAoQG8etNeiZw8xZxXcrAClgSUJSxu/sSzB/KoXq54sPnhD2I3kf+aRpT1vB/zYTve
         CTqNB5yFCar+7xEQrkYlDaNy59M9lgGo0ujhNRLIN6ZOAF++CBKbJoASA7uTwLEsuqL51cgoqRup
         97dP5DOZ/+vzxJwx6Kv9iwslf7cW81PQBpDyuhlIREEb7BceSphcS4juU7UweFCiU9cC0UyAFuRw
         lDWk5eCL6VE7re6Q4gr6T0hjhso4/8cmZ4zj9KR0awcKbsWuVimo2L8q3AXkKCABEmAPiZwJ8hsp
         HNN8VDG8EMc5CcslXCq6yaHAaUloW+dJvhJ7lbI41JSkW9XwnIqAJuCJe2eHCIwaeiGA6sl5lrpW
         zF0vp3NZxK9mxJP3x0/RdmHVjs9+0oDuEFhtns0kZTuTUdiPOPL0KTjgTE6CEFDkirrAQMWkNb6N
         ndExMKAXp8b5+yZaGD+sisSaEiEKq2MtXRUCLR1D/2S89E3r5hbA==
From:   Rong Tao <rtoax@foxmail.com>
To:     sgarzare@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tools/virtio: virtio_test -h,--help should return directly
Date:   Thu,  9 Mar 2023 16:42:50 +0800
X-OQ-MSGID: <20230309084251.119197-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

When we get help information, we should return directly, and we should not
execute test cases. Move the exit() directly into the help() function and
remove it from case '?'.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: help(): exit with a value different from 0 (e.g. 2).
v1: https://lore.kernel.org/lkml/tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com/
---
 tools/virtio/virtio_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 120062f94590..33e17307441f 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -327,7 +327,7 @@ const struct option longopts[] = {
 	}
 };
 
-static void help(void)
+static void help(int status)
 {
 	fprintf(stderr, "Usage: virtio_test [--help]"
 		" [--no-indirect]"
@@ -337,6 +337,8 @@ static void help(void)
 		" [--batch=random/N]"
 		" [--reset=N]"
 		"\n");
+
+	exit(status);
 }
 
 int main(int argc, char **argv)
@@ -354,14 +356,12 @@ int main(int argc, char **argv)
 		case -1:
 			goto done;
 		case '?':
-			help();
-			exit(2);
+			help(2);
 		case 'e':
 			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
 			break;
 		case 'h':
-			help();
-			goto done;
+			help(0);
 		case 'i':
 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
 			break;
-- 
2.39.1

