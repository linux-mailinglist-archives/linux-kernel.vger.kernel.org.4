Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43FB5B7F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiINC4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINCzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:55:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CD6556A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:55:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CBE022C0270;
        Wed, 14 Sep 2022 02:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1663124149;
        bh=H0/klz/IKHeMo91NuA4Kfz5soX2qBJommkcIekCaTxc=;
        h=From:To:Cc:Subject:Date:From;
        b=VkEtkIAG6Ue9oRXFm95lhMTl66qVAFRB96WySeBTUMuw5ESVVye8TQPsI0nXYsfe7
         hoc85qTOoHUe8/mATNyBFSibbjoz8f7TQVXDD32frkKtdDCWf5LpiBi7yd0OUrD9Tq
         87OfqkC2WcoYUmfLyrxL19ZkbvQfi6n1/sQ+aJ+rf7TmMdIWKhVVcaYlkKLlkz0fMj
         XBmB/f2pIQJmzlzAhOWPmoVUcavK1RDiuwTOogrKX3/Vx3rOma5s1M8nQBddKfuCNu
         hJt5Uq7AODaZzGOph1hE1qKXvmgOV+TwSfacb3NSZ3Cn1WV61+6Viuy7XzAAQP+Q91
         GNGzBXKfxN7Hg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B632142b50000>; Wed, 14 Sep 2022 14:55:49 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 9F41313ECD2;
        Wed, 14 Sep 2022 14:55:49 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9B7522A00E3; Wed, 14 Sep 2022 14:55:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     hyamamo@allied-telesis.co.jp, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] USB: serial: option: add NetIndex UX302NC and docomo L-03F
Date:   Wed, 14 Sep 2022 14:55:39 +1200
Message-Id: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=xOM3xZuef0cA:10 a=rRKZ0iCwKHS3KTUxTXQA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a couple of patches we've been carrying around in our tree for a =
while.
I'm not sure why they weren't submitted upstreamed (probably because I di=
dn't
nag loud enough at the time) so I'm doing it now.

Chris Packham (2):
  USB: serial: option: add support for NetIndex UX302NC
  USB: serial: option: add support for docomo L-03F

 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

--=20
2.37.3

