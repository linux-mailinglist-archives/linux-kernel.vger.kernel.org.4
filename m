Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A715F82C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 05:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJHDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJHDWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 23:22:50 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E330100BD1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 20:22:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665199360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBW+bvnL5i50BkAPUWYpIsJVocJvNtR4CUdFoCZ1wWk=;
        b=CCw0xblUcmAxhmwNRPRPUFnH1N6nhjzVu1qDJJItMHls1BuBOOe7QtuMk20yb2ZhowvGOQ
        cb09F49jeOL26wM5y8LEUEke2OKl1HE3yPsojBskC18AeY3oMbU3zBJPs9OZZvJYtCfHxY
        1P/UmZNUVNfa28wPTdjzMIi6pk9oAZU=
MIME-Version: 1.0
Subject: Re: [linux-next:master 12548/12775] mm/hugetlb.c:6835:6: sparse:
 sparse: symbol '__hugetlb_vma_unlock_write_put' was not declared. Should it
 be static?
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Y0DfbjPdpdECTHUT@monkey>
Date:   Sat, 8 Oct 2022 11:22:35 +0800
Cc:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09F76B11-5440-485C-82F2-C12A140C021D@linux.dev>
References: <202210080448.1cB176kW-lkp@intel.com> <Y0DfbjPdpdECTHUT@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2022, at 10:24, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 10/08/22 05:00, kernel test robot wrote:
>> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git =
master
>> head:   082fce125e57cff60687181c97f3a8ee620c38f5
>> commit: 95b61bfed8291e54f65e1fc836c5f9b49f74068c [12548/12775] =
hugetlb: take hugetlb vma_lock when clearing vma_lock->vma pointer
>> config: x86_64-randconfig-s022
>> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>> reproduce:
>>        # apt-get install sparse
>>        # sparse version: v0.6.4-39-gce1a6720-dirty
>>        # =
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3D95b61bfed8291e54f65e1fc836c5f9b49f74068c
>>        git remote add linux-next =
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>        git fetch --no-tags linux-next master
>>        git checkout 95b61bfed8291e54f65e1fc836c5f9b49f74068c
>>        # save the config file
>>        mkdir build_dir && cp config build_dir/.config
>>        make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' =
O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>>=20
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>=20
>> sparse warnings: (new ones prefixed by >>)
>>>> mm/hugetlb.c:6835:6: sparse: sparse: symbol =
'__hugetlb_vma_unlock_write_put' was not declared. Should it be static?
>>   mm/hugetlb.c:459:12: sparse: sparse: context imbalance in =
'allocate_file_region_entries' - wrong count at exit
>>   mm/hugetlb.c:530:13: sparse: sparse: context imbalance in =
'region_add' - wrong count at exit
>>   mm/hugetlb.c:597:13: sparse: sparse: context imbalance in =
'region_chg' - wrong count at exit
>>   mm/hugetlb.c: note: in included file:
>>   include/linux/mm.h:1282:17: sparse: sparse: context imbalance in =
'demote_free_huge_page' - unexpected unlock
>>   mm/hugetlb.c:4969:20: sparse: sparse: context imbalance in =
'move_huge_pte' - different lock contexts for basic block
>>   mm/hugetlb.c:5340:17: sparse: sparse: context imbalance in =
'hugetlb_wp' - unexpected unlock
>>   mm/hugetlb.c:6221:25: sparse: sparse: context imbalance in =
'follow_hugetlb_page' - different lock contexts for basic block
>=20
> Apologies for missing this in the previous fix!
>=20
> =46rom cabb47237ecc48fceba767eee90f9b311876b329 Mon Sep 17 00:00:00 =
2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 7 Oct 2022 19:15:08 -0700
> Subject: [PATCH] hugetlb: fix sparse warning for
> __hugetlb_vma_unlock_write_put
>=20
> Declare __hugetlb_vma_unlock_write_put as static.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

