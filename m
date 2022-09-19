Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F15BC3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:01:45 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498A64E2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663574503; x=1695110503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QOSBZSc9dzIuGWpOOaX6YfZf7Xdxte9azBq14tzI/IQ=;
  b=Ci/Jz0LVOEBrxjTreUE+9yjLzgOkMg2WGoXoucqITpF68Mr8B/dZCnKV
   zI1l4sRlXc9gE7pgWhZThHlAlj70P2J1xLxWMh81hJ9fpr3nV6dITFBNR
   K/tNKe0mZ18wERJn/iS3EiIVNk+X6UqeHWvc3J2/KyZyFHWdR0IhQ6Qsj
   UhL4Fe8LXsOzbh7ElpzpSnvYRjUde/5i+qYLf3XMJmvYXoALuk/r4OWeU
   INgdltZPC859XyXfwlsCPFaIXoK1Duh4h7Inxdaq0H6ET4A2WPidZ53ZL
   EcVGxTT3rluvU9z61IXwZLntCTx2dJdJfwTzGYq1XAZvgK/mPCqbHYXW5
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,327,1654531200"; 
   d="scan'208";a="210080796"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 16:01:42 +0800
IronPort-SDR: 7gA23Es/RCg8l7trZr36bkNFX6DAzKbh/cZPCrV83BSFFla1GwovMoZV+h8NhON4PYeXmkVo6U
 9jV/YNENrfV8xMtbOHuxg+9QojJD6wyb6PJLnDdrBtjEqkYFtr9/S4wal1V1b6RWK9LNMRk40c
 k/2ARQEbj/kzGf/cThXs5eQdleJxCSWMFTEr/X0q4W2BcWB+o0HCGhKFEV+blLAYQ8pJBbqLj2
 lA3LLTwRTGQ3SdMvr6xfua3qZaMEBO/+bmDcNr+LyT8v/8x1mZ+RlppQYjo5tA4pVf+2mXbtAv
 q4q/3HL2dxrT4TlGwj2yzjVi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 00:16:20 -0700
IronPort-SDR: duJYUzNaiRNaEUmpP3dEI2d9pJdq3nxCTMjSsTKqvzqilmwqqV5okFYVuVmbvIxPFJaIlsqtQb
 oF/jVIdYuYaek8lyCEN5vq/pU9OFFFS6MURY6nSJGfLzpuT9/53G5gqVFP/rzR8loU4xk5Mwgs
 nPA4gbKjLLpVOiLwiYi0G0dX6hpNIn7C+uujML3/iVzmcjxIWtZGx7psM0NTdGcsAJ9AX7uGS5
 EyO2tiFuWg2nhe54qe9qFboQ+jYjf6sl+AIc2PMcNLBLBnGSgSOX2PYvyqlPhU/UKg0edxAaZI
 yG8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 01:01:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MWHFL24lsz1RvTp
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:01:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663574502; x=1666166503; bh=QOSBZSc9dzIuGWpOOaX6YfZf7Xdxte9azBq
        14tzI/IQ=; b=N/oqFP8VCXIWVhCpfik9OSZiScAQ4M+81VAmFu77/3LgC95P9Ln
        KyPoIaSUS5qQISB+hfvD7YC2QVLdPZnYKRHH/MlzEwAKojwKo7PPqhga3gGwKGg5
        MAbgEP1wzQkS9MZoLfL+zpBiJRVGrdNurOM8OPme4Y3VHA2jhKGNpmGvxmSftOfM
        bT01e+Fm8+jFnX/OscAetT5TfPFrMSlSNono93kQnHudqZsbukFM8thjnbtRIN7Z
        ODOC6d8mLHCtYiC5oW4ovY/2TiBYT+M8Y0mq62gY1OU2NsIglQ8VDEog0K3IOw3k
        RADZ2Jtfa/XV+dS1TTdPcOhjR7WhlWDOx+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Q-r5CQO5tdk for <linux-kernel@vger.kernel.org>;
        Mon, 19 Sep 2022 01:01:42 -0700 (PDT)
Received: from [10.225.163.80] (unknown [10.225.163.80])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MWHFJ4Rp8z1RvLy;
        Mon, 19 Sep 2022 01:01:40 -0700 (PDT)
Message-ID: <e58c02dc-1560-84db-d9cc-a16f47426b7d@opensource.wdc.com>
Date:   Mon, 19 Sep 2022 17:01:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: linux-next: build warning after merge of the libata tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220919124034.58670a27@canb.auug.org.au>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220919124034.58670a27@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 11:40, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the libata tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/ata/ahci_st.c: In function 'st_ahci_probe':
> drivers/ata/ahci_st.c:147:24: warning: unused variable 'dev' [-Wunused-variable]
>   147 |         struct device *dev = &pdev->dev;
>       |                        ^~~
> 
> Introduced by commit
> 
>   3f74cd046fbe ("ata: libahci_platform: Parse ports-implemented property in resources getter")
> 

Serge,

Can you send an incremental fix for this ? If not possible, I will do it.

-- 
Damien Le Moal
Western Digital Research

