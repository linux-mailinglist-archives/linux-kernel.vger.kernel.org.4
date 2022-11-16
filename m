Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401B362B091
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiKPBa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiKPBaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:30:52 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF7C76F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668562252; x=1700098252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i0gHRwXuIJOP8atw8EZvBB0QFTOEHheZ0uEGpIud+BM=;
  b=RnQoNC1tjc6AG5aQuRpvcxYx/4nuFQZJeZH+KOrNloJa5nUAd9EiUYTY
   77U/9DfgvLZKyyrKkvZDnmVUKV3X0xgViyO+CT36DVVTC+OtvZUQGUOKv
   a3HhNsegq16zNuBMlf9IZtyCMLUT3nw0BLwwoBd8yMuQ0/4R2SwP+ft7y
   UwPMW5efYvwEyaymIhHzt3USTf2hQhwhh0XUlysNiCzTUuIbPaUn/tXpD
   f5MUP6VUJyht0ngyneMLTshRQp77OZVW0bhLhpi1SbLHIf3gZy9+ZA0Mn
   kR2T8uDiHurLphZHqRLjdT4YuowKz8hSPfqmeqfo1F+kKrGn1ExjIWlkP
   g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="328468525"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 09:30:50 +0800
IronPort-SDR: Ore5EJewZqfgRi7/zGxzcBAxZ4zIEavVcjw7SDQPKnic4n5Qo2ccGuwHT9lGxVpypuNQpade+J
 oYqOLt3Q0L8CmzvaZdbI9CvHQBXafY4/3w7RPCbd7/s5pzYav0pnD31RQ1YBwQgA8DoO5dh1CC
 0djJEAZQleRMKLuSr0+hC40PHS822QJGTjjEbms3KO08kJJtTHNN+0Hn/iBw75WGo3S23gHASZ
 U+tVEqiQr+OxAGDIWo9gyNYW8yHS+eQjDUMpoHTm3Ff+A0tePk9v5AxrdoGEXvdmnku+wFucCV
 k5I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 16:44:02 -0800
IronPort-SDR: WPzUr9mQQYZeAt542EGDRmzNhKwpp6g9cLF7EqL143bEFPyrThoOtXmitEqaJmF9OvW1uLIJ3u
 OHhQZXWJEfvaLkNEc5V3pjMxssgjQJ1RDhFuDRU/IKW1AEV6dQL0sPdpjCBVh0AZ8RTkB+sKPk
 K211zcOU8Nx4axEp9Rml9N1LaYCX/MvONliQ5dBrSef8BRJ1bvtIgkO2+UCU9Er2iI7VXvOhuk
 5MKW+m8G98Mv+9VZUx46cBRlHiDhZLFPJnooWbg/PiBtYuhyDmSYuG3/lcsP8yoBEhDnhw8s8b
 z4U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 17:30:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBlqZ1BQHz1RvTp
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:30:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668562249; x=1671154250; bh=i0gHRwXuIJOP8atw8EZvBB0QFTOEHheZ0uE
        GpIud+BM=; b=BBIEMAk856oaXs3IanIMxDQOlnD/E9Ik7i+gmzHFWZfz7TF7sjY
        e3kBBmtQ3D66tqy7s7X7TloXP083wtLoiYC0sVlkAAB7fzl581zmMA0hFRJ8M+Dd
        oUnSZgaUzPcSAuAMtJbOwxS4mDB5KRUOFoUvLPkNPu0b1YPO/Ljm+dWOSB5pYmwh
        hUAAk3GzToH8ggHAxz7/BweHVBuLVITRf3uyA5gb8TwaQiUaTK48PEaybRLjUBnX
        oy0mfa7eHjpM9Cvwvi0aG/tA2MMb3cZPZZOsLlZghSYv/LkJzv3s4OVjBfODzj6z
        SjdVr5Dgmhw3Nda6hYwEv/6K0oFM7E/cNRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r-bpWzVzxD2i for <linux-kernel@vger.kernel.org>;
        Tue, 15 Nov 2022 17:30:49 -0800 (PST)
