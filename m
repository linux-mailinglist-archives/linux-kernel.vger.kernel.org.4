Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9F5BF51E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIUD7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIUD7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:59:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090B21D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663732784; x=1695268784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Mby3RcaccXTpAuP1MtHipLkQzfzXB20Lb9u7VhsKeA=;
  b=S7rW3Amc4qhU0LZMi5EoL1M8j0gCFlebCNr+E9qDlmRKqNT5YhlT8BQr
   HiiA9w/ZkI27qAY5riP/JqLet2huvFn8RttHqOeZN2gfb5er9svvBvbdM
   pttokv6JB3J8euEtZryafVrf2ERt/b+vqP9AAy1uLZrQoveraznPL/cdT
   T/JcZgpB2PZIY9slNYFtYXBBT4UwfcF60eLnWe0J0YOpBSY0YjMAdD/6W
   lwe5SvzNkmm75sUYrpd36bRwyeT46ZT4l+4R1ZoQHbBGhx4JpYkpaZoa3
   ccYBrbr6t4p+ABURnuEqobpRAaZkT794qgtr1OVQwqv202auw9V716QSI
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="323978827"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 11:59:43 +0800
IronPort-SDR: aG9TkkOzzBi9c97djYwI9ypF6rYy/8WkpIkPf7eW6DkzZB1nrwhYNwClioFvOdYFBL2zFCjg8x
 D+bADdsZO8Azr87Z8emGIu8ooUKSLtNj0CH7Tio9OHZ9qeehpNyDgRYBfNkh6jN2pcikHhORdK
 Eu7RcOt242Ggwt18H+pYa5z+H4vjwg/54DvCQt8K0fZYN1iBv8zmvN3DR4ORfKWqcu9T9K8NrQ
 bYvQNBA4WCaynw80pWyhpImcUqy11FUbvyGeZDMlF2YvDucD0exke2EnDj5IgKFfH/S7SBDhIk
 Jxoi7G2iHO3gsmTaFdfXByg1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 20:14:19 -0700
IronPort-SDR: GazhRVfq5XMo6Ab9aSlo/Etb867t2n6ML9ylyTwb1+TMsC6LCMi51HdfdGg/0u71m28dldbJa1
 xTt+fMOQ6U+7UCm7YRtHFRy8Qm/R+2f1czVENPCty3yJRkuURAAS/9zao/pIkUR2HM7WS7BcfE
 NNu45MJg4RPjdn6q1HzdwWunQQaKUCgphLmdVKNm59J0pD6jdoQzZ+KbFTZZ7dTChQsM3N0c8e
 AOgHeMy6UIBVNtPAwWJrPxePc5KVqVlG8Ql1Ltscfr/i3/6bdq/o52GkY8/7Utu9sbYmijNF7e
 f24=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 20:59:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXPnC2wx1z1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:59:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663732782; x=1666324783; bh=/Mby3RcaccXTpAuP1MtHipLkQzfzXB20Lb9
        u7VhsKeA=; b=F+lAWLwMMoMdsUGgZUIrgokVDK0SvCpsmemngbw4no5lrVNkP6d
        hXTUzbOdO1CH02qLfF3nXJO6cZqw2H3//U6urPK0AGUc9grGsIQW4zyPdu562eqj
        6A9JWWTWQt8+a09WBl+5oGDoRgPr3ZUC0MtdQwJgOFEcgvTByD/hTEVWYLi51TJV
        q4nrh4heEwB1OThkf+T8jNLdZ6aOeK0qrOt16gr63nAp219QKFmacFdL0MIUxDjS
        UHOvA4hetg04T+P4x6R/h2iSeVAsLeWzJWFQTSDSoJ3G9knI/+8YFNgU2Xr5Q3ch
        p9YUYK6VTEUZbG7J+n7sNI04Od6ORO7UTxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2nd1GmdWeiGo for <linux-kernel@vger.kernel.org>;
        Tue, 20 Sep 2022 20:59:42 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXPn71qspz1RvLy;
        Tue, 20 Sep 2022 20:59:38 -0700 (PDT)
