Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2372A70D603
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjEWHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjEWHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE910F8;
        Tue, 23 May 2023 00:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483546269B;
        Tue, 23 May 2023 07:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E729DC433D2;
        Tue, 23 May 2023 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684828146;
        bh=hJiDw9ugpgApqdgD2+nzV5nCu7C1Ebe2qqQWmq94DmM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NrXT8v/V4bqoKnIPQ2NFacGA+sQfEs9U78EKQ7KMgVc7YfQbUCyGjIH8sIKc67B92
         rVyDSCr2J0KXPfJxkbA1ttY1GcyysxjP5Zz26+hg/0z8O5Awh7smUrxBdIhDRN2mzV
         61GspTabigYC6AwN/phpGNEr/VWIEqx+4b9CxzZY3GkqGPkBTmNiyKucyNA+54R6Xw
         CxSlfKqGkJw1761K6OL8KntL/1hRudeczAFuPLDnwmyrVOKsIwiGm/HHpKfTxSs/ik
         P0tBSIZRziwGHjfS0M2/k2FJFoLMV0Js2sa+9Pf4zk1uIldhFXmhXeD/jfNJ1qtrwt
         vCwcW/zCQ+NHA==
Message-ID: <c08c6dd3-a70c-1624-90bf-0d0081a00b74@kernel.org>
Date:   Tue, 23 May 2023 16:49:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: build warning after merge of the scsi-mkp tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230523133833.64560bf3@canb.auug.org.au>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230523133833.64560bf3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 12:38, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-mkp tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/ata/libata-scsi.c:3864: warning: Function parameter or member 'spg' not described in 'ata_mselect_control'
> 
> Introduced by commit
> 
>   df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
> 

Martin,

To make things simpler, I posted a small patch to fix this. Please feel free to
fold it in df60f9c64576. Thanks !

-- 
Damien Le Moal
Western Digital Research

