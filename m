Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2AF736503
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFTHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjFTHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4C1732;
        Tue, 20 Jun 2023 00:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1CD61052;
        Tue, 20 Jun 2023 07:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0EBC433C0;
        Tue, 20 Jun 2023 07:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687246974;
        bh=YerGYPsch1T+BfxemUSZ9eeDg0EC2FKopbOQRfVYmiA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ptm3hpM75VrbDf6TydCCqWsG923n8D/S+lLLWuFaWrbuq8WD6amZWLZCTezmA81A0
         kmNYvnPpLhvJH+Kw0J8CWCpYBWT0lX1/QLKx3mHpEZk3LgirHlcjAKOOo6tPa8nSKS
         i6NH7rdHzRqmOcfdf4622aLSFZr3klIfmyShbm++yqnhRbTu9HjiGqxFgwYY51Oqje
         ZfOTxlcAqzRsBRNpRYSSAY5A6SaXjNG03IMVwDj5bMLK6yMFHtaFFPH/8FO9u+YgR5
         TdAKtZNHuSp9/AdqFk8q7IC1ApaJx9B0zwCUo6aegPzS5HkzO2lq+K06V4MhIktvKm
         NtxpZvS3Qpw1A==
Message-ID: <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
Date:   Tue, 20 Jun 2023 16:42:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [linux-next:master] [scsi] eca2040972: ltp.ioprio_set03.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it
References: <202306192248.1ece4c29-oliver.sang@intel.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <202306192248.1ece4c29-oliver.sang@intel.com>
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

On 6/20/23 14:58, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.ioprio_set03.fail" on:

LTP maintainers,

Patches have been submitted to fix this issue. Were these patches applied ?

Kernel test robot maintainers,

Once the LTP patches are applied, you will need to update LTP.

> 
> commit: eca2040972b411ec27483bf75dc8b84e730e88ff ("scsi: block: ioprio: Clean up interface definition")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master f7efed9f38f886edb450041b82a6f15d663c98f8]
> [test failed on fix commit 01584c1e233740519d0e11aa20daa323d26bf598]
> 
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230520
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-05
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202306192248.1ece4c29-oliver.sang@intel.com
> 
> 
> 
> <<<test_start>>>
> tag=ioprio_set03 stime=1687153195
> cmdline="ioprio_set03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> ioprio_set03.c:39: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
> ioprio_set03.c:47: TINFO: tested illegal priority with class NONE
> ioprio_set03.c:50: TPASS: returned correct error for wrong prio: EINVAL (22)
> 
> Summary:
> passed   1
> failed   1
> broken   0
> skipped  0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=3
> <<<test_end>>>
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

