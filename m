Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0454C711F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbjEZGHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZGHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:07:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BEA125;
        Thu, 25 May 2023 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YeHMLKYZLktUZXoDtbAI9yhcE3xWnVS3PncgW4EqLBk=; b=tp+xdtdyNF52jXyBTcVwA1UTER
        ZuU7JzwtKRd6UMNN3BdJWzAfzZqtz6GRytU0kpiOcqNNLK2rCmWCn9w+qXB3n9UOtLLZqCaQv8fle
        tBBwVRhJ2MOcTef6ttqqlWJmkY+vCfYImEz/OjOmME1PSJyjkVOLiUpFQ8eQupVwFZv/0oU3hlz6h
        QBtuLCIU+Lsta0ApEeb4HVGYUIanGdPiT1w00CMZOA0D05bRF2sm50VrJRbiTzuhZXxW7kae1ARb9
        VP0fc5eiUj1I2Jg9N0S2oz8kbSy5vIOczWoVOWVr+SOuO3EpnBtmHFppW6QamVJd39TuiQmLXwYLE
        Pjsy6i8Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Qbr-001CCa-0O;
        Fri, 26 May 2023 06:07:31 +0000
Message-ID: <b6c6eab1-9e81-4247-ee92-4684dae78c15@infradead.org>
Date:   Thu, 25 May 2023 23:07:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
Content-Language: en-US
To:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, mcgrof@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, rppt@kernel.org,
        kent.overstreet@linux.dev
References: <20230526051529.3387103-1-song@kernel.org>
 <20230526051529.3387103-2-song@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230526051529.3387103-2-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/25/23 22:15, Song Liu wrote:
> +/**
> + * struct vmalloc_params - Parameters to call __vmalloc_node_range()
> + * @start:          Address space range start
> + * @end:            Address space range end
> + * @gfp_mask:       The gfp_t mask used for this range
> + * @pgprot:         The page protection for this range
> + * @vm_flags        The vm_flag used for this range

    * @vm_flags:

> + */
> +struct vmalloc_params {
> +	unsigned long	start;
> +	unsigned long	end;
> +	gfp_t		gfp_mask;
> +	pgprot_t	pgprot;
> +	unsigned long	vm_flags;
> +};

-- 
~Randy
