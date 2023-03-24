Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F6C6C86CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCXU0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjCXU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:26:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200671C304;
        Fri, 24 Mar 2023 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679689590; i=w_armin@gmx.de;
        bh=gPtrA4XXwFpO+QSD0Pp1Uxg5JqNK3hlKWegTIDrJi8U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=tvlpfmIvXdljnSnpQk0PrswOjNSaO4EqRj44vnq6ZWpSMEmvptnmSO4Ap3a54Zt+N
         GXf9qM5tZgOmo8Z51ayRz6Cu3ihxBJcXgEAJHxMAFxs0k1oHQrX5DZD724iD2aeY0B
         bS9yjCxo8QyMaFrjLN1i3fMmNi8QRiSmraliYBVN1T5BVJTaZml8AfKF8qRUK6pLjH
         X7txqV0exD0dCb1utfuurep1DOwURIUJZ+Cc0ov8JkFYVs9857VEUHjtPhzqSqhpjq
         iFeJT6WZ3rwl3D/oqX2Tn6SjlPkYQRhcaEw78R6+bDEJdsSaFME/OggkbVqHcdHtkT
         ypDcdvMLJvk+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTiPv-1q3Hid0aOD-00U0on; Fri, 24 Mar 2023 21:26:30 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] ACPI: SBS: Fix various issues
Date:   Fri, 24 Mar 2023 21:26:25 +0100
Message-Id: <20230324202628.76966-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hl3kgS54/FH1VV5aYYsy4O4Wqlp1NzLkfJ+iE3s1bWG3sgBt0Am
 ZGx/IH2CtYrdzaDsWKAl5TT9E6xxMjd7FWkWvm+U4z6AKcr4B2aQxCMbJh4x0a0BGlCsRVn
 1B+SUo6cg2BdU5icgrmcO7+fjoi0kHVcuMBFx2Vb3+0fhinhOhIzbsZX9ZjRDq4l0HQUyjs
 ZOoDFo6beQSDHcoLg45iA==
UI-OutboundReport: notjunk:1;M01:P0:gQuTgH6+dCc=;OZU0r5gBd1jpoS+AensvGI4Lvvt
 NftPRSWPc3fzQHLlyQdkMR4sSVJAOkTGSP7xpjEfgFKYBN0hXLTDP54pydt7BnYsxROuOg1Hn
 0TsG4zBll7NzeRejEJ/o5xt0/Lqm7L6CSyaR7ueF0mWDnZ2648mC9kmpW+ULjIcj0mYQCIg3z
 fLdRmPavdFO+ICChyYmUiIHSpdbhaDb4Gn93fH+wmZuPfME1x483xjjPZOVCMuFlsJc/QGFcy
 WCs0kxDvrK1eODZ+2dwIExR9Fl24d7pcdvGcBwk1FkBjgoUlfDvOSs6qJjeeD7Q3Ej16rL8GR
 H+1H2YOMFiLOayC0BD6n0uJom3r2uBMBfedAPoq66y04MKDZbzyKlxJdCrpL54Yy+iZSyjECv
 2iCkbmmrZoR5323xHN+lMd53LhDAp4gKAupHn7cuzT54dYHqOxKso8XCtKXWaVK89mVNUAj5n
 +qHK382AoRMgVtVvkk8hDx90wNR2cinkVgQjXXw8xfU5PVputfMzdFOr8QQpGT45xBmg1uBiH
 wOeRIntUb/fXN3pRIaevoLsT3k7ryv4Iwf0oQ8bVjsvwqFIiFhj+qqjnR5OS8chWOXRdCndls
 zQ9VYUr/We3UY3x/ymqA1ekcB7lpT7zAx/9M9ojhUvtqIuv7Z3+p/J/7SCj4aeiwyNsup8EMU
 qdX7dNPQKk7m4G3pd2AVSS/IypjJnyBml3Fps/hrr2yyOFwbdK/jH2q+9veM7iWNewdKGiWhD
 6MMN7CDJQ24JEWaeeIiSX/4sG5r4251vhD67b3BeOT7pAOvm+d4AifTY84tEPUhGID66sw7uS
 tf8GrrTDJxM+VzUCi6Ft7x8gYSDmAnDA8ym5o+tr37toBtQEtKl7YdhfhLBE4IYNG0plc3zz6
 7veSC4vv4riD6pfCmWrnpNR+I69fRQDDrdys0AOB/cA96bKV7lnLX1UZUK5VIFbPA5Wzo2RFD
 X9+xzxbmIn+6ZKXZV7JkI6hjKbs=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Acer Travelmate 4002WLMi, the system locks up upon
suspend/shutdown. After a lot of research, it turned out
that the sbs module was the culprit. The driver would not
correctly mask out the value used to select a battery using
the "Smart Battery Selector" (subset of the "Smart Battery Manager").
This accidentally caused a invalid power source to be selected,
which was automatically corrected by the selector. Upon
notifing the host about the corrected power source, some batteries
would be selected for re-reading, causing a endless loop.
This would lead to some workqueues filling up, which caused the
lockup upon suspend/shutdown.

The first patch fixes an issue inside the ec driver regarding the
removal of query handlers discovered thru ACPI. The second patch fixes
a kernel oops on module removal caused by a race condition when removing
custom EC query handlers. The last patch finally fixes the
suspend/shutdown issues.

As a side note: This was the first machine on which i installed Linux,
to finally fixing this took ~5 years of tinkering.

Tested on a Acer Travelmate 4002WLMi.
=2D--
Changes in v3:
- Rework solution for the kernel oops on module removal
Changes in v2:
- make acpi_ec_add_query_handler() static to fix warning

Armin Wolf (3):
  ACPI: EC: Limit explicit removal of query handlers to custom query
    handlers
  ACPI: EC: Fix oops when removing custom query handlers
  ACPI: SBS: Fix handling of Smart Battery Selectors

 drivers/acpi/ec.c  | 17 ++++++++++++++---
 drivers/acpi/sbs.c | 27 ++++++++++++++++++---------
 2 files changed, 32 insertions(+), 12 deletions(-)

=2D-
2.30.2

