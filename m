Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1076B6C82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCLXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCLXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:18:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC8F764
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678663085; x=1710199085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74R5irxjgYlSr4yhr9cCXldvYivv9NABOS/YyCLCL70=;
  b=BIdPS31VpH+iB0+Q3nhHftfWrQg93L8eJqdt27pB2TRtdbFq/noV0i+0
   b7X6Ykkf0V2prTFaIgT9uS9XJGSIn+5DNTfPBEGrEyZlJY2JHgiLPAcGv
   kG1nxsanX5jAT6ZLzM3Lhmw4ctRqTZvWzl2YjX+7DqGHcgvieSaICYMOE
   ThY1TJ9ZxjWWp34kNrgJBxEoSqNj3fMw2PmRmPByb9SIzYm4/Mj9girYT
   jky2nS4sqMTTR+Xcv/KeQN6Wf/MQUUZKBzdQtvv712OXmGEW/rdlmRvca
   E84KpBmcxP5iIzNIDOiIB4CsOjFtpG6D8ycJO1w33ky8klQ2nzy5+5JQz
   g==;
X-IronPort-AV: E=Sophos;i="5.98,254,1673884800"; 
   d="scan'208";a="230404647"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 07:17:15 +0800
IronPort-SDR: 6olvhsWVebrX5wpIffcD8M8f3K4UyaNKNURQSk0WJIev40/27axL6tCye/gvb1URyplDTb5STG
 V67Y65dtE70J1mh/LPxZW4KxlMJnqeSSBqccLBozqcKScd6QEHy4uJbrlSzH5qUNm3e1WlhGfT
 jvkU4KbxmNNDhehwo/UAbOiYcuB2irorMKZkez0H3xHByn4ow3zDqfxMREfToXU7q7Y1Q3eH7s
 DHvwSIO5aCE+RoqXHpNpgjpG9YWMPllu3JIZzuQeKchVuxBqBTQ9KvrIyfk0L4z/m/UhyeVzPI
 8yo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 15:28:04 -0700
IronPort-SDR: +4ZnBU/pCXGHBi5HojfQJXmteh2QWKgQaKe23lw8lHoRtcqIsQptUGo9TLcDCEQd1kYtJWwjzQ
 GxHbey3Q4Brj3Aho0YMVEgR/tUZKwOgsgzE0XuTcF4VEnFDPQCARrwb+mg3Fx2cXIGLK4q0c4A
 /UYABpu5JnILWFPaP9UZBM9MYmDZxYgzKIMMMgoUxC0VMABmE6dUvOX+luBnF3fteRRZSm7lFh
 8qKHpE/ujxmBtbsXCz5blKojilE9NgNPmboc9SHi3V5YCv84imXBeyPVbR2r7PiXGpkA/bN1ae
 /X0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 16:17:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZbKR222Vz1RwqL
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:17:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678663034; x=1681255035; bh=74R5irxjgYlSr4yhr9cCXldvYivv9NABOS/
        YyCLCL70=; b=KAgXTulmY3chQ2KGDIGycK03RqqXs7g/uxdMQ6PZremiZU64l7a
        TUjx47AwOI2hVxDbHTHf07O2O3DC6Xq514apEPpk+LX5qjXKnOVaqXLLksOrb2ig
        9ysTLRVOKvuW5+Gg5OzDK8BagcwUyX2jYVuYyFfY9Wn4X0On1jqQSGXHu0sGHDwb
        5hsvRp7PUYh6W/PJqy2vB4Wtpg4OEwIH7xE9vLucwh3G2c5+Ze58zji3VSqwf8JH
        nyxYEd107FwhZZxlm7M4MLrYrN2QpF2nkgC0/BIgQEJWBr0fU9RooZ5/rEhlWBNP
        d2BPSD7p940HG1JZ3f6xdr+01y8hE/WB9jg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n4vF1Z9gwuUc for <linux-kernel@vger.kernel.org>;
        Sun, 12 Mar 2023 16:17:14 -0700 (PDT)
Received: from [10.225.163.79] (unknown [10.225.163.79])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZbKP652jz1RvLy;
        Sun, 12 Mar 2023 16:17:13 -0700 (PDT)
Message-ID: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
Date:   Mon, 13 Mar 2023 08:17:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] pata_parport: fix possible memory leak
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303112239.21234.linux@zary.sk>
 <20230311214447.7359-1-linux@zary.sk>
 <8b0eb4d0-ca10-35a5-a74c-fd0f7d11713c@opensource.wdc.com>
 <202303122224.29035.linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202303122224.29035.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 06:24, Ondrej Zary wrote:
> On Sunday 12 March 2023 01:56:25 Damien Le Moal wrote:
>> On 3/12/23 06:44, Ondrej Zary wrote:
>>> When ida_alloc() fails, "pi" is not freed although the misleading
>>> comment says otherwise.
>>> Move the ida_alloc() call up so we really don't have to free it.
>>
>> Certainly you meant: "so we really do free it in case of error.", no ?
> 
> I meant "so we don't have to free pi in case of ida_alloc failure".

That is better. Please rephrase the commit message to this.

>>>  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
>>>  	pi->dev.parent = &pata_parport_bus;
>>>  	pi->dev.bus = &pata_parport_bus_type;
>>>  	pi->dev.driver = &pr->driver;
>>>  	pi->dev.release = pata_parport_dev_release;
>>> -	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
>>> -	if (id < 0)
>>> -		return NULL; /* pata_parport_dev_release will do kfree(pi) */
>>>  	pi->dev.id = id;
>>>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
>>>  	if (device_register(&pi->dev)) {
>>> @@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>>>  out_unreg_dev:
>>>  	device_unregister(&pi->dev);
>>
>> Same comment as Sergey: isn't this going to do the ida free ? So shouldn't you
>> return here ?
> 
> No. device_unregister() calls pata_parport_dev_release() which does only kfree(pi), not ida_free(). But it probably should do ida_free() too.

Yes, it should, otherwise you are leaking the ida with the normal (no errors)
case. Care to send a fix for that too ?



-- 
Damien Le Moal
Western Digital Research

