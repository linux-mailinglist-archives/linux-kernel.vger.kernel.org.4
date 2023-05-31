Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A2717BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjEaJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjEaJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:23:33 -0400
X-Greylist: delayed 140643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 02:23:30 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2386C0;
        Wed, 31 May 2023 02:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685525008; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nm9Hi9A5UctHoqFjtC93BVffbJPaM7L6WOpkvur311D6dVMN8NrpiA+w0lz3DiRRLs
    j+LmgWQb/qQk/oaSvqMWq2PzmKdNaqJFHOcI+ZYZI24uH8uFdMFrGlY7Kld3oSdEW4Vg
    3NcBeCWjr+TfGLU+xPekaYL1x1r0C8UsAXNGXojRLZNUnuzAsxPFZwSxZSKSqWifoPJN
    GZVuQq6NkLruy4up1WkHVSkJTfhWG2KKaIETEVWyOh7AqLaraLbpENxdicuzTrPQwsHS
    bkPBRJG6d1n7ayTZrV+2e7W5pZLhfbY00CAtYP7P7uPpDNIfmZX9S/X9JC71yA31lqyg
    eauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685525008;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O7FyB279Rp+Phddz55VXfH7fCqQWfLJZzJTaIeWqqyg=;
    b=XoiYCRwRiXywrNMs6YyDbbl4CH+BZwJOlgCGcjKzYL9/UFPDdXRWzbPfMn9vlToWe0
    HiRcdRvteODMCYC0Vo/zVKJxFdIxe9Wcj3TITMwqSLoj9SxHnJGfmzMT9wErczxg9IWr
    w25tXoqZAmOYH9I4I5Nlxe+y8fmqnYyDiK1vn1cLkFu4u2HTqZiQk4U2XlImn89WtzRu
    4T36jaZYHVbnNtG4MMQ2e8BAECMdv64mnx2qMBnlUiFafn2jb/mRZdWCDvu/LDZOK0eZ
    uZV6cBvGMwg3iJBlK3y+pWbLT6KQJfDohaEbe6VyAARZmkVtN1uTovcLOPV3WLgsSYq0
    Talw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685525008;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O7FyB279Rp+Phddz55VXfH7fCqQWfLJZzJTaIeWqqyg=;
    b=ZWLhCS/vhJ/FOqRZUZ4QoD7sQQjQRSkzhslLpBH1G1Or/KsfeKUPFCrr4p2ObkgIq+
    nd0q2w+T7V+NEUwLMF7Ced0klinmD4DDCNEq6866Byq4+Nug+HIa1BvXz5y6fZ2S0CyO
    JoDphi/6LRxrrmCd43n0WZsraeYNzb5bqmhaXgoI3ZHnkIsW3w+O5kluTfxRSxQsCH/j
    fKQFCFdERJXwBceaWRTRrvPCchTL5obgwurU80vYsKsrEwFrnnPMmtH1BmLhU7LOWypz
    AMRbI2WuRdxKIz3gF7GH5k1n2dG5W0grmI6ObqoLgcEc+vOoVY5x5jtvCLB09Oqso/1i
    r86w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685525008;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O7FyB279Rp+Phddz55VXfH7fCqQWfLJZzJTaIeWqqyg=;
    b=aRfVrx+liZHuqZnJZvTLZESHcRH+5lTL36vKU4EzeWqDFwhmnXSkHpfvhKfJlqv9kP
    /Y4NXJlOj8mBZYo43JAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4V9NRlix
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 31 May 2023 11:23:27 +0200 (CEST)
Date:   Wed, 31 May 2023 11:23:22 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
Message-ID: <ZHcSAbu1yYuhnKSc@gerhold.net>
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
 <38a627a2-040d-23e2-5637-32f199d0fc31@quicinc.com>
 <ZHbvkDkkS_pZltMG@gerhold.net>
 <31b850f0-7ee4-67e0-8cdb-39b9651a9d57@quicinc.com>
 <eefd371e-9c9c-2e29-8d6e-d657ee0db237@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefd371e-9c9c-2e29-8d6e-d657ee0db237@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 01:15:26PM +0530, Mukesh Ojha wrote:
> 
> 
> On 5/31/2023 1:04 PM, Vikash Garodia wrote:
> > 
> > On 5/31/2023 12:26 PM, Stephan Gerhold wrote:
> > > On Wed, May 31, 2023 at 11:36:52AM +0530, Vikash Garodia wrote:
> > > > On 5/29/2023 11:46 PM, Stephan Gerhold wrote:
> > > > > Reserved memory can be either looked up using the generic function
> > > > > of_address_to_resource() or using the special of_reserved_mem_lookup().
> > > > > The latter has the advantage that it ensures that the referenced memory
> > > > > region was really reserved and is not e.g. status = "disabled".
> > > > > 
> > > > > of_reserved_mem also supports allocating reserved memory dynamically at
> > > > > boot time. This works only when using of_reserved_mem_lookup() since
> > > > > there won't be a fixed address in the device tree.
> > > > IIUC, this would avoid precomputing the hard range for different firmware
> > > > regions and also make it more flexible to adjust the sizes, if anyone wants a
> > > > bigger size later.
> > > > Incase a specific firmware needs a dedicate start address, do we have an option
> > > > to specify the same ?
> > > > 
> > > 
> > > If you want a specific start address (or in other words: a fixed base
> > > address) then you should continue using static reservation for that
> > > component. You can mix static and dynamic reservations. The static ones
> > > (with fixed addresses) will be reserved first, then the dynamic ones
> > > will be allocated from the free space.
> > > 
> > > I have this example for one device in my proposal at [1]:
> > > 
> > > 	/* Firmware must be loaded at address 0x8b600000 */
> > > 	wcnss_mem: wcnss@8b600000 {
> > > 		reg = <0x8b600000 0x600000>;
> > > 		no-map;
> > > 	};
> > > 	/* Firmware can be loaded anywhere with 1 MiB alignment */
> > > 	venus_mem: venus {
> > > 		size = <0x500000>;
> > > 		alignment = <0x100000>;
> > > 		no-map;
> > > 	};
> > > 
> > > The wcnss_mem will be always at 0x8b600000, but the venus_mem can be
> > > loaded somewhere around that. If only certain regions need a fixed
> > > address this still provides the flexibility to change sizes more easily.
> > > 
> > > Does that answer your question? I wasn't sure what exactly you mean with
> > > a "dedicated start address". :)
> > Yes, it clarified the need if any subsystem wants a specific start address.
> > 
> > One more thing, lets say, we keep it dynamic allocation and at the same time we
> > need to pass the start address to TZ call in [1]. How do we get that allocated
> > address so as to pass in [1] ?
> 
> +	*mem_phys = rmem->base;
> 
> It will provide the start, is not it ?
> 

Yes, when using of_reserved_mem_lookup() the allocated address is
available in rmem->base. If you have this patch applied then it should
be given to the TZ call as expected.

Thanks,
Stephan
