Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F040709AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjESPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjESPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:08:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2D121;
        Fri, 19 May 2023 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=kbaxQZCodf2yoZcuu6R7VLifT8XkIEU/jEP4FhjIvzw=; b=gLgsQoFNwQ57BiPjIr7AWvyYvD
        JDBLJPExw4+cTXNbu9qi1VK8CHo7eEaLFR0xsUOkdOGHTtsSk/70qH74mpYKfoOBRqW8li+D4FuTP
        vMuekMfVgBl3EdHukGjVSe1zFwKu2H7F+jPMcTN0ZYir8QQHXJBj+B7l4GCVgpGZrIwLFMdjKTdWt
        oX1CstcBb0vmB7itZvHvREwhyMmfXOwuz1Il/CO35XWXa7wO8YvvUhREDUwgCDcmfOKrrgiVGMsaL
        fd6l7hLw0/3XZyxOSJwdQI2KRO4oi4WC59VJVHX9XGGY66P6/p8OVF7JpVKc6625lyVCamNXTwoHd
        RRtDobQA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q01ir-00GZ7k-0Z;
        Fri, 19 May 2023 15:08:49 +0000
Message-ID: <5ac82c44-a778-046b-2d68-0003b5afa42c@infradead.org>
Date:   Fri, 19 May 2023 08:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 -next] tty: serial: add panic serial helper
Content-Language: en-US
To:     Hongyu Xie <xiehongyu1@kylinos.cn>, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
References: <20230518102903.1179581-1-xiehongyu1@kylinos.cn>
 <a8c0f2b3-fcc3-ee94-16b5-ef37b4ec37a9@infradead.org>
 <0507937d-33ed-9396-2efd-c749acdcefc7@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0507937d-33ed-9396-2efd-c749acdcefc7@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 01:40, Hongyu Xie wrote:
>> [snip]
> 
> What does "[snip]" mean? Can't find it on Bing or Google.

It just means that I cut out parts of your email that I was not responding to.

It is preferable to trim email replies much of the time.

Thanks.

-- 
~Randy
