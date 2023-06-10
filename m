Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE71872AF04
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFJVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjFJVey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 17:34:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA04535A3;
        Sat, 10 Jun 2023 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SVQOiL58pzZ1OEe4MGs4zcbNyDX1FZkzmkO8QAtkpWw=; b=WWrsK13eS66WBEsTkpNrpYwjPo
        NPvwmYOiCpnKAmXvmIojgxv9pgjTIqhI+NFeU9YrIp35VaLskxI5Xy05T4E4MoTd0rn7qTyurdw7W
        schPT6wqZA7PdVohp3Ox6KLxHpk6tBukV6aQDTOPFyjTfQhsfObxm+V9If4qzfi2Nfw96i5CCpuTJ
        gj4jShz/sRMfimnP8R9x0ndKl6mSfWFK0olOcgDcTsCDLS2uzCRIjEnY0fOy5rUixeKhd+R/+173o
        AvmGY3oyNW75ErEa6fDD+MbqrLefqpsSthRfQe7Mh63JS4YGAFIq+TgkrWHVpfkw9yRI4PzFpr+Cr
        6T6iGkfA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q86EJ-00H6Iz-0G;
        Sat, 10 Jun 2023 21:34:39 +0000
Message-ID: <d2ff1125-e675-3081-fa00-fcdf56a3afdf@infradead.org>
Date:   Sat, 10 Jun 2023 14:34:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] Enable AMD3255 Proc to show negative temperature
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Baskaran Kannan <Baski.Kannan@amd.com>,
        Mario.Limonciello@amd.com, babu.moger@amd.com, clemens@ladisch.de,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Baskaran Kannan <bakannan@amd.com>
References: <20230610205357.5658-1-Baski.Kannan@amd.com>
 <797319c5-9b03-704d-2e32-fadcec924019@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <797319c5-9b03-704d-2e32-fadcec924019@roeck-us.net>
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



On 6/10/23 13:58, Guenter Roeck wrote:
> On 6/10/23 13:53, Baskaran Kannan wrote:
>> From: Baskaran Kannan <bakannan@amd.com>
>>
>> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
> 
> Please resubmit and either make the changes you were asked to make,
> or explain why you did not follow them.
> 

I don't know if anyone asked you to change the Subject: line, but you
should look at the output of
$ git log  --oneline dirvers/hwmon/

to see appropriate Subject: lines.

thanks.
-- 
~Randy
