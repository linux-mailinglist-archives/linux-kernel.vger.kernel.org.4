Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891245EC78A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiI0PXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiI0PW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:22:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE748160E60
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:22:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nb11so21440744ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=erSV/LQniRo494ECVW4U1bCw7qSOzHbBVNjiw4aEUwM=;
        b=Tp660BAjo3G+BsL/ugjmeq1Rct7qvWoZz8hDMb9aW0yo0LV225kCt7w84VPk0RS1Ml
         0pZIfCPqC7Xjm69W/p1iuJOqCLHLc7FfaOz1jFoYQrex9wgHKoLXee7kQeoTECqRfjcj
         IdXihVu6JOTBHCQQfHZojyC+iC22+I3ROEBNO3X/rIdEw1juqcRNR93OvcXRsMsbSEcb
         tkWWkB5G/VPfF7x20pjCF29ZuqmclJCXlK5njoXIdOUqiBQY5GGDp4+hSoZHMWrSIUFV
         0HqiiF6MJP0ICcdbFwqDZx63dAXxzV4Hx0uDsqBPGjtJ5+RoeV+HbL1AejyaDP2U3+42
         jJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=erSV/LQniRo494ECVW4U1bCw7qSOzHbBVNjiw4aEUwM=;
        b=xEb0NbJpRzdsMYvapHUhVUHggHA7PPu6DQqQqQUaefpq4Rth8plKhb5aqV83MEhl4w
         FQFTrtTcw6muXPp+xJQKgsLIkQicEUPmaCRl9n1xM8RZfC2Lv++W+vcOPJHHxlCEMEWQ
         DEvJ6fYt1mEY3Rq+zXAtt4mofpdk5ecYvMwcyUjqvhRoILEW5rgn2tAhVhGsM7Yt2etz
         izc/IEP7gYNRIF321BtNpIhgcCYulpyypVueES+TOQSOSQzDqDdOYRbdax56PBF9uW20
         HxWkETP44ZNEozlHxyGWLJxBUhawc6kcCT9mO7vmRrQRR9y+oSQeAMKItLNvGPPPCuSm
         pHXA==
X-Gm-Message-State: ACrzQf0f6fwwhM8/Dr/2dJ8JmS5PI+9ilDWPSjRisJJCjlGx6l6oDk+7
        8dVJk6zvUgXiiv6muswvfLqSbkj5LTU=
X-Google-Smtp-Source: AMsMyM6ORwEPx17ooVtnAkD8sUM9hP3viynQDYDPUEMwUEn+64CkCaKPHB1Kn62qQ+5ltV+3woym6Q==
X-Received: by 2002:a17:907:2c75:b0:77c:2b6a:6b63 with SMTP id ib21-20020a1709072c7500b0077c2b6a6b63mr23937278ejc.702.1664292169261;
        Tue, 27 Sep 2022 08:22:49 -0700 (PDT)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b007417041fb2bsm913340ejh.116.2022.09.27.08.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:22:48 -0700 (PDT)
Message-ID: <6c75a90d-3793-55fc-e525-eca14e562350@gmail.com>
Date:   Tue, 27 Sep 2022 17:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [dm-devel] [PATCH] kernfs: fix a crash when two processes delete
 the same directory
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Christoph Lameter <cl@linux.com>
References: <alpine.LRH.2.02.2209260418360.16612@file01.intranet.prod.int.rdu2.redhat.com>
 <YzGYFBv0pdt+DQg+@kroah.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <YzGYFBv0pdt+DQg+@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 14:16, Greg Kroah-Hartman wrote:
> On Mon, Sep 26, 2022 at 07:04:52AM -0400, Mikulas Patocka wrote:
>> There is a crash when running the cryptsetup testsuite on Fedora Rawhide.
>> It can be reproduced by installing Rawhide with the 6.0-rc6 kernel,
>> downloading and compiling the cryptsetup repository and running this test
>> in a loop for about 15 minuts:
>> 	while ./integrity-compat-test; do :; done
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 0 PID: 50087 at fs/kernfs/dir.c:504 __kernfs_remove.part.0+0x26f/0x2b0
>>   Modules linked in: crc32_generic loop dm_integrity async_xor async_tx tls isofs uinput snd_seq_dummy snd_hrtimer nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_intel iTCO_wdt snd_intel_dspcfg intel_pmc_bxt snd_intel_sdw_acpi iTCO_vendor_support snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device joydev snd_pcm i2c_i801 snd_timer pcspkr i2c_smbus virtio_balloon snd lpc_ich soundcore zram virtio_net net_failover virtio_blk serio_raw failover qxl virtio_console drm_ttm_helper ttm ip6_tables ip_tables fuse qemu_fw_cfg
>>   Unloaded tainted modules: crc32_pclmul():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>>   CPU: 0 PID: 50087 Comm: integritysetup Not tainted 6.0.0-0.rc6.41.fc38.x86_64 #1
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
>>   RIP: 0010:__kernfs_remove.part.0+0x26f/0x2b0

...

> Can you see if 4abc99652812 ("kernfs: fix use-after-free in
> __kernfs_remove") in linux-next fixes this for you or not?  It seems to
> be the same issue, as was also reported at:
> 	https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp


I tried it on system where cryptsetup testsuite almost immediately crashed in the integrity test.

With the patch in https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp
it now iterates for some time without any problems, so I think it is fixed.

Tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan
