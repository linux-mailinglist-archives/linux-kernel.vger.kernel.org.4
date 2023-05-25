Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF1C710556
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjEYFhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEYFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:37:01 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F6A1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:36:54 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="96634625"
X-IronPort-AV: E=Sophos;i="6.00,190,1681138800"; 
   d="scan'208";a="96634625"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 14:36:51 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B2222D29E5
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:36:49 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com [192.51.207.11])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E0089BF4BA
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:36:48 +0900 (JST)
Received: from [192.168.122.212] (unknown [10.167.226.45])
        by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6CB792FC685A;
        Thu, 25 May 2023 14:36:47 +0900 (JST)
Subject: Re: [RFC PATCH v2 0/3] pmem memmap dump support
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>, bhe@redhat.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
 <774fd596-5481-aeff-aace-8785158728ea@fujitsu.com>
 <0fe0d69e-e33b-cf45-c957-68a8159d29ab@fujitsu.com>
Message-ID: <f8aff5b7-4892-9ccb-8079-abd87e9ab8b0@fujitsu.com>
Date:   Thu, 25 May 2023 13:36:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <0fe0d69e-e33b-cf45-c957-68a8159d29ab@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27648.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27648.005
X-TMASE-Result: 10--36.427300-10.000000
X-TMASE-MatchedRID: YmTIeYLGqWmPvrMjLFD6eCkMR2LAnMRpThn37FFP5A2Z6U7QhkqRnjig
        xUJufWBq8GZ6UXtd/D8knOGoeIQzlrLPlm4wh/ZC71L6f9O5B+bHbztUafrIJrwxqSK0GSPRJf5
        otvavOZdfShUER1/uQrIR2fkfALoSk3+L/4zTFEMF7cpFXK76Tb/I3arxTrviHpyu/FxYOKH6NX
        Oh/Q26I55+Yz1Sdwy4b6fm/8CuE09LyNFBdZE0R6zGfgakLdjanY+2FiS7N53PWp1UK7zV94X8M
        Gul6j45WeYbg0RZpl1DTrJAgvBeWaUEDxO9eWwq93bduyx/IZzEOsCKZvLZAdVtkV1dqmwpFTcl
        NALNY0cWeucbks6Qtsano5bsVuqHb6wZx1ul0pwvz6alF1rVgye0Z6pse6+bhJsTo2dS2dm/BR6
        8O365bn9eOltIlLtrdthZ52U1v6XwR+yx9wo5ahFbgtHjUWLyUrr7Qc5WhKgQRik6+J7XSf9hZe
        ynbNVArY6OTSUV7oJEPm1gqq01NcZjWS+/cngMvR08UROkEAeok0CD5UnL64Ajsy+r+wvnLHCPR
        rZVF/euMZ3gmgaUtf+d8LoybRqLv9CQXR/hM+TfSQNpZkETVEhdBJqHdZ1jF7XImrociEcEgwlH
        ZNfFor3SKCxDfa5Nh/v5z8O9WopdfABN5LHDU7hXT+72mpTN1LV3ye5rrQEz91mDYZLM5XGk47q
        JAyS/XICzc9HFHLudqC2fLtk9xE1+zyfzlN7ygxsfzkNRlfJoFT3KzpHqEw6wQI72z4YedB0ntd
        9Tzp7iRhduhvElsvJT+hf62k2YIbZSWXZZ520=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

Baoquan, Dan

Sorry to bother you again.

Could you further comment a word or two on this set?


Thanks
Zhijian


