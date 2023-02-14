Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5530D697030
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjBNV4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjBNV4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:56:10 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0010A;
        Tue, 14 Feb 2023 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=9IN3eOt3oiputxBZkCNAXozCKfVDwLRKM9iYz/qgSDk=; b=csG4bZANruBFHWc9GszVvK0FLy
        bhe1HV3ZBNcKPt034MHOYz9gxDuKT7ui8J3EydSMgBZYqaoDsYgZMoXStypl6ApJnNb6uplWeV9Ez
        eMSiAiOuRXbRH3XeO8t/7J0IjrvxiOSAO1m3jEhpBzHKkzm+g9RnWEJn7Oo5BuCA8MJPdLwwSnZ4P
        vklv9P22GCqKYMTpezBSrhguVeNgzPmEK2IWAJPI0h76/NrDNBlUyIOUx1xmYTLFRSCWe88oxDKY5
        C9N4HjzxCoKFGVhHx6F6cB0Nyh47prCHJsoGOUKFqeOaA0q7in51Q7i9oKY76f+N14uEsKdIbdrHZ
        xLH+MhHA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pS3H7-001tak-WF; Tue, 14 Feb 2023 21:55:46 +0000
Message-ID: <d483ea28-feed-41d1-f9b6-4abfcfe42874@debian.org>
Date:   Tue, 14 Feb 2023 22:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] Enable hwlock on Allwinner A64
Content-Language: de-DE-frami
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230213231931.6546-1-bage@debian.org>
 <20230214001805.6ead683d@slackpad.lan>
From:   Bastian Germann <bage@debian.org>
In-Reply-To: <20230214001805.6ead683d@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.02.23 um 01:18 schrieb Andre Przywara:
> So are there Linux/Crust patches out there that use this device?

I do not know of any. I was just investigating the chip and checked the parts that I could easily use in Linux.
