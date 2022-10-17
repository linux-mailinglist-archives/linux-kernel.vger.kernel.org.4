Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A9600589
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiJQDEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJQDD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:03:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47504A82B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665975834; x=1697511834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ov5cmz9gU35KmoNjjYRwvfTEW+3UgseEzrD+fH3pwk=;
  b=lH02fHQYhkgSezBBrYtah2NxhU3X/v0E+B8va70XyLUlCqt10rNXXOV8
   hlvYn+bmLKz2dOgaqwqxcpxmYREdPoo1hf4RfYRHBDSEhek++TQYlEaST
   Hj58OZ9hrbxUL2wH33Ic+Bhrsa/DGBaC0jvs9L2LxFBDH2G7e2wtYucox
   E5e1MvhrPwOyxAkBbjgW+eQXZ2dtyVDu16j6FGywKLSVnU5jAiyd6yYxx
   xikMM6KR8rFDaXUVc7/ry5ojPIFlu/HOAFK1yXyJ/MMRi0tnFCZ8sy5nh
   6dyMFw9waLsR+pX/O1X8UbYrMTOXDO8EAY2VK+ihCFSqhIJDodA04zMrd
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="212301920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:03:52 +0800
IronPort-SDR: uiVdIsUYdx06J9Da2e/jluEUtQmQeNtMxTdmFp+lmTNzC4dErRBycLvxa2nL4NdXzjm50q13lA
 OHB2sKy71JTh4sItPpOjwfy06QwP9vvDldAT6Rh+/MvFovXTPuHcD+NjXQQ7zG91bT/VWeJ3Eu
 1gNBpaE96IFm8abWqSrAJt1V/jZtR52tBbKQzN3WxFkDg9hGWgobQa/kM2GDRmXISRPwlOLJTZ
 9uNdajZgQxR3KHh3KPEykBTXTk+v8YXcfBRu6SQtM9vAU3Ea6Qe1gSgYIQtwo58ePitipzKIAV
 Ab4vdvxx0Yz3dzURpFtHI1ND
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:23:25 -0700
IronPort-SDR: +Iq1ydYQLt6X9CI/XArm/dEh+4afPw99Qr9YXEuzC7ZQvp0S9fEeOJAjn0Gap7L0T+t8LJUnMR
 NOsUoq+pucxUdHB5Z01bp783+l2tCboGL8ksa/9kqOmpxDccN2bOUCqcWATiPeqj6FNfoeK6UL
 aBIkr5uyLcOB+Q8B+VgWzesdAB/GvVfsEuC+J9oWxGxBse1A/9AHPV3YxsJCZQ4EdYp0ZuuJ7B
 XFIB6FcZVU/OKopWbcjxiaX/2bqt5I4xO+hM2I1gTLZyK0yeASbHJO6Ocswf36mSlc9+11MWvH
 cvw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:03:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMJm095Dz1RwqL
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:03:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665975831; x=1668567832; bh=8ov5cmz9gU35KmoNjjYRwvfTEW+3UgseEzr
        D+fH3pwk=; b=K/G9/8y6racPVJwwOT/iDo6fKDGtXdez/QXPaXZF4iUk9yuY3E0
        VMzO0B38Wou4xRjNIO18tGjpbMunen14j92wYGFAhjXeA+OrNczkgAOvLYHPBp66
        AbgF6Fh6fqk8BqFP8tQ+RaEXhth/cRn8qxvBdebZ5n31tgATFMRwYWkSP8YdYngA
        +3V5Gz5K8MnCUr62KmwLkUOQ7mi4WpqHdJTuBMFXtOPsQI3n4E52K/hsFYVGuXIV
        B/ypd6U5ZrbYIIcSI5GQm5JD7quf+eKxV1ilwFpBmcHjcw8/ARc7bxmb6b7puogq
        EZlQt49YHWnDJO9YnvQwdhpEWIhKCB0bryw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0sMPI2vMLqol for <linux-kernel@vger.kernel.org>;
        Sun, 16 Oct 2022 20:03:51 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMJk66Wmz1RvLy;
        Sun, 16 Oct 2022 20:03:50 -0700 (PDT)
