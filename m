Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC786CCC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjC1Vwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1Vwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:52:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844E172D;
        Tue, 28 Mar 2023 14:52:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SLqZ8f116428;
        Tue, 28 Mar 2023 16:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680040355;
        bh=tANqL8TgbKcam/Bj4sYIV8e9YOgtRGtUv8fdoYNLx7o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MZNRgKE7BCyZDr/wG8+xSTJIVqMnHBUqg3/5/EUu6hQWQLIDQbzPvgmtIu6kuAwn7
         8cmDMM7fzHBgfXWvV/xNN6/ZlLImVbR79NJnqdZL1qpCEB8Amntyy8jDgGYUKzkduF
         Ca+3iPRm/6zzTkcLV69/cFRb7Fzt770V5rC1Ixyc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SLqZGx027945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 16:52:35 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 16:52:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 16:52:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SLqYPT003033;
        Tue, 28 Mar 2023 16:52:34 -0500
Date:   Tue, 28 Mar 2023 16:52:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port
 for USB0
Message-ID: <20230328215234.ug7x34rjfiv7ixhi@trimness>
References: <20230328124315.123778-1-rogerq@kernel.org>
 <20230328124315.123778-3-rogerq@kernel.org>
 <20230328131810.x2j6uvwzhniclvwf@evoke>
 <3bd6191c-caa4-15a8-92ad-17a07ec085e2@kernel.org>
 <20230328133024.ow6cvm22o2c5heem@untrimmed>
 <39cb4f8c-d10f-f543-ddca-8a8507757f4c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <39cb4f8c-d10f-f543-ddca-8a8507757f4c@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:46-20230328, Roger Quadros wrote:
[...]
> >>> 	How about sk-lp ?
> >>
> >> moved it to sk-lp. see above in this patch.
> >>
> > 
> > A bit confused. Looking at [1] vs [2], it seems to indicate pd controller at
> > 0x3f as well? Am I misreading the schematics?
> > 
> > [1] https://www.ti.com/tool/SK-AM62-LP#design-files
> > [2] https://www.ti.com/tool/SK-AM62#design-files
> 
> Yes PD controller is at 0x3f for both boards but IRQ is not routed on AM62-LP.
> I tried to explain this the cover letter. ;)
> 
> Pasting here for convenience.
> 
> > Although k3-am625-lp-sk USB is exactly the same as on k3-am625-sk,
> > it is missing the IRQ line from Type-C chip which is currently
> > required as per chip's DT binding. So we don't add Type-C support
> > for k3-am625-lp-sk till h/w is fixed or polling mode support for
> > Type-C chip is accepted [2]
> > 
> > [2] - https://lore.kernel.org/lkml/20230324133741.43408-1-rogerq@kernel.org/T/

Thanks, This thread does seem to be progressing? Since LP-SK is already
in production, it might do good to hold on to this series a little
longer instead of shuttling dts nodes back and forth.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