Message-ID: <d2ff0ebf-e22f-85ac-6964-27bafadaf8f3@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 12:59:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/6] libsas and drivers: NCQ error handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yangxingui@huawei.com, hare@suse.de
References: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 00:08, John Garry wrote:
> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover, if necessary
> 
> Indeed for the hisi_sas driver we want to add similar handling for NCQ
> errors.
> 
> This series add a new libsas API - sas_ata_device_link_abort() - to handle
> host NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it.
> 
> A difference in the pm8001 driver NCQ error handling is that we send
> SATA_ABORT per-task prior to read log ext10, but I feel that this should
> not make a difference to the error handling.
> 
> Damien kindly tested previous the series for pm8001, but any further pm8001
> testing would be appreciated as I have since tweaked pm8001 handling again.
> This is because the pm8001 driver hangs on my arm64 machine read log ext10
> command.

I tested this series on top of the current Linus tree. All look good. As 
ususal, I hammered an SMR drive connected to a pm80xx adapter and 
generated lots of invalid commands to check EH. No issues that I can see.
E.g., an unaligned write error look like this:

[ 5384.194853] pm80xx0:: mpi_sata_event 2685: SATA EVENT 0x23
[ 5384.238720] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[ 5384.246171] sas: sas_scsi_find_task: aborting task 0x0000000050be2a4b
[ 5384.254654] pm80xx0:: mpi_sata_completion 2292: task null, freeing 
CCB tag 2
[ 5384.254676] sas: sas_scsi_find_task: task 0x0000000050be2a4b is aborted
[ 5384.294659] sas: sas_eh_handle_sas_errors: task 0x0000000050be2a4b is 
aborted
[ 5384.318691] ata22.00: exception Emask 0x0 SAct 0x200000 SErr 0x0 
action 0x0
[ 5384.328425] ata22.00: failed command: WRITE FPDMA QUEUED
[ 5384.336277] ata22.00: cmd 61/01:00:01:00:ea/00:00:02:00:00/40 tag 21 
ncq dma 4096 out
[ 5384.336277]          res 43/04:01:01:00:ea/00:00:02:00:00/00 Emask 
0x400 (NCQ error) <F>
[ 5384.357299] ata22.00: status: { DRDY SENSE ERR }
[ 5384.364459] ata22.00: error: { ABRT }
[ 5384.553177] ata22.00: configured for UDMA/133
[ 5384.560343] sd 19:0:3:0: [sdl] tag#80 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[ 5384.572175] sd 19:0:3:0: [sdl] tag#80 Sense Key : Illegal Request 
[current]
[ 5384.581765] sd 19:0:3:0: [sdl] tag#80 Add. Sense: Unaligned write command
[ 5384.591126] sd 19:0:3:0: [sdl] tag#80 CDB: Write(16) 8a 00 00 00 00 
00 02 ea 00 01 00 00 00 01 00 00
[ 5384.602938] I/O error, dev sdl, sector 391118856 op 0x1:(WRITE) flags 
0x8800 phys_seg 1 prio class 2
[ 5384.613854] ata22: EH complete
[ 5384.618570] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 
tries: 1

So looks good to me.

Feel free to add:

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> Finally with these changes we can make the libsas task alloc/free APIs
> private, which they should always have been.
> 
> Based on v6.0-rc4
> 
> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/
> 
> Changes since v2:
> - Stop sending SATA_ABORT all for pm8001 handling
> - Make "reset" optional in sas_ata_device_link_abort()
> 
> Changes since v1:
> - Rename sas_ata_link_abort() -> sas_ata_device_link_abort()
> - Set EH RESET flag in sas_ata_device_link_abort()
> - Add Jack's Ack tags
> - Rebase
> 
> John Garry (5):
>    scsi: pm8001: Modify task abort handling for SATA task
>    scsi: libsas: Add sas_ata_device_link_abort()
>    scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
>    scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
>    scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
> 
> Xingui Yang (1):
>    scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
> 
>   drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
>   drivers/scsi/libsas/sas_ata.c          |  12 ++
>   drivers/scsi/libsas/sas_init.c         |   3 -
>   drivers/scsi/libsas/sas_internal.h     |   4 +
>   drivers/scsi/pm8001/pm8001_hwi.c       | 186 ++++---------------------
>   drivers/scsi/pm8001/pm8001_sas.c       |   8 ++
>   drivers/scsi/pm8001/pm8001_sas.h       |   4 -
>   drivers/scsi/pm8001/pm80xx_hwi.c       | 177 +++--------------------
>   include/scsi/libsas.h                  |   4 -
>   include/scsi/sas_ata.h                 |   6 +
>   11 files changed, 96 insertions(+), 335 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

