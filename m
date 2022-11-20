Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EC63130B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 09:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKTIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 03:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 03:31:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6977D502;
        Sun, 20 Nov 2022 00:31:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E7FBB80818;
        Sun, 20 Nov 2022 08:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B93C4347C;
        Sun, 20 Nov 2022 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668933073;
        bh=YzdHamMHxhIvOkUcVi73tvjWfjgrz55++jhDY5V4iSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bG8sQnNpVQVQDylUY+MnhQNRHU8A+uo2Sly70D/I0CNBkHDPj7SEj/bouRhS1bqJj
         VRwmgFUwed5GYVDk9rvdbJWSNImOCFaebxolZfqP4uUQIQ8JkLV0YH+abB8MovKvMV
         O4KeBYKFXWKKrPbDAZBT6vNnjBjDBSEOZ8vDPEQCkcV7tPDswPmTS2BnyDX2+eT0UE
         NJ7GZGRFHfGWu/LNzMzGS3UihUl7knPMORY8RBbpyQlwjHMDFrdqymuEx0g473WPY4
         R+cqDrrOlwAzEZ1GsCsuQXy4gEtFl/Lad/MScUbMMSF3JXzMdQ8rfxXMZ108kVAYRK
         puQfrIamOVEsg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 3/7] MAINTAINERS: add myself as a reviewer for Bouffalolab uart driver
Date:   Sun, 20 Nov 2022 16:21:10 +0800
Message-Id: <20221120082114.3030-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221120082114.3030-1-jszhang@kernel.org>
References: <20221120082114.3030-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to maintain this Bouffalolab uart driver from now on.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2585e7edc335..92451834b940 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3718,6 +3718,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 F:	drivers/iio/accel/bma400*
 
+BOUFFALOLAB UART DRIVER
+M:	Jisheng Zhang <jszhang@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
+F:	drivers/tty/serial/bflb_uart.c
+
 BPF [GENERAL] (Safe Dynamic Programs and Tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-- 
2.37.2

