Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBE5ED9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiI1KGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiI1KFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:05:50 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 03:05:45 PDT
Received: from esa1.hc353-39.eu.iphmx.com (esa1.hc353-39.eu.iphmx.com [207.54.70.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52FB5166
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sequans.com; i=@sequans.com; l=2276; q=dns/txt;
  s=corp; t=1664359545; x=1695895545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bpdRzLVCWWYk4BBy803hxX2xqiCJilbJdeh5X6y/oLg=;
  b=iMjIfhnbp7iC01sPDfu5bCsFoaQEbs2jPhx3eEsAStDfaGkwkWpVVq4v
   wjQQHqhsMoF9yuuq27e8sATvwEfWUdAmN1ElbSgBnkMVS2xXFTk2DiYrS
   PUUrEOonRDh4TTtxMRWtU9k/oAxKPiGcl+ISG2t1ijti+R7ZZNVpco6ff
   o=;
X-IPAS-Result: =?us-ascii?q?A2GrAABkGzRjf5bSIB9aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4lMkReEJ5cWg1ILAQEBAQEBAQEBCUIEhQcChG0nOBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBAQUBAQEBAQEGAgEBAQECEAEBPEqFL0aCNSkBg20BAQEDI?=
 =?us-ascii?q?xVBEAsYAgIfBwICVwYBDAgBAXCCCYMhoGsBixqBMoEBiB2BZYERLIwBhChDg?=
 =?us-ascii?q?UlEgTyDAz6IGoJmBJk5JgQOAxkrHUECAQtyAxUDFAMFJAcDGQ8jDQ0EFgcMA?=
 =?us-ascii?q?wMFJQMCAhsHAgIDAgYTBQICTTYIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGB?=
 =?us-ascii?q?AQEBBUCEAgCCCYXBxMYGxkBBVkQCSEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKg?=
 =?us-ascii?q?QwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJ?=
 =?us-ascii?q?jwHWDsEAwIQIj0GAwkDAiJadQI3ExUFAw0ZJggFIxcdBAg8AgUGVxMCChIDE?=
 =?us-ascii?q?w8GLpsKBiBcVqRxn0ODZ6AjBhMug3aSfQgwkVotlmAgoWGFODCBPzmBf00jg?=
 =?us-ascii?q?zhQGQ+OV44bgS4CBgsBAQMJiBGCNwEB?=
IronPort-PHdr: A9a23:h7aePhedNtgcCcseSSmCoJAQlGM+MNnLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWSG96Hu7ke0KL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNbQhEnjSwbLxxI
 Rm5swncuNQdjJd/JKo21hbHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2U
 bJXDDI9M2Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VDK/5
 KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94RWGhPUdtLVyFZAY2yY
 YQAAOQcM+hGsYT9qVsAohmiCgejH+7v1j1Fi2Xq0aEm3eksEwfL1xEgEdIUt3TUqc34O6gIX
 uCx0qbIyynDb/JQ2Tzg7YbIdQohru+KXb1rdcrRyFUvHB7Cg1WOqozlOCmV2foLs2eA6+pgV
 P6vhnU8qw5vuziv290jio/Sho4P1l/E8iB5zZ8zKNalR0F1fcSqH4FMtyGGKYR2WMUiTnlnt
 ion17EKpZq2cTYKxpko2hPSaeCKf5SH7x/sV+ucPSp0iXZldr+/hhu+71Wsx+3/W8Wq01tHs
 ypIn9fCuH0J0RHY98uJSuNl80qvxDqDzQ7e5v9eLUwqiKbXN4QtzqMwm5YPt0nIAzX4l1/sj
 KCMc0Up4u2o6+P6bbr4vpKcLIp0ih3mMqQph8y/Hfw0MggQUGif/uSxzLzi/Uz8QLpRlP05i
 LPVsIvEKsQCu662GQlV0p055xmjCDem1cwUnXgBLF1bZBKKl4bkN0zULP32E/uzmUqgnCp3y
 /zcI7HsAonBImDGkLj7fLZ970BcyBA0zdBa/59UFLIBIPXpWkDvstzXFRs5Mw2ow+v8E9Vyy
 JoeWX+VDa+fK6Peq0OH5uUqI+WUYo8aoy7yK+I56P72kX85hVgdcLGo0JcPcnC3AuxmI1mFY
 XrrmtoOC30KvgwjQ+HxklKCSzhTaGupUK4m+z40FpqqDZ3fSYC1nLyBwCC7E4VTZmBHE1CMD
 Gnnd4GeV/cWci2TIslhnSYAVbW6UIAh0hautBP+y7pmKOrY4DEXtZXm1NRt/e3ciQky9SBoD
 8Say2yNS2J0nnsTSj832qB/vVJyylOZ3adkhPxYEMRf5+lVXQciKZ7c0+t6BsjxWg3aY9eJS
 VKmTci/DT4rStIxx8QDY0J8G9W5khDDxDCmD6MIm7CRA5w06K3c02DrJ8lh03bGyLUhj14+T
 8tLMW2mmKt/+hPXB47IiEWZi72qeb4Y3C7M8meD0GWPsFtFXwFuT6XJRWofaVfOrdTl+kPCS
 KejCbAmMgtH1M6DJbJGat73glVcQvfsJtDebnmvm2e/GxmI3KmAbIn0dGUH2iXSFkwEnxoU/
 XacOghtThum9kvECjAmP1/1bEbl9+82/HqhSEMcxhuMY0cn27fjvlYwhOWBRvdb5LsVvi4l4
 2FxHU+g0taQEdORoQNlVK9bZs854VEB3mXc4V9TJJulep5rglMYbwVx92DpzRhxAIFBjYB+s
 nAt1gd0I6aZzHtaeiqF1JbrfLbQLz+hr1iUd6fK1wSGg56t8aAV5aF98g271Dw=
IronPort-Data: A9a23:7EKNHqhh763KIxWLi7Mvm26gX1615hAKZh0ujC45NGQN5FlHY01je
 htvXmqBP/jfNDejKItwaty3oBsGv8DQnd5hTAo4ri9gQnsW8JqUDtmwEB7MMnLJJKUvbq7GA
 +Y2OoKQfJ5sHhcwgj/3b9ANeFEljfngqpzUVracYkidYic7FHx+4f5bs7dlxNQu2bBVOivV0
 fvqucrTJVS57DB9N2MQ+sqrpQhm+f//o1v0hHRnDRxwlAKYxiJ94K43f/nrdSOpGNkMR4ZWe
 s6apF2H1jKBl/sSIo79+lrLWhViaqLfOwGIlk1XV8CK6vSVjnVvukqTHKN0hXZ/011lrfgoo
 Dl+ncXYpTMSA0H5sL11vy9wTX4nZf0WpuOvzU+X6KR/x2WeG5fl668+XBluVWES0r8f7Wpmr
 JT0JBhSNEjb7w4fLX3SpuRE36wewMfX0Iw3gCxn5i+EV/0acb/7frX32tJAzDozr5UbdRreT
 5JxhTtHfhXFaQdGfEwaEY83mvzujX76G9FagAnM4/FtpTKKlEoojeCF3Nn9I7RmQe1LnUGCq
 2TM+2XlKgoXLcGWzyHD+XWp7gPKtX+nCNxKSePQGvhCggTN1GgtEzYqaVaSq6e5lkKRd8JmJ
 BlBksYphfJorRbwJjXnZDWxuniIlhcGXdZaVeE3gCmIy7PJ7gLfHGEVSDdFQNYhs9MyRDps3
 ViM9/vtBiRHsbuJRHbb/bCRxRuxMzUUKWNHbCsAZQ8E+MX45tlqyBXVQb5LFKqri/XxGCrs2
 HaOrS4jl/MfgNBj/6G6+03XxjGhvJ7ESiYr6QjNGGGo9AV0YMiifYPA1LTAxeRBKYyDRx+as
 WEZks6FqusJCPlhiRBhXs03QbaC+avfOwHsrmZSD6Qe+iy99n2KKNU4DC5FGKt5DioVUWa3P
 hOI4lsOvcA70GiCMf8nMt/tYyg+5fK6SIu5PhzBRoMWCqWdYjNr6wlAXyZ8NUjGl1U2m6whP
 paWGSpHJSdAVfw/pNZab0z71bJuyi1763naQ5v2pylLMIZyh1bMGN/pyHPUMogEAFqs+W05C
 ep3OcqQ0Al4W+bjeCTR+oN7BQlUcyRgXcuq8JYHJr/rzu9a9IcJVq65LVQJJdQNokipvr6Rl
 p1AchAAmQGi3SGvxfuiMyo5OOiHsWlDQYITZ3Z1Zw3AN4kLa4Gy/agCeoB/YbQj+edkyJZJo
 wotJa297gB0Ym2eo1wggWzV9tMKmOKD2V3TZEJIoVEXI/ZdeuA+0oW8JVO1pXFXUHbfWAlXi
 +TI6z43iKErH2xKZPs6otr2p79tlRDxQN5PYnY=
IronPort-HdrOrdr: A9a23:ac9xlal+j2k33CAVVCVNDy9AJdHpDfIR3DAbv31ZSRFFG/FwWf
 re+MjzpiWE6gr5P0tQ4uxoWZPwOU80mqQa3WB8B8bFYOCighrQEGgA1+rfKl/bdBEWn9Q1vc
 wMH5SWSueAamSS5vyKgzVQfexQpeVvvJrJuQ4A9R1QcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="4486056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-Virus-Scanned: amavisd-new at sequans.com
Message-ID: <a20dc3ff-58e3-2fe2-f531-a2f55db35d4d@sequans.com>
Date:   Wed, 28 Sep 2022 12:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209210641.MziHAbW7-lkp@intel.com>
 <20220921104002.226ff3f6@xps-13>
 <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
 <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
 <20220921164720.6bbc56d5@xps-13>
 <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
 <20220921183807.241e2518@xps-13>
 <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
 <6b5a2b19-39c6-5116-60c2-d292ae2e7bae@sequans.com>
 <20220922113613.4d7273c8@xps-13>
 <01210adb-ff77-4ec5-8d10-ab56ae986d58@www.fastmail.com>
 <da19f271-6ad6-7158-2ebe-e54fa5c91f6b@sequans.com>
 <e0a3bc54-a1be-4e10-afcb-bee1888c4066@www.fastmail.com>
 <6fe0fecc-0636-67be-c5c9-ebd5aacc3f0e@sequans.com>
 <16c470b0-0a69-4182-9676-2367a7fd831d@www.fastmail.com>
From:   Valentin Korenblit <vkorenblit@sequans.com>
In-Reply-To: <16c470b0-0a69-4182-9676-2367a7fd831d@www.fastmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDkvMjgvMjIgMTA6NTYsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gT24gV2VkLCBTZXAgMjgs
IDIwMjIsIGF0IDEwOjQxIEFNLCBWYWxlbnRpbiBLb3JlbmJsaXQgd3JvdGU6Cj4+IE9uIDkvMjcv
MjIgMjI6MDIsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+PiBPbiBUdWUsIFNlcCAyNywgMjAyMiwg
YXQgNDo1NiBQTSwgVmFsZW50aW4gS29yZW5ibGl0IHdyb3RlOgo+Pj4+Pj4gQnV0IGluIHRoZSBt
ZWFuIHRpbWUgSSBhbSBvbmx5IGhhbGYgc2F0aXNmaWVkLCBiZWNhdXNlIHdlIHBsYW4gdG8gZG8K
Pj4+Pj4+IHR3aWNlIG1vcmUgYWNjZXNzZXMgdGhhbiBuZWVkZWQgX2p1c3RfIGJlY2F1c2Ugb2Yg
YSB0aGUgQ09NUElMRV9URVNUCj4+Pj4+PiBjb25zdHJhaW50Lgo+Pj4gSXQncyBhbHNvIHBvc3Np
YmxlIHlvdSBoYXZlIHRvIHJlYWQgZnJvbSB0aGUgc2Vjb25kIHdvcmQgZmlyc3QsCj4+PiBsaWtl
Cj4+Pgo+Pj4gICAgIHUzMiAqYnVmOwo+Pj4gICAgIGRvIHsKPj4+ICAgICAgICBidWZbMV0gPSBf
X3Jhd19yZWFkbChyZWcgKyA0KTsKPj4+ICAgICAgICBidWZbMF0gPSBfX3Jhd19yZWFkbChyZWcp
Owo+Pj4gICAgICAgIGJ1ZiArPSAyOwo+Pj4gICAgIH0gIHdoaWxlIChidWYgPCBlbmQpOwo+PiBT
YW1lIHJlc3VsdCB3aXRoIHBhaXJzIG9mIHJlYWRsIGF0IE9GRjAgYW5kIHdoZW4gcmVhZGluZyBh
dCBPRkYxIGZpcnN0IHRvbywKPj4gSSBzdGlsbCBzZWUgc2RtYV9lcnIuIEkndmUganVzdCBvcGVu
ZWQgYSBjYXNlIHRvIENhZGVuY2UgdG8gc2VlIGlmIHRoZXJlCj4+IGlzIGFueSB3b3JrYXJvdW5k
IGZvciB0aGlzIG9yIGlmIGl0IGlzIGp1c3Qgbm90IHBvc3NpYmxlLgo+IEkgdGhpbmsgdGhpcyBq
dXN0IG1lYW5zIHRoYXQgdGhlIGFjY2VzcyBoYXMgdG8gYmUgZG9uZSB3aXRoIHRoZSBleGFjdAo+
IHdpZHRoIHRoYXQgaXMgY29uZmlndXJlZCwgYW5kIHlvdSBjYW5ub3QgaW1wbGVtZW50IHRoZSBh
Y2Nlc3Mgb24KPiAzMi1iaXQgYXJjaGl0ZWN0dXJlcy4gVGhlIG9ubHkgcG9zc2liaWxpdHkgaXMg
dGhhdCB5b3UgY2FuIHJlY29uZmlndXJlCj4gdGhlIG5hbmQgY29udHJvbGxlciB0byAzMi1iaXQg
bW9kZSBhdCBydW50aW1lLCB3aGljaCBpcyB3aGF0IENhZGVuY2UKPiBzaG91bGQgYmUgYWJsZSB0
byB0ZWxsIHlvdS4KPgo+ICAgICAgQXJuZAoKSSd2ZSBqdXN0IGNvbmZpcm1lZCB0aGF0IHdlIGNh
bm5vdCBjaGFuZ2Ugc2RtYSB3aWR0aCBpbiBydW50aW1lIGFuZAp0aGF0IHNkbWEgZXhwZWN0cyB0
byBiZSBhZGRyZXNzZWQgaW4gYnVyc3Qgd2lkdGgsIHdoaWNoIGlzIHRoZSBidXMKd2lkdGggKDY0
LWJpdCkuCgpWYWxlbnRpbgoKLS0gSU1QT1JUQU5UIE5PVElDRToKCgoKVGhlIGNvbnRlbnRzIG9m
IHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkg
YWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9z
ZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9z
ZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4KCgoKVGhh
bmsgeW91Lgo=

