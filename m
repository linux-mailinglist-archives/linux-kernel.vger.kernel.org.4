Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74277619E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKDRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiKDRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:21:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D94199C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:20:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so8803963pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OczEUwDaDCJagzs0QtMr8aHYN/ko8ymZX7lVummJVOs=;
        b=uAw80S9vBEJp3aHojoMEpA/68sS1rwm2/DWeE+ULXnA6VihFLM1tIcWa71PfRN9kBY
         0Dv2ncNI3cIHP1goXyeXZom0/uBfoDaO30ASdZEL4aGfHRhvJUIMCG8nrQlvfooqmoJO
         hUAuGLtFkFgLnDesYbOIb/h2RG1W4Vfgffao9TGfEveZhdIZofkxgjiB9PJaysiRvxez
         qh27EMHRn8B9dhv5bFV0Gj3bOcrEvWTaLB9Ua8Lz3QnnrjBVMODvXVdUSprTVXviQ9hj
         D+qpWlXKArSY4d+JaCwNiIRypZgFLSZR3fDUcNuaeyz///hny0BZ0cHpkYlDAwWb4Z7k
         HJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OczEUwDaDCJagzs0QtMr8aHYN/ko8ymZX7lVummJVOs=;
        b=GoDvtRYmHpcUPKX6/ZiPl7ISr/UjAaF20/xID+J96AVL73kcTuqn48mctI0HDJ8MuL
         rDW/rTOXdbFo1l9V3WQHeF+B15hJ0KptW3nRW8eh9wt7lfZD9/zeTfouqFZNYY24ByLA
         6/x0bpiEUstI1AO40Y8upmOTU7QsjA5Rcr1BwC4Sf2ih1lps2MB73sx2YrvwOy2WHBIk
         OIO3aFWAgiYsoLnmkse2pvoo83K8fbqOhUn1OVt58hWdlmozt6xV9AH8Te/9m5AK6t0l
         iChWSMyAlxDjbijVDLx/E87Yp303HwaNc/1M4MGrL8l32mhPgvi2WvtC/bIirSf8zZJ1
         eDxg==
X-Gm-Message-State: ACrzQf06paqAvFdg8igA3WXjLSL92S8TlKR4m2UHICiN4ZgzIxM5ISds
        1uSk1KnhrKgrBMfPcLyBiBJjpA==
X-Google-Smtp-Source: AMsMyM7qXmb1tKLbXoG2RN7MYH+OBDKZmahcKO3ZgUlIGFzbY77VBHGSlWccWa4sVOHz9dNTYKbNgg==
X-Received: by 2002:a17:90a:6045:b0:212:fe9a:5792 with SMTP id h5-20020a17090a604500b00212fe9a5792mr53370678pjm.178.1667582458816;
        Fri, 04 Nov 2022 10:20:58 -0700 (PDT)
Received: from [10.255.167.72] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b0056e0ff577edsm2990000pfj.43.2022.11.04.10.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:20:58 -0700 (PDT)
Message-ID: <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
Date:   Sat, 5 Nov 2022 01:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of status clearing
 api
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
Content-Language: en-US
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
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

Hi Bjorn, a gentle reminder.

Thanks and regards.

On 9/28/22 6:59 PM, Zhuo Chen wrote:
> Hello.
> 
> Here comes patch v3, which contains some fixes and optimizations of
> aer api usage. The v1 and v2 can be found on the mailing list.
> 
> v3:
> - Modifications to comments proposed by Sathyanarayanan. Remove
>    pci_aer_clear_nonfatal_status() call in NTB and improve commit log.
> 
> v2:
> - Modifications to comments proposed by Bjorn. Split patch into more
>    obvious parts.
> 
> Zhuo Chen (9):
>    PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>    PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>      uncorrectable error status
>    NTB: Remove pci_aer_clear_nonfatal_status() call
>    scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>    PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>    PCI/AER: Move check inside pcie_clear_device_status().
>    PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>    PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>    PCI/AER: Refine status clearing process with api
> 
>   drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>   drivers/pci/pci.c               |  7 +++--
>   drivers/pci/pci.h               |  2 ++
>   drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>   drivers/pci/pcie/dpc.c          |  3 +--
>   drivers/pci/pcie/err.c          | 15 ++++-------
>   drivers/pci/pcie/portdrv_core.c |  3 +--
>   drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>   include/linux/aer.h             |  4 +--
>   9 files changed, 44 insertions(+), 41 deletions(-)
> 

-- 
Zhuo Chen
