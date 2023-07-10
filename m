Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E574DF69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGJUha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGJUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:37:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE328127;
        Mon, 10 Jul 2023 13:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689021445; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c153HvdjWNLM9GC+AIiNmIDr3Y7Tr0ZVH9xqbSZ3O9x6GDqNWrXqoN+j5hUXtr101e
    gRTTbNu596vKJRbfAoujJ23DHny5Y4xSfZ7VWuObhMvxWLLgbVjj/v2Pn+in5K92f888
    rw3B1bC5PRk7TNgiFMyb4fRez4SsInTqKjNhi/Sckrsgc90t1ExB4ULMClz17fm1QuaP
    FqruQBS1b0mufzbOfJhaumE3yWywbx1HyHiW4TLXCRUNDpTKe/DAqYUrB7IQ8AAKXZXY
    BO8uvMamSwk0Lj9VQMCR35SoQG/z7k0IM+E5Bhkmg6VqQ956dVQiiSWgbx0+MFv/mBLp
    9uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689021445;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O0/nLsGKuz9y9JiZ+HIeDIwhM0vfV03x0I6Z5++zIlg=;
    b=LYOy0HpziynsvV/huMdf27Ch+v6mljBkbpEXXa3NcN4k0d9hq+Gfm0aAlV5Azlk7DA
    3HP4xOLLbgfW0bumPbUvaHxiELJq9ewFssMCI5yMiZDaXIYDit882gpJcLblADx4dmjb
    tt10zPBsHXeDa/hd3fvhVTDuCbaKTanlLcBUSF7Pj//XJymYhQ5LhWHPOrO4OBAyC66+
    hwUHjVQ3sxrz3+O+SM2NVuJqm1V91TEtMJK3XpDie3ZsWiwTghxlA8whxHGbTp/77HkA
    jvZk/UgGpjf+izxuDwLveL+KqCGDyCxci3GP6IL+fD7Nfl6P1qRYfshyNHSIrq2wrXdi
    cEiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689021445;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O0/nLsGKuz9y9JiZ+HIeDIwhM0vfV03x0I6Z5++zIlg=;
    b=TMAb4VcZ9mlbzZZDJ56Ru8vJhCsPQw+UCG8dwxuoASUPPu7Fi81xeYBCTpCVDxxDGW
    CRx+t0ZsbqSrZKmoyNjHfOPGZ8KGm649xiJFCzFBxro6MLAUHdj2zvbL4bMDsOe2/R0v
    VzNUJncrf5pyxCyBmOiZOato3FVixFsE3ilhB+aQA3otIpKSL5ZEZRYusjhCJnK+37Zm
    K0U0IUeVul2czCH/4m9SfmNsiIsOiWcdy4e0hQKfpupCcjjKqkDe/Q73z9FmWJHHmknV
    yGP5XzHLOl81I6JZWQc0cIaNALkTWhN34HuN/ow5nzOFpk240K/T0bzL/IFmI/CNgMTN
    kC5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689021445;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O0/nLsGKuz9y9JiZ+HIeDIwhM0vfV03x0I6Z5++zIlg=;
    b=L9mVg9F6ODNQLWVVIS9FGGA8j0Plvro3SxPm2XZ3ixwIGwUEYhujPmvMFGKeK0cUQU
    Y9P33bj34GmE1wxrzFBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+53h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6AKbPEot
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 10 Jul 2023 22:37:25 +0200 (CEST)
Date:   Mon, 10 Jul 2023 22:37:10 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] remoteproc: qcom: Handle reserved-memory
 allocation issues
Message-ID: <ZKxr6hyqq3s7nqix@gerhold.net>
References: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
 <20230529-rproc-of-rmem-v2-1-95e39b959585@gerhold.net>
 <c3f59fb4-4dd8-f27a-d3f5-b1870006a75c@linaro.org>
 <ZIsld-MAdkKvdzTx@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIsld-MAdkKvdzTx@gerhold.net>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 04:51:44PM +0200, Stephan Gerhold wrote:
> On Thu, Jun 15, 2023 at 11:44:06AM +0100, Caleb Connolly wrote:
> > On 6/14/23 17:31, Stephan Gerhold wrote:
> > > If Linux fails to allocate the dynamic reserved memory specified in the
> > > device tree, the size of the reserved_mem will be 0. Add a check for
> > > this to avoid using an invalid reservation.
> > > 
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > 
> > Other uses of of_reserved_mem_lookup() also have unchecked uses of rmem [1],
> > or check different things [2].
> > 
> > Does it make sense to put this check in the function itself?
> > 
> > I can't think of any obvious scenarios where it makes sense to differentiate
> > between rmem being NULL vs having a size of zero at the time where a driver
> > is fetching it.
> > 
> > As Bjorn described in the rmtfs patch, the memory allocation is essentially
> > ignored, wouldn't it be better to print an error and invalidate the rmem in
> > [3]?
> > 
> 
> "Invalidating" isn't that easy because the reserved_mem is currently
> stored in a simple array. Removing an entry would require shifting all
> following values. But I suppose it would be easy to add the rmem->size
> != 0 check in of_reserved_mem_lookup() so it doesn't have to be checked
> on all usages.
> 
> Given that no one seems to check for this at the moment I'm inclined to
> agree with you that it would be better to handle this directly in
> of_reserved_mem. Bjorn, what do you think?
> 

I sent a v3 with the additional checks reverted. I'll work on a separate
patch series to improve this independently of this one for all users
(directly in of_reserved_mem).

Thanks,
Stephan
