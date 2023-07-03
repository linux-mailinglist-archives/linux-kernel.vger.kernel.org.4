Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCC745573
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGCGX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGCGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:23:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6787CD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688365409; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h2wZhgnFTRaW48adXC7R9FkvMJt0cqe0pht6vrt0diiaSzKPAc0FDyifj26vamMXhE
    YhuFrrtnWNISk/8VrYXRsn1wch2/AH7EWJdpJrhGWdrEdjhVc8+fHUunE+5ANfnAwp1k
    K1/jwD5SHB5CKX3hBUY7JGNniRkyTH66OJSJABiBnvATUbc2ZlYKBtLW99Kk3lryP101
    V/DBFYogGUG9yBN8WA9Qv7i/BaXw96p/YzNfo3b+UXs6JKf3QCVmvtcLhqfkTq3rnMDC
    kMKJlB1hS0L5+jInEEQoSCeak/W1H3VZLGnxuQf/XUdKbKFmHSV8rFGVBFAgUgxQxvQh
    oH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688365409;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VigkN2P9VAqWMVxOPGmNVBtxL11TIs6XihUyRsbczCs=;
    b=Bv76Wo/XYZOMQXkKbsH0QMfaqvr8MspGFv/DWSEPzPKTwyotNKmPOfZ46S2pUcOlBr
    cmyw3n0s0rFXm4mRloYqs8UXmef/+TnQqWhWeCBNLwkqjIFYMJdLADLCQO2s8IYyi4AR
    KlO2Bm/fuKG5cMhnnXZaQ9mnL91ntxA1dWKj2YzFvNycLczW2iQaWH05qR5xuH2pAy8o
    jZEJkwWxcCgis/hi2iJ+ZOvU397FnIlkzzdo2ApA3t9dR3U6C3pM79VSBorJNC70mkXZ
    IIZN4xDH9uwES60i2xUBpz0s1H7RgSatWbZJfej/tqIpZsyyaHxvIM9If/P4rjNYYy0R
    q8uQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688365409;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VigkN2P9VAqWMVxOPGmNVBtxL11TIs6XihUyRsbczCs=;
    b=OxNBsNc3d7VvRr+7SL7aETVTNDLn1L9f5xSC+G2rFViyPImSg0u0TAfSmrOPXujx+p
    nTU+1umTZIghLQJylr/Kyc2dLbgNbfMTVyX8Fv8GZyOoH+2AEmlkP5v4zy5DC/43zub4
    slkRJv4jCwvRbrI4zh7gFoX8cvBeLH5LsFvUYQegJ30rFzUlsmeZhF76+z3yXtZIQyt5
    TUL+8xoXNaDwKS7fMz4+SznohvKhTvXjRMRXbqksyOH/SnoCZm+S9X1GblgcjwT8Cp60
    atR3hlXP7dLt+zwiiS01P0cnxbfA7RxSsqmTlzto82lZM8KxkUw++28hHQnfoNeroJeR
    wjNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688365409;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VigkN2P9VAqWMVxOPGmNVBtxL11TIs6XihUyRsbczCs=;
    b=Mh3osUCY+AsP/pYGNodti7Q+cGwfHJmZH0RBwCwVTTjUwm8fUh1B7pm7IHgOxIYEKf
    qFLx3be6Q6S3AeVsjiAQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedV4gJwiYnA2b8Im6fsBSfXOgxLFqo2dX1be4ZzRPQGO"
Received: from [IPV6:2a01:598:d035:1cd6:a8bc:1f79:6a95:4328]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z636NRvGH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 3 Jul 2023 08:23:27 +0200 (CEST)
Message-ID: <1a205224-06d4-9337-5621-c9760c02f9e5@xenosoft.de>
Date:   Mon, 3 Jul 2023 08:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is
 not present
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230505171816.3175865-1-robh@kernel.org>
 <168836167601.46386.17041701491443802315.b4-ty@ellerman.id.au>
Content-Language: en-US
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <168836167601.46386.17041701491443802315.b4-ty@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.23 07:21, Michael Ellerman wrote:
> On Fri, 05 May 2023 12:18:17 -0500, Rob Herring wrote:
>> Commit e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges"
>> parsing") broke PASemi Nemo board booting. The issue is the ISA I/O
>> range was not getting mapped as the logic to handle no "ranges" was
>> inverted. If phb_io_base_phys is non-zero, then the ISA range defaults
>> to the first 64K of the PCI I/O space. phb_io_base_phys should only be 0
>> when looking for a non-PCI ISA region.
>>
>> [...]
> Applied to powerpc/fixes.
>
> [1/1] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is not present
>        https://git.kernel.org/powerpc/c/79de36042eecb684e0f748d17ba52f365fde0d65
>
> cheers
Hello Michael,

This patch has already been applied. Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4927cb98f0eeaa5dbeac882e8372f4b16dc62624

Thanks,
Christian
