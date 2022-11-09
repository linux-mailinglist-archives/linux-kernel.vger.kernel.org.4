Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745316222CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKIDtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiKIDtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:49:47 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E910DE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:49:45 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221109034940epoutp011dea417f40a4331e60a40cc6a05b5cd7~lzgpDoMmK0442604426epoutp01x
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:49:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221109034940epoutp011dea417f40a4331e60a40cc6a05b5cd7~lzgpDoMmK0442604426epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667965780;
        bh=f4uj/2b286Sv/+C+R2INmgplgOtBdNl04uwoOHKNWow=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gx/SyFSpDIktgmp7Je8o8oL/nLCeWPEDfl7C6vtNZlZIqLQtb5FxNmtlmrq7t/7HY
         zgzDddjqjnIG4YSYo7poeBn1NWYbej6TmQqsQDRqDFaPgM3HIBTaHBgPsBaB6kaSgY
         S8In2UyoiEHxyHVTXJPwYa9yHi2K/zzFC3LfQ/sQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221109034939epcas5p4747e6e57f34c6935c6f40925b4c71b56~lzgoKFUo80145801458epcas5p4h;
        Wed,  9 Nov 2022 03:49:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N6WDs43T3z4x9Pr; Wed,  9 Nov
        2022 03:49:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.E9.01710.D432B636; Wed,  9 Nov 2022 12:49:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221109034659epcas5p344ec93dad20a0994937f689d81e3f275~lzeTRVveB1607516075epcas5p3Y;
        Wed,  9 Nov 2022 03:46:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221109034659epsmtrp146092e018b104e988e6d3ed5f543c07e~lzeTQBM731074710747epsmtrp1M;
        Wed,  9 Nov 2022 03:46:59 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-be-636b234d5a65
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.8F.14392.3B22B636; Wed,  9 Nov 2022 12:46:59 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034656epsmtip151f3e307170cfbc57a722acdbdc049a4~lzeQBKqSg0214002140epsmtip1H;
        Wed,  9 Nov 2022 03:46:56 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [PATCH 1/3] media: s5p-mfc: fix usage of symbolic permissions to
 octal
