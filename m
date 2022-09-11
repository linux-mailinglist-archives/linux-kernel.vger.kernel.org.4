Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5A5B4F6A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIKOSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiIKOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:18:49 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012D21245
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662905928; x=1694441928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ZeosKCdRqJre/8DiboNXUF0h0xy40H1IiMlnXbs1ts=;
  b=adZE2pMzG6X4VpOvqc5IuK0HychrImAl/63pnc3dSQMi5sj0/IShqzBs
   L4ZEpOVnnY64rC7MeXpMkwivfgBB7qlwndZs3Yff9l1c9JC+p1uKy2ICa
   4sBBgSC6hz5EfW7WsSwmOfdJukSd72ivMfX1RRohmoirtDRjrpQM72RNr
   h6ta9jdnatjetr1sAoveMGwauWqSRHbA+Z/gOgXVQS5OfHjJoxDsC4icD
   Qfm+RV06+c2XZFIm7ee8LmS2B4F51fGVAtM8y4lx3cMDYa8B9tRYzpTF4
   pdegOFCjmdAai9yuMGREzL9LjfP7l6jED1LVE7ZZX5PSqAmP3SxaoHv1H
   g==;
X-IronPort-AV: E=Sophos;i="5.93,307,1654531200"; 
   d="scan'208";a="323164908"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2022 22:18:47 +0800
IronPort-SDR: dca/WEYOpMgd5J2vtZltinpb8KwqgWN4TIGPzxEv0JUWyW6Q9up5acpBVhXRKceTIxY9g9xKRv
 bw523sj2vqXl9xqnJbMgpVhNZnjq4B8NuCi+ZETa0/BcxL/jY6WVAoGHToyoUsSeGOEgQnLSI2
 dB0wfBsKvLAM5eO4P/JUzZEs0WE//xbJmRdPIKJspKBeRiIMHOtBFtH1E8eTyI4yaxiMky99ZQ
 Ph3IJUMGQ5xntmCQIrb8Jyq4D3Jae3KDV5A+P0xHxISPFVVAdlVTFlbsrpvxz2vQ0Y2tjgfv7P
 DnrKM4iiqgs0P0ACb8qu8FKM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2022 06:33:37 -0700
IronPort-SDR: CoSAOp//LA6y6q8Z5Zm8ZV8lFvA20rUm+7u97hOqbrsQrQ3bj6wbMuqQJXaACOqBBsTIXBbw66
 aINI7PbPewmQNeRTITPXmWZhPotSXSJn4l9XbEKsQJnqxDNVbtBsbFyowhTtXd9x8z1kN8uVdF
 I8ZteOVAZRMyqI802/uNhUhjiYVEBBvKEVjWB7zUZSGvYbeACst+mdyCmmjN2yzoFLoaluAhS2
 P97ISyySZN8Yj27jXeYh4ekxHLGzdQ2Ytku9W4iHWqnSoSO+bxn+xLAMMCPSsZpe33Rpa3bmen
 VLk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2022 07:18:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MQX064hTRz1RwtC
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:18:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662905925; x=1665497926; bh=1ZeosKCdRqJre/8DiboNXUF0h0xy40H1IiM
        lnXbs1ts=; b=j4h2ZE/9PX6h/2kYKLziwwoSgdmonXasjWQwvwVH6ACmLFoeoQC
        RIAi/oynNfqjDavUA/A9ZlQSaIU2wt6G7N+Z5LeY0j6WKkCIQEexOpArbHZcK7rz
        608Gw/tG/qm0KYRDg3nUrrcfMhvhif7729OMuAtTtXRmcRCPBX1eOw6PVAZdXj26
        gTwhvg7Z0Zmm3wyLcqoAHrL2j9S1ZRcP/v5z3Ha2/05VGkPZA11LtjpPoZPaY63A
        pD8vGUpLde2i8Xeu3yNpleGpo4howJ9GIfSdaSoruNfpKDdhzsGhkW+hIdnuibbG
        6dB1jAdwiBHJNCV4FGuKPh40dmLBeCSQyTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OysM0BdQdxrH for <linux-kernel@vger.kernel.org>;
        Sun, 11 Sep 2022 07:18:45 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MQX024lcsz1RvLy;
        Sun, 11 Sep 2022 07:18:42 -0700 (PDT)
Message-ID: <99d7c533-f19e-a52a-e532-2a07cd78e9b9@opensource.wdc.com>
Date:   Sun, 11 Sep 2022 23:18:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of
 creating a PPC dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
 <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
 <2379456e-4f18-d619-10bf-022327de0463@csgroup.eu>
 <4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com>
 <0ad5f339-de31-2849-34a1-928ae65cc696@opensource.wdc.com>
 <c4f3d527-7e70-4077-b40b-129144d79374@www.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c4f3d527-7e70-4077-b40b-129144d79374@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/11 21:41, Arnd Bergmann wrote:
> On Sun, Sep 11, 2022, at 1:54 PM, Damien Le Moal wrote:
>> On 2022/09/09 20:31, Arnd Bergmann wrote:
>>>  
>>>  config PATA_PLATFORM
>>> -	tristate "Generic platform device PATA support"
>>> -	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
>>> +	tristate "Generic platform device PATA support" if EXPERT || HAVE_PATA_PLATFORM
>>
>> Shouldn't this be:
>>
>> 	tristate "Generic platform device PATA support" if EXPERT || PPC
>>
>> ?
>>
>> And while at it, it would be nice to add "|| COMPILE_TEST" too.
> 
> The idea was that this can be selected by CONFIG_PATA_OF_PLATFORM
> in any configuration that has CONFIG_OF enabled. Since PPC
> has CONFIG_OF enabled unconditionally, there is no need to
> make this option visible separately.
> 
> Same for compile-testing: since CONFIG_OF can be enabled on
> any architecture, PATA_OF_PLATFORM is already covered by
> allmodconfig builds anywhere. The separate HAVE_PATA_PLATFORM
> is only needed for machines that want the non-OF pata-platform
> module (sh, m68k-mac, mips-sibyte arm-s3c-simtec).

Got it. Thanks for the details.

> 
>        Arnd

-- 
Damien Le Moal
Western Digital Research

