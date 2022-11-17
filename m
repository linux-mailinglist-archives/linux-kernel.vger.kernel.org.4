Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E962E27D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiKQRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiKQRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:02:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C67DEC7;
        Thu, 17 Nov 2022 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nMNBUQ0gB1BIFI7lqf3e+d2exv3yiKu4pNt7fTaoekk=; b=n8T2mYbQBqFsPUd5HZ94HvFGMe
        fOuVtq9WOURbgYpta93uZg4mp/MQJMJDPe8EqRK7DWPmBNClpMUBYrJt/gfGnx/1hT1O9ieUOM7I9
        /qHyPfoOTYytBPw7FGmIbjBDmf8AF6BsIfb0XQv6rco1LjDhdt5bkNqvB/cu5nAx4ItoeaeNz2bdk
        ZKEF0bYjPKdi54xG2WsPGWnNZ695snVvJq2XxJ9PRJX/W43clK/iIRfUCHo/67lA91obL54EaSW8C
        WJ/8/E4ZTGp3pETz/bLmomO2jg7ZrGbS+098Dp6C3wgYpqCymjBbYP7wRPNZ8O1e8NJpbzSA+L3U0
        CAd0VuTQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oviHU-00GHGC-QO; Thu, 17 Nov 2022 17:02:28 +0000
Message-ID: <202224b1-ebd6-97b2-0868-c6a9102748a1@infradead.org>
Date:   Thu, 17 Nov 2022 09:02:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/2] math64: add kernel-doc for DIV64_U64_ROUND_UP
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117023510.2338176-1-liambeguin@gmail.com>
 <20221117023510.2338176-2-liambeguin@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221117023510.2338176-2-liambeguin@gmail.com>
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



On 11/16/22 18:35, Liam Beguin wrote:
> Add kernel-doc for DIV64_U64_ROUND_UP so that it appears in the
> documentation.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/math64.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

-- 
~Randy
