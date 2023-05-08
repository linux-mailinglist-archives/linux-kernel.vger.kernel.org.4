Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBFD6F9D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEHBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHBMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:12:40 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAD30FF;
        Sun,  7 May 2023 18:12:39 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id D3FB714EC;
        Mon,  8 May 2023 03:12:37 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1683508357; x=
        1685322758; bh=IeHcnYGT8x5oIMpt7vaj6WJo5TzDUMMrc5PAh+gHWeM=; b=g
        7W463VF/adkDqa44QzzkcPInNaz36baWwB1FizUBPUXnJCs0846IrDj414oyUMG1
        vm1MMBTcScaH0DWJtqKXQXHtvlNreuhdwmLUbMbcoiJjxr6q6VZDvL9t+FfK7aFd
        4gzArBT/QaUnJsFwLRarUErQ9/hGiobcPG0SHYrRAYrCpffcSny+/gYgZ3Kl49BV
        efgziOatftBsMLlhHGuqJ72kV0sshI65Lp+pLk2zRLlGnObxswRxkbnJakfJ20m9
        64Fv64FKEV6k8NR0nrjZer8pO/xBw6cUY9cGDikQhwsXid1ompVtZu6oMBENS9hL
        EpByPmG3nxb8FTyyrZik5cRCxJXDTsZbjD4KefkVVMlZm60bTl4ccTUKKG4zGpaB
        4Df7u4oWGIhANv3Jet9eWsEJGVSt1nFmf1RBrOFE5ukXXIhdEwnbhIpla2YOv+6d
        TR6MlQnoEk/v7VNIdj48asCk06N+p8MuaZ3H1VJE6VUbj4hXtWjC1DFcljCrZYcG
        QVzfkf8/SwZqPMvSFo1iyGHc65G7CYEpPkAaVpphXUJxUOQrJRgYxQkRznfP8091
        BOlJvKxmJaumzZnhoFMHQZklu8tV35oyquoMNlls75vFbETj5QA6rSRm9Z+yzKMK
        FID/xhKKUsd5SOFnQP7wqdp8ojyX26X6rRDiQlBUDs=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ejdT8ismRjGi; Mon,  8 May 2023 03:12:37 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 4834B14A3;
        Mon,  8 May 2023 03:12:37 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id D274614280;
        Mon,  8 May 2023 03:12:35 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Sun,  7 May 2023 18:11:59 -0700
Message-Id: <20230508011159.263322-3-alison@she-devel.com>
In-Reply-To: <20230508011159.263322-1-alison@she-devel.com>
References: <20230508011159.263322-1-alison@she-devel.com>
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

