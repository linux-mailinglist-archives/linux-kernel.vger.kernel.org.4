Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC0665D42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjAKOE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjAKOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:04:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1157DFEE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:04:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m21so22475580edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bby1XMmIVOMeE8dZt4UhpjM4Ztxie80HQBKnIBaFQFQ=;
        b=c0n9jirivLhbTDgR1r35ycXx8NWZLV0BzUWncMqkhegokjCLll3YHjK7kucJhpxTnl
         T+gw9HDg2HSTB9Wl/oklCEbRYDW8NaQqCntjfu8SnocuYRwM0ljjfKJg/FV075YpngiA
         V74TFSGqYKF+9ub2LD+gk2UKDPmX3wyF6WZMYVVvEfrjkqNiiQtEP6z4PVNALCxUV1K1
         svb0E2kRF1qYRl+Csmi2cfqdxPq6+fEO6qhCbi37MvHMdPSiBV/62q3ZJcFWDXV9p5nH
         PcXH5QbEOzTTQFVO2WoEUWRYR5Yo744qCfl6OYtoZ0c/kUT4UkCjn+bP5DvQV1ajWmx8
         UKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bby1XMmIVOMeE8dZt4UhpjM4Ztxie80HQBKnIBaFQFQ=;
        b=Bpe+fOabcuAt2hajFas3j4G5p9z2/xDhAt1w2ZhBvgV+U6aiaXtP9dHm1mKjJ1f4cR
         iwMaO/31B6K60elTsycXYDuP29y1H8jx7AyrBaaCuKyrXn9aKAjWE1XhnsCxaVhk17KL
         MS6SITYKRgzDo4ln0x0bfjAaXtwgIK5WHiU9ywqUQBAjQlu9Jv8l90qudt1StEQSGAqt
         EXd9HFjeiIDpGeBV3srEcvoB/0Ns1rAMuv0mKjp3xcWYoHJtYid1yPGOmJu2O7n81cEI
         zf8ru1TW9whQduuLwcYO5u9XCs78K/rZ/DZuZaYcyhfijSMru5a77dUjTlt2wT3/EzIg
         P0Vw==
X-Gm-Message-State: AFqh2kovJoulKNe2QsfdfXVSFhTrQ29QPfAAuqy0ij0PJxcqwmO0hnB/
        H2jMnDMRur2ORzbSBJfPVTB3XQ==
X-Google-Smtp-Source: AMrXdXvRh7X7ad5/WUxWZXCui7Sa4vvigvWj0hq2t2qqcEB31HpKuMi9Fv8jHsuVDZaSA7YIw1JChA==
X-Received: by 2002:aa7:d0c9:0:b0:498:d121:6e00 with SMTP id u9-20020aa7d0c9000000b00498d1216e00mr12838138edo.35.1673445859077;
        Wed, 11 Jan 2023 06:04:19 -0800 (PST)
Received: from ?IPV6:2003:c1:c70c:c600:2431:52f9:7c18:3205? (p200300c1c70cc600243152f97c183205.dip0.t-ipconnect.de. [2003:c1:c70c:c600:2431:52f9:7c18:3205])
        by smtp.gmail.com with ESMTPSA id z6-20020a50cd06000000b0046267f8150csm1695248edi.19.2023.01.11.06.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:04:18 -0800 (PST)
Message-ID: <9c990d23-1318-a178-01b6-6c1fbf8018dc@profian.com>
Date:   Wed, 11 Jan 2023 15:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH RFC v7 39/64] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_UPDATE
 command
To:     Tom Dohrmann <erbse.13@gmx.de>, Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        luto@kernel.org, dave.hansen@linux.intel.com, slp@redhat.com,
        pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, ashish.kalra@amd.com,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20221214194056.161492-1-michael.roth@amd.com>
 <20221214194056.161492-40-michael.roth@amd.com> <Y76/I6Nrh7xEAAwv@notebook>
