Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5472A8E0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjFJDsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjFJDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:48:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D6335B6;
        Fri,  9 Jun 2023 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pfiNKoPyYFFiWG12s6o0wQH5ZBbYeJyeN7rBA+gUHVc=; b=fe9oa4f536Hp+ucK8zG10Hzohb
        cW0UJlLCOr6oEhU5P2th6t3FwRGpq5ickdoh8upFV0QzK9QNVEUT+KqE99wd3nOfkHJM5LLLbgtxm
        /UaPIZ2SwchtjG7VthGK44kxMHXb+wz2l2EX/xzYADINDule6T7PqQGkd+XLIC0W2ni15rQbwrQ7V
        Ha5POMbzxUMty/akIT0pKlLpABWUSH6NfbWpfjSbXVGOzktpkhIg9x9N1m8je4Y4vJ1fBbSzRUMlf
        t3PgdljdVI2M/CRLS5bHz/yg4Y6hxLvDjSVeZs7XawsD9ltj6kEI7RWEOejaFsEmAQlD4zsTqaDYn
        RPgKaqog==;
Received: from c-71-59-149-187.hsd1.or.comcast.net ([71.59.149.187] helo=[10.0.0.152])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7pa5-00F6lb-2L;
        Sat, 10 Jun 2023 03:48:01 +0000
Message-ID: <8db150f5-0a37-5ee2-c221-9cf150420fc2@infradead.org>
Date:   Fri, 9 Jun 2023 20:48:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 9 (drivers/s390/char/uvdevice.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20230609140618.532c4bcc@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609140618.532c4bcc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/23 21:06, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230608:
> 

s390-linux-ld: drivers/s390/char/uvdevice.o: in function `cpu_feature_match_S390_CPU_FEATURE_UV_init':
uvdevice.c:(.init.text+0xe0): undefined reference to `uv_info'



# CONFIG_PROTECTED_VIRTUALIZATION_GUEST is not set

Also, KVM is not set, so PGSTE is not set.

-- 
~Randy
