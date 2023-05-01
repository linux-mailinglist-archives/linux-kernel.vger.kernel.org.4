Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A718E6F34FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjEARSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjEARSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:18:05 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77819F5;
        Mon,  1 May 2023 10:17:27 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id CA495E8D;
        Mon,  1 May 2023 19:01:38 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1682960496; x=1684774897; bh=7mYtdk4SkFBKzGfT
        yMekgb3iz0PSpK7RZi9D7/acNmQ=; b=lXZCEWxQDiF4/MY6PZm20Y/lfioT+J5l
        PywLATLls+1E/OYFbH0yTUpsSTkYtZuck6o3rQH8GDbYeq8Y5AVkFovxgV2Ist4l
        VJqOghGuHQx90qnjr3heced94WJPm+n6rcs3mGnhVwymgTQPfvxCdZipu/sb53xf
        z4MuJ8U9h7XqgvRPJa8710lk2KaWxKB/o9dxoLW04MvMJ/o2H7pMe9EOtJxYLq94
        pbrXnLWqXvdQZcJ3gGQDtRBs+7F6b5aeHuHkm7F8g9AzN1ADHKmp2QlvKahhQ9ZH
        MPb8x+hVgKltQ5EZjO2k4MObYfpHM+tJGBVjmMuDARvCjtKEfW/CIigx8FgGsggF
        +w7D8aqbmAgJHZKey8ojA/1/X/HXujSmzkkIlUWZ1DuUZZHoQdwZWcgpOrfctdS7
        QdT2RulthQP7A7hKiYMYBBnS0Z5XP/fsHWPf01lUZv8e8sXx1N+3mJa/qZywAoNy
        aEBAV3XCdLqv9wcHS4peTdUIwLjHvPUKoKDqt+ntw02uwNZODAcL/Yc8azju8Uqd
        t1r5P50JEeg5AMthFLFb/Ss/axunuc6iCSs3KcluGTLk+GCFf0Opz+TvMZ48zdte
        ExsLhb3g+h4HbftTwMcctCwj+qgiM0etCHXtb9sTdN9Q1BIh6hsp/aORe2leLXBl
        oQMt+jJB3qE=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vC2Yf_IgpRW0; Mon,  1 May 2023 19:01:36 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id 42339E4A;
        Mon,  1 May 2023 19:01:32 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id C3B3277A2;
        Mon,  1 May 2023 19:01:31 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alison@she-devel.com, achaiken@aurora.tech,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 0/2] support config of U-Blox Zed-F9P GNSS
Date:   Mon,  1 May 2023 10:01:22 -0700
Message-Id: <20230501170124.1218603-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Add generalized support for setting arbitrary configuration of the
U-Blox Zed-F9P GNSS.  Employ the new functionality to set the baud rate
of the Zed-F9P if the devicetree specifies a non-default value.

Tested with 6.1.22, only on a U-Blox Zed-F9P GNSS.

V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304300819.u0hfUj33-lkp@intel.com/

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 195 ++++++++++++++++++
 2 files changed, 196 insertions(+)


base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
-- 
2.39.2

