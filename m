Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9A5B930A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIODZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiIODZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:25:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DC422F9;
        Wed, 14 Sep 2022 20:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663212324; x=1694748324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZsBcgBJQm4l4g5pNCmnqgaFEg0v9KwN5MLAaQq6q/0=;
  b=Uc3JSgKEdV5CKa8ELqIp2QAe7V8LjJGqvd4Jv6TQzOXJiWcHCC5vB6GS
   IAoyg8YmKdUO04maNZl1Y3Kx/WpsVbdwpi+il2ZK5AjF9ufguF2h9O0JH
   a+UqdbDpT0pYl0/6Q2IYGMjHN/nP78Qnc1y9I6iK7nddoJAVVvEg6GNON
   7Z6r6dWq/CyR1QVY74Qvm3DxpUZRF+BqUj9ngim/IhUnsFGkYcNUcBC6J
   5BdYCw9ZotlPZfTD/QBo7UCkh5hFA379Hja9XAUr/V89tb6cymTa+zkDk
   8Far6zACufu+oflV8Vm3HZcRigYzNOu+Jd86LfljnqxFIytL0GqoRaIZe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285641709"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="285641709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="742778603"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga004.jf.intel.com with ESMTP; 14 Sep 2022 20:25:18 -0700
From:   wen.ping.teh@intel.com
To:     wen.ping.teh@intel.com
Cc:     bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, dinguyen@kernel.org,
        dmitry.baryshkov@linaro.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/2] crypto: intel-fcs: Add crypto service driver for Intel SoCFPGA
Date:   Thu, 15 Sep 2022 11:25:06 +0800
Message-Id: <20220915032506.641639-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914144137.605279-1-wen.ping.teh@intel.com>
References: <20220914144137.605279-1-wen.ping.teh@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wen.ping.teh@intel.com=0D

>This patch introduces a crypto service driver for Intel SoCFPGA=0D
>family. The FPGA Crypto Service (FCS) includes a large set of security=0D
>features that are provided by the Secure Device Manager(SDM) in FPGA.=0D
>The driver provide IOCTL interface for user to call the crypto services=0D
>and send them to SDM's mailbox.=0D
>=0D
>Teh Wen Ping (2):=0D
>  crypto: intel-fcs: crypto service driver for Intel SoCFPGA family=0D
>  arm64: defconfig: add CRYPTO_DEV_INTEL_FCS=0D
Hi,=0D
=0D
I just found out that there was a previous attempt to upstream this driver=
=0D
2 years ago. It was NACK because it did not implement crypto API. Please=0D
drop this review.=0D
https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg44701.html=0D
=0D
I will move this driver to drivers/misc.=0D
=0D
Thanks,=0D
Wen Ping=
