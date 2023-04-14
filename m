Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB026E27E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4861BD0;
        Fri, 14 Apr 2023 09:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AB5164661;
        Fri, 14 Apr 2023 16:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F8FC433EF;
        Fri, 14 Apr 2023 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488191;
        bh=mwpEVmthTFGXrAt5wlQ6rrrdR4nou9HpjsVImzjWbwc=;
        h=From:To:Cc:Subject:Date:From;
        b=USod7eYDgwQFm8mGHq42JZkxRBBqcRBcS/dbXR1mcv0RHk+Wj3tekEGltOQYaPwCo
         dZt0N2BAlkr6VaDxl1+zcnQ3GXIt+opo76fryYak+swZvJtsM2bqb1uTUtJja8cojQ
         G0pDi3ElubIeYbRzlQk5uxmmMPtQbQcJ9H9VvmtYxvs7lHOBlcRRMq8FCVA1Mkd4Vd
         9z3c+bLF4BF/auLop7aQd7etKjmN6HitGbyrI4otiF0VABaZqj6k6gVbEONUiN6m79
         QhHmB2x3VnpL8BlzKgdmhDh7fnsFzM6sPqUr+o+gD//pwJlAt7lN8lq7QDwCwCRrCK
         duZTIYnnhvPaQ==
From:   broonie@kernel.org
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the nvmem tree with the devicetree tree
Date:   Fri, 14 Apr 2023 17:03:06 +0100
Message-Id: <20230414160306.2254545-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the nvmem tree got a conflict in:

  include/linux/of.h

between commit:

  82174a0a9c5cf ("of: Move of_device_get_match_data() declaration")

from the devicetree tree and commit:

  82174a0a9c5cf ("of: Move of_device_get_match_data() declaration")

from the nvmem tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/of.h
index 6ecde0515677d,9b7a99499ef35..0000000000000
--- a/include/linux/of.h
+++ b/include/linux/of.h
