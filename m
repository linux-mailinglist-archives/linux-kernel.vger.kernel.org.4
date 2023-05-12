Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D2700449
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbjELJw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbjELJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:52:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2851703
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:52:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3062b101ae1so6342468f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683885139; x=1686477139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVwfY7mFtOC1Cyl/KY/aAvzCNFHS9pnu/L2vWR6tanM=;
        b=lNzuu9Se/s0jcY6pZAND5J+za3iyY2kmU/Qe9R38rH2EFeEqL/34VKE/tWoV2tBKEa
         Fw6lmUuJpXg20E7W32rMINXgYWNRIWbtF8uyZ4kMiuZwkgGcd/bJ4v8JUcYD6qKTcoPg
         ianJHJKzOqPsTSFROW7NeQio/KlRFIHI/dANjN5Sz5pbucFNrVsiwmRnUBJFjYgIGS6G
         Zo+3ASjXWAApymP8We615flEIP+yVcQ5eq1nQuW/gN8PBp7h2cLdxAjtEQo/ICnXN5qH
         VzPe1GJ6zpZ9Q5/EIljzVlpCJICuv4tgPYoRSGHN6UcEnOZLpwnjaJs1m8EnX6onftVt
         wErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683885139; x=1686477139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVwfY7mFtOC1Cyl/KY/aAvzCNFHS9pnu/L2vWR6tanM=;
        b=HPttdVuGICJlwGgIzcxuRy5GUSiH+hSTOriHyA8phDjC/xziHu+7WpiYuUZAMeJGTP
         jyeEdGZyGuDsvSyK6VPP8dVWzdtcaezE8izOu6FklQjq/jB5ucsyo/ZrYYy8fPGSpT+F
         5a2/uwIiCA9DP5g1n1kePcaOe30i4tZk56IuhiavYXjxCFoB4mecSZBudk7braXcEXFI
         iilfl8YWh9dmuzhz6gx5t65NRFXF9XrNWEex9Cjf7G+OLRv313xhzixY6yA/MBlEBoWb
         vFnQlDT1In5GQBfyg2Vty8TL1UA0SxzLEEGiNSNtVqO3oZ7vF6sWDsM+2jPVaWrTkkmb
         xdvw==
X-Gm-Message-State: AC+VfDzHgD7Z5+ADNgFAWaZjktGPR0rn0uLsUznALYvlonUpoF6Fn5YI
        7ooxqXSGRclkUfu+/doV3qaUZA==
X-Google-Smtp-Source: ACHHUZ72yfT/ipVvWkp3tdhBbWIMTlfNqj0QNbWJT6ZB1wy8qtqjR51BIQkJp7SfwGPNsAf1IjpTng==
X-Received: by 2002:a5d:4344:0:b0:2f5:fbe5:bb1c with SMTP id u4-20020a5d4344000000b002f5fbe5bb1cmr16791103wrr.63.1683885138573;
        Fri, 12 May 2023 02:52:18 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6b01000000b0030903d44dbcsm168171wrw.33.2023.05.12.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:52:18 -0700 (PDT)
Date:   Fri, 12 May 2023 11:52:17 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     zhangfei <zhang_fei_0403@163.com>
Cc:     aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH v2 2/2] RISC-V: lib: Optimize memset performance
Message-ID: <20230512-815af10bf1c437851e7f8fa5@orel>
References: <20230511-0b91da227b91eee76f98c6b0@orel>
 <20230512085124.3204-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085124.3204-1-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 04:51:24PM +0800, zhangfei wrote:
