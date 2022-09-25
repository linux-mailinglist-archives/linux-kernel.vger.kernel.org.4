Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB45E90E6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIYDsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIYDsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 23:48:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2D32ECC;
        Sat, 24 Sep 2022 20:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LsLLzEWNZH/o3nTsVAf5omXopkBAkpTPKmK0vsG80jA=; b=fnSXPh0MDNiodBQtRS3Uaa+iEN
        IPIXQ2BWQHnEU6ZgwwhyOGvB85wXtX6zexe7OF8LuSCMLzPDCkoKu3EPN03KzHxAbVBd7XRN+r6KL
        +t0lB2X5t7oH2U6d1R6t/v3Nyt52np0yUm/ikgmLKRrrt+K6S/HTXQrrq5Fr1ygPw9RkZo+SUKiNl
        tMJ1jszMQCzZfvqr1mZIVUy8wlZC4xxbupN6q0Xc2ajZKy1Avhl+lfrpWs3wMdnth29Iy2cE/YSrn
        948RqAqIu2vnNwLhPhOAfmpr1ZlCp2r+1H+BiepCykfXusNyt9hZt1OPq3+tmcx69z+4pz0FWr/qK
        vPOLDrDA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocIce-00AmGS-6C; Sun, 25 Sep 2022 03:48:04 +0000
Message-ID: <e3e32b99-e8a3-ba8d-5d84-3ed99af308c8@infradead.org>
Date:   Sat, 24 Sep 2022 20:48:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt into
 the core-api book
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
 <0ce29b47-1e4b-6c3a-27fa-47e442f1f21e@gmail.com>
 <87a66qp5vn.fsf@meer.lwn.net>
 <e97ff5c9-6ffb-08b0-0da0-8035fe2dc877@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e97ff5c9-6ffb-08b0-0da0-8035fe2dc877@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/22 20:18, Bagas Sanjaya wrote:
> On 9/23/22 20:39, Jonathan Corbet wrote:
>>> Shouldn't warning like "This documentation isn't in RST format and included
>>> as literal block" be added?
>>
>> Why?  Who needs that information and what will they do with it?
> 
> At least readers will not be surprised with the anomaly...
> 
> But anyway, for consistency, I'd like to see these *.txt docs be converted
> to proper RST.

I'm pretty sure that Jonathan knows that those files' owner(s) want them
to remain in txt format.

-- 
~Randy