Received: from [10.89.82.19] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBlqW6TR0z1RvLy;
        Tue, 15 Nov 2022 17:30:47 -0800 (PST)
Message-ID: <bfc49618-dbc3-8ffb-f536-3b4486e1980e@opensource.wdc.com>
Date:   Wed, 16 Nov 2022 10:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202211142025.46723.linux@zary.sk>
 <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
 <202211151556.52895.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202211151556.52895.linux@zary.sk>
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

On 2022/11/15 23:56, Ondrej Zary wrote:
> On Tuesday 15 November 2022, Damien Le Moal wrote:
>> On 11/15/22 04:25, Ondrej Zary wrote:
>>> On Monday 14 November 2022 09:03:28 Damien Le Moal wrote:
>>>> On 11/14/22 16:53, Ondrej Zary wrote:
>>>>> On Monday 14 November 2022, Damien Le Moal wrote:
>>>>>> On 11/12/22 20:17, Ondrej Zary wrote:
>>>>>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
>>>>>>>> It's been a while - did you get a chance to make some progress on
>>>>>>>> this?  Do you need any help to unblock you?
>>>>>>>>
>>>>>>>
>>>>>>> Sorry again, I'm back now. Trying to fix locking problems.
>>>>>>> Added this to each function for analysis how the functions are called wrt.
>>>>>>> locking:
>>>>>>>
>>>>>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
>>>>>>
>>>>>> Do you have your code somewhere that we can look at ?
>>>>>
>>>>> This is the current version with debug printks. I've also added dump_stack()
>>>>> to find out the code path but haven't analyzed the output yet.
>>>>
>>>> Can you send a proper patch ? Or a link to a git tree ? That is easier to
>>>> handle than pasted code in an email...
>>>
>>> Patch against what? I don't have a git server.
>>
>> patch against current 6.1-rc, or against an older kernel should be OK too.
>> But please "git send-email" a patch, or push your dev tree to github ?
>>
>>> I've done some call trace analysis. These code paths are calling
>>> pata_parport functions with ap->lock locked during init.
>>>
>>> Comm: kworker, Workqueue: ata_sff ata_sff_pio_task
>>> ata_sff_hsm_move -> ata_pio_sectors-> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
>>> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
>>> ata_sff_pio_task -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_sff_hsm_move -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_sff_pio_task -> ata_sff_hsm_move -> ata_pio_sectors -> ata_pio_sector -> ata_pio_xfer -> pata_parport_data_xfer
>>> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_data_xfer
>>> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_tf_read
>>> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_qc_complete -> fill_result_tf -> ata_sff_qc_fill_rtf -> pata_parport_tf_read
>>> ata_sff_hsm_move -> ata_pio_sectors -> ata_sff_altstatus -> pata_parport_check_altstatus
>>> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_check_altstatus
>>>
>>> Comm: modprobe
>>> ata_host_start -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
>>>
>>> Comm: scsi_eh_4
>>> ata_eh_recover -> ata_eh_reset -> ata_eh_thaw_port -> ata_sff_thaw -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_eh_reset -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
>>> ata_scsi_error -> ata_scsi_port_error_handler -> ata_port_freeze -> ata_sff_freeze -> pata_parport_check_status
>>> ata_sff_error_handler -> pata_parport_drain_fifo -> pata_parport_check_status
>>
>> What exactly are the issues you are having with ap->lock ? It looks like
>> you have done a lot of analysis of the code, but without any context about
>> the problem, I do not understand what I am looking at.
>>
> 
> The problem is that pi_connect() can sleep because it calls
> parport_claim_or_block(). And any access (even reading ATA status register)
> requires pi_connect.

OK. Let me have a look.

-- 
Damien Le Moal
Western Digital Research

