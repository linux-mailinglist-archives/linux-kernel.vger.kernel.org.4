Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9E6DCCE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDJVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417BA172D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681162788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=upgu2OeMvV+rfG2Ghh613QetkB7vJuE3skdR1FunYJU=;
        b=eC7aD6Bid+9Qycoh4ghzpESL9YJgiJePGthnsjiiemwIqU5Ty3O8n4AB/JM1Cl1c7JwAFM
        mvonciGdYwI2GF2UsV9ftUistI3LkEFZvsdOnTPvZOEdN3uLlMJ2QbUf8gpcKRhbLXL4tj
        TGNB6hnVWDv0Fvi9fAjKkWx+AKKsbrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-M6GgUEOPMeqb2cPwBvSNZA-1; Mon, 10 Apr 2023 17:39:43 -0400
X-MC-Unique: M6GgUEOPMeqb2cPwBvSNZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73FDF101A531;
        Mon, 10 Apr 2023 21:39:42 +0000 (UTC)
Received: from jtoppins.rdu.csb (unknown [10.22.16.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6484407D445;
        Mon, 10 Apr 2023 21:39:40 +0000 (UTC)
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] mailmap: update jtoppins' entry to reference correct email
Date:   Mon, 10 Apr 2023 17:39:35 -0400
Message-Id: <d79bc6eaf65e68bd1c2a1e1510ab6291ce5926a6.1681162487.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e42486317d18..86d0760c15eb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -232,6 +232,8 @@ Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
+<jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
+<jon.toppins+linux@gmail.com> <jtoppins@redhat.com>
 Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josh@freedesktop.org>
 <josh@joshtriplett.org> <josh@kernel.org>
-- 
2.31.1

