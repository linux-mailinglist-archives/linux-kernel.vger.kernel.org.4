Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09EA6C597B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVWgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCVWgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:36:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288940FF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679524568; x=1711060568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z33AnAkFE4jAkA5B22cWfL3zIfROoEjUwvM0cjRl6vU=;
  b=SVQqvvograSLlFHcmijPn4Yx2nyNpfuTXCEp5QYfq7ppsPVi2EFluC8b
   /7ihmbrlf/ChEQ7ZqzLge0tOQr7KXpPvjNWYALWCMUS3+gf4z2ZpCVbMm
   n2Q5IKCZuHpvxrPS5reO585uHOCgkOsCM2JgN/b2HHcJssza7chyhaWcf
   SnczCKVXRGwaslukQ/7rCGznjvUPhg9t0y+0pKKUh4n6hxCj878XexB+T
   3Wzo2fN7Mjqk9ZEN3zKOZEongTuliKPo0U7AwOpF+qdoJYGx/3hfrhpuY
   2eV2dJclQ72rbGF84b3BMfnsO3wLk2wPvOGlad1Z8rq8jQZAXStSbF54O
   A==;
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="226270766"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 06:36:07 +0800
IronPort-SDR: 0C9i3qJSpeqzmXozQakpUVh7aFXzlJjdMx3Iz3v/ksRHNhOvE32xkeelMooNtD9uIPXzGxFpyE
 8PNKYfmR5fwvNDFL79958DKQCGjGvfj0WQNYc214pLclzw+IUNt8/qMf2NZAr3ntyqCbAW6+Ax
 mofc39laHlw17azcAYVo/P/b/R2ejkmA+JOkEngVUy+yqVEsMfCVmQJnA7hTGcqFNZl3sPRs+Y
 0QR4JdjA8qTVPunZ31k5MmJvRKJojlEljlIcX7F0ED36A0KOVlslLSYEGWNIQ8Jzk7cAYxplpy
 njI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 14:46:43 -0700
IronPort-SDR: 2tP4cTvB+WDGoqkpy1L89p0zNulKR8lE7MAuoHmbaQ/JxsBTK6zSM1lJ9O3pLRiu48ZPvagAKB
 jd6t8r+fjSuz87fpA4TMSROhWoFIydgmSlRszN4lf4OcfrHv1tgrnUBjt/L3FyMLnaiLB/cEWk
 LPNaUD8n/CTAmSc0/pNRTLEhL9/fbrvPG+0jTKQH23ISGwGR3wPTsP+6KqbF+uLYrFOp4hTGbB
 6z/RNBw/nNt6fmOLfi/lcQ2S6dGkec2y8Hsikfb6+Amomyzwz7aHyDEIl8BdIhwFsHTGXjVwA5
 nvw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:36:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhjxM2QCCz1RtVq
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:36:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679524566; x=1682116567; bh=z33AnAkFE4jAkA5B22cWfL3zIfROoEjUwvM
        0cjRl6vU=; b=cYNzMeW+lSttMeDns2BoJy1PZKd+ZRtCtC/Kl/KTSdsiTpvNu6p
        PJ5u/QNTnu4kdRNTYF7r/W2gcBYEPVT8CVve/4lftZUXpeYg7UAnjONT0GXdguxo
        WzQZKJO2N9y7T9oeiwScu+IFHNoQ4HcqOJk7t2dardZl7Z24mPPKSgzvDoZpVi6l
        NyynR5TQMjWNigoZJvW/0+/ioakVt3qpqOX/ZSgDjpujILKOgmAhqEi9BUOO/ial
        9JQHJyFasMP26Ml07aQFlfxb5FCQ8QQsND+sOejbhrlU5JNT3pZQEaAujvNjww0y
        jW72vLDC6w3hyi9OIqv1tnRpbMYMezZ4ofw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OjvP0ST9wEPi for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 15:36:06 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhjxL0LJCz1RtVm;
        Wed, 22 Mar 2023 15:36:05 -0700 (PDT)
Message-ID: <5856b70f-e5bc-d802-7450-7a11c570c10e@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 07:36:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pata_parport: Clean up some inconsistent indenting
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230322055519.67900-1-jiapeng.chong@linux.alibaba.com>
 <202303221314.41470.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202303221314.41470.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 21:14, Ondrej Zary wrote:
> On Wednesday 22 March 2023 06:55:19 Jiapeng Chong wrote:
>> No functional modification involved.
>>
>> drivers/ata/pata_parport/comm.c:159 comm_write_block() warn: inconsistent indenting.
> 
> This patch does not fix any real problem. All the protocol drivers have coding style problems but they need other work first.

Does your pending series address the style issues at least in the areas of the
code you touched ? If yes, then good and a style cleanup can go on top.

-- 
Damien Le Moal
Western Digital Research

