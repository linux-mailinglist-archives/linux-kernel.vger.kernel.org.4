Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74F1623C98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiKJH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiKJH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:27:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F7313D2F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Bgg4kjG9SCmsiOPgzEcrTSKTn0lUunQ/8cf/4nUuORo=; b=gp6yRjU2+REAxrfSSzZ/z48U0g
        hil0YhjVab1Wc89q898z8osT5fIczFPT67pi8LEv0jAxUVdya2bDJfln9qNzvHsKQNctdOG48FULN
        vm8gKpMCobWK4+0LjYWC8vKACJ4YMEpv/CHddTH0BRLRvBFygzrcMSAcOqWUkp4StOdh35hHAN7nX
        eZxR6hyM6S/ev9B5pQz15JwpBAWHfrien8wMqC/PVfN7+ldkXTZPG4fvRa9xTzyaC1d3SJkUg7yEg
        WegSN8sSo+vMylutlVp6dF0+MQs7Y3+sPDvysQg/OenGwga8PVdU2U2JqSD0ntrzapT2atFArpXR8
        rxtx3lbw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot1y5-003mba-Va; Thu, 10 Nov 2022 07:27:22 +0000
Message-ID: <68d969b7-1a86-3be6-86f2-a78e92af46a4@infradead.org>
Date:   Wed, 9 Nov 2022 23:27:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Submitting patches without using git.
Content-Language: en-US
To:     A <amit.general.misc@gmail.com>, linux-kernel@vger.kernel.org
References: <CAEq81z03GOTiME=q83B9L-fg3bG6Mu_0_Em67Y1DqTp_oj_fZg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEq81z03GOTiME=q83B9L-fg3bG6Mu_0_Em67Y1DqTp_oj_fZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/9/22 21:22, A wrote:
> Hi,
> 
> Is learning git necessary to submit patches to linux kernel?

No.
Simple patches or small patch series don't need to use git.
As patches become more complex, git could be more of an advantage.

> Can I do it without git?

Sure. For me it's easiest to use 'git send-email', which doesn't require git,
but I have also done it just using an email client (Thunderbird in my case).

(git send-mail may require a separate software installation depending on your
distro and its packaging.)


> I have used SVN, etc. but I found git a little bit complex.


-- 
~Randy
