Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5D639C13
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK0Rge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Nov 2022 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiK0Rgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:36:31 -0500
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCCAEE30;
        Sun, 27 Nov 2022 09:36:29 -0800 (PST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D33C5462DF8;
        Sun, 27 Nov 2022 18:36:27 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id BB2FC462CB0;
        Sun, 27 Nov 2022 18:36:27 +0100 (CET)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Sun, 27 Nov 2022 18:36:27 +0100 (CET)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Sun, 27 Nov
 2022 18:36:24 +0100
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Sun, 27 Nov 2022 18:36:24 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: remove non-data R1B ioctl workaround
Thread-Topic: [PATCH] mmc: block: remove non-data R1B ioctl workaround
Thread-Index: Adj/YjUrXkzlUmHATlmcTHF+6XwQXwCb623AACGjReA=
Date:   Sun, 27 Nov 2022 17:36:24 +0000
Message-ID: <2c146e342ac5417db29645f5980ad16c@hyperstone.com>
References: <dd632a86fb924b019d1a009b17eb3cbc@hyperstone.com>
 <DM6PR04MB6575FEC365167C7347D7FF2FFC119@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575FEC365167C7347D7FF2FFC119@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.27]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27290.001
X-TMASE-Result: 10--8.090300-10.000000
X-TMASE-MatchedRID: yxAmdCLMIs3UL3YCMmnG4szWN98iBBeGEeq+exnvf0iv23Txl75Bv9lM
        ASzPGs9URexsVN65tZCKoSP1b8EZpENEncOGEu4x8eSmTJSmEv2vMPxisLn2/Mbl1d1BOPY4pie
        YwslGH4n8PxvmZ7ST0W+OJmpydfpy7J0gbMX+46wqy6shOlK/4zqu3dM+YhFRmbc4hVJ/g/nBZq
        EdJyZjPcAqhyRxrdojEB5v/PN0c+1DpQmw35j1chqkhv3OdF4DNi8L88UV9IBnyL8x0tKlOy1sQ
        GcqD7UtTEt5x8T2C8tgLOoGbJe9AgqU4tmmg3HIG9TMqjxt7zG061diBteN17cIt210bWgIKpi9
        XFTnNcAi+t+0AiFaYvL3NxFKQpq1ZmXf4kSR87cdZEkR8Y/meRgff28UuvITPQ0VhRgDvgujxYy
        RBa/qJSw7AP50bcPJp5scLHMFXhPdB/CxWTRRu/558CedkGIvzP4Frv6e/e5jXsvdQtthxnDciE
        lFVgI6cZL3O8zo/IEhHYnbRdSCKn7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 4e17c365-270e-49a1-8f08-d9679fb049c1-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Avri Altman <Avri.Altman@wdc.com> 
Sent: Samstag, 26. November 2022 21:18
To: Christian Löhle <CLoehle@hyperstone.com>; adrian.hunter@intel.com; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: RE: [PATCH] mmc: block: remove non-data R1B ioctl workaround

>> The workaround of pretending R1B non-data transfers are data transfers 
>> in order for the busy timeout to be respected by the host controller 
>> driver is removed. It wasn't useful in a long time.
>> 
>> Initially the workaround ensured that R1B commands did not time out by 
>> setting the data timeout to be the command timeout in commit 
>> cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl").
>> This was moved inside of an if clause with idata->buf_bytes being set 
>> in commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
>> This patch intends to fix the issuing of R1B data command CMD24.
> CMD24 response is R1?

Yes my bad, that was a relic of my userspace program to poll for busy.
In that case see below.

>
>> Its data timeout was being overwritten with 0 because cmd_timeout 
>> wasn't set at the point the workaround applied, but data_timeout was.
>> But since the workaround was now inside of the idata->buf_bytes clause 
>> and intended to fix R1B non-data transfers that do not have buf_bytes 
>> set we can also remove the workaround altogether.
> I find the above explanation a bit confusing.
> Maybe just explain in 1 or 2 sentences why this workaround is no longer needed?

My explanation could have been clearer if I understood why the original author chose
this way. Maybe some host controller drivers did not call mmc_request_done until
busy is no longer asserted if MMC_RSP_BUSY was set?
Maybe also the workaround was never necessary at all (my guess).
Why I think it can be removed:
The workaround has been moved inside of the if (idata->buf_bytes) clause and is for R1B
type command responses.
There are no commands with R1B responses that invoke data transfer in either direction.
The workaround is just dead code since commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
I will fix the commit message up a bit.

>
> Thanks,
> Avri
>
>> 
>> Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>> ---
>>  drivers/mmc/core/block.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index 
>> db6d8a099910..20da7ed43e6d 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -514,19 +514,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card 
>> *card, struct mmc_blk_data *md,
>>                 if (idata->ic.data_timeout_ns)
>>                         data.timeout_ns = idata->ic.data_timeout_ns;
>> 
>> -               if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>> -                       /*
>> -                        * Pretend this is a data transfer and rely on the
>> -                        * host driver to compute timeout.  When all host
>> -                        * drivers support cmd.cmd_timeout for R1B, this
>> -                        * can be changed to:
>> -                        *
>> -                        *     mrq.data = NULL;
>> -                        *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
>> -                        */
>> -                       data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
>> -               }
>> -
>>                 mrq.data = &data;
>>         }
>> 
>> --
>> 2.37.3
>> 
>> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
>> Dr. Jan Peter Berns.
>> Commercial register of local courts: Freiburg HRB381782
>
>
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

