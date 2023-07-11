Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B45174EDDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGKMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:15:00 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8BE49
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:14:58 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso11997045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077697; x=1689682497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrZ8yh4nFHBxX4BgGqt9YuV6OVfsRrdwyKxh5AGLUOY=;
        b=RE7dUDjWinnxgq06CZSJv9PqjRUB33OL7JhMVfglI81PDjC9XsUwd+lZayIGif09ey
         FSGUOx06vSZu3L3hRC2asjL0CNl5akvoLKOHUS+9M3OE8b+dQIRLLCE+p5Z+ny6uKBQl
         xBHZJDeBDJTRcGPOFcZatUb9Hd2nx5TBMkFVnpUwlzROD8lOwCQ6FqDRc5pph4T4zuBb
         QdgzrLhAoHDkSiPe31EHdhmF4jG1VawL2n94MvaIacOB8fUo1t3nHlBcxqXmM41Tz8Yp
         ekymCOekz8zvuJHE7G8uvNX5KXLDoCMOnUb0lp0bAedFuou+uMbGQlr1EBTFWOs7opRe
         zakw==
X-Gm-Message-State: ABy/qLaEjem4auOX7XsDu1FQ9YIECp4we30wkcZR3DMc1g/leKT78eIE
        X/Ux9TohEuWpotnkHASUWfg=
X-Google-Smtp-Source: APBJJlFTz6sRrKHYL8i9OSKnEs6VzdhcuUcl03pmVYw312kGUe2L1rfBbXc0ltDJz2GHqbM8BxUQag==
X-Received: by 2002:a05:600c:4709:b0:3f6:8a3:8e59 with SMTP id v9-20020a05600c470900b003f608a38e59mr16114725wmo.1.1689077696814;
        Tue, 11 Jul 2023 05:14:56 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b003145559a691sm2115991wrw.41.2023.07.11.05.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:14:56 -0700 (PDT)
Message-ID: <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
Date:   Tue, 11 Jul 2023 15:14:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
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
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230711120609.GB27050@lst.de>
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


>> Well, that "They keep pumping out more and more devices with the same
>> breakage" and the "new device" comment from Pankaj below bear the
>> question: should we stop trying to play "whack a mole" with all those
>> quirk entries and handle devices with duplicate ids just like Windows does?
> 
> As far as I can tell Windows completely ignores the IDs.  Which, looking
> back, I'd love to be able to do as well, but they are already used
> by udev for the /dev/disk/by-id/ links.   Those are usually not used
> on desktop systems, as they use the file system labels and UUIDs, but
> that doesn't work for non-file system uses.
> 
> And all this has been working really well with the good old enterprise
> SSDs, it's just that the cheap consumer devices keep fucking it up.
> 
> If we'd take it away now we'd break existing users, which puts us between
> a rock and a hard place.

Maybe the compromise would be to add a modparam that tells the driver
to ignore it altogether (like allow_bogus_identifiers) that would
default to false. Then people can just workaround the problem instead
of having the back-and-fourth with the vendor?
