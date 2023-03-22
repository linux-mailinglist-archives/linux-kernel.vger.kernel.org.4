Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464A66C40EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCVDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCVDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:21:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57630559FC;
        Tue, 21 Mar 2023 20:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=DSyI8L5oT8eOqUOSX8aSXNDzQ40wNn5rmXBNbP1Vl/I=; b=f97vUw9NR76Vf9DY8rj3DhncTg
        1dk9JXIvIaYWwy06I4CWh6DY5f6k/R3dHsBaKsD9RvY0PeEvla3Oj+oDyQouT1vnJ69la57Z950nh
        qnOcCudCmroTgtmwaYOnwvVvAWnXawpCHiBYh1VPsTOYk6ssdoW0GkC/j0M5zEN15pOwojjnCCOWl
        i4Hdu1bohsa+3kBRcGG0n9rO6/gKWrPeDE71dJQ7nY6+ulN+dyI+L3XYSU849i9MtJoQlSzy1In/t
        oO/8q/n9SmB8DdZgSdkzdFWI8/GDsLC2KPju1+juadsV85QXbv91OxwyK2310+Ha994xVePUG7ZVd
        nVsb63AQ==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pep2d-00EQDw-1m;
        Wed, 22 Mar 2023 03:21:35 +0000
Message-ID: <ee585b21-7b75-c7fe-57fd-ad6d35986a11@infradead.org>
Date:   Tue, 21 Mar 2023 20:21:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] of: fix htmldocs build warning
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
 <20230310113258.463f836c@canb.auug.org.au>
 <b8e8e51e-1ccf-e413-0831-ae5f70da539b@infradead.org>
In-Reply-To: <b8e8e51e-1ccf-e413-0831-ae5f70da539b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/9/23 20:52, Randy Dunlap wrote:
> 
> 
> On 3/9/23 16:32, Stephen Rothwell wrote:
>>
>> Fix this htmldoc build warning:
>>
>> include/linux/of.h:115: warning: cannot understand function prototype: 'const struct kobj_type of_node_ktype; '
>>
>> Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creation functions")
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 

Can we get Stephen's patch merged, please?
Thanks.

> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.
> 
> After this patch, there is another warning for this function:
> 
> ../include/linux/of.h:118: warning: Excess function parameter 'phandle_name' description in 'of_node_init'
> 
>> ---
>>  include/linux/of.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> This is actually untested, but seems pretty straight forward.
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 0af611307db2..814d33f3835a 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -100,6 +100,9 @@ struct of_reconfig_data {
>>  	struct property		*old_prop;
>>  };
>>  
>> +extern const struct kobj_type of_node_ktype;
>> +extern const struct fwnode_operations of_fwnode_ops;
>> +
>>  /**
>>   * of_node_init - initialize a devicetree node
>>   * @node: Pointer to device node that has been created by kzalloc()
>> @@ -111,9 +114,6 @@ struct of_reconfig_data {
>>   * whether to free the memory will be done by node->release(), which is
>>   * of_node_release().
>>   */
>> -/* initialize a node */
>> -extern const struct kobj_type of_node_ktype;
>> -extern const struct fwnode_operations of_fwnode_ops;
>>  static inline void of_node_init(struct device_node *node)
>>  {
>>  #if defined(CONFIG_OF_KOBJ)
> 

-- 
~Randy
