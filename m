Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852E61560C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKAXZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFC17053
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3166176B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC42C433C1;
        Tue,  1 Nov 2022 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667345106;
        bh=y6Y9I/ABUdMHuo+uopOpBsdU+t60oaGbhI3WXNVdouA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LA+sP5X07WKG0/kUsIJUsBpOwBWeg/nsoQj6lZmHYOY8ncPL6LzSxSGRPNU/QMOFS
         qv6gn344oUiw+t7wPpeG+2LETSwolXntgy3ohIasP8kOaRgW76sm5HpgGqZc+1e9Kq
         L/vYTaF00gdRcu0g8k9oO/b5jyz4Y3DJP71nIilFUSFtp1rIj9CcxFW6qmaVAfOXBd
         xJIsTAZpcXGhmCIc7wwwg8XZutg83KIFMahxctVWyMO/PHBRvTN/ZRkWv4kmNUQCxG
         C4T1U7YJKh5waZgw6eK4JIa+c/MKoDjmD6ZEdoaaNJP7Wxz17p+eNzAWBFjSvKFJ0J
         8IfcjDcGPHkqw==
Received: by pali.im (Postfix)
        id A57F17F8; Wed,  2 Nov 2022 00:25:03 +0100 (CET)
Date:   Wed, 2 Nov 2022 00:25:03 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
Message-ID: <20221101232503.qymzj7dypsehafvj@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-3-pali@kernel.org>
 <fd9c174e-2c89-7e11-9e68-d6044b7eab21@csgroup.eu>
 <20220926094706.km22rqzuuulvfssq@pali>
 <20221016110529.76bcgq2v2h4pg2of@pali>
 <3111f16b-2e6d-c46f-67e9-6cb5fada4cc7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3111f16b-2e6d-c46f-67e9-6cb5fada4cc7@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 October 2022 16:59:53 Christophe Leroy wrote:
> Hello,
> 
> Le 16/10/2022 à 13:05, Pali Rohár a écrit :
> > Hello Christophe! Do you have any other comments for this patch series?
> 
> I'm AFK for two weeks, but as far as I remember I don't have any more 
> comments.

Hello! When you are back, could you look at my feedback to your comments?

> > 
> > On Monday 26 September 2022 11:47:06 Pali Rohár wrote:
> >> On Monday 26 September 2022 09:43:55 Christophe Leroy wrote:
> >>> Le 19/08/2022 à 21:15, Pali Rohár a écrit :
> >>>> Function mpc85xx_ds_pic_init() is not used out of the mpc85xx_ds.c file.
> >>>>
> >>>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>>
> >>> This patch should be squashed into patch 1.
> >>
> >> No problem. Just to explain that I split those changes into different
> >> patches because they touch different files and different board code.
> >> And I thought that different things should be in different patches.
> >>
> >>>> ---
> >>>>    arch/powerpc/platforms/85xx/mpc85xx_ds.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>>> index f8d2c97f39bd..9a6d637ef54a 100644
> >>>> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>>> @@ -54,7 +54,7 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
> >>>>    }
> >>>>    #endif	/* CONFIG_PPC_I8259 */
> >>>>    
> >>>> -void __init mpc85xx_ds_pic_init(void)
> >>>> +static void __init mpc85xx_ds_pic_init(void)
> >>>>    {
> >>>>    	struct mpic *mpic;
> >>>>    #ifdef CONFIG_PPC_I8259
