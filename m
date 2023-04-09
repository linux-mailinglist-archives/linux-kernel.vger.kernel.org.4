Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630D6DC212
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 01:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDIX4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 19:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 19:56:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983630F3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=17fSIrQK/jC0LFsSBtbaMBCXOYH1U68mDASv1TgAVaU=; b=bKgNob/Dr/Gq2gMSk3NbuEYaA6
        Bp92XfwmNkptfHpgOZuyRYhlcCqNhDa2MdrKUOWp71K/wUueLey1kqH02+cs7/ci8F8g/5LzmqZnJ
        JEW4XP66hxEaBVWF61xJGZuc+zpkUqoZHY2t0p8bDsE+/YI5m4WCNN/JVI+gD4Ih8vYh71w25Gdjj
        WpTt1FRW/J6vHP/Ts5wF/WTHTFEbCwVHkpqxsp+PdQkuK1gItJcljTAxlf1wXwTzyv77fVnbSXE4i
        gd+LOGrTrVgMgzjhdWZOY2iPHZkog0v6DH07m00BiAlaw06u2vYUGZJ/jlG12jwgZFMz1giV2ElP5
        yxcfizqw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pletj-00EN8h-1D;
        Sun, 09 Apr 2023 23:56:39 +0000
Message-ID: <de5025fa-6e71-1e16-7f9b-e65d60af14cf@infradead.org>
Date:   Sun, 9 Apr 2023 16:56:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Content-Language: en-US
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, tiwai@suse.de,
        broonie@kernel.org
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
 <20230310210356.561dbe63@kant> <20230311080343.GA378828@workstation>
 <20230311101554.14c211d4@kant> <20230312070728.GA421475@workstation>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230312070728.GA421475@workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/11/23 23:07, Takashi Sakamoto wrote:
> Hi,
> 
>>
>> It's good to see you being active in the kernel and related userland
>> development/ maintainership, and that you have a plan for the next years.
> 
> At the moment, I have a problem about the list archive.

If there is still a problem about the mailing list archives,
Hank Leininger at marc.info has been pretty good in the past about providing
archives fore lore.kernel.org.
See the bottom of https://marc.info/?q=about for his email address.


Are you waiting for the kernel.org account before merging the update to the
MAINTAINER's file?

thanks again.
-- 
~Randy
