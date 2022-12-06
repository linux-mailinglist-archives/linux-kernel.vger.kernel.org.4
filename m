Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A5644F85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLFXXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLFXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:23:01 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E673B1CB08
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670368974; x=1701904974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7dTgJZvXn/0rjzJG4KrL4TNwGEAxt2FG5yydkETyABg=;
  b=Cl31QvEMt+8BaMkeam9CfZDNidlBSMuR6XMHS7bXjdQ4VCdSbF3d8V6Q
   IdNyT4WyKV2CcHrC4jhs3hDYqoXmAGEYLY78SyiH7pVIXY7rZKqO2Z+ez
   VY/2aP2q1Nd9khRbghGROzukuwTxHwpcH6w9HQettJpnFNqZgOBxCVobU
   E5YSqXgOXLdYkbopMPKWzDOXvSn9bX9+fJg/WcI9vqhnx+X1jdGkXXdRK
   vFL69Pk50sr86e/pa/eMPgIsPMu7atd9h6dBhtQuMQDeRINeGWehUIiHU
   YOFpyMbAv11W6nV6WGqk0RYpXEUMUYm10qxoeSsEjmNq3mMWchJsvGyiC
   w==;
X-IronPort-AV: E=Sophos;i="5.96,223,1665417600"; 
   d="scan'208";a="330140992"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 07:22:54 +0800
IronPort-SDR: omZ/UmOZTl3hSty0MVKUpTl/r4oklm4XJxtOKIPbMRlERnvGvY8GOrEU5kTiXTce2XpGMABwN7
 PBPNunq/6SDKlTKsoruL1r9+4VdjfLvqNl6+tomjNMWDwyVUOE0scHYUCy9K/nd2IJ5UkhifjN
 +hty6a2XvJsl78c1NN4Ng9OyUi6oq+jBKf+dwApRoRyMjpkCNghX/InbDLdUJgmam1e3R3LUKf
 OTkPNLbOEAFxsNdJ4+Yo8Hg/j5fwh4KRczYAh/F9JFtkZDuitQ0NuWd/lSnGdlHFJ0WfBqnZtS
 zQE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 14:41:25 -0800
IronPort-SDR: 5i1eHQs6v7nk2roFC2xyaKQSbbGviZbiWAkfbXB7/T33zspsRG7ekI8sMmhVq8zcx+IISLpuXq
 XrkLX3eNMh1kQRG4fstWFyu9mbTO7aaEV5DNDev+4y4W0nQYOBxnzLemeYLPNcX5Io7fB4ZXVi
 wxP+SmNt/3YK9zIhXO/hRubo6p7Ts4g4Ta5A+RKKQyFL8M/F73a3UXuNSwu5ImnJFqmJPXgpnZ
 HRuYsa5gKjkcWMhHmmAs61eJGJG01xB1su9GBtLDlRm1tXXTqklv6+8FFfLi0dOc/893cWfJL7
 vI0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 15:22:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRc0F6zX5z1RwqL
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:22:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670368973; x=1672960974; bh=7dTgJZvXn/0rjzJG4KrL4TNwGEAxt2FG5yy
        dkETyABg=; b=X1aW3GN1utk0UgPHuHVZA2oTdTMeXctOUd+rsdoX8RAorOW2zdu
        afiI0sEz8xelO16qCfd05xOj/naPGG9KLUZFZZUsBV2ACtoCNtTNLZ+U2gA2rucx
        NZq77IpJaxnPhBzbvDlsx7V+7DThQJ4058ldWNt8C1IajrKEN7cAcsC/73fXPXJm
        7BtbId2rGWTt20WsBg2p9qFp1XASo7eGAz897IaXqXhJYvEcd0bRN30rH14gEuJM
        6e7wVfvze8dvTy4/M1nbyBf+HgsnetFvCrvDv0zg3JOgTiiV8YHfJ0iq0J3oCuYQ
        BcUQwoGVNxwJ1kSv/ZyBgkVW2BZzrgcqO/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j3BqsLkjju8U for <linux-kernel@vger.kernel.org>;
        Tue,  6 Dec 2022 15:22:53 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRc0C5NZhz1RvLy;
        Tue,  6 Dec 2022 15:22:51 -0800 (PST)
Message-ID: <52576133-b94e-e667-8410-33e44f3f37f1@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 08:22:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V8 3/8] block, bfq: move io_cq-persistent bfqq data into a
 dedicated struct
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221206163203.30071-1-paolo.valente@linaro.org>
 <20221206163203.30071-4-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221206163203.30071-4-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 01:31, Paolo Valente wrote:
> With a multi-actuator drive, a process may get associated with multiple
> bfq_queues: one queue for each of the N actuators. So, the bfq_io_cq
> data structure must be able to accommodate its per-queue persistent
> information for N queues. Currently it stores this information for
> just one queue, in several scalar fields.
> 
> This is a preparatory commit for moving to accommodating persistent
> information for N queues. In particular, this commit packs all the
> above scalar fields into a single data structure. Then there is now
> only one field, in bfq_io_cq, that stores all the above information. This
> scalar field will then be turned into an array by a following commit.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
> Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

