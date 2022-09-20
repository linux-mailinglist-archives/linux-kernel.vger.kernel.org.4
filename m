Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008C55BE954
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiITOsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiITOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:48:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356CC58B40
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TwHHjLSb/3B92HnbWvhN8I/TcbGfmh11K5oo3jdWgNs=; b=C7wB+jWCfEd71+mAqXSsbaSLdN
        VTkhdJU8Blkh7ORudNPBg0DSDNyQgV2zrnZ+UDNLutzQxZOTqbbXUoPLNxQqpqxm+y4lAGPBBTVgX
        jQMh/03K2Jn6CWi+3CMwHhPhOdLZN5SwrcYANmm8bQJMH1xyUb+DBxDbGH5EJg08vVYgX67pL4r7+
        7aIf4SVL5kMYx4JPuVTw3d8s1R1IMCRK0oocw/uKVgsAMiUk7XblNUkjnVvpjfhj7AYVSzjHkZMGe
        OILH2a9Iw3EDRcHyjPpq2qtQXVMJ4rBokIKwZjc/KxBUA5M4XDUhyyRbGMhjisEUnDxIyCZrsp+Ms
        g67JVDvQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaeXT-004awq-Oh; Tue, 20 Sep 2022 14:47:56 +0000
Message-ID: <0fbe656f-bc96-6ec0-4fab-2e020484a9a8@infradead.org>
Date:   Tue, 20 Sep 2022 07:47:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: ERROR: modpost: "vmf_insert_pfn_prot"
 [drivers/gpu/drm/ttm/ttm.ko] undefined!
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209181951.Wdmac1wt-lkp@intel.com>
 <d369f23b-8c14-1d72-8d1c-2c3791a09b1b@infradead.org>
 <bae0ae28-b3b7-765d-3ad1-aed269046437@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bae0ae28-b3b7-765d-3ad1-aed269046437@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/22 02:19, Javier Martinez Canillas wrote:
> Hello Randy,
> 
> On 9/20/22 08:04, Randy Dunlap wrote:
>>
>>
>> On 9/18/22 04:08, kernel test robot wrote:
>>> Hi Javier,
>>>
>>> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
>>
>> On 2022-June-19 Javier said that he would merge my patch:
>>
>> https://lore.kernel.org/dri-devel/5eabd169-b8a0-fb8f-d70b-4495d3790f05@redhat.com/
>>
>> What's up, Javier?
>>
>>
> 
> Sorry, you are right. I've pushed now to drm-misc (drm-misc-fixes)
> after fixing the commit message and Fixes tag as we talked before:
> 
> https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=d8a79c030549

Yes. Thanks.

-- 
~Randy
