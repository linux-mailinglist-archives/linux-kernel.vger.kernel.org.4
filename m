Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B624D6F2A10
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjD3RtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjD3Rst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:48:49 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8B19A2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 10:48:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id BDB96B08;
        Sun, 30 Apr 2023 19:48:47 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1682876927; x=
        1684691328; bh=IeHcnYGT8x5oIMpt7vaj6WJo5TzDUMMrc5PAh+gHWeM=; b=J
        BvufOV/JSoATrFZQWaP8nrwgQea4RAWwbgSQd18wVW/nl8HUP6yKluXfYHNizWC0
        Hgmnv+PRmxkQhf8QbnXHR1tXOVjXCQj02vmi9TFita74eTmFXsMuVDx30IwTVxyu
        QY958TJVwZfeg8TmJIctMWocTXHk33SUXw+TcXXbGzMPW9Yum0y7bVCZgyGcf+oM
        BoMaKT/HIU/Pdodc9kWPEr2dNYdBDcnEzUvydnMwVs5SQ5BD2r/C6C5y/FlW05Z8
        l4RBlvJhOjJCsTGUYdP+b6TWSwFzdNu+dVrzxNU1sJyjiQWwsc91U0lluJu1Hkwy
        jXJ49357+yMtpsmUX4+deG4P35HwJVQcGHoUCq0W0qRRfA4KmrykaYQzh0gOYXVE
        d07rhAOrsaJoLiFdx4KqMvh9ikqNg2vopkQ8Sd5G21wfhOAkOFUCbSd7Fq+CSwPi
        9T6PfR3tTuGrEvq3ctyrhvZyRfXIZOgYAsx/L5szaOJ4bVSwayfut/0TZsQQIFgS
        +wPAyxix0XuIoCAd1IS8qqMkJJLlNt/zU85mmWRCbEYlkVZ1tJnRnY+ddh3GS0Fm
        aJAjvBQ63+nfvFV9B/snZq5T1Na2/QVnDAVu2fH+WIJr01mHKDvH/bPXaK4jtsrb
        Emghld2SZTjrtvoQATw5/OGZe4/zT/oNenEcwMfC34=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A_CjlYBeEyAh; Sun, 30 Apr 2023 19:48:47 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 34105AFA;
        Sun, 30 Apr 2023 19:48:47 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id C5C2A685A;
        Sun, 30 Apr 2023 19:48:46 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Sun, 30 Apr 2023 10:48:20 -0700
Message-Id: <20230430174820.748119-3-alison@she-devel.com>
In-Reply-To: <20230430174820.748119-1-alison@she-devel.com>
References: <20230430174820.748119-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add support for the U-Blox Zed-F9P GNSS device.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..86b65d4d9266 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -21,6 +21,7 @@ properties:
       - u-blox,neo-6m
       - u-blox,neo-8
       - u-blox,neo-m8
+      - u-blox,zed-f9p
 
   reg:
     description: >
-- 
2.39.2

