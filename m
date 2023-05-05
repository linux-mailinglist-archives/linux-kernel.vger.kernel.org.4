Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F274A6F83E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjEENXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjEENXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:23:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23757203EB;
        Fri,  5 May 2023 06:22:56 -0700 (PDT)
Received: from localhost ([31.220.113.235]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAfQk-1q5y0W4AXY-00B68k; Fri, 05 May 2023 15:22:41 +0200
Date:   Fri, 5 May 2023 15:22:40 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] MAINTAINERS: Add Honeywell mprls0025pa sensor
Message-ID: <ZFUDIGl4z9H/tfeA@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUCf059+PSR+3Wb@arbad>
X-Provags-ID: V03:K1:/fsn1w4SfKbWyG9rqpbeOL1Yf6IVtQ0SC6bOfnJLczQe2vxM9rz
 aARtXyfm5oTFWe4c5xTXmEVFAaKp/lTkl1iZwjROISMM7N4gLsPcUSy/Vo5DquKjaxy/iMX
 0OFHF9JIdULoe1ATqup7hd9PmR2QotBbF78YVjvFdIE5gwpuJimQ6n9fc1p+7KdAC1T69Va
 GPAcmwTfvn3GGYtpbg9wg==
UI-OutboundReport: notjunk:1;M01:P0:WCrxDYDJzc0=;yQJjsLP3+3G/RQH7RBrxS4CQp+Y
 WHbE2949Szl/S7DNM/8BjRR/DQ2PBakSHVZy0VEshIAh+vvazaknlj9T6wAiroidzCKKJFlRd
 HlEH1i+QWR42CiVXzPS0Gfx6oMjo5lEvHDh3yq+740PfA+HKuyHvwlb0Pm9DN7KoDsFpxUBbp
 QqwJKGXQ2WtnPP7D1BeAn04q1hTKwLwtwK5zTzFluQ+2xkfTvYq3TbKJFHyUG3hPYXqwGuOaj
 xbYJArzYchlffYSah7PHdaw5RdZReIHdZU13zQwbzrQ1VNcTcPeVZOfRjGS7gUd7oOSbLdLa0
 e9M7g31KGgJY3hNZ74XqUrlwAcnyvadwZ/zS87iah3I6j0828uiZ/cUnwDTZW3z/Hep8t9uK9
 WJZiO2iuMApJl/ht5fWkmZqn6Kg1J8+D85/Sgo18woIx+Dmqi5a7wIntRAZwU0t2uu3oqRCKH
 5by3Em0zOoAqMIxEP9QAfOq9pA4YS85u20shyCnH0orEim0DVXRI+uA8Lmf8WwCIflEYx8dRT
 FlOY0znvutgglCCo9Xlbgazmu+rx4Ymq3qao+Yx16CZ8jbtiZhOtAaiwjFXCZ8s27rjiTquVn
 HhNhX9a2Jt3b/zP/ix2cYGkTrRtrf0VSU6/8YgJuK7GPxJ4NLMEJDbjvFgxjZm5vEqM3w9lNp
 OGqWnBSXL6IAn/3+9L435f9QiTgsCN3YkpPgZ4knIQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer for Honeywell mprls0025pa sensor.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6545eb54104..7b68ec3fba88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9361,6 +9361,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HONEYWELL MPRLS0025PA PRESSURE SENSOR SERIES IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+F:	drivers/iio/pressure/mprls0025pa.c
+
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
 L:	linux-wireless@vger.kernel.org
-- 
2.30.2