> From: zhangfei <zhangfei@nj.iscas.ac.cn>
> 
> On Thu, May 11, 2023 at 15:43:26PM +0200, Andrew Jones wrote:
> > On Thu, May 11, 2023 at 09:34:53AM +0800, zhangfei wrote:
> > > From: zhangfei <zhangfei@nj.iscas.ac.cn>
> > > 
> > > Optimized performance when the data size is less than 16 bytes.
> > > Compared to byte by byte storage, significant performance improvement has been achieved.
> > > It allows storage instructions to be executed in parallel and reduces the number of jumps.
> > 
> > Please wrap commit message lines at 74 chars.
> > 
> > > Additional checks can avoid redundant stores.
> > > 
> > > Signed-off-by: Fei Zhang <zhangfei@nj.iscas.ac.cn>
> > > ---
> > >  arch/riscv/lib/memset.S | 40 +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 37 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> > > index e613c5c27998..452764bc9900 100644
> > > --- a/arch/riscv/lib/memset.S
> > > +++ b/arch/riscv/lib/memset.S
> > > @@ -106,9 +106,43 @@ WEAK(memset)
> > >  	beqz	a2, 6f
> > >  	add	a3, t0, a2
> > >  5:
> > > -	sb	a1, 0(t0)
> > > -	addi	t0, t0, 1
> > > -	bltu	t0, a3, 5b
> > > +       /* fill head and tail with minimal branching */
> > > +       sb      a1,  0(t0)
> > > +       sb      a1, -1(a3)
> > > +       li 	a4, 2
> > > +       bgeu 	a4, a2, 6f
> > > +
> > > +       sb 	a1,  1(t0)
> > > +       sb 	a1,  2(t0)
> > > +       sb 	a1, -2(a3)
> > > +       sb 	a1, -3(a3)
> > > +       li 	a4, 6
> > > +       bgeu 	a4, a2, 6f
> > > +
> > > +       /* 
> > > +        * Adding additional detection to avoid 
> > > +        * redundant stores can lead 
> > > +        * to better performance
> > > +        */
> > > +       sb 	a1,  3(t0)
> > > +       sb 	a1, -4(a3)
> > > +       li 	a4, 8
> > > +       bgeu 	a4, a2, 6f
> > > +
> > > +       sb 	a1,  4(t0)
> > > +       sb 	a1, -5(a3)
> > > +       li 	a4, 10
> > > +       bgeu 	a4, a2, 6f
> > 
> > These extra checks feel ad hoc to me. Naturally you'll get better results
> > for 8 byte memsets when there's a branch to the ret after 8 bytes. But
> > what about 9? I'd think you'd want benchmarks from 1 to 15 bytes to show
> > how it performs better or worse than byte by byte for each of those sizes.
> > Also, while 8 bytes might be worth special casing, I'm not sure why 10
> > would be. What makes 10 worth optimizing more than 11?
> > 
> > Finally, microbenchmarking is quite hardware-specific and energy
> > consumption should probably also be considered. What energy cost is
> > there from making redundant stores? Is it worth it?
> 
> Hi,
> 
> I added a test from 1 to 15 bytes in the benchmarks.The test results are as 
> follows:
> Before optimization(bytes/ns):
> 1B: 0.06  2B: 0.10  3B: 0.12  4B: 0.14  5B: 0.15  6B: 0.17  7B: 0.17 8B: 0.18 
> 9B: 0.19 10B: 0.19 11B: 0.20 12B: 0.20 13B: 0.20 14B: 0.21 15B: 0.21
> After optimization(bytes/ns):
> 1B: 0.05  2B: 0.10  3B: 0.11  4B: 0.15  5B: 0.19  6B: 0.23  7B: 0.23 8B: 0.26 
> 9B: 0.24 10B: 0.27 11B: 0.25 12B: 0.27 13B: 0.28 14B: 0.30 15B: 0.31
> 
> From the above results, it can be seen that the performance of 1-4 bytes is 
> similar, with a significant improvement in 5-15 bytes.At the same time, it can
> be seen that redundant stores does indeed lead to performance degradation, 
> such as at 9 bytes and 11 bytes.
> 
> Next, I modified the code to check 2, 6, 8, 11, 14, as shown below:
> '''
> sb a1, 4(t0)
> sb a1, 5(t0)
> sb a1, -5(a3)
> li a4, 11
> bgeu a4, a2, 6f
> 
> sb a1, 6(t0)
> sb a1, -6(a3)
> sb a1, -7(a3)
> li a4, 14
> bgeu a4, a2, 6f
> '''
> The results obtained in this way are as follows:
> After optimization(bytes/ns):
> 1B: 0.05  2B: 0.10  3B: 0.11  4B: 0.15  5B: 0.19  6B: 0.23  7B: 0.23 8B: 0.27 
> 9B: 0.23 10B: 0.26 11B: 0.29 12B: 0.26 13B: 0.28 14B: 0.29 15B: 0.31
> 
> From the above results, it can be seen that when we modified it to check at 11,
> the performance improved from 0.25 bytes/ns to 0.29 bytes/ns.Is it possible to 
> minimize redundant stores while ensuring parallel stores to achieve optimal 
> performance?
> 
> Therefore, I modified the code to detect 2, 4, 6, 8, 10, 12, 14, as shown below:
> '''        
> sb a1, 4(t0)
> sb a1, -5(a3)
> li a4, 10
> bgeu a4, a2, 6f
> 
> sb a1, 5(t0)
> sb a1, -6(a3)
> li a4, 12
> bgeu a4, a2, 6f
> 
> sb a1, 6(t0)
> sb a1, -7(a3)
> li a4, 14
> bgeu a4, a2, 6f
> '''
> The results obtained in this way are as follows:
> After optimization(bytes/ns):
> 1B: 0.05  2B: 0.10  3B: 0.12  4B: 0.17  5B: 0.18  6B: 0.21  7B: 0.22 8B: 0.25 
> 9B: 0.24 10B: 0.26 11B: 0.25 12B: 0.27 13B: 0.26 14B: 0.27 15B: 0.29
> 
> From the above results, it can be seen that this approach did not achieve the best
> performance.
> 
> Through the above experiment, here is my conclusion:
> 1.This optimization method will inevitably result in duplicate storage. I cannot 
> achieve the optimal state of each byte, for example, when I add checks on 9, 
> the performance of 9 will naturally improve, but 10 and 11 may become worse due 
> to redundant stores.Therefore, I need to make a trade-off between redundant stores
> and parallelism, such as checking 9 or 10, or something else.
> 
> 2.Storing parallelism and reducing jumps will compensate for the cost of redundant
> stores. Based on the current multiple test results, regardless of which bytes I 
> modify to check, its performance is better than byte by byte storage.
> 
> 3.From the above experiment, for the detection of 2, 6, 8, 11, and 14, its overall
> performance is the best.
> 
> Because I am not a chip designer, I find it difficult to answer specific energy 
> consumption costs. Do you have any suggestions and how to conduct testing in this 
> regard? I think although storage has increased, there has been a corresponding 
> reduction in jumps and the use of pipelines.

That's my point. There are so many variables that it's hard to know if it
makes sense to do this micro-optimization at all and certainly hard to
decide if adding the unnecessary branches at 8, 11, and 14 make sense.
I see some value in an 8 branch and maybe a 12, since it seems somewhat
likely memset would get used for data with sizes that are 4-byte aligned.
But even that is just speculation. I think without running comprehensive
benchmarks, and seeing an overall gain, then this isn't worth merging.
That said, if you post again with stronger justification based on these
experiments, then I'll give it a tentative r-b and let the maintainers
decide.

Thanks,
drew
