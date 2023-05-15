Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB47E702A52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjEOKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbjEOKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:16:13 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE82173C;
        Mon, 15 May 2023 03:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684145544; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gid8Z8GPX+8U8veQDzigS8Kg6g36Fygn5Di1dTukcxwv9ENyB9BT7VxZHsIFy2fLS5
    A/LqUC1JPW00lcgXen7jK16CCDBjCluAkZEWAS2BHyfmAvVrGBymfKuXv509DjqpLywO
    b8ltprG0Wd+RKsm3/tk7f4haWCVOfSEcGaQbNIQFYyoZnwOOcd2x3ycFFYRtjcEqfgnE
    1ZVL909FOqrOY5d1Qvb9LVmVQD1diy38FVZKscTk5by5QilsXcKgm8h2N/C5xU0ZzxNS
    ZssZslo9rhxI7cW5Op0dusCJ3M7q5WzNfNOD5k1/DV6zpolgMzP/+tJAVRAIPf0iJ3Tt
    z3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=DNTC0U3plBj7cthESRLpCld4G4lr+3CgqNixMQWGBow=;
    b=B640sq6QxE1g7r5NSs5nSKwdO0W6d5EZsOuxZ1B0bGH8H4VYZc2kuF6nfUSNze66oo
    uDYKmzbSB/feJ2pHf9fpDckepVVjyt47dwpfspm/S1syU8PnC/4ObI8Bg9Et/jkzTFIO
    eF0G+tb3SccVQRLWHdTwAFS/53TAXHEZMAmm6COT3TdPl3quPBeEC5pwZg7DFNlmyoJz
    Mtf0vtHHotD+zjRuDdXcy6tA2p/pkOv/txHRkUwrib0TcCGm6yc9jjTauOS1IqsP0kfu
    TVslfMhPw6UYTJ9bUI1QbL7szA/B0Imh9LOZd4jHwRyjvDV7I6iiWGji1PM2fdM5q49r
    Lgeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=DNTC0U3plBj7cthESRLpCld4G4lr+3CgqNixMQWGBow=;
    b=op7/C51ozPARSOEyrMPwMTrmQQgjf+W/Gx3IIhxw7EY8aDIImpixNrB6PSIS2YAZXY
    40c5+jU2bqPIKPwlhcf/8ua+4uttvlmm/Z0/UTxvg8f2ViJEY7u0OTzNUk2ZYM57ckr2
    UxRbDawLu/LFc5R4r0PjCd1MlaX2+ncl70AdCmc6cgIHzC1n4bR1zQUBYlOtAjUHo18d
    lLO/Zc/p0ewSGPnRhZ1WbvI23htdtVmVzKiodXnNdfdJeK8ro8ttLYam85ebX+6eRD5b
    jRERkKUE+s13J+91vGLuX9gB7Fh4OL3RJUvznHHi0j5w6JZ0xq2LAkW+UbhSGwojrSUf
    tW8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=DNTC0U3plBj7cthESRLpCld4G4lr+3CgqNixMQWGBow=;
    b=gMMt+EFdTB5ds3J1kxDXQo7JfoVyAQx2QRs1dmiW5lPRexdNCZs/JQvvOFUBF4781W
    MEy3TBDkmpRCfTcEnkBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4FACO1JI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 May 2023 12:12:24 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 15 May 2023 12:12:18 +0200
Subject: [PATCH 3/5] of: reserved_mem: Use stable allocation order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v1-3-3bf68873dbed@gerhold.net>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
In-Reply-To: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sort() in Linux is based on heapsort which is not a stable sort
algorithm - equal elements are being reordered. For reserved memory in
the device tree this happens mainly for dynamic allocations: They do not
have an address to sort with, so they are reordered somewhat randomly
when adding/removing other unrelated reserved memory nodes.

Functionally this is not a big problem, but it's confusing during
development when all the addresses change after adding unrelated
reserved memory nodes.

Make the order stable by sorting dynamic allocations according to
the node order in the device tree. Static allocations are not affected
by this because they are still sorted by their (fixed) address.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/of/of_reserved_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6443140deacf..f6d14354a534 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -224,6 +224,11 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->size > rb->size)
 		return 1;
 
+	if (ra->fdt_node < rb->fdt_node)
+		return -1;
+	if (ra->fdt_node > rb->fdt_node)
+		return 1;
+
 	return 0;
 }
 

-- 
2.40.1

