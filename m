Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE473A0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFVM3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjFVM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:29:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF7AB4;
        Thu, 22 Jun 2023 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687436969; x=1718972969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUgGotXhMv1WrSS/NSFaFGHTb5xR4LxoJgck4Fh0kTY=;
  b=K5PR+D9rySeBahdjDWyWrOJYLOmsJDDxGv4shHPL9aOpuOvglv+iDSK3
   FPQZxxnWkxW8nQEfU0hFv1uEnN2gK20+xOM1kmig1cf33DNZLXcNLyko/
   lsSw98nLHqjLiugobW+QFoxZgvCz5t/rfV7eo/VFvITat5nsIJ0E/qTqo
   iWjtOoExKvtIipFFI7Vkvl1igyl6CG/729uExJ78O+D3ot8N0WbKt0D0F
   3MgvT1pGVNF0bhqddzhBQj1HTsisU4pr+5KmM9KzuFSXzFKTqJk5OaN71
   DMTVsayy5VxIOcIs11NxMCMuZf8BFk7GN7oYIMJ2n2QE201OexWZiQ2dK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390192392"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="390192392"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="709077606"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="709077606"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2023 05:29:08 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kah.jing.lee@intel.com
Subject: Re: [PATCH 0/2]: Enable UBIFS support
Date:   Thu, 22 Jun 2023 20:27:21 +0800
Message-Id: <20230622122719.593138-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b7ffa43c-3dee-b0cf-2672-6b56fcbcd0e6@linaro.org>
References: <b7ffa43c-3dee-b0cf-2672-6b56fcbcd0e6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <kah.jing.lee@intel.com>

> 
> Your patchset has also broken/missing threading. Read carefully submitting
> patches and rest of documentation.
Updated in v2.

>
> Best regards,
> Krzysztof

Thanks for quick reply.

Regards,
Kah Jing
