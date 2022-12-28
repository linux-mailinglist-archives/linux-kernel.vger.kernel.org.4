Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E765726B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiL1D44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiL1D4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:56:54 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6E7766E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:56:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 04EDA5C00AE;
        Tue, 27 Dec 2022 22:56:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Dec 2022 22:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672199811; x=
        1672286211; bh=nNQzqCe5zmOATT2jxUQw+cDTgzFKZ4/xmHDTPVepV/k=; b=D
        GengyLG6n+MGuxF34MbI2RWwssG4W0LzEgDWZV2POn6hh+fNvQstG868POWFv+9G
        Lu1O8PmtjEJpfDg0m6/ULkUDWBrMIl3ZSbg5tm/z+SltiVa5VOizXiQh46eJ8QJd
        rDuSbGggAVVg7Gh3B4mtTjGvRGrnoPOvucrFb8msyCvZWCwKotuIjx0zJ81Rn+5Q
        fXikVLFL0CpJMQRnTkHsL1F1DKAk8nap/VrjVhB0QxojcSiN2B8oQS2jv1MAooY5
        jpr1IkpCcEddwDZDTdgnBH8gpiBAqN4UXZ3C/gqiXNY5VwrfqN/CNRVruQ9bCxyy
        IwCDPcB2Zo3z0h2Zkpy6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672199811; x=
        1672286211; bh=nNQzqCe5zmOATT2jxUQw+cDTgzFKZ4/xmHDTPVepV/k=; b=t
        EfbjtJfNY62p1XC4Ul9Dl5ZCooGB2+FGMgrUKVJL+UENKfZasKdObWLNF56Oman9
        q4ql349Oy7btcbNQGL9R26Kt9j+jCiEi/kZw1AtalnnLoGCwJgxZin9CNb9H0bo8
        OR5lXaFv1246GJg6yg7BCU2EpVPpWsVIbQypfF8UEYnNBnpBwQQ+uhKtbFX2FiHW
        aTzQEpfBicCGlk6H+kQK3yglbs9RnMoE6T3jbcl/vK7sYTTB+qP1E/AV5nn1R7B9
        WHy+RRj/RdgV/onxrqU5IzePalHLb/EO72OSOQLM4Hnz8q5ygGA2FjMGkotwN0fX
        PlRgP4rPqoKid+tt8BeCA==
X-ME-Sender: <xms:gr6rY7t3kA69y5zdmFAcKplGjQ1X7xK7uNpGYPCA8XdmvLVlhUqtPg>
    <xme:gr6rY8cYb9FonDazqxV0cbUoiI2lNihNX2vs9k3XYYXPnfzlqGxEH7p57T2NzPxak
    k3hP1x4uRZKbb2w9w>
X-ME-Received: <xmr:gr6rY-yuZF0rNeuWqT5mRnkw-sZQtYJMFHyg_gnnZ2gIzNCcJftSxbQu6FWEakWqrkOdVi3oFuHPqg_lMjYAEZKozvgNclFP_nJie2jEaQVPFdIAD7OJ-tFLmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheettdefgeeuudelvdffleejheejueeludduiedvkeffgeetueev
    vdelvdetfeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:gr6rY6PueWeKCaGwGMREr1EfetzgLJyzRYLc5jP0mvp-SM6OLNWlZA>
    <xmx:gr6rY7_R2C8mwoGBDzYggcTpVGs47KAW8Q7YOj1Y_-J6ZYvtm8KB4g>
    <xmx:gr6rY6WEvaquENmFGnHcJESTEJ-z6-6iwFJZCosbrSh9z6Op22euNw>
    <xmx:g76rY-b5UUSYNn2PcbA_OtfBbSBLY4tA4vDhuY4DDdj6BLIxMvLqmg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Dec 2022 22:56:50 -0500 (EST)
Message-ID: <9015e4b4-4652-3c19-b845-4fa8855559d7@sholland.org>
Date:   Tue, 27 Dec 2022 21:56:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Aren Moynihan <aren@peacevolution.org>, Lee Jones <lee@kernel.org>
Cc:     Ondrej Jirman <megi@xff.cz>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
References: <20221208220225.635414-1-aren@peacevolution.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2] mfd: axp20x: fix order of pek rise and fall events
In-Reply-To: <20221208220225.635414-1-aren@peacevolution.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 16:02, Aren Moynihan wrote:
> The power button can get "stuck" if the rising edge and falling edge irq
> are read in the same pass. This can often be triggered when resuming
> from suspend if the power button is released before the kernel handles
> the interrupt.
> 
> Swapping the order of the rise and fall events makes sure that the press
> event is handled first, which prevents this situation.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> changes in v2:
>   - add comments describing the reason these are out of bit order
> 
> previous version:
> https://lore.kernel.org/lkml/20221123230741.2430813-1-aren@peacevolution.org/T/
> 
>  include/linux/mfd/axp20x.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

