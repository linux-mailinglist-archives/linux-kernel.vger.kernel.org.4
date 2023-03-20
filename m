Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C216C0976
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCTDsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCTDry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:47:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5D1C588
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:46:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C1BE5C00D6;
        Sun, 19 Mar 2023 23:45:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 19 Mar 2023 23:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679283929; x=1679370329; bh=DPqa9CIo5gQ5h
        DYjjjU5QVq+p20sroVnUZOnK4guvsM=; b=GH9nsM2bm+R9hdZqUUL/8G9bHHVtH
        o+rs3TAV2mrY2xaQ04HMzSmeKGrMCPtPy2u87Bt91P6C4D3hHDNImAsESSWVkrpV
        RD3ebWRRSdyvZg22lSW70V5dPW9mmk9pscDw4xzpFuT+zDA7c8lD5CtDGZQJLLIe
        VeLPzFZ77q7VDiLRiHe4VFJ07ZVpOxIPW/5BdF6Kwib6P8aypqQBOzEb//1HH7vy
        UnqlxhDzfoEDGsWoop25xUrX05KT3LopRpN6eyGV8u4qpEeVOMCMq/jsegLBFPa1
        yNCaTkrZPVWUEOFnqGTDV5iWxyKw/NT4EqjVHMeSZft2x02Rp3KjtOyqw==
X-ME-Sender: <xms:2NYXZEHK8xR7AlrNId0Nj62pu5-_ocML8iABU4pCum5lDfLJgVCRzA>
    <xme:2NYXZNWfZQ1U3Or57QFa1_GTH5MCi7kukSSqhrXFQK8YxdYFa8uksA-iLME678lOu
    7GfS0HUKGZaEo_NxQk>
X-ME-Received: <xmr:2NYXZOLDmgcfoaUd92AKkrQ8BeX2hmTkIXQX4em9oK7_8SB6wkyo8UnZ8xoHWeFsHq05YZW9XSxtlsJIbDsvySqxMeF2bh5652Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefujgfkfhggtgesthdtre
    dttddtvdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhig
    qdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnhepfeeiheejvdetgfeitddutefhke
    eilefhveehgfdvtdekkedvkeehffdtkeevvdeunecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:2NYXZGHfHR4AUjpSPd5vpjyVn4CyBAH711cCOBbLB5nUPITvSm_1SQ>
    <xmx:2NYXZKUGGfFuBHCJdVSu6NF2tJ9koPz8hJSIIbBOThXHS2XMJqTf2Q>
    <xmx:2NYXZJOuotoEckIypd7DsUwLCj3XHF5nykr7id9MU_g2Qd_PNzjc6Q>
    <xmx:2dYXZDe7k_BjQ9kFKg6UMrwExmDJKVI7X9CiRtBTEm_darTlQwKMxA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 23:45:26 -0400 (EDT)
Date:   Mon, 20 Mar 2023 14:48:17 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     lizhe <sensor1010@163.com>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v1] nubus: Remove redunant driver match function
In-Reply-To: <74decde9.155d.186f9737c21.Coremail.sensor1010@163.com>
Message-ID: <999d6634-3f06-12be-d6b9-c79019d50787@linux-m68k.org>
References: <20230319040816.232446-1-sensor1010@163.com> <3d77744b-ea67-a5bd-8126-f3d56e608add@linux-m68k.org> <74decde9.155d.186f9737c21.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023, lizhe wrote:

>        i have already issued this patch a year ago, please accept my patch.
>        Please see the patch information below :
>        
>        https://lore.kernel.org/linux-m68k/20220506045952.136290-1-sensor1010@163.com/

What can I possibly do? Your link shows a thread with an acked-by from me 
from 10 months ago. Also in that thread is a review from Greg 
Kroah-Hartman that you also appear to have missed.
