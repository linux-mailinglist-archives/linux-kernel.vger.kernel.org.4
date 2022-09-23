Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FCC5E8200
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiIWSsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIWSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:48:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC31205A0;
        Fri, 23 Sep 2022 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=t2OLBQEmg4AoUb1NRCujWt4eLSWl7grEqO7FcmKManU=; b=oFo0Ys/xhZAy+k9GdkSrmpOgjI
        1zDdRO8+3NxQGaKeJURysOSPjtgIV0WzFW433yC0gz/Idd6slmlw6rSKrJzf4ax6LcUwQi4Gc2ePT
        12SNJlK8ZK66WCJ9CQ65ffQ4yLKe0oJphtrTCED9Dz8e1gxMCynmcb7OLP68OlKziTPda0GaIw/cl
        9ZOcjeJ9CWLwBcic3YTtk2eZ5t1jwkmLX9BCu75bO+/vOQy0Qncd7P3q0Q6+rlW98fp1JYz1myfYN
        gbcADmQKRQ9/yM1E8C/ZqqEbbhQ0vZsF0cu7lKD36XakZQA4mKldnuvHu2f6TwB8glgxjlscP7GTO
        9UrA5EDg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obnis-005OS9-7z; Fri, 23 Sep 2022 18:48:26 +0000
Message-ID: <0b717bbd-0b3b-ecf8-e1f5-4641491498c3@infradead.org>
Date:   Fri, 23 Sep 2022 11:48:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/4] Rewrite the top-level index.rst
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <7f02143c-461f-268b-0f17-7fe20a7423d6@leemhuis.info>
 <875yhep5l1.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <875yhep5l1.fsf@meer.lwn.net>
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



On 9/23/22 06:45, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> On 22.09.22 22:41, Jonathan Corbet wrote:
>>> The top-level index.rst file is the entry point for the kernel's
>>> documentation, especially for readers of the HTML output.  It is currently
>>> a mess containing everything we thought to throw in there.  Firefox says it
>>> would require 26 pages of paper to print it.  That is not a user-friendly
>>> introduction.
>>
> 
> Again ... who are the users?  I maintain that the actual users of our
> docs are primarily kernel developers.

ACK!


-- 
~Randy
