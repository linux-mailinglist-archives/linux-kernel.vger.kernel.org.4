Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5D74FAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGKWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575CD1705
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689113273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22o7sJ4qMvAv+MYHGzcaJXVzraK0uhlI2bEFW2/yXhs=;
        b=DgvZvIqFRHDZkwqpIbvRgX7bkqQ6AIcExp3tfbETDebBhahEbXkytIPywBJ6gponLE+9QF
        /5+Q9ckThEo1uyCNseeYv/qFSvBhId5ZkVzutwyuf4qMPnKWBlPma4cf1SBoYS5eNFLaDq
        w/oCjiZFbqv0HvsetclMUKbChFVtXto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-XMfvtaptNeqoL_2kfIKVVA-1; Tue, 11 Jul 2023 18:07:48 -0400
X-MC-Unique: XMfvtaptNeqoL_2kfIKVVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53BDF185A791;
        Tue, 11 Jul 2023 22:07:47 +0000 (UTC)
Received: from [10.22.16.29] (unknown [10.22.16.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF1A40C6CD0;
        Tue, 11 Jul 2023 20:13:46 +0000 (UTC)
Message-ID: <87b925cb-6393-ca9b-6549-b3ba85ad54fc@redhat.com>
Date:   Tue, 11 Jul 2023 18:07:46 -0400
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
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
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
From:   John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ZK2PgNizcMLW+S/V@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this is what I thought.  This is all the result of the duplicate NID check added to deal with TP4034 Dispersed Namespaces.

One suggestion I have would be to limit this check to nvme-of subsystems only. These are the only devices I am aware of out 
there which support TP4034.  Moreover, all nvme-of devices report a valid NID.  It's required with NVMe Over Fabrics. The PCIe 
devices, I expect, don't care. You don't really need a valid NID with a private namespace - which is what most PCIe devices are.

I'll wager that if you change nvme_global_check_duplicate_ids() to check only nvme-of subsystems, and simply continue with PCIe 
subsystems, 90% of these nvme quirks can be removed.

John Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com

On 7/11/23 13:21, Keith Busch wrote:
> On Tue, Jul 11, 2023 at 09:47:00AM -0700, Linus Torvalds wrote:
>> On Tue, 11 Jul 2023 at 05:06, Christoph Hellwig <hch@lst.de> wrote:
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
> 

