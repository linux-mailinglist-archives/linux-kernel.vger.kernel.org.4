Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86272B10D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjFKJG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:06:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA81BD;
        Sun, 11 Jun 2023 02:06:53 -0700 (PDT)
Received: from mars.fo.jb.local ([188.174.4.245]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis) id
 1MZSJa-1qcdQz3uqM-00WaA4; Sun, 11 Jun 2023 11:05:40 +0200
Received: from localhost (unknown [127.0.0.1])
        by mars.fo.jb.local (Postfix) with ESMTP id C763417F700;
        Sun, 11 Jun 2023 09:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at jmbreuer.net
Received: from mars.fo.jb.local ([127.0.0.1])
        by localhost (mars.jmbreuer.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8p5VEtgeCkTo; Sun, 11 Jun 2023 11:05:28 +0200 (CEST)
Received: from sol.fo.jb.local (sol.fo.jb.local [192.168.23.1])
        by mars.fo.jb.local (Postfix) with ESMTP id 209A117F413;
        Sun, 11 Jun 2023 11:05:28 +0200 (CEST)
Received: from [192.168.23.25] (mars.fo.jb.local [192.168.23.254])
        by sol.fo.jb.local (Postfix) with ESMTPSA id D8535604E111;
        Sun, 11 Jun 2023 11:05:27 +0200 (CEST)
Message-ID: <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
Date:   Sun, 11 Jun 2023 11:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
From:   Joe Breuer <linux-kernel@jmbreuer.net>
Organization: Joachim Breuer EDV
In-Reply-To: <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GuseqWr4gMONF06rsnM6AiOEXCkR/Cv44Upar/c5EOonR0Jf6Hq
 w86W4ACYVsGhV48P0yuUxXkClARNSuVZc+BaegKZ2vTmY1I8oeztd7KC1cpSSOo8OXMWres
 +LDD4DisXFNhpAJrA/DEybPUVbje5HkqNGXx/kekJvWCzwnas/Irpi9fwbL2SUeSJfcIgKf
 gViTPsz32HjQZNWeKbhpg==
UI-OutboundReport: notjunk:1;M01:P0:qcZsypbWK7s=;yakvpRY7qzxSMXRhppYJuzX0cLd
 DT7i1Jc9kBxkWkEMb20eplGhqWfn1pxPGwOVq/ygBAv7xqmTKjzb3dyEK6XbBRCJDUwJsIfE3
 pQW9vAstekoEZtPs9ys3guIZHaWQ2Ov02k1DfidPST6GbhYsZMdEe2CgZV5mbNCll7cvvbSLe
 qxA/+p3ZJ9LnRhr2+ven419CD6PZDYBDUaS8vr/KcFQF/Gd7ksig0RnaKVz8uTpVCJTG+GXIL
 U5CuF76mf0p3GbwCk9+JC57N5BWunyWsRx8jE6t0ZWvmgPMVXs2rq2ftmf5gZp19H+8LRXXpg
 xtIExACfDBAPMNCPVvy7bYKZhCZzj4OuuxVjMoKoIOp/hWGXQzd1nVxaSTZ++g59brCwBAR4T
 LQH5ruvgA94L+oao5AmLWwxNPa57YTo3bQceqKbiVeT9lFT9hWeYGRigc4iD7Yei4mzDYBgn8
 f1dhAhkuCiNDmQg0THzt+CElUikvBR9URlnVAcn7rn/3Te9ciirECiKFWE9Lp4khlHjzYTURp
 lZpkyFLHwtl6LBwXrfS7AoCSucbzXaNg3o2BcpdFP7W8sEvyCI/ltt1AOXWYcWU9cag6Ygefn
 4tP6KqTod+sOZKsZBzRU886X/Bm+nd/Y2lx6PxZE2d6xzzoBtcnamBrch+7Mif/TTtDX8MJmz
 x6rsHNmeDUVr/y1dKlsq/JledutLsIWtgmrX7TsanQ==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm the reporter of this issue.

I just tried this patch against 6.3.4, and it completely fixes my 
suspend/resume issue.

The optical drive stays usable after resume, even suspending/resuming 
during playback of CDDA content works flawlessly and playback resumes 
seamlessly after system resume.

So, from my perspective: Good one!


So long,
    Joe


On 10.06.23 17:03, Bart Van Assche wrote:
> On 6/10/23 06:27, Bagas Sanjaya wrote:
>> On 6/10/23 15:55, Pavel Machek wrote:
>>>>> #regzbot introduced: v5.0..v6.4-rc5 
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=217530
>>>>> #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
>>>>>
>>>> The reporter had found the culprit (via bisection), so:
>>>>
>>>> #regzbot introduced: a19a93e4c6a98c
>>> Maybe cc the authors of that commit?
>>
>> Ah! I forgot to do that! Thanks anyway.
> 
> Hi Damien,
> 
> Why does the ATA code call scsi_rescan_device() before system resume has
> finished? Would ATA devices still work with the patch below applied?
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 6a959c993dd8..be3971b7fd27 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1629,6 +1629,20 @@ void scsi_rescan_device(struct device *dev)
>   {
>       struct scsi_device *sdev = to_scsi_device(dev);
> 
> +#ifdef CONFIG_PM_SLEEP
> +    /*
> +     * The ATA subsystem may call scsi_rescan_device() before resuming has
> +     * finished. If this happens, prevent a deadlock on the device_lock()
> +     * call by skipping rescanning.
> +     */
> +    if (dev->power.is_suspended)
> +        return;
> +#endif
> +
> +    /*
> +     * Serialize scsi_driver.rescan() calls and 
> scsi_driver.gendrv.remove()
> +     * calls.
> +     */
>       device_lock(dev);
> 
>       scsi_attach_vpd(sdev);
> 