Date:   Wed,  9 Nov 2022 09:23:46 +0530
Message-Id: <20221109035348.69026-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1CTdRzH7/s827OBDZ8DpS8rgnsqCS5w0zG/mEgJdY9HdJCFd951a42n
        DRjb2jPEOCXtgIOBowWcQDiFYXqAw8ZPAQvGzKIAudBd6QAFlFl/lKSBclybw/rvde/P+/Pj
        Pp/vl48HjxJCfrbGwOg1cjVFBHJ6RqJfiU17MVchuroajhb66rlo1tJDIOvyXQzNWJc4yNHZ
        zUNdU1/h6OyVIS465Rznot7h2xz0zaI3Olnv5qC7p2wAeRqmCWRavIUj+9x1Lvqlv5FAlRe6
        uei8081DZ1yTGPravoqh5u6/eajkkpOH3IM9ABWXOrHXId1uaQd0n7sF0K6W+zh9scHNo62D
        Hoy2t5YT9M3rgwTd2fIZXXL5EYc2dbUC2uh0EfSS/QV69MESL11wIHeXipFnMfpIRqPQZmVr
        lIlU6j5ZsixeKhLHihPQDipSI89jEqmUt9Nj38pWe1dARR6Uq/O9UrqcZamtu3fptfkGJlKl
        ZQ2JFKPLUuskujhWnsfma5RxGsawUywSbYv3Gj/MVVW6WjGdlXeouryHcxTYCSPg8yEpgV31
        oUYQwA8mBwB8OPO+n+8DuHA8yAgCvfwQwAbnCu4L+Pyu31aA33QJQNdUmp9LMGjrSPPVJMhY
        ONar9smbyGMAzpUZfHVw0syBN0yLT+qEkBnQZKzDfH4O+TIcGNvmkwVkIrxz0gz8rSJg24Uh
        3JcLyXk+dJRZ1gMp0DSxwvNzCLx3pWudhdBTVbrOCjjX7FmfWQ07Bms4fk6CQ1ONHF9fnIyG
        Hf1b/XI4rB21YT7GySB4/PE85tcFsM/ylLfAxpvLXD8/D0fazqyPQ8Pxth95/jV8AO1uE/YF
        CG/4v8NpAFpBGKNj85QMG68Ta5iC/26k0ObZwZNHHbO3D7hn/4xzAIwPHADycWqToN2WowgW
        ZMk/LWT0Wpk+X82wDhDvXZkZF25WaL2/QmOQiSUJIolUKpUkbJeKqWcF1roYRTCplBuYXIbR
        MfqneRg/QHgU+5IpCGY/V20JqL+2Q7WvOj0kr6lO1STJnD128fEKmupNeXNh/Fzmz0lNxOZ/
        iI5O80lhRfPanr8aRzbYeictsCofec51Ttxe252cdbB2b6FjLSenSrAqv+YJ1M+WKUNVo0l7
        8InfdwaVzRxOzc448m1BhQemP3NEwqzWDsoGqOr3ZjLPDsnM2p9eLSjvmn3tqn7+h6iIwydE
        YdD2a1MRs9C2Oi10fFx+/l7MZfKlsNLC/ueIT77bONahOEFFWXW33umrrGCLckZy37ghzUhN
        3F9bU7x9Q9zYxv315qK4BynTfzyKejf6UMRHw0q22H3APhFW2tr2/ek7oVONpuVko2W4huKw
        Krk4Btez8n8BXm0wN10EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzVRfyxUcQDv+9679x657e20eiHposXy41TrO5WJ1V6q0aZWttLFG4fT7Y7I
        JC3UHVm/1sbhWkfmQpwOie06JyPMj3KrnPwqrJP8ajGjLuu/z+9/PiTKW0IdSFFCIitNEMbz
        cVusroXv7FnLj4v0Ge3dAb825HPgcHEdDtW/JxD4RT2PQUOtjoAv3ytRWNam50CVsZsD69+M
        YrBm8q/bm2/G4ISqCsCpgiEc5k2OoFA7NsCB/Y2FOMyt1nFgpdFMwFJTLwKfaVcQ+FS3QMCs
        ZiMBzU11AGZmG5EAmqkorgBMg7kEMKaSOZR5VWAmGHXTFMJoNXKcGRxowpnakhtMVusyxuS9
        1ABGYTThzLzWmelYnCdCueG2h6LYeNFVVurtf8k2JtekQSRqIuWhvA7LAFpcAWxImtpHmz4t
        ASvmUa8BvVZNretO9Fr2W2Id29PlqxPEeuYWQhtajyoASeKUJ91VH68AtuQmKgvQpnI5YiUo
        VY7Rn2tyEWvBngqhVQ+zUGsBo9zo112+VplLHaa/Fd0H6/vb6efVevQesHsCNmjAVlYiE0eL
        ZQKJIIFN9pIJxbKkhGivyCtiLfj3jod7A6jX/PQyAIQEBkCTKH8Tt6IqNpLHjRJeS2WlVyKk
        SfGszAAcSYy/hdujaI/gUdHCRDaOZSWs9L+LkDYOGcgGufi75UGQ7kifW8FGkYOj8nDoj5bd
        97cdPx7T35iuEnyYuXggzDXpctn+vkeivSnH5lam0m5n3nzh2lBkKTkv/qLoWIv4NfbYb8Tl
        bNhCc4AmfU+Rf8oc3Jc8M3jOYejiGWGgeXxR4houWMwcmrzT0+4XFvS8cVavV17vjdP1MO6/
        z3r05QXPwaaDMafU2N09nUmepe9Uos27Lrh4z0piA9umLTt1J5vtqIiJ7tXhwYDNi6fNgdWW
        UY+wkKicfvgpauxjZ9Fyn+/dQsuDgeBKZVBq+kprM89u2qf9WcD4LrmncsSRG7rb35RX9TOn
        Re6E6NPCK7vaGFljK2ZZPmHDx2QxQoEHKpUJ/wDdKeTzDAMAAA==
X-CMS-MailID: 20221109034659epcas5p344ec93dad20a0994937f689d81e3f275
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034659epcas5p344ec93dad20a0994937f689d81e3f275
References: <CGME20221109034659epcas5p344ec93dad20a0994937f689d81e3f275@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change symbolic permissions to octal equivalent as recommended
by scripts/checkpatch.pl in drivers/media/platform/samsung/
s5p-mfc/s5p_mfc.c.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index fca5c6405eec..bc6d53e78876 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -36,7 +36,7 @@
 #define S5P_MFC_ENC_NAME	"s5p-mfc-enc"
 
 int mfc_debug_level;
-module_param_named(debug, mfc_debug_level, int, S_IRUGO | S_IWUSR);
+module_param_named(debug, mfc_debug_level, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level - higher value produces more verbose messages");
 
 static char *mfc_mem_size;
-- 
2.17.1

