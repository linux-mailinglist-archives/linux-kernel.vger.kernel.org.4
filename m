Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454456FB686
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEHSz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:55:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362FE5FE6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=sFmS593k5JYIG6Y6mBz5lD1bpF/IGbDpeAilaPVo3QY=; b=me1Q7wHVbMu89bCBKN9JpNQFuh
        P9duQkiJTguZq8JfDcCbDAg7ZTeXUVf6sO2ak/+q6S5OHB7+7G9Rs3mh96QXHZ3bWy5kCW/gpcavh
        1BIDIVA5QcxFTz9+uG271nTeU4gKAHseXkeuMzd63dYqObnzkLVS9/C84rBIHQYtQkRwhr/IFan5u
        y7zWeg4mrfdtoPzlXLa4xuAnfv1KLMooa7WAXOuapgpsnKP+IC+/NaMVv8TXyb7IPC/E1UlJFKSgs
        NVAe/Sh1CfB0CWGp6PzlTERICaySsQPW4H6rWOQISBhmn8Z5qU+i3DNHEu+yyivL1x/N0N0Aa8Wxu
        /a0+rcVw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw61T-0019u5-2U;
        Mon, 08 May 2023 18:55:47 +0000
Message-ID: <0a75a41e-6458-8f7a-67cd-89eb05eb822f@infradead.org>
Date:   Mon, 8 May 2023 11:55:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] driver core: device.h: add some missing kerneldocs
To:     James Seo <james@equiv.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230508154849.1946589-1-james@equiv.tech>
 <ZFkftcxqQRblDgzX@equiv.tech>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZFkftcxqQRblDgzX@equiv.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/23 09:13, James Seo wrote:
> On Mon, May 08, 2023 at 08:48:50AM -0700, James Seo wrote:
>> Add the missing kerneldocs (except for DEVICE_ATTR_IGNORE_LOCKDEP(),
>> which is only meaningful on debug builds with CONFIG_DEBUG_LOCK_ALLOC
>> not #defined, and is aliased to DEVICE_ATTR() otherwise).
>>
>> Signed-off-by: James Seo <james@equiv.tech>
>> ---
> 
> I just noticed that there shouldn't be a "not" before "#defined" in the
> last line of the commit message. Apologies.
> 

Other than that (above), LGTM.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
