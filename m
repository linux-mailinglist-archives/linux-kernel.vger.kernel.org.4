Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259E6C2925
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCUE2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUE2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:28:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E632358D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:28:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t15so12351138wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679372895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sToM1jB8CHkGYs4Sbd9Gz4DhbErAxDcSGYRiBMmdYJo=;
        b=HTogfaIeWYUjE+kVmP5jfchryq3dgoR1u573YLIAL/1N5+2JyrRhe/4LWJZLjvYqtA
         EkojXvXAxSC7Pi+vINMkcMMUXGSu27GvKEddrr0Th/26a+LErT4gdw94YOdaRezTRbmX
         NqdjvXQPlG0ZAN/2vWs5jCChsWFEFSQ/LdGstsMpGzmpAgDyznDjjNo68uG6bjpO2VCs
         WVLKmQjNjWtn/DatBwKLEycURExmd+sq+n141V+8xte8RgK3VzfdGI5peeedHq5c2kd2
         ZbzoJG99QDCHWKHkYzyuXbZsdb2iqkFpGVWrDFGByBH/ARNLA/4R1NSAvU7DwBJgR7LR
         8sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679372895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sToM1jB8CHkGYs4Sbd9Gz4DhbErAxDcSGYRiBMmdYJo=;
        b=D4DpXR03Vj2W3oDBLcxIqkZJgpbRVv5hX7K59CMjr1d4LDDA9tkzQdVyc83ollTLtq
         Gvo69SnIBhhf3OhagIAQcwf3Cva8NpmaoSLyuUFK0ufuU3OP3ho1tkGu/GR7mYDatg0k
         a2JT6Xz7+YwyzXC2x9bQ3hikAJYh5R5trcMERqb1rPMWx0qENJcCTF3pult96bKdcxdR
         PRvY4Z9w5668mv90XvNUEVBHM9h5/F3dxKvNE0H/vvzo6SWQsvxX4XM/mInSH+GjQlSq
         Gb19Xy4ifDwawqj/ozSbK9qADVWVzW0co87PLrRTfiI3XoM036+aPRhhgoYyCaSEIShV
         5DDg==
X-Gm-Message-State: AO0yUKXCffkiY2c9TXYGL5iHQsRFjp1Gouv9eP+9hSsNrULvjRYFyKb5
        alK8jptZ+uSqEnJk/kmrgGHGEYnMFes=
X-Google-Smtp-Source: AK7set/dnBOSjQ4cyGbtLpEdG1EpMqIYEjB2vM62REuhEEKDaOP/eLFMqHnotbjBZknUFyTQLt0kIw==
X-Received: by 2002:a5d:660e:0:b0:2d7:82ee:c9ce with SMTP id n14-20020a5d660e000000b002d782eec9cemr1219740wru.20.1679372894627;
        Mon, 20 Mar 2023 21:28:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5307000000b002c5a1bd5280sm10243809wrv.95.2023.03.20.21.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 21:28:13 -0700 (PDT)
Date:   Tue, 21 Mar 2023 07:28:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Atish Patra <atishp@rivosinc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: arch/riscv/kvm/vcpu_pmu.c:40 kvm_riscv_vcpu_pmu_ctr_info() error:
 buffer overflow 'kvpmu->pmc' 64 <= 64
Message-ID: <85162d82-9ca6-4912-99d3-01583f843fa9@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17214b70a159c6547df9ae204a6275d983146f6b
commit: 8f0153ecd3bf184bc06afca25b737c707fa4d765 RISC-V: KVM: Add skeleton support for perf
config: riscv-randconfig-m031-20230319 (https://download.01.org/0day-ci/archive/20230321/202303210940.XYeKyGru-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303210940.XYeKyGru-lkp@intel.com/

smatch warnings:
arch/riscv/kvm/vcpu_pmu.c:40 kvm_riscv_vcpu_pmu_ctr_info() error: buffer overflow 'kvpmu->pmc' 64 <= 64

vim +40 arch/riscv/kvm/vcpu_pmu.c

8f0153ecd3bf184 Atish Patra 2023-02-07  30  int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu, unsigned long cidx,
8f0153ecd3bf184 Atish Patra 2023-02-07  31  				struct kvm_vcpu_sbi_return *retdata)
8f0153ecd3bf184 Atish Patra 2023-02-07  32  {
8f0153ecd3bf184 Atish Patra 2023-02-07  33  	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
8f0153ecd3bf184 Atish Patra 2023-02-07  34  
8f0153ecd3bf184 Atish Patra 2023-02-07  35  	if (cidx > RISCV_KVM_MAX_COUNTERS || cidx == 1) {

Probably change > to >= RISCV_KVM_MAX_COUNTERS.  It's strange that 1 is
invalid.  I would have expected 0 to be invalid.  (I have not looked at
the context outside this email).

8f0153ecd3bf184 Atish Patra 2023-02-07  36  		retdata->err_val = SBI_ERR_INVALID_PARAM;
8f0153ecd3bf184 Atish Patra 2023-02-07  37  		return 0;
8f0153ecd3bf184 Atish Patra 2023-02-07  38  	}
8f0153ecd3bf184 Atish Patra 2023-02-07  39  
8f0153ecd3bf184 Atish Patra 2023-02-07 @40  	retdata->out_val = kvpmu->pmc[cidx].cinfo.value;
                                                                   ^^^^^^^^^^^^^^^^^

8f0153ecd3bf184 Atish Patra 2023-02-07  41  
8f0153ecd3bf184 Atish Patra 2023-02-07  42  	return 0;
8f0153ecd3bf184 Atish Patra 2023-02-07  43  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

