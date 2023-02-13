Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB496695003
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBMS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:56:55 -0500
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B0DDBEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676314614; bh=cAs71QSd1p8y4Virq2PcJ1/GIZ3CFdwGcEuPI5/WEjE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=vebhCHhY4TpVHMIZC/uxY1K+4LzJx5diauL7UxCfD7Y5FA/LBihR/aHUzjQLui0E6
         KoNOfPajFyik5QlBzpLT8OiweY4esO/F/5mVn39qoPfqi7vJ66wTqdNW4q3tyVofYS
         16506j1TglyNQCfy0pvbiQPaoHAs9OfUU8CAt2CLNcxiH3twPlyCKxRvKno52TCx7s
         NhYLYHr+Vi0K8DVd/wfEtyHsBSobg4Nt879mF8BI8yIwSzUDO8jYucnICuZH6fRHCh
         tttuXM44euiqcD4LwhorAToAlWQYr8cnr8rzYByBNElBOrnQl94XXhhmFDOH1Gyd2Z
         7dKA6RRejGY5Q==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id BD3CF357AFD9;
        Mon, 13 Feb 2023 18:56:53 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] dt-bindings: sti: updates for STi platform
Date:   Mon, 13 Feb 2023 19:56:29 +0100
Message-Id: <20230213185633.15187-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fiH6lc_UDSSbDLXfeiQ_Tpk6lazqeBJc
X-Proofpoint-ORIG-GUID: fiH6lc_UDSSbDLXfeiQ_Tpk6lazqeBJc
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=605
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302130166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the sti.yaml file with addition of board information and
removal of no more supported STiH415/STiH416
Add the st,sti-syscon.yaml binding file for STi platform syscon

Alain Volmat (2):
  dt-bindings: soc: sti: add STi platform syscon
  dt-bindings: arm: sti: add STi boards and remove stih415/stih416

 .../devicetree/bindings/arm/sti.yaml          | 25 ++++++----
 .../bindings/soc/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
 2 files changed, 62 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml

-- 
2.34.1

