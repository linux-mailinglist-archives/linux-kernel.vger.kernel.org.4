Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A56A64BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCABXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCABW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:22:57 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BF34007
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677633753; x=1709169753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DByreY2GJXdAGvq71tt9Fo41tXYu1N83vt1UZRvOcNg=;
  b=qr4bXhrybpzW53liFuCNx1/52j3qTI8AlyMYCB/rDGxt4AksQnNqvcua
   82Cj/lSZXhr/Bpl1cAxymQdTFGxhWkewFuB9dk/+REHDPEglYmpxw6ekw
   wCEfieuNdbdaSWWkyvq9Q0rmUXqrlIix8uKiBgeItpwGwVQ/CDsqzl/04
   zke3yliQ4qaFaT9HlEMT8F3xUpbro3d3OAZ6uMGuOLOSw060KBhHqJ96V
   xMRJE5IdgzJtSoCOYV+7ZX0tN+LMh6c1xft5uWSCdsBF4UKWS0ElSIK9w
   jtXGUVEwuSxxFNwTFsVLSmr23TWLRqyHyj1QGrVkVsfoxLa1u56oicHKb
   g==;
X-IronPort-AV: E=Sophos;i="5.98,223,1673884800"; 
   d="scan'208";a="224259750"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 09:22:13 +0800
IronPort-SDR: l8S+3OuI+epSNcWP3vqS/MaNp29MvAJfe0mqMb139NVPIbR0RaktCk1SAXsc2vj0ZWjpObLwlH
 G1Oucszbcb6A6NwMoMrz0PHxSPOzZxXVIZtZrdzlcaEOLUvLejR08sghiDkK4qucTtiqPRX24E
 PJCieokADgMyFJaD86MUDJ0TgV2NWQ8YiDO3OQ32G4fG4+YSXym7rac8ntlX8r9RnR4UqHSd90
 XEHV8hKF56rfjKm9tFT+N4S4gf1NC7OEmiV6BqUOXwjei00jfiqSNn4ReZQ7oE6/br+DnihqiH
 RdQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 16:39:00 -0800
IronPort-SDR: 82MBcRzwoeN60BBFOX8ZFZr+dQwAf6PIXX+aER+hK5k2a/SXsSLKcE96PFkqkcq/jWvjm2YEsV
 OWkHz1UI+O9fw1tYMt6DLJDoyCB51m97bqiFz9sXmrF9Tm8a+hRJUQf0Kdz/0m1ZlHviLihLLD
 uEnQ1DztAikC8wMZrydqTCsFXYQPzJTkl0C9Q4oABY7YBkvhJnuYKV64dJ7Xs1MtScDHUbmSQm
 3wQVNkTeTH5iS9CGXPhLbG+MyniXZbeQNciPS30ZL9ZsfkbtfGF09E/1E5YtO3M0rr+vBGO/ui
 Jsg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 17:22:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRGg573ZTz1RwvL
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:22:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677633729; x=1680225730; bh=DByreY2GJXdAGvq71tt9Fo41tXYu1N83vt1
        UZRvOcNg=; b=aRZcjnIWzTDBFw+lwAK0yQ8I8bxlc+Ac1zRjAR1GywFhY4yN1yH
        aI+zVMJ6Q0eG41nPwWDXNKq/hOWxeI01P52EdQGYIOYzXOkufeBRfJIy6NRF23nX
        Mv/CsRYiuYhXA9RxOcnGN3cKK70ZZzHyVwwLeiPp4Q25wXt4ULnXNHNK/fyeKyA1
        72yG9x6b5NEawCA8VtwAC4s21lnwzYOOwwPhvyEQomn5yv9NJmNTstMZIMVrGBKM
        4gtrS+dFAyEVUXJQ5eCYv8E5ukl9iy2YrxwHKqzpEipCj7vPGQzjx2LdG3rpZiBz
        7ie+6OMDK/aILh8Jql2vRDyQiwps+YPQ7Zw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 80z6N2jLhkcW for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 17:22:09 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRGg32nyRz1RvLy;
        Tue, 28 Feb 2023 17:22:07 -0800 (PST)
Message-ID: <efe45f04-3a7a-3e94-ef79-4dcdd6029f44@opensource.wdc.com>
Date:   Wed, 1 Mar 2023 10:22:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/3] riscv: Kconfig: Allow RV32 to build with no MMU
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <20230301002657.352637-3-Mr.Bossman075@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230301002657.352637-3-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 09:26, Jesse Taube wrote:
> From: Yimin Gu <ustcymgu@gmail.com>
> 
> Some RISC-V 32bit cores do not have an MMU, and the kernel should be
> able to build for them. This patch enables the RV32 to be built with
> no MMU support.
> 
> Signed-off-by: Yimin Gu <ustcymgu@gmail.com>
> CC: Jesse Taube <Mr.Bossman075@gmail.com>
> Tested-by: Waldemar Brodkorb <wbx@openadk.org>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

