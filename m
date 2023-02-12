Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B8693A15
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBLU6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjBLU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:58:08 -0500
Received: from st43p00im-zteg10062001.me.com (st43p00im-zteg10062001.me.com [17.58.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9DEB7E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676235079; bh=/uevlDnWAZTLA9DIggXawtSem4lZDJQX/OobCScL1qk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=A3aRgrRx/IynSmBdR9V3vNkhjg823GwVDgDZNkXSzwWbKRsS/eVpqPDHRT7Ro/9pN
         ZQD5Rigx7/Dg3cEeESTLHUwW8dLHfe4wbuE1XKX00xJeNQqfcy3pgfcqhhVJvRynH4
         wsLQ7GQ21x9pdYXpxkEBOcHmtpv9pO4L06Mr/770+Zd555F0Yseu4eOqrOx9+Fwfb9
         2F7AmIsmaz+QjCjPSwejqnSf3In8dP318ZZ/gKZAY6zaT3TM4XXKQFb39SPud5PuT4
         i5IZGGcSj9CL8yjlHHyO2zwWZq3QF81akqguqcgy9R48xtRh6j9oAylhMs5PLqdadF
         KX1WKkvRO0wlg==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 6EA7A80070F;
        Sun, 12 Feb 2023 20:51:18 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] dt-bindings: sti: updates for STi platform
Date:   Sun, 12 Feb 2023 21:51:05 +0100
Message-Id: <20230212205107.8073-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QppeA9kaSm7GsxNjjLr4AYnKwAH1ogrd
X-Proofpoint-ORIG-GUID: QppeA9kaSm7GsxNjjLr4AYnKwAH1ogrd
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=615
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302120192
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the sti.yaml file with addition of board information and move it
into soc/sti folder.
Add the st,sti-syscon.yaml binding file for STi platform syscon

Alain Volmat (2):
  dt-bindings: arm: sti: add STi platform syscon
  dt-bindings: arm: sti: add sti boards and remove stih415/stih416

 .../devicetree/bindings/arm/sti.yaml          | 26 -----------
 .../bindings/soc/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
 .../devicetree/bindings/soc/sti/sti.yaml      | 33 +++++++++++++
 3 files changed, 79 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sti/sti.yaml

-- 
2.34.1