Content-Language: en-US
From:   Harald Hoyer <harald@profian.com>
In-Reply-To: <Y76/I6Nrh7xEAAwv@notebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.01.23 um 14:56 schrieb Tom Dohrmann:
> On Wed, Dec 14, 2022 at 01:40:31PM -0600, Michael Roth wrote:
>> From: Brijesh Singh <brijesh.singh@amd.com>
>>
>> The KVM_SEV_SNP_LAUNCH_UPDATE command can be used to insert data into the
>> guest's memory. The data is encrypted with the cryptographic context
>> created with the KVM_SEV_SNP_LAUNCH_START.
>>
>> In addition to the inserting data, it can insert a two special pages
>> into the guests memory: the secrets page and the CPUID page.
>>
>> While terminating the guest, reclaim the guest pages added in the RMP
>> table. If the reclaim fails, then the page is no longer safe to be
>> released back to the system and leak them.
>>
>> For more information see the SEV-SNP specification.
>>
>> Co-developed-by: Michael Roth <michael.roth@amd.com>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   .../virt/kvm/x86/amd-memory-encryption.rst    |  29 ++++
>>   arch/x86/kvm/svm/sev.c                        | 161 ++++++++++++++++++
>>   include/uapi/linux/kvm.h                      |  19 +++
>>   3 files changed, 209 insertions(+)
>>
>> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> index 58971fc02a15..c94be8e6d657 100644
>> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> @@ -485,6 +485,35 @@ Returns: 0 on success, -negative on error
>>
>>   See the SEV-SNP specification for further detail on the launch input.
>>
>> +20. KVM_SNP_LAUNCH_UPDATE
>> +-------------------------
>> +
>> +The KVM_SNP_LAUNCH_UPDATE is used for encrypting a memory region. It also
>> +calculates a measurement of the memory contents. The measurement is a signature
>> +of the memory contents that can be sent to the guest owner as an attestation
>> +that the memory was encrypted correctly by the firmware.
>> +
>> +Parameters (in): struct  kvm_snp_launch_update
>> +
>> +Returns: 0 on success, -negative on error
>> +
>> +::
>> +
>> +        struct kvm_sev_snp_launch_update {
>> +                __u64 start_gfn;        /* Guest page number to start from. */
>> +                __u64 uaddr;            /* userspace address need to be encrypted */
>> +                __u32 len;              /* length of memory region */
>> +                __u8 imi_page;          /* 1 if memory is part of the IMI */
>> +                __u8 page_type;         /* page type */
>> +                __u8 vmpl3_perms;       /* VMPL3 permission mask */
>> +                __u8 vmpl2_perms;       /* VMPL2 permission mask */
>> +                __u8 vmpl1_perms;       /* VMPL1 permission mask */
>> +        };
>> +
>> +See the SEV-SNP spec for further details on how to build the VMPL permission
>> +mask and page type.
>> +
>> +
>>   References
>>   ==========
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 6d1d0e424f76..379e61a9226a 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -238,6 +238,37 @@ static void sev_decommission(unsigned int handle)
>>   	sev_guest_decommission(&decommission, NULL);
>>   }
>>
>> +static int snp_page_reclaim(u64 pfn)
>> +{
>> +	struct sev_data_snp_page_reclaim data = {0};
>> +	int err, rc;
>> +
>> +	data.paddr = __sme_set(pfn << PAGE_SHIFT);
>> +	rc = sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
>> +	if (rc) {
>> +		/*
>> +		 * If the reclaim failed, then page is no longer safe
>> +		 * to use.
>> +		 */
>> +		snp_mark_pages_offline(pfn,
>> +				       page_level_size(PG_LEVEL_4K) >> PAGE_SHIFT);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static int host_rmp_make_shared(u64 pfn, enum pg_level level, bool leak)
>> +{
>> +	int rc;
>> +
>> +	rc = rmp_make_shared(pfn, level);
>> +	if (rc && leak)
>> +		snp_mark_pages_offline(pfn,
>> +				       page_level_size(level) >> PAGE_SHIFT);
>> +
>> +	return rc;
>> +}
>> +
>>   static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
>>   {
>>   	struct sev_data_deactivate deactivate;
>> @@ -2085,6 +2116,133 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>   	return rc;
>>   }
>>
>> +static int snp_launch_update_gfn_handler(struct kvm *kvm,
>> +					 struct kvm_gfn_range *range,
>> +					 void *opaque)
>> +{
>> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +	struct kvm_memory_slot *memslot = range->slot;
>> +	struct sev_data_snp_launch_update data = {0};
>> +	struct kvm_sev_snp_launch_update params;
>> +	struct kvm_sev_cmd *argp = opaque;
>> +	int *error = &argp->error;
>> +	int i, n = 0, ret = 0;
>> +	unsigned long npages;
>> +	kvm_pfn_t *pfns;
>> +	gfn_t gfn;
>> +
>> +	if (!kvm_slot_can_be_private(memslot)) {
>> +		pr_err("SEV-SNP requires restricted memory.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params))) {
>> +		pr_err("Failed to copy user parameters for SEV-SNP launch.\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	data.gctx_paddr = __psp_pa(sev->snp_context);
>> +
>> +	npages = range->end - range->start;
>> +	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL_ACCOUNT);
>> +	if (!pfns)
>> +		return -ENOMEM;
>> +
>> +	pr_debug("%s: GFN range 0x%llx-0x%llx, type %d\n", __func__,
>> +		 range->start, range->end, params.page_type);
>> +
>> +	for (gfn = range->start, i = 0; gfn < range->end; gfn++, i++) {
>> +		int order, level;
>> +		void *kvaddr;
>> +
>> +		ret = kvm_restricted_mem_get_pfn(memslot, gfn, &pfns[i], &order);
>> +		if (ret)
>> +			goto e_release;
>> +
>> +		n++;
>> +		ret = snp_lookup_rmpentry((u64)pfns[i], &level);
>> +		if (ret) {
>> +			pr_err("Failed to ensure GFN 0x%llx is in initial shared state, ret: %d\n",
>> +			       gfn, ret);
>> +			return -EFAULT;
>> +		}
>> +
>> +		kvaddr = pfn_to_kaddr(pfns[i]);
>> +		if (!virt_addr_valid(kvaddr)) {
>> +			pr_err("Invalid HVA 0x%llx for GFN 0x%llx\n", (uint64_t)kvaddr, gfn);
>> +			ret = -EINVAL;
>> +			goto e_release;
>> +		}
>> +
>> +		ret = kvm_read_guest_page(kvm, gfn, kvaddr, 0, PAGE_SIZE);
>> +		if (ret) {
>> +			pr_err("Guest read failed, ret: 0x%x\n", ret);
>> +			goto e_release;
>> +		}
>> +
>> +		ret = rmp_make_private(pfns[i], gfn << PAGE_SHIFT, PG_LEVEL_4K,
>> +				       sev_get_asid(kvm), true);
>> +		if (ret) {
>> +			ret = -EFAULT;
>> +			goto e_release;
>> +		}
>> +
>> +		data.address = __sme_set(pfns[i] << PAGE_SHIFT);
>> +		data.page_size = X86_TO_RMP_PG_LEVEL(PG_LEVEL_4K);
>> +		data.page_type = params.page_type;
>> +		data.vmpl3_perms = params.vmpl3_perms;
>> +		data.vmpl2_perms = params.vmpl2_perms;
>> +		data.vmpl1_perms = params.vmpl1_perms;
>> +		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
>> +				      &data, error);
>> +		if (ret) {
>> +			pr_err("SEV-SNP launch update failed, ret: 0x%x, fw_error: 0x%x\n",
>> +			       ret, *error);
>> +			snp_page_reclaim(pfns[i]);
>> +			goto e_release;
> 
> When a launch update fails for a CPUID page with error `INVALID_PARAM` the
> firmware writes back corrected values. We should probably write these values
> back to userspace. Before UPM was introduced this happened automatically
> because we didn't copy the page to private memory and did the update
> completly in place.
> 

Yes, pretty please!

