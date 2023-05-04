Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192496F6DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjEDOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:22:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508EA26A4;
        Thu,  4 May 2023 07:22:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 344EMdxd111061;
        Thu, 4 May 2023 09:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683210159;
        bh=gnwNizn4SSx/rJB7GXkyAUjtVDX5f2tKsOI8nX5fTj4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BJ3K3BvUWnpVP9YU9SUv8/BDk6xoajFVqf+6o9OqYMu8UMyN8DNIGueBjb/qoi7dq
         jucZ6j6neLFSaV6KY8VzMEFZ9X/+CrVFGNoAxvZmNvz+Zl0+cjVmGhPOJQppOXLqcw
         2G0PU/fg3iEwUeLFHcnGb2Ft9++yZC3Jly7lNtOc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 344EMdDM061798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 09:22:39 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 09:22:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 09:22:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 344EMdLx026442;
        Thu, 4 May 2023 09:22:39 -0500
Date:   Thu, 4 May 2023 09:22:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Thejasvi Konduru <t-konduru@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and
 pinctrl node offsets
Message-ID: <20230504142239.hqhni2c52k3a3asz@prune>
References: <20230503083143.32369-1-t-konduru@ti.com>
 <20230503114625.gqnijd3bog5bwemz@parameter>
 <31b31af7-6c54-7d05-f7ef-fcceba48580e@ti.com>
 <20230504115207.h6trzy4mqjcbkcm3@comment>
 <67eccecb-f4a4-7f15-5316-27fd39e65b51@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67eccecb-f4a4-7f15-5316-27fd39e65b51@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:40-20230504, Thejasvi Konduru wrote:
> 
> On 04/05/23 17:22, Nishanth Menon wrote:
> > On 14:36-20230504, Thejasvi Konduru wrote:
> > > On 03/05/23 17:16, Nishanth Menon wrote:
> > > > On 14:01-20230503, Thejasvi Konduru wrote:
> > > > > The wkup_pmx register region in j784s4 has multiple non-addressable
> > > > > regions, hence the existing wkup_pmx region is split as follows to
> > > > > avoid the non-addressable regions. The pinctrl node offsets are
> > > > > also corrected as per the newly split wkup_pmx* nodes.
> > > > > 
> > > > > wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
> > > > > wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
> > > > > wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
> > > > > wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)
> > > > > 
> > > > > Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
> > > > > Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
> > > > > ---
> > > > Could you provide a link to the output of:
> > > > $ cat /sys/kernel/debug/pinctrl/*/pins
> > > https://gist.github.com/thejasvikonduru/05b1a8e0fd8176116b7a3cc4e43b244a
> > Was this failing prior to this patch? Trying to understand the "Fix"
> > aspect of this patch.
> > 
> Yes,it was failing prior to this patch.
> 

next time some asks this question - give summary AND give a log. Even
better, please don't make folks even ask the question in the first
place by including the logs in the diffstat of the patch.

Please share the log to understand what kind of "failure" was occurring.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