Message-ID: <5d249f84-bf74-153d-294d-cab2f6456ff7@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 12:03:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011024617.720898-1-kai.heng.feng@canonical.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221011024617.720898-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 11:46, Kai-Heng Feng wrote:
> UBSAN complains about array-index-out-of-bounds:
> [ 1.980703] kernel: UBSAN: array-index-out-of-bounds in /build/linux-9H675w/linux-5.15.0/drivers/ata/libahci.c:968:41
> [ 1.980709] kernel: index 15 is out of range for type 'ahci_em_priv [8]'
> [ 1.980713] kernel: CPU: 0 PID: 209 Comm: scsi_eh_8 Not tainted 5.15.0-25-generic #25-Ubuntu
> [ 1.980716] kernel: Hardware name: System manufacturer System Product Name/P5Q3, BIOS 1102 06/11/2010
> [ 1.980718] kernel: Call Trace:
> [ 1.980721] kernel: <TASK>
> [ 1.980723] kernel: show_stack+0x52/0x58
> [ 1.980729] kernel: dump_stack_lvl+0x4a/0x5f
> [ 1.980734] kernel: dump_stack+0x10/0x12
> [ 1.980736] kernel: ubsan_epilogue+0x9/0x45
> [ 1.980739] kernel: __ubsan_handle_out_of_bounds.cold+0x44/0x49
> [ 1.980742] kernel: ahci_qc_issue+0x166/0x170 [libahci]
> [ 1.980748] kernel: ata_qc_issue+0x135/0x240
> [ 1.980752] kernel: ata_exec_internal_sg+0x2c4/0x580
> [ 1.980754] kernel: ? vprintk_default+0x1d/0x20
> [ 1.980759] kernel: ata_exec_internal+0x67/0xa0
> [ 1.980762] kernel: sata_pmp_read+0x8d/0xc0
> [ 1.980765] kernel: sata_pmp_read_gscr+0x3c/0x90
> [ 1.980768] kernel: sata_pmp_attach+0x8b/0x310
> [ 1.980771] kernel: ata_eh_revalidate_and_attach+0x28c/0x4b0
> [ 1.980775] kernel: ata_eh_recover+0x6b6/0xb30
> [ 1.980778] kernel: ? ahci_do_hardreset+0x180/0x180 [libahci]
> [ 1.980783] kernel: ? ahci_stop_engine+0xb0/0xb0 [libahci]
> [ 1.980787] kernel: ? ahci_do_softreset+0x290/0x290 [libahci]
> [ 1.980792] kernel: ? trace_event_raw_event_ata_eh_link_autopsy_qc+0xe0/0xe0
> [ 1.980795] kernel: sata_pmp_eh_recover.isra.0+0x214/0x560
> [ 1.980799] kernel: sata_pmp_error_handler+0x23/0x40
> [ 1.980802] kernel: ahci_error_handler+0x43/0x80 [libahci]
> [ 1.980806] kernel: ata_scsi_port_error_handler+0x2b1/0x600
> [ 1.980810] kernel: ata_scsi_error+0x9c/0xd0
> [ 1.980813] kernel: scsi_error_handler+0xa1/0x180
> [ 1.980817] kernel: ? scsi_unjam_host+0x1c0/0x1c0
> [ 1.980820] kernel: kthread+0x12a/0x150
> [ 1.980823] kernel: ? set_kthread_struct+0x50/0x50
> [ 1.980826] kernel: ret_from_fork+0x22/0x30
> [ 1.980831] kernel: </TASK>
> 
> This happens because sata_pmp_init_links() initialize link->pmp up to
> SATA_PMP_MAX_PORTS while em_priv is declared as 8 elements array.
> 
> I can't find the maximum Enclosure Management ports specified in AHCI
> spec v1.3.1, but "12.2.1 LED message type" states that "Port Multiplier
> Information" can utilize 4 bits, which implies it can support up to 16
> ports. Hence, use SATA_PMP_MAX_PORTS as EM_MAX_SLOTS to resolve the
> issue.
> 
> BugLink: https://bugs.launchpad.net/bugs/1970074
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to for-6.1-fixes with "Cc: stable@vger.kernel.org" tag added.
Thanks !

> ---
>  drivers/ata/ahci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index da7ee8bec165a..7add8e79912b1 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -257,7 +257,7 @@ enum {
>  	PCS_7				= 0x94, /* 7+ port PCS (Denverton) */
>  
>  	/* em constants */
> -	EM_MAX_SLOTS			= 8,
> +	EM_MAX_SLOTS			= SATA_PMP_MAX_PORTS,
>  	EM_MAX_RETRY			= 5,
>  
>  	/* em_ctl bits */

-- 
Damien Le Moal
Western Digital Research

