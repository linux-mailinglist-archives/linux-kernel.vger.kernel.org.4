Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8366F9803
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjEGJah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:30:33 -0400
X-Greylist: delayed 185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 May 2023 02:30:31 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD511556
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 02:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683451465; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WPB39i+Pzfc102z7n4oaQgZKljJEXRaQdM1TztlQVauQYzS42OmvQTGLr1Q0tN5JN8
    ClSe/G6E0cT5sAbq9L9lEBsZ5GHun7xxh6L3JhAkNhWhsLwYsADcdweGzIBRAjght0jc
    aVwFCH7f1SqX877ya7uEzv1tH2x9MWLsSkkcTHLUNoajAMfg78KN7IOSWMRYaNGn5ELI
    HDMHLZkR1kIYfCxnKKbrX2/gOk57OaH6Ns0ES49+xqPsJL4yv+Da8ITfP1DY3PwmB81H
    NIVUzf1lammF+3cDgRvJWOATcQNd3n+p/qSaJGrMRLghyV1itInHiC4gsz8ULc6TwMw6
    hZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683451465;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WhzhEPW3IuSAbhMuYgA0QH0NqDdyN/a5WuPdo7pOvWQ=;
    b=ZnWtpIn5wv+8tsObH22QNOKHgdnurIAzYqlqKOc486Lc03zL7pGj/TP4ncI/V7+Ek1
    FrdgnL0wSb8lEZiCd9SxJ66EJMVqnX8BHtntJ/7uWW4ummUb/gOtOpWrRgU9N5THm8Jz
    VuYVkLteIYXrTYzg6hq0wlD/v/FDVP30lYW/1rbQoIA4zD6kY1DOMyoxYl6i4A7wDajB
    UVjT38v69/d0TN3Zi6cPhtPvnXP3HDl4WxyzwP/+h0zQyRyJEkTPhoqK+j3AfHphF/M8
    8QiiQkoxt+Uevaq+KdZ/JB9FSc5gnS81AkFoD2Mc+eWg7Cn5sMFBMmLIoXrxNMLGPObN
    BkiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683451465;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WhzhEPW3IuSAbhMuYgA0QH0NqDdyN/a5WuPdo7pOvWQ=;
    b=K92uH6AtiM3p0+WoyoJj2HHWCEReRvnIgjQzJjR1kIPM/PFP/on18xoxSKNYxzGNmS
    NtPINN8icjKfe12PACPBbbgAZBPokWjd5VI9UvyTYqegeGEvgrw16uFjW3f561yCy9/0
    D8q/v2sXRXXx/6OkVhqhl44ajKNUPXmcMVD8nrrFfUi8BWDvi+o3ito9V7BHKTAYxLky
    kGwJGrtYYMOC9V98wMKtR9a1H3YMwinEqDhuWCKbuwMCsEsuSQABpX7PWXh2330M+GKO
    QctS0CmDPeWeYNMSNi+xVO7yEAYxx5vapT4OTgwPI1b5tc7k10hKfd1NVRioekzJQQI2
    Nn6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683451465;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WhzhEPW3IuSAbhMuYgA0QH0NqDdyN/a5WuPdo7pOvWQ=;
    b=RyGwuNbxXKaAmCdsEN/385LI1bt3W6E9Y3rXVTV+aAFOuo30lvkl1swTUI79Nqo9Up
    e/T19gqFHc3o1kzG9PCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfio0GngadwiAuo0nkh/QkTJY0F5KivYZg6rg"
Received: from [IPV6:2a02:8109:8980:4474:ec95:ca11:b696:829]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id w2b3aez479ONXom
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 7 May 2023 11:24:23 +0200 (CEST)
Message-ID: <3cbe9734-265e-d9f0-fcf8-433ef306a46f@xenosoft.de>
Date:   Sun, 7 May 2023 11:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is
 not present
To:     Rob Herring <robh@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>
References: <20230505171816.3175865-1-robh@kernel.org>
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20230505171816.3175865-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 May 2023 at 07:18 pm, Rob Herring wrote:
> Commit e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges"
> parsing") broke PASemi Nemo board booting. The issue is the ISA I/O
> range was not getting mapped as the logic to handle no "ranges" was
> inverted. If phb_io_base_phys is non-zero, then the ISA range defaults
> to the first 64K of the PCI I/O space. phb_io_base_phys should only be 0
> when looking for a non-PCI ISA region.
>
> Fixes: e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges" parsing")
> Link: https://lore.kernel.org/all/301595ad-0edf-2113-b55f-f5b8051ed24c@xenosoft.de/
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Untested, but I think this should fix the issue.
>
>   arch/powerpc/kernel/isa-bridge.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
> index 85bdd7d3652f..48e0eaf1ad61 100644
> --- a/arch/powerpc/kernel/isa-bridge.c
> +++ b/arch/powerpc/kernel/isa-bridge.c
> @@ -93,11 +93,12 @@ static int process_ISA_OF_ranges(struct device_node *isa_node,
>   	}
>   
>   inval_range:
> -	if (!phb_io_base_phys) {
> +	if (phb_io_base_phys) {
>   		pr_err("no ISA IO ranges or unexpected isa range, mapping 64k\n");
>   		remap_isa_base(phb_io_base_phys, 0x10000);
> +		return 0;
>   	}
> -	return 0;
> +	return -EINVAL;
>   }
>   
>   
The Nemo board boots with this patch. Thanks a lot for your help!

Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
