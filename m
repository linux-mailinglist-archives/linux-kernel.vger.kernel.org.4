Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF70F70432C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjEPB5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:57:45 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DCB3A91
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:57:44 -0700 (PDT)
Message-ID: <6db6be89-553b-2ea4-c560-85d7656b1a64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684202262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkgJr5TntcsmOa2FHc9lEEHs25pFEnEi+hsLB4y5ZKc=;
        b=PBzDjZNOTYQwIdfGd4tTMQ4KbP5VVFAryOUs1Ecmxp7cM7IZDPm8iLGmf4uFDVOatqXkBp
        I4qkw3Y9eYYAOXVVGCL4Fk3+CeR1Labso0Evadby62oplEOZho3OuZrEuZAk4iEr/K4Yqw
        JBttLnfSbkLEBFknClhf9/KXiBpBSMg=
Date:   Tue, 16 May 2023 09:57:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Content-Language: en-US
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de,
        akpm@linux-foundation.org, peterz@infradead.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        thunder.leizhen@huawei.com, ardb@kernel.org, bhe@redhat.com,
        anshuman.khandual@arm.com, song.bao.hua@hisilicon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        21cnbao@gmail.com
References: <20230515094955.GB23880@lst.de>
 <20230512094210.141540-1-yajun.deng@linux.dev>
 <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
 <20230515133821.769158bb@meshulam.tesarici.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20230515133821.769158bb@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/15 19:38, Petr Tesařík wrote:
> On Mon, 15 May 2023 11:23:27 +0000
> "Yajun Deng" <yajun.deng@linux.dev> wrote:
>
>> May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
>>
>>> This looks fine to me. Can you please work with Barry to make sure
>>> the slight different place of the initcall doesn't break anything
>>> for his setup? I doubt it would, but I'd rather have a Tested-by:
>>> tag.
>> Barry's email is no longer in use. I can't reach him.
> Which one? I would hope that his Gmail account is still valid:
>
>    Barry Song <21cnbao@gmail.com>
   Thanks.
>
> Petr T
