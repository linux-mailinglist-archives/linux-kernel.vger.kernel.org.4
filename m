Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD286E81C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjDSTXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDSTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465259E3;
        Wed, 19 Apr 2023 12:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC0AD6400C;
        Wed, 19 Apr 2023 19:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572B7C433D2;
        Wed, 19 Apr 2023 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681932193;
        bh=or2HJONe3O8ddoiHASXnOq90Hlfo90B4VuLfBfgdYqE=;
        h=From:To:Cc:Subject:Date:From;
        b=Id9KKEqa3u7Hw33Z0acnzBZadz+dMCNFxIQLyVhS3u13XRkCWlLnoSQFI0xU+b9zl
         Xxs5ltpxuOWIEUHPofCUCGkQFNNZIYozsaPSfaNpyqwTgLgt/OAdIG57CtfFReualA
         Yn22aVc34YNL8YvJSYSwfnTmsk6njjmFzNYDBSvmDnuTQANfhQlTcTtGTKswKamb9d
         aBZy19fy3Tlh4THITpI4Y30Iz0tFIbKMznNYy2e8XrVCH15a8LJhYk3xUOh75FQpSS
         T+vqjYdsQnLm1jHnfTXgpqF8uStz/JU67u4Wef1trYmvDz/dk+AGnfIopxLSBeaAlW
         ip/07oS8GyYNA==
From:   broonie@kernel.org
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: linux-next: manual merge of the cxl tree with the pci tree
Date:   Wed, 19 Apr 2023 20:22:16 +0100
Message-Id: <20230419192216.149588-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the cxl tree got a conflict in:

  .clang-format

between commit:

  09cc900632400 ("PCI: Introduce pci_dev_for_each_resource()")

from the pci tree and commit:

  74e491e5d1bcc ("PCI/DOE: Make mailbox creation API private")

from the cxl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc .clang-format
index 2048b0296d76f,1c85f6ddc71ab..0000000000000
--- a/.clang-format
+++ b/.clang-format
@@@ -520,8 -520,6 +520,7 @@@ ForEachMacros
    - 'of_property_for_each_string'
    - 'of_property_for_each_u32'
    - 'pci_bus_for_each_resource'
 +  - 'pci_dev_for_each_resource'
-   - 'pci_doe_for_each_off'
    - 'pcl_for_each_chunk'
    - 'pcl_for_each_segment'
    - 'pcm_for_each_format'
