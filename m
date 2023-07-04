Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F347467A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGDCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGDCiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:38:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA9D195
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f8RkJQKjsXoHsI7HcP1B4JZjrinjwR96VwvZQStcKHw=; b=gyfOHkOD5v5YlUW4rCaUykC/j/
        q7135RUMhwLRvUsXyKA8+kUzIhKllXv1PZPh85UJYwpZAuQ42zHAd9k8DCwIFiiNJ7fMES1vy+3Ne
        I6E5w3vZmC5IehUwHKq9ohLPiYGBO5WVhU0/qXa4ZQ3xr0tgpranDNcFpDjdtOjaQ9kunQBecwjS4
        2NnRiYULgPikpbSTs0EZtPUErL6Taier0ESMeffviK2ejosstSKvgcXotNYj38SDmZu/kLPVzOZzm
        G/rLFWU6xHDj1XN7NyJPxxUzesrfNr+7nstk2kWCZFUmfpgXG0TMzX4SNumluWzVXSEszb/kH/4pu
        dbFvSwTw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGVvz-00BwL5-0k;
        Tue, 04 Jul 2023 02:38:31 +0000
Message-ID: <ca7ec187-ffbc-0779-0dbe-21238a566e7b@infradead.org>
Date:   Mon, 3 Jul 2023 19:38:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Content-Language: en-US
To:     =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
Cc:     Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
 <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
 <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org>
 <CAAxE2A5C96k5ua+r938VA_+w7gHHNTdF3n8LwDb98W0Bf9wCVA@mail.gmail.com>
 <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org>
 <CAAxE2A7RGDY4eRC85CsqfszNzyKvMU2MX1wa+3HZ1hgNeAw3cQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAAxE2A7RGDY4eRC85CsqfszNzyKvMU2MX1wa+3HZ1hgNeAw3cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 19:34, Marek Olšák wrote:
> 
> 
> On Mon, Jul 3, 2023, 03:12 Michel Dänzer <michel.daenzer@mailbox.org <mailto:michel.daenzer@mailbox.org>> wrote:
> 

Marek,
Please stop sending html emails to the mailing lists.
The mailing list software drops them.

Please set your email interface to use plain text mode instead.
Thanks.

-- 
~Randy
