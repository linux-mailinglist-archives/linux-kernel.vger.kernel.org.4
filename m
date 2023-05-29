Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05099714F73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjE2SnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2SnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:43:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC73C4;
        Mon, 29 May 2023 11:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685385788; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KV6zdvHmyfJT1JSgT3wcmofS6het1flt6Jf9YJjYUs63uysKHckwafM5st3k54ILbe
    fDJgvdgJhNH0rlFsBOldKwxaOdmVRMmuzGm6OAxo4Kec0e4yZqpFLWgr7AJr8cOPLdAD
    Ua/bYmfky5P45aZeGSfYjCqRy6Ah5xYEu5a45ulHznf7fnHOZsPK3T2Bwb1j459fXKHo
    cVQeyA0E20uIsEFLUAz5eGORQR1pGLUbwfvatBusTe5tG7d3n7YiEnz1d4zo/L1S2GWu
    aoorCJuYbsnfY0R28Pn0ojh+2g28wZ7TsG4qairEKJKIleHTDeYXi49D48uLDCp2YY/b
    /EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685385788;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4pZ3+LAIJOzNjSsRz5kHcOyArnUgDjM1FUPpD/a3GB8=;
    b=MJnO4YH6WNeYMcpIcQThR3rW1U+L0ak9YOP9hgeR4BY+X4Pgdycezffk8qZt1oNrom
    n3l6RfadOgPMJQZGmVUsnyY9o/LVPFTZSTkmgEmDlOVxNcvwX3W+zO1QNx/foIxLiEnh
    BCqWk+wnDeT6pR93hJYJk9iB3a9aZ64+NcQ3ko7YX7JlZaBM2JSzeiiekblDriFkW9zQ
    I7QC1O2AbU+ItcJ7d/nGv3QuanEx4uYCuvIEnUO6Oa3CKRuTS9PJnmwi05+PxHUcnGOS
    9I4qLSN/49yIiK+MW/qkf6F4xUvG5s8ZssyjRVU1oUw7ngYOtCB5mLnDSSx9q0DbaHl5
    E3Hg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685385788;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4pZ3+LAIJOzNjSsRz5kHcOyArnUgDjM1FUPpD/a3GB8=;
    b=YDBWDF7sbPsAxkDf73EQVIHxKG/KDON8cQUPMrpo4g5+SzHL6FyQ/AR6AK7aJW40Wn
    0Brg1jfHaioOozoz5a3D5ZRYNE4JZz1yhZYmUrQa4uuFLPT0NtpiT8NLTaC6NJO50Pau
    +RatG/b78krbdYrXC9BBBc8td4BpYtkO2H4P/qdXmW9iI+PvCGKZhDt9DsWFWtqTXtIc
    Y3YraXz4fqXNc3ivTWnrgwA/HSJVd1+tbpwK3a9mcoogTTimweoVDEWd6eFkXbjlBM5K
    rPQmyX1zXmaietYDBf6IrzGOpEeFTZwYfuZ2yAJoDxmznF64ZLe6SPj55a0SPAcqAvLP
    YrkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685385788;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4pZ3+LAIJOzNjSsRz5kHcOyArnUgDjM1FUPpD/a3GB8=;
    b=wkCa9rk2GcmlmzzJMicvHYPqLzHZYDZPktoqhU/R6x4+ssbH52qWkgwYe7TeTNyv6X
    2L/m1hrgxPIJjVjTc3AA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8pqP1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TIh8fW5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 20:43:08 +0200 (CEST)
Date:   Mon, 29 May 2023 20:43:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
Message-ID: <ZHTyNA7CCQft-_HP@gerhold.net>
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
 <ec745998-8b07-c5a5-5220-b2e21528eac1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec745998-8b07-c5a5-5220-b2e21528eac1@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 08:36:27PM +0200, Konrad Dybcio wrote:
> On 29.05.2023 20:16, Stephan Gerhold wrote:
> > Reserved memory can be either looked up using the generic function
> > of_address_to_resource() or using the special of_reserved_mem_lookup().
> > The latter has the advantage that it ensures that the referenced memory
> > region was really reserved and is not e.g. status = "disabled".
> > 
> > of_reserved_mem also supports allocating reserved memory dynamically at
> > boot time. This works only when using of_reserved_mem_lookup() since
> > there won't be a fixed address in the device tree.
> > 
> > Switch the code to use of_reserved_mem_lookup(). There is no functional
> > difference for static reserved memory allocations.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > See e.g. [1] for an example of dynamically allocated reserved memory.
> > (This patch does *not* depend on [1] and is useful without as well...)
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> >  drivers/media/platform/qcom/venus/firmware.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> > 
> [...]
> 
> > -	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
> > +	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> >  	if (!mem_va) {
> > -		dev_err(dev, "unable to map memory region: %pR\n", &r);
> > +		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
> Nit : I'm not sure which is more useful, but many mapping functions
> seem to prefer printing
> 
> start, start+size-1
> 
> instead of 
> 
> start, size
> 
> on failure.
> 

Shrug, both is fine for me. I just used this because the qcom remoteproc
usages of of_address_to_resource() that I also patched already seemed to
log it similar to this.

If someone wants me to resend this with start, start+size-1 as suggested
by Konrad (or something else) then just let me know. :)

Thanks,
Stephan
