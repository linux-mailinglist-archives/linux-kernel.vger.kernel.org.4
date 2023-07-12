Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B9F74FE06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGLD7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGLD7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:59:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84941709;
        Tue, 11 Jul 2023 20:59:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36C3wihK086819;
        Tue, 11 Jul 2023 22:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689134324;
        bh=OkfbRb8Gv0FdX+D3e3VIlXAwGhNuTLzplBRSNoW277M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ki2BUU7PBP1AHx3cUbY1ZlxZuI3g4QO2dSRVeZa6x92pOBcMDZeX4BPSU8+KgbHJh
         C00t/7cMQ92W8twCsZdSdrDYFdvKUvTHVAWO0a7StYNgLccc5gKIuY/1sCSp5kqN1o
         8cir8CtGdPbCtVxURglYHrsfAnj9laudYw38GGv4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36C3wiBS092006
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 22:58:44 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 22:58:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 22:58:43 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36C3wgYZ009014;
        Tue, 11 Jul 2023 22:58:42 -0500
Message-ID: <40fad90a-551e-e66b-f225-8add53b417e0@ti.com>
Date:   Wed, 12 Jul 2023 09:28:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: branches to be removed
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20230710172602.05d32c03@canb.auug.org.au>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230710172602.05d32c03@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Miquel

On 10/07/23 12:56, Stephen Rothwell wrote:
> Hi all,
> 
> I will remove the following branches from linux-next tomorrow as they have
> not been updated in over a year.  If you want your branch retained or
> reinstated, please just send me an email letting me know.
> 

[...]

>   git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git     cfi/next

[...]

> These branches are all empty except the last which just contains a
> commit that is the same patch of a commit in Linus' tree.
> 

Development on CFI + Hyperbus has slowed down a bit, apart from odd
fixes every now and then which I have been asking Miquel to directly
apply to mtd/fixes. I do expect odd patches/improvements over next few
months, would it be possible to keep this tree included in linux-next if
its not too much of a burden?

-- 
Regards
Vignesh
