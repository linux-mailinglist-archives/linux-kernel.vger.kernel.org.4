Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5E70D007
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjEWBEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEWBEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:04:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0261988
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:03:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34N12o8x006305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 21:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684803773; bh=Ah3rCU/IRQBeh9qf9Arxw5ClPLOS9Y0efGYc+L0edGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=mhqfgMiWpjaTpIrY3ClRYjUwWUJBSRW5wJu9dnj51gZfg2Dllmp9SxIyNDmMZ10i4
         HZzBsENdLvolT+jBzJAIGUSC0r/CmDT0jzAU9wafIk6gXtjv/sQKXTnXpsap+GOAns
         Nmizt+GFkK+I+AIL5byXG1TIBq92iIuTY25w8C0QM36Cd8XyKm3bRjK5My+0VnG2Q8
         e5ByZ1O057Zk/d9xWNezyf50xQl+gMbyTso4NtfDrVIFhtT89Kj+rvaPz0t7J6WP2+
         ltkPAZBTdMtCSBCVS533xZqiJ7PaklecvkSdrBpfWUGZlD//KTAU8yRdDsEIvlHR6j
         nZEVdqy/cL62g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A0F0415C052B; Mon, 22 May 2023 21:02:50 -0400 (EDT)
Date:   Mon, 22 May 2023 21:02:50 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
Message-ID: <20230523010250.GF230989@mit.edu>
References: <20230522190354.935300867@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:07:04PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Theodore Ts'o <tytso@mit.edu>

No regressions found for ext4.

					- Ted

TESTRUNID: ltm-20230522174100
KERNEL:    kernel 5.15.113-rc1-xfstests-00204-g30213a86a6fe #25 SMP Mon May 22 17:36:06 EDT 2023 x86_64
CMDLINE:   full --kernel gs://gce-xfstests/kernel.deb
CPUS:      2
MEM:       7680

ext4/4k: 530 tests, 2 failures, 34 skipped, 5650 seconds
  Flaky: generic/051: 20% (1/5)   generic/475: 60% (3/5)
ext4/1k: 526 tests, 1 failures, 47 skipped, 5750 seconds
  Flaky: generic/476: 60% (3/5)
ext4/ext3: 522 tests, 2 failures, 123 skipped, 4479 seconds
  Failures: generic/347
  Flaky: generic/645: 20% (1/5)
ext4/encrypt: 508 tests, 3 failures, 141 skipped, 2958 seconds
  Failures: generic/681 generic/682 generic/691
ext4/nojournal: 525 tests, 3 failures, 102 skipped, 4256 seconds
  Failures: ext4/301 ext4/304 generic/455
ext4/ext3conv: 527 tests, 1 failures, 35 skipped, 5196 seconds
  Failures: generic/347
ext4/adv: 527 tests, 5 failures, 42 skipped, 5192 seconds
  Failures: generic/475 generic/477 generic/526 generic/527
  Flaky: generic/051: 20% (1/5)
ext4/dioread_nolock: 528 tests, 2 failures, 34 skipped, 4128 seconds
  Flaky: generic/475: 60% (3/5)   generic/581: 60% (3/5)
ext4/data_journal: 526 tests, 3 failures, 102 skipped, 4278 seconds
  Failures: generic/231 generic/347 generic/455
ext4/bigalloc_4k: 502 tests, 39 skipped, 4372 seconds
ext4/bigalloc_1k: 502 tests, 1 failures, 57 skipped, 4458 seconds
  Failures: shared/298
ext4/dax: 517 tests, 137 skipped, 2396 seconds
Totals: 6332 tests, 893 skipped, 95 failures, 0 errors, 52817s

FSTESTIMG: gce-xfstests/xfstests-amd64-202303031351
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 676d42c (Thu, 2 Mar 2023 15:25:44 +0900)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5-6-g5d6f7c4 (Mon, 30 Jan 2023 23:22:45 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-53-gd90b7d5 (Tue, 6 Dec 2022 12:59:03 +0100)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v6.1.1 (Fri, 13 Jan 2023 19:06:37 +0100)
FSTESTVER: xfstests-bld 2e60cef3 (Thu, 23 Feb 2023 15:02:58 -0500)
FSTESTVER: xfstests v2023.02.26-8-g821ef4889 (Thu, 2 Mar 2023 10:23:51 -0500)
FSTESTVER: zz_build-distro bullseye
FSTESTSET: -g auto
FSTESTOPT: aex
