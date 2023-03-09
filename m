Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7F6B1B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCIGNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCIGNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:13:21 -0500
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729F50F92
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678342397;
        bh=MbkZJGPvm/6bN2F41pQdsLf4lU63VdzvpsHuR3YXtUU=;
        h=From:To:Cc:Subject:Date;
        b=LUqgfdTnaAKI9Cv0C0X3C+uKTPZeS2/nUMvqhcXmIlHhgYjMMc9dG3YQ++hHk6AgE
         /Jm66kHQYy9d1AqAWns94NNrmSTQ3sOFmEJv+14HHQuhEvd+uS8mGzzBcKeJqT1etf
         Nh6GyV15ykykND/XWqX+xEgdl+0wVKFnV6BbOyiw=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 34F04024; Thu, 09 Mar 2023 14:13:15 +0800
X-QQ-mid: xmsmtpt1678342395t8o48kwb5
Message-ID: <tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujA5JTUx5CuMOUECnkCxxYC7SogPq7OqiEtaA8CecKXsnoKCGUJU
         JZNxu5iqQqGX0RMkjo81H9FY7hyxmqNsxtB7lgvP48ut8K0mkrCg/86ypPMuie30H5HqI1HLN9Ns
         TgJUgNdSF88wVGfqMbrESDKGg7j5/JcDSW/lsWHIqE2TnvEDHa/Mees3z9W49xgGwb0CENFOUYj/
         oOAb6b1W5R7NY4CVZIxXlCBuGr0Up/AKf36hDnAFGrX6PSj0aAsXz0vpa1OwVWe/VS+dynE1CPdt
         Uy5fDyQ6luBO6gSr3VIH837zipTYrp5kkY7T8rQPn+1l/PVs7RtOZshpIP0H4JBT1f0agrDhhhQy
         YqMPHturHmsFe043e/HRuc/aXnxXbVbt02QaiHeE+XtiJVhjjnbHnGoW3wMq1uoE5sI/PQ4kVD60
         l+wxIA5MkvCsveo1+5gZ1MHDocIUMjA0Jxeal2vQsjIC7QsPXatyzU3k3vGP1DFZqhTM84keugRZ
         LnPWiQ6IkhJjKXRgetu5a2ArG0JKTdGelrp3HVPWXeh/7mYjrvujBLQFUNRQ52dMe1n/eXHbz6WW
         jn33IWHKsLN3J/PgnOB7BNcwPToP2GVEu1T3LsJd2KvTlgLA8fNkA6/2jWFTaw7ssusIyOc4fHXf
         eutajpd+Ltv31z8dWG26jPeO0wnIS1F53JxAOLSu8MS1azDn15EP4RgEsXf8iHGZ1vZW2ej8A/bU
         Cp5L2gs9P10Q4RymJcIyiOOIpCfb5Oa8VnvReMN5wmbbtSCUFaTwhGyfgn0X4yOkIcYCSBbGrIIa
         SP/6cUKkGqd042MQM+knCr4Ld7FNjMO29nlV/Fa9Ippmef9ynWeAD/f5ufY/0jy11/VC0eubU6fB
         I9iHcl2RPDdtA91CuRyKP05GZz2gIZWFEQn7eC8ENzDefD7UjyBFhWPhKN9rNSdPhtSZwYh2LyMX
         ixtriHLPEplDj+qIOfWxHJRDGnbwwJCLMlqirm/4qnwLq7DwHF7w==
From:   Rong Tao <rtoax@foxmail.com>
To:     sgarzare@redhat.com, mst@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Date:   Thu,  9 Mar 2023 14:13:13 +0800
X-OQ-MSGID: <20230309061313.30097-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 tools/virtio/virtio_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 120062f94590..6e348fbdc5d8 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -337,6 +337,8 @@ static void help(void)
 		" [--batch=random/N]"
 		" [--reset=N]"
 		"\n");
+
+	exit(0);
 }
 
 int main(int argc, char **argv)
@@ -354,14 +356,12 @@ int main(int argc, char **argv)
 		case -1:
 			goto done;
 		case '?':
-			help();
 			exit(2);
 		case 'e':
 			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
 			break;
 		case 'h':
 			help();
-			goto done;
 		case 'i':
 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
 			break;
-- 
2.39.1

