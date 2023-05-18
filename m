Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F151E7080F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjERMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjERMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:15:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACB110A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:15:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 961145C00EC;
        Thu, 18 May 2023 08:15:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 18 May 2023 08:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684412107; x=1684498507; bh=fS
        5DdDFtTTn+8EfiHkrWv7ABPSLcgtewyNrKXdzJzs0=; b=Q7YRtBTF1pz8hraVVH
        +cr9wqKEaL/zXIHhwE05rzn6ITpGP7IeHlrfUOSSNSFqf2C9ZYr17Ggs92JkqBdo
        skVQ+s9NN0U15wPsjr9R7wSKZN2XXP4T2a60jG6997EpkjTTekdYOgLvytJlp5fa
        xYEhqDxz85//H6nYiQ1173fkd6ZOruHC7xnQgpkqHyf6s4A2VB1brNJ2jI5y13gH
        o2gN9DDk8L5hfMAj/AI7LYnAM5kW7eosyDGED+F9gvVuVJx8DJEOiTPhbxGykdqP
        c0gUswWp3UhMoSbNRjUidXkS89bcN24EGNfMh0TO3JX+j6/84zTamuLsUbr1cFry
        gV+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684412107; x=1684498507; bh=fS5DdDFtTTn+8
        EfiHkrWv7ABPSLcgtewyNrKXdzJzs0=; b=NGeYbaHU+K4pr/7KGmqf1TnTUfFLZ
        4Bio3c4/IIGCHL4E8YCncmW+541GIBZRSXuG7t5c6Z5LDWzObS1kgSCM2pCpI/GA
        W4GSHv31Cj7shqrx2hIcwGYVsktnaypSXy1lJcOHbBk4jeJHQrc9tNNyS4mh+pLW
        /uuj1+/oJNcz/zxUPj7Tsxm87CpmubGKShp+5beFSotDHZMeOUO9zgcvTPZZE9SP
        OvVXFe0kq0HGO3a51XK1J6eKJeA3I+qLFmL9Zc8xklGGJayNQF/Kxbvfkc4gTpKv
        geqzVX3KPfbrHth33eRSiFricZtzsSj7FC33JWkzb3DWvxRu1x853rb5A==
X-ME-Sender: <xms:yxZmZPXADb9mThc68Q53vbyrn3n6Vuub5vTSpww1n8u9Fw7VkiBSOg>
    <xme:yxZmZHliCVSrg689UuJ6AmOokKWjRsBOJMj04iiXz5rft0jXfGOUUARgkhglJ4JCp
    04h5CSExytxL_H72Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:yxZmZLb7Y-Odn2Y-xDQus1bG0zy5rXtGPQE_lkj1N_iA1Gd4Gsrpyg>
    <xmx:yxZmZKUcY8qdH8EBaj88DaSq1LsCN4EzmILUSF1zQLBo2O1TP6Raag>
    <xmx:yxZmZJk0T_LgYLRQK1ku5i1OE-NTqXO9-1rrDbKDGs4mgo-gn3cCOg>
    <xmx:yxZmZM8H66rNa6irTC97CIMg5_CMMo_vWxJVjSpcsoDrX25Etk4LhA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 29BD4B60086; Thu, 18 May 2023 08:15:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <85a2cc47-dd95-4c39-82ab-8bf7a2a1589a@app.fastmail.com>
In-Reply-To: <86lehmksf1.wl-maz@kernel.org>
References: <20230517202352.793673-1-arnd@kernel.org>
 <86lehmksf1.wl-maz@kernel.org>
Date:   Thu, 18 May 2023 14:14:46 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marc Zyngier" <maz@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Oliver Upton" <oliver.upton@linux.dev>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Shaoqin Huang" <shahuang@redhat.com>,
        "Ricardo Koller" <ricarkol@google.com>,
        "Gavin Shan" <gshan@redhat.com>,
        "James Morse" <james.morse@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "Zenghui Yu" <yuzenghui@huawei.com>,
        "Cornelia Huck" <cohuck@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kvm: avoid overflow in integer division
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023, at 09:30, Marc Zyngier wrote:
> On Wed, 17 May 2023 21:23:39 +0100,
> Arnd Bergmann <arnd@kernel.org> wrote:
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 3386bd28d267..6db9ef288ec3 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -92,8 +92,8 @@ static int kvm_mmu_split_nr_page_tables(u64 range)
>>  	int n = 0;
>>  
>>  	if (KVM_PGTABLE_MIN_BLOCK_LEVEL < 2)
>> -		n += DIV_ROUND_UP_ULL(range, PUD_SIZE);
>> -	n += DIV_ROUND_UP_ULL(range, PMD_SIZE);
>> +		n += DIV_ROUND_UP(range, PUD_SIZE);
>> +	n += DIV_ROUND_UP(range, PMD_SIZE);
>>  	return n;
>>  }
>
> This is against -next, right? Oliver, I assume you'll take this as a
> fix for Ricardo's series?

Yes, correct, I saw it after rebasing my tree from 6.4-rc2 to the
latest -next.

     Arnd