on 5/10/2023 6:41 PM, Zhijian Li (Fujitsu) wrote:
> Hi Dan
>
>
> on 5/8/2023 5:45 PM, Zhijian Li (Fujitsu) wrote:
>> Dan,
>>
>>
>> On 29/04/2023 02:59, Dan Williams wrote:
>>> Li Zhijian wrote:
>>>> Hello folks,
>>>>
>>>> About 2 months ago, we posted our first RFC[3] and received your kindly feedback. Thank you :)
>>>> Now, I'm back with the code.
>>>>
>>>> Currently, this RFC has already implemented to supported case D*. And the case A&B is disabled
>>>> deliberately in makedumpfile. It includes changes in 3 source code as below:
>>> I think the reason this patchkit is difficult to follow is that it
>>> spends a lot of time describing a chosen solution, but not enough time
>>> describing the problem and the tradeoffs.
>>>
>>> For example why is updating /proc/vmcore with pmem metadata the chosen
>>> solution? Why not leave the kernel out of it and have makedumpfile
>>> tooling aware of how to parse persistent memory namespace info-blocks
>>> and retrieve that dump itself? This is what I proposed here:
>>>
>>> http://lore.kernel.org/r/641484f7ef780_a52e2940@dwillia2-mobl3.amr.corp.intel.com.notmuch
>> Sorry for the late reply. I'm just back from the vacation.
>> And sorry again for missing your previous *important* information in V1.
>>
>> Your proposal also sounds to me with less kernel changes, but more ndctl coupling with makedumpfile tools.
>> In my current understanding, it will includes following source changes.
> The kernel and makedumpfile has updated. It's still in a early stage, but in order to make sure I'm following your proposal.
> i want to share the changes with you early. Alternatively, you are able to refer to my github for the full details.
> https://github.com/zhijianli88/makedumpfile/commit/8ebfe38c015cfca0545cb3b1d7a6cc9a58fc9bb3
>
> If I'm going the wrong way, fee free to let me know :)
>
>
>> -----------+-------------------------------------------------------------------+
>> Source     |                      changes                                      |
>> -----------+-------------------------------------------------------------------+
>> I.         | 1. enter force_raw in kdump kernel automatically(avoid metadata being updated again)|
> kernel should adapt it so that the metadata of pmem will be updated again in the kdump kernel:
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index c60ec0b373c5..2e59be8b9c78 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -8,6 +8,7 @@
>    #include <linux/slab.h>
>    #include <linux/list.h>
>    #include <linux/nd.h>
> +#include <linux/crash_dump.h>
>    #include "nd-core.h"
>    #include "pmem.h"
>    #include "pfn.h"
> @@ -1504,6 +1505,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
>                           return ERR_PTR(-ENODEV);
>           }
>    
> +       if (is_kdump_kernel())
> +               ndns->force_raw = true;
>           return ndns;
>    }
>    EXPORT_SYMBOL(nvdimm_namespace_common_probe);
>
>> kernel     |                                                                   |
>>               | 2. mark the whole pmem's PT_LOAD for kexec_file_load(2) syscall   |
>> -----------+-------------------------------------------------------------------+
>> II. kexec- | 1. mark the whole pmem's PT_LOAD for kexe_load(2) syscall         |
>> tool       |                                                                   |
>> -----------+-------------------------------------------------------------------+
>> III.       | 1. parse the infoblock and calculate the boundaries of userdata and metadata   |
>> makedump-  | 2. skip pmem userdata region                                      |
>> file       | 3. exclude pmem metadata region if needed                         |
>> -----------+-------------------------------------------------------------------+
>>
>> I will try rewrite it with your proposal ASAP
> inspect_pmem_namespace() will walk the namespaces and the read its resource.start and infoblock. With this
> information, we can calculate the boundaries of userdata and metadata easily. But currently this changes are
> strongly coupling with the ndctl/pmem which looks a bit messy and ugly.
>
> ============makedumpfile=======
>
> diff --git a/Makefile b/Makefile
> index a289e41ef44d..4b4ded639cfd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -50,7 +50,7 @@ OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>    SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c
>    OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>    
> -LIBS = -ldw -lbz2 -ldl -lelf -lz
> +LIBS = -ldw -lbz2 -ldl -lelf -lz -lndctl
>    ifneq ($(LINKTYPE), dynamic)
>    LIBS := -static $(LIBS) -llzma
>    endif
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 98c3b8c7ced9..db68d05a29f9 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -27,6 +27,8 @@
>    #include <limits.h>
>    #include <assert.h>
>    #include <zlib.h>
> +#include <sys/types.h>
> +#include <ndctl/libndctl.h>
>
> +
> +#define INFOBLOCK_SZ (8192)
> +#define SZ_4K (4096)
> +#define PFN_SIG_LEN 16
> +
> +typedef uint64_t u64;
> +typedef int64_t s64;
> +typedef uint32_t u32;
> +typedef int32_t s32;
> +typedef uint16_t u16;
> +typedef int16_t s16;
> +typedef uint8_t u8;
> +typedef int8_t s8;
> +
> +typedef int64_t le64;
> +typedef int32_t le32;
> +typedef int16_t le16;
> +
> +struct pfn_sb {
> +       u8 signature[PFN_SIG_LEN];
> +       u8 uuid[16];
> +       u8 parent_uuid[16];
> +       le32 flags;
> +       le16 version_major;
> +       le16 version_minor;
> +       le64 dataoff; /* relative to namespace_base + start_pad */
> +       le64 npfns;
> +       le32 mode;
> +       /* minor-version-1 additions for section alignment */
> +       le32 start_pad;
> +       le32 end_trunc;
> +       /* minor-version-2 record the base alignment of the mapping */
> +       le32 align;
> +       /* minor-version-3 guarantee the padding and flags are zero */
> +       /* minor-version-4 record the page size and struct page size */
> +       le32 page_size;
> +       le16 page_struct_size;
> +       u8 padding[3994];
> +       le64 checksum;
> +};
> +
> +static int nd_read_infoblock_dataoff(struct ndctl_namespace *ndns)
> +{
> +       int fd, rc;
> +       char path[50];
> +       char buf[INFOBLOCK_SZ + 1];
> +       struct pfn_sb *pfn_sb = (struct pfn_sb *)(buf + SZ_4K);
> +
> +       sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
> +
> +       fd = open(path, O_RDONLY|O_EXCL);
> +       if (fd < 0)
> +               return -1;
> +
> +
> +       rc = read(fd, buf, INFOBLOCK_SZ);
> +       if (rc < INFOBLOCK_SZ) {
> +               return -1;
> +       }
> +
> +       return pfn_sb->dataoff;
> +}
> +
> +int inspect_pmem_namespace(void)
> +{
> +       struct ndctl_ctx *ctx;
> +       struct ndctl_bus *bus;
> +       int rc = -1;
> +
> +       fprintf(stderr, "\n\ninspect_pmem_namespace!!\n\n");
> +       rc = ndctl_new(&ctx);
> +       if (rc)
> +               return -1;
> +
> +       ndctl_bus_foreach(ctx, bus) {
> +               struct ndctl_region *region;
> +
> +               ndctl_region_foreach(bus, region) {
> +                       struct ndctl_namespace *ndns;
> +
> +                       ndctl_namespace_foreach(region, ndns) {
> +                               enum ndctl_namespace_mode mode;
> +                               long long start, end_metadata;
> +
> +                               mode = ndctl_namespace_get_mode(ndns);
> +                               /* kdump kernel should set force_raw, mode become *safe* */
> +                               if (mode == NDCTL_NS_MODE_SAFE) {
> +                                       fprintf(stderr, "Only raw can be dumpable\n");
> +                                       continue;
> +                               }
> +
> +                               start = ndctl_namespace_get_resource(ndns);
> +                               end_metadata = nd_read_infoblock_dataoff(ndns);
> +
> +                               /* metadata really starts from 2M alignment */
> +                               if (start != ULLONG_MAX && end_metadata > 2 * 1024 * 1024) // 2M
> +                                       pmem_add_next(start, end_metadata);
> +                       }
> +               }
> +       }
> +
> +       ndctl_unref(ctx);
> +       return 0;
> +}
> +
>
> Thanks
> Zhijian
>
>
>
>> Thanks again
>>
>> Thanks
>> Zhijian
>>
>>> ...but never got an answer, or I missed the answer.
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

