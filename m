Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9308F5ED818
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiI1IqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiI1Ipw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:45:52 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 01:42:25 PDT
Received: from esa2.hc353-39.eu.iphmx.com (esa2.hc353-39.eu.iphmx.com [207.54.65.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC2A4B05
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sequans.com; i=@sequans.com; l=2304; q=dns/txt;
  s=corp; t=1664354545; x=1695890545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BaGpCouI2Zg3U8TxOU8YO86WONUKYp5oF76Zucu7pR0=;
  b=Ba9B6T9dT+vVnaZG/Q5j+uW9nLkYTfKd8JFnXXxp5fKetmGLwH7bGVHw
   KhTj/0Fb3CtlGPpztFmoc8HEysCzPrdLTcfsXYbWegm/61YLve4zdqaX8
   dBHpq/+AQRSPSHCBZzyzx1Q2GdEgb9m2T6Ta52uaxruSS9SFPX72DW0dc
   c=;
X-IPAS-Result: =?us-ascii?q?A2GtAABLBzRjf5bSIB9aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4lMkG4mA4QnlxaDUgsBAQEBAQEBAQEJQgSFBwKEbSc4EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEBBQEBAQEBAQYCAQEBAQIQAQE8SoUvRoI1KQGDbQEBA?=
 =?us-ascii?q?QMjFUEQCxgCAh8HAgJXBgEMCAEBFoJjgyGgZgGLGoEygQGIHYFlgREsjAGEK?=
 =?us-ascii?q?EOBSUSBPAyCdz6IGoJmBJk5JgQOAxkrHUECAQtyAxUDFAMFJAcDGQ8jDQ0EF?=
 =?us-ascii?q?gcMAwMFJQMCAhsHAgIDAgYTBQICTTYIBAgEKyQPBQIHLwUELwIeBAUGEQgCF?=
 =?us-ascii?q?gIGBAQEBBUCEAgCCCYXBxMYGxkBBVkQCSEcCgQaDQUGEwMgbwUKOg8oMWsrH?=
 =?us-ascii?q?RsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhH?=
 =?us-ascii?q?wcoJjwHWDsEAwIQIj0GAwkDAiJadQI3ExUFAw0ZJggFIxcdBAg8AgUGVxMCC?=
 =?us-ascii?q?hIDEw8GLpsKCHpWbn1koiKfQoNkoCIGEy6DdpJ9CDCRWS2WXiChYYU4MIE/O?=
 =?us-ascii?q?YF/TSODOFAZD45XjhuBLgIGCwEBAwmKMwEB?=
IronPort-PHdr: A9a23:5Cq5excAVsln/Li3YDkJjclBlGM+MNnLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWSG96Hu7kc1qL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNbQhEnjSwbLxxI
 Rm5sQncttQdjJd/JKo21hbHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2U
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
IronPort-Data: A9a23:HzDia6+oRykea7PXzbrUDrUDBn6TJUtcMsCJ2f8bNWPcYEJGY0x3x
 mAeUWmDOPjeYTH3fI0ib9+3904GvZ6AxtZnSgpv/3sxFiIbosfsO42lIxarNUt+DCFioGFPv
 55OOoeYfKjYaleG+39B55C49SEUOYegGOKkUIYoHQguGVQ7IMsZoUs/3bR/2uaEuPDhayuVo
 9T+vsbDD1Gs3j9wIwo85rmK7Rhip5weghtB1rAFTa0N7QS2e0U9VspFf/ngdSugG+G4I8bjL
 wr95ODhlo/m10p1Yj+Vuu6TWlEHRLfUIT+PhhJ+M0R1qkEfzsCa+v9T2Ms0MS+7uR3Q9zxC4
 IwlWaiLdOscFvSkdNI1DUYBS3EuY/EuFIjveBBTueTLp6HPWyG8k602ZK08FdRwFu1fWAmi+
 dRHcmhVBvwqai3fLL+TE4FRasofwMbDFcQPsHtKkxTlAs16br7DWbqX/P1T5WJl7ixONa62i
 8sxeztqZg7JJQZCI0oeDol4l+Ct7pX9W2YB7gnP4/Buuy6KkVQZPLvFabI5fvSURsJPk0CSo
 mPa13/0GwwTMsfZwj2Amp6prrOWwH+nBth6+LuQ0u80ux6hzXQpDiIbeViFncaXqlPgYocKQ
 6AT0nB09PJpnKCxdfH0RRu0iHeeuBIWHdZde8U/6RiQx66S+Q+IAGEAZjRGb8AitclwTjsvv
 neNnMvBBDpzvbnTQnWYnp+Xpy6zPSRQJGsGTSsFVhcepYG65oYpgXrnStJ9FYaxj8bpAnf0w
 jaXvG4yiqt7pcoK0biruFPKmTShorDXQQMvoAbaRGSo6kV+foHNWmCzwUra6PxaJcCCQ0Cct
 X4f3cOZ6YjiEK1higSkB/UHFpv3wsqKC2Hzr151AMQ41T+UrivLkZ9r3N1uGKt4Gp9aJ2OyO
 xeM4Fw5CIx7YCv6PPIrC26lI55wkPe8fTjwfqmMBueidKSdYyepxkmCj2a72H33mkUylqAyU
 XtwWZf2US5CYUiL5JFQQ+pY3bJu6Do3w2jeLa0XLihLMpLHNRZ5sZ9fbDOzghkRtctoWjn9/
 ddFLNetwB5CSuD4aSS/2ddNcwxRdSNnXsqm+50/mgu/zuxORTBJ5xj5n+tJRmCZt/0M/gs11
 i7lCxQFkAaXaYPvcF/QOisLhEzTsWZX9yhiZ3dE0aeA0X8+cImy4bxXa5YzcLIg8YReIQ1cE
 ZE4lzG7Kq0WElz6F8E1N8aVQHpKKEv23mpj/kONPFACQnKXb1eXo4+0LlO2qHlm4+jenZJWn
 oBMHzjzGfIrLzmOxu6PAB5z5ztdZUQgpd8=
IronPort-HdrOrdr: A9a23:S1s8IKDyc//apurlHemR55DYdb4zR+YMi2TDGXoBLSC9Afbo9f
 xG+85rriMc6QxhIE3I9urvBEDtewK7yXcx2/hpAV7AZmjbUQmTQ72KhLGKq1aMdxEWtNQtsp
 uIGJIOa+EYY2IK6PoSrDPZLz/++rO6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="4154462"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-Virus-Scanned: amavisd-new at sequans.com
Message-ID: <6fe0fecc-0636-67be-c5c9-ebd5aacc3f0e@sequans.com>
Date:   Wed, 28 Sep 2022 10:41:08 +0200
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
From:   Valentin Korenblit <vkorenblit@sequans.com>
In-Reply-To: <e0a3bc54-a1be-4e10-afcb-bee1888c4066@www.fastmail.com>
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

Ck9uIDkvMjcvMjIgMjI6MDIsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gT24gVHVlLCBTZXAgMjcs
IDIwMjIsIGF0IDQ6NTYgUE0sIFZhbGVudGluIEtvcmVuYmxpdCB3cm90ZToKPj4+PiBCdXQgaW4g
dGhlIG1lYW4gdGltZSBJIGFtIG9ubHkgaGFsZiBzYXRpc2ZpZWQsIGJlY2F1c2Ugd2UgcGxhbiB0
byBkbwo+Pj4+IHR3aWNlIG1vcmUgYWNjZXNzZXMgdGhhbiBuZWVkZWQgX2p1c3RfIGJlY2F1c2Ug
b2YgYSB0aGUgQ09NUElMRV9URVNUCj4+Pj4gY29uc3RyYWludC4KPj4+IEluIG15IGV4YW1wbGUs
IEkgaGFkIGFuICNpZmRlZiBzbyBpdCB3b3VsZCBvbmx5IGZhbGwgYmFjawo+Pj4gdG8gMzItYml0
IGFjY2Vzc2VzIG9uIHRoZSA2NC1iaXQgcmVnaXN0ZXIgd2hlbiBydW5uaW5nIGFuCj4+PiBhY3R1
YWwgMzItYml0IGtlcm5lbCwgYnV0IGxlYXZpbmcgdGhlIDY0LWJpdCBjYXNlIGVmZmljaWVudC4g
U29ycnkgZm9yIG15IGxhdGUgcmVwbHkuIEkndmUganVzdCB0ZXN0ZWQgdGhpcyBhbmQgdW5mb3J0
dW5hdGVseQo+PiB0aGUgdHdvIHNlcXVlbnRpYWwgMzItYml0IGFjY2Vzc2VzICh3aXRoIE9GRjA9
PTAgYW5kIE9GRjE9PTQgc2VlbQo+PiB0byB0cmlnZ2VyIHNkbWFfZXJyLiBJIG5lZWQgdG8gY2hl
Y2sgc29tZSB3YXZlZm9ybXMgdG8gdmVyaWZ5IGlmIGl0Cj4+IGhhcHBlbnMgcmlnaHQgYWZ0ZXIg
dGhlIGZpcnN0IGFjY2Vzcy4KPiBXaGF0IGhhcHBlbnMgaWYgeW91IGRvIHBhaXJzIG9mIHJlYWQg
ZnJvbSBvZmZzZXQgMCwgZWZmZWN0aXZlbHkKPiBkb2luZyBhIHJlYWRzbCgpIGluc3RlYWQgb2Yg
cmVhZHFsKCksIG9idmlvdXNseSB3aXRoIHR3aWNlIHRoZSBudW1iZXIKPiBvZiBhY2Nlc3Nlcy4K
Pgo+IEl0J3MgYWxzbyBwb3NzaWJsZSB5b3UgaGF2ZSB0byByZWFkIGZyb20gdGhlIHNlY29uZCB3
b3JkIGZpcnN0LAo+IGxpa2UKPgo+ICAgIHUzMiAqYnVmOwo+ICAgIGRvIHsKPiAgICAgICBidWZb
MV0gPSBfX3Jhd19yZWFkbChyZWcgKyA0KTsKPiAgICAgICBidWZbMF0gPSBfX3Jhd19yZWFkbChy
ZWcpOwo+ICAgICAgIGJ1ZiArPSAyOwo+ICAgIH0gIHdoaWxlIChidWYgPCBlbmQpOwo+Cj4gICAg
IEFybmQKClNhbWUgcmVzdWx0IHdpdGggcGFpcnMgb2YgcmVhZGwgYXQgT0ZGMCBhbmQgd2hlbiBy
ZWFkaW5nIGF0IE9GRjEgZmlyc3QgdG9vLApJIHN0aWxsIHNlZSBzZG1hX2Vyci4gSSd2ZSBqdXN0
IG9wZW5lZCBhIGNhc2UgdG8gQ2FkZW5jZSB0byBzZWUgaWYgdGhlcmUKaXMgYW55IHdvcmthcm91
bmQgZm9yIHRoaXMgb3IgaWYgaXQgaXMganVzdCBub3QgcG9zc2libGUuCgpJJ2xsIGJlIGJhY2sg
YXMgc29vbiBhcyBJIGhhdmUgc29tZSBuZXdzLgoKVmFsZW50aW4KCi0tIElNUE9SVEFOVCBOT1RJ
Q0U6CgoKClRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24s
IHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9u
IGluIGFueSBtZWRpdW0uCgoKClRoYW5rIHlvdS4K

