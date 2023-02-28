Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9D6A62CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjB1WtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjB1WtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:49:16 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D919135255
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677624550; x=1709160550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vy8BS1FuQ/PhAs7eaiMqD6ABWjKT7b+2fZNPoZ13nRU=;
  b=SgSYfGrKLeiyVMBJNEdLwDsGOP+tPjVRo9Va/QOp8FWTsj5pbFQdlRzj
   dqfxWbQstw/Rykkdf/uBx5YifE4mfiBUuCEyVlncZtU84C69a2VoECYvL
   a2NOBacuCEllFjgV84SsBF4PJgh/sav5fsRlr+lXFFfoz2v/n7h8PvSjR
   PXYNDDnILkALaLSHuAXGx2zvOHI2weGhrzY+5+Zhbgh48O86C4wT6qXPU
   257Z1OoInmKtZikPXhA0o3gzHLZMItoYpv5DJtXHOv72TvipYGQwXTuta
   8z0fzgvt8+yQx8jS35JmGvK8i0W0hKROg7dh+kT/Kd69EN4td3glyJ5Eb
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,223,1673884800"; 
   d="scan'208";a="224470108"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 06:49:09 +0800
IronPort-SDR: EK6lzJ7oPYIdhuTQLQ960XwrV6alckdYezmvdXMO3Fpaap/Okb5OkNmsjhnUztt6OeLCLc6psZ
 ymMYrRjpS/wtvrMTVNa4XkTu36j7fKNP6qv/slX43idwX8p24wjJVVmUgCVZsQ9uGBdaegwQ8q
 1Xyv2n8pwYQYqLKMvLmw//zGn9Q6nMIkTETTDy63KNF8dPixl4uM3L6PaCtogRm374kkw1mEG7
 yZLQrTvLT1z9F5dU4Spfn4esJL/YM3kJkV8QooNSEMfWE4Db/5N5WZBsdWCZmHpU+OSZuJRBZK
 At8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 14:00:15 -0800
IronPort-SDR: NsEDAFCd4ZSTj3Wj+EakJfW6g54gNTbZ7pUBC5kxqH3zsNJ6NbOmgzPfKBcdfVyIMsirPrBM1n
 qYthxSzZ30XnZr3HB/mLtMQA/NWnxM75f0eIv59/YRTZLjZDw/4Dm8lqMEKc86Ji7ZSNPo2Omp
 b8KE+p5Ce7dooEk5e14OIPxjHRRFm2+6iHrejhx/4jNE4h+GSakB5Gfh87OBTMMpLaivbCVOD8
 WMov4zT6Y+bf6TtJbnNv0jhLPeiub89dEbRA7X8DBFq1o5ioFa38dJ9i+f4B/r/XEzMTGwZs6W
 /Bo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 14:49:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRCGX6sWPz1RvTr
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:49:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677624548; x=1680216549; bh=Vy8BS1FuQ/PhAs7eaiMqD6ABWjKT7b+2fZN
        PoZ13nRU=; b=nNSuDRehF9NyWIUnmI4m07iYXddB/xgLe80TA1tPm62D0oXt4RJ
        us8sBSemat7k5pviO1lhW+duKe9Zedu3bh03ySY3v+0Zxu2ivUdFWahT55NcbpzT
        zKbn3NPYI6vX2h4bMk0pzlbjPFuRkyq+c6osZzHOSg8xoMvUhnDStQxsJsl5afLZ
        CcbRd+fOiTTj+onBmRcCkCcLBrLDWmbcMIIpSJ3XGWvJZA5bySbuavDPXCGDffkY
        VTTSceKu2ks0Ul0gLNSCpHaMZck1WXtVnjeZVnPqxsGpAyk3r80WjwEOZ38l+ZW7
        3ZU1GEOZDzdd3lM6SsYwWPl4ASsc/4zhF2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r4Dzdz9zLvFe for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 14:49:08 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRCGW1cbgz1RvLy;
        Tue, 28 Feb 2023 14:49:07 -0800 (PST)
Message-ID: <3719a4f0-1a5a-4661-a6d7-5d4f67d7b7e8@opensource.wdc.com>
Date:   Wed, 1 Mar 2023 07:49:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, gerg@kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 06:52, Palmer Dabbelt wrote:
> On Tue, 28 Feb 2023 05:51:24 PST (-0800), gerg@kernel.org wrote:
>> The following changes add the ability to run ELF format binaries when
>> running RISC-V in nommu mode. That support is actually part of the
>> ELF-FDPIC loader, so these changes are all about making that work on
>> RISC-V.
>>
>> The first issue to deal with is making the ELF-FDPIC loader capable of
>> handling 64-bit ELF files. As coded right now it only supports 32-bit
>> ELF files.
>>
>> Secondly some changes are required to enable and compile the ELF-FDPIC
>> loader on RISC-V and to pass the ELF-FDPIC mapping addresses through to
>> user space when execing the new program.
>>
>> These changes have not been used to run actual ELF-FDPIC binaries.
>> It is used to load and run normal ELF - compiled -pie format. Though the
>> underlying changes are expected to work with full ELF-FDPIC binaries if
>> or when that is supported on RISC-V in gcc.
>>
>> To avoid needing changes to the C-library (tested with uClibc-ng
>> currently) there is a simple runtime dynamic loader (interpreter)
>> available to do the final relocations, https://github.com/gregungerer/uldso.
>> The nice thing about doing it this way is that the same program
>> binary can also be loaded with the usual ELF loader in MMU linux.
>>
>> The motivation here is to provide an easy to use alternative to the
>> flat format binaries normally used for RISC-V nommu based systems.
>>
>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>> ---
>>
>>  arch/riscv/include/asm/elf.h         |   11 +++++++++-
>>  arch/riscv/include/asm/mmu.h         |    4 +++
>>  arch/riscv/include/uapi/asm/ptrace.h |    5 ++++
>>  fs/Kconfig.binfmt                    |    2 -
>>  fs/binfmt_elf_fdpic.c                |   38 +++++++++++++++++------------------
>>  include/linux/elf-fdpic.h            |   14 +++++++++++-
>>  include/uapi/linux/elf-fdpic.h       |   15 +++++++++++++
>>  7 files changed, 67 insertions(+), 22 deletions(-)
> 
> Adding Damien, as IIRC he's had some hacked up userspace bits for the 
> K210.  I'm yet to get anything running, but it'd be great if we get this 
> to a point where I can actually boot test this on QEMU (I'm just doing 
> builds now).

+Niklas

Niklas, didn't you add a nommu qemu build for buildroot ? Can't find the config
though...

> 
> Given that it's the second week of the merge window and this is a bunch 
> of new uABI it seems best to hold off until the next cycle.  I poked 
> around and don't see anything wrong, but I'll try and take a more 
> detailed look after the merge window.

Does any riscv compiler support nommu fdpic now ? When doing the work on the
k210, there was no support at all, hence the statically linked user binaries
used (no shared text for libraries).


-- 
Damien Le Moal
Western Digital Research

