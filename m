Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245C5675BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjATRiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:38:16 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBC5FDD;
        Fri, 20 Jan 2023 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1674236296; x=1705772296;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VjofiAXhO5C80JdyAXswdYDTLZEOnLHRkk1uSsByVus=;
  b=ND3GaapqjA4uSB6dtlYJfJmFmceYssSqm5jcJHXZt1eH71iv2vi/xPpM
   RO8D855D5JnSBMMnSQSvS0CoI1pxz7HLpL6gvYw4zvoAaasKJ98hH2X0u
   LF9jzec5lGLBpXDfbMKFKrshW5ef2JKNBXgPcTQZPE3tBVUQ5m7QPbMlJ
   M=;
X-IronPort-AV: E=Sophos;i="5.97,232,1669075200"; 
   d="scan'208";a="302491059"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 17:38:10 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 473B7E5D3C;
        Fri, 20 Jan 2023 17:38:06 +0000 (UTC)
Received: from EX19D001UEB002.ant.amazon.com (10.252.135.17) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 20 Jan 2023 17:38:06 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D001UEB002.ant.amazon.com (10.252.135.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Fri, 20 Jan 2023 17:38:06 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server id
 15.0.1497.45 via Frontend Transport; Fri, 20 Jan 2023 17:38:06 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 2B9BB20D16; Fri, 20 Jan 2023 18:38:05 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Rob Herring <robh@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd: partitions: Fix partition node name
 pattern
References: <20230120020454.3225796-1-robh@kernel.org>
Date:   Fri, 20 Jan 2023 18:38:05 +0100
In-Reply-To: <20230120020454.3225796-1-robh@kernel.org> (Rob Herring's message
        of "Thu, 19 Jan 2023 20:04:53 -0600")
Message-ID: <mafs03585cdj6.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19 2023, Rob Herring wrote:

> The 'partition' node name pattern is missing start and end anchors, so
> anything is allowed before or after the regex pattern. There's no in tree
> users needing that, so add anchors to the pattern.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Pratyush Yadav <ptyadav@amazon.de>

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



