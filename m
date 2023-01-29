Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05267FEB5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjA2L7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2L7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:59:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D21A4A7;
        Sun, 29 Jan 2023 03:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674993565; bh=dsYA3TJFoKxRXCyOmwr6lbeTv9iP7lBwN1Z82eU3mBE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Mgr8rUWoNDXTxMZhQ+9BnfLs1XhOD/7GNsKxCWWXsnZi8QYWWt6xnoT8XpdFtnzjM
         wdND8adrg/LH6/TcyDILhU26jQIz7IKQ1KwSZrkUI9Qq/mjMP01ig2o946xAq41DmQ
         xD9ao13Iwc+PwbV5wCNTVLZNLqH2xvanIk1H1dcbsi48HQSfKu734FsFVXZDNhUtu1
         UpHK1ONXxW5lTwVaUM35kykMRZkjf2uFl+bd/wOsLlkXotDG7AqTv+uMOXqWgsnApw
         SM4bD6jWMqyE+Bnie04trUS4rdO9sP1xGdAkK6ghnMYp5DV0o3xus7/3FQdfYNPbFI
         zCd8Nd/65XaJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1p8IaU3vAw-00VMyl; Sun, 29
 Jan 2023 12:59:24 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf: Add "dma-buf" to title of documentation
Date:   Sun, 29 Jan 2023 12:59:17 +0100
Message-Id: <20230129115917.1229529-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oi5JlNYNUWp/c7+muHI4kjvbKTuF7k4nnmPz0F0CEVayxmY3pvC
 Wb8boStiLvOC2QrclCRf8hl1M0OO0hLMItz0N9D6u8oQ2kSXEl2+Mxn18usJIiQYLmazR4L
 vcy6MRZ0uK8bSGr490VkZrYD3rGBLOZcwPz5FKuLTMapfHtmXBgEevzzmSG4zFn/iImQcX3
 87ZqC7McaihczOjLb6XPQ==
UI-OutboundReport: notjunk:1;M01:P0:huz1cX/hXdw=;NCwhynrk+L8Fjw8o9/ouSpJiPBi
 +JinvjApiOya4DA70vc1hjj5tfjP79zPjCkwOAloe/Xg4e7UB/XXw5gV1Czbzve9DXNXmZbug
 vj3IgR0PMLgjBGsUEb1yChibSyJl3ewT9cgWi2m2ROmTEzSWEjU5LhoX5HlE0bJ3Oi4k75vER
 P2qEPgfuU78o5vyW/4GaniG10vLljm/5PmwHvuPAHdWb+YRz+veZq41FK3rDpbsb1DOzfbSX4
 oSPeNmqjPGurYB+Bred3J9KNEzcLraLOngyfOgxqYtm1ae7M2p+OGPq0CX989GOoP8t+WZ6QV
 oJi9Nn2JxllNI5DY4SZ9rNA7CcDFevPm2rzKaTpikEp2mbP/VFjVDg2Vre0MoASzMSCiVhTkm
 4TwTzYkboI9UHSM+q0eNKneyQ7W0VNDBFwec9kpCokp7A12btvWMqUZsNCuwzRLbw9/Tq1U/5
 ZqIZF0VZUScbKs2tPVSaBvT6EMh2avVPGDI5Yk0/EGqQKD7deOwSoQzEmmtOcavVxc9D1QYKF
 nvojhqaUTaWlmn+gb50QStfEws/CVPhKlvz3XPYWT6aj31V1lnS4ZyX4Nk79QO6j1NkhHh0aY
 CnIu4cdiPb5E5N09JqAfaVN8YglXkmfqcrKBxkW+IObE9iBxX5d5YAWfmF4jaBrZEqrzPQ2QK
 PuDRz3zxbqm+ChFyetKMX/mZjgf/1li6bSQ3/vDOZyBeWCLAHGVxdSsNdZKsW0xVU9bxj5dXr
 MGCDEMKvgE7y5q9FAX4hl2SA85hMa9f4DqOXCLicVp39PVEj/yVySl2a5uaLGdqsnl240Nx3X
 WtIvmMnCORLzFmhAekHRLuCy0P5FflN4x6Jl7E8/pyJJoM/skf9wN+6nh9r9iWdEnwGrmRT1A
 9JVECEv6Y6lhGwh5C9RydAosTcOOh3NP826+SLIhfxmNXBgub3kvBJMnGho1O3eWDLwOyzFMl
 aoWMSvvIweuVsytdLYgQDkxKhlc=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it easier to find the dma-buf documentation when looking through
tables-of-contents etc., put the name "dma-buf" in the title.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/dma-buf.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-a=
pi/dma-buf.rst
index 622b8156d2127..61b6f42ed0f18 100644
=2D-- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -1,5 +1,5 @@
-Buffer Sharing and Synchronization
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Buffer Sharing and Synchronization (dma-buf)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 The dma-buf subsystem provides the framework for sharing buffers for
 hardware (DMA) access across multiple device drivers and subsystems, and
=2D-
2.39.0

