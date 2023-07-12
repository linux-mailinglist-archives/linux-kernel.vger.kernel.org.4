Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD969750037
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGLHjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGLHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:39:04 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0B219BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:38:45 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3159adb7cb5so732897f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689147524; x=1691739524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oChKme24SZPOA92hTi9VYNZ4RCh0CFOD0OdnxXjwR/I=;
        b=IjvTPP0bs/cfGsUiAqdR+/jGEZKAdusmhMNed/WwAL5TIxsd0QV5ObIujZ7DNGD+xa
         7XpaBPyy90aKmZL4BpuhHL+8PvJnJgwVJsX3z/TGvJRn+nmgTpEJmFejIg7KAfjYBc3c
         gpoi3j+rGOypJgzV1PjJ1GlwlutzmbEku+3kR7coJge54D7xlUJlnyURkP/FpwOFbB9s
         epTOneTQ58UXJx18p3pw7HAwyVzXroRaZigHjKyBpS/9cxvHPk1DLpupxWwvQDqz0Tv8
         q5i7KC7dJ3z7UgPGjXhiYj2IWalA8hpc0TbsUMZhbfw9Sabr+6HTLiopwMtaPkOgxxtu
         KekA==
X-Gm-Message-State: ABy/qLbgfanzS3c1DxnzBvStfVsrAXweAA1LfB/W5H81N6kHP6+jyeOj
        UUJwMeP1h9lQhOdds2OFDnQ=
X-Google-Smtp-Source: APBJJlFGYYhdLQYp1qY5RENlDfGjtleaBJ34hizcHHIjbEHqYhTrPpcNzYFzCgPsLN4VJw3meqaKNA==
X-Received: by 2002:a5d:4c85:0:b0:314:1d7f:9e9 with SMTP id z5-20020a5d4c85000000b003141d7f09e9mr17797032wrs.0.1689147523663;
        Wed, 12 Jul 2023 00:38:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b003140fff4f75sm4260000wrs.17.2023.07.12.00.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 00:38:43 -0700 (PDT)
Message-ID: <f0e8de7b-655c-9932-16d4-105decff9a6c@grimberg.me>
Date:   Wed, 12 Jul 2023 10:38:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
 <ZK2PgNizcMLW+S/V@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZK2PgNizcMLW+S/V@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> For example, we have this completely unacceptable garbage:
>>
>>          ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
>>          if (ret) {
>>                  dev_err(ctrl->device,
>>                          "globally duplicate IDs for nsid %d\n", info->nsid);
>>                  nvme_print_device_info(ctrl);
>>                  return ret;
>>          }
>>
>> iow, the code even checks for and *notices* that there are duplicate
>> IDs, and what does it do? It then errors out.
> 
> This check came from a recent half-baked spec feature called "Dispersed
> Namespaces" that caused breakage and data corruption when used in Linux.
> Rather than attempt to support that mostly vendor specific feature, the
> driver attempted to fence that off as unmaintainable. This check wasn't
> aimed at enforcing "correctness", but it certainly found a lot of that
> as collatoral damage. Let's see if we can find a better way to detect
> the difference with a sane fallback as you suggest.

Perhaps we could fallback to what we do in wwid_show()?

"nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id, serial_len,
subsys->serial, model_len, subsys->model, head->ns_id)
