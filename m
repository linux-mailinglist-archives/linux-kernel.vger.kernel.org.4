Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D480695F31
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBNJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBNJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:29:00 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AC7DB1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676366908; x=1707902908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Ckkp53UAyC9U2WznllXQH3WfWvQ+d2yQVlYyIbkiWU=;
  b=KXiErh76rM+9aaMW9v2ieQ9NZGwQfArKzTJj28lNWArz51lYvZB2Ifmo
   HGohQaRUBgruoratlDbDrmqg7Ak4ED7Ig78fSd+DykFKy1yAW0Qw7Rzkf
   vy1QTYlU8RlrLZlIHiMf6sf6RbtlunQV3b6eBjbvC3linnCE8GPM4mlrN
   dJ56IrvfrT35ud4N/KhJISr1z498yo9ZhmHiREHKxknd8+D3GeT5zLvVZ
   apF9ZorPWagyDVKPA0btk5MvlqkUhwq8uD+gUIVKu52S0Si5U4UrRRbUR
   xKBoyxaCbpVvaSWmaAQ2L+nYypMAYyYsb09Jyui0HWy+tmJDwe9A6lppN
   A==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669046400"; 
   d="scan'208";a="228227569"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 17:27:10 +0800
IronPort-SDR: cHYFRhuYtQzLoBA2pvDmL0PW6syMvm6FMIy/AGfqVHvo8q8qEExaWdCHg+5eqRMCHw1YMrqSbZ
 jfBuvRB+pSxlrSu4CJBKA943FSY+tlqruYR5ygIUbbZmMGUZ9JBrbBdEYvP4r1dG6+Ekq3Oaip
 Rv/He9WuUPNJ2Noerwv1RNVCpQcDlc7AChwDOxfmuXsPGGuDWimT3xNFa3tON7DwwyniniCwlA
 oiUtpTry6ggXDboQHF4bVRDYVUPivz8gd4PHRn9LDWsXvsFcmhzfWQ1F6epht8mroHkNbXCewL
 244=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 00:44:18 -0800
IronPort-SDR: IpRZ01C72TL2Iiz+o6estu0aW5LW54nsuoaPWsvDkL6ZqqI26fuWgSUL7L0l/yEK8zTUEIOzXL
 PNgjcBTbb358vvJN6kTI7omLT9manv3PK8h8PL/PoN1E9mmv0JOXwF5KyJvxxMl4kIDeHCVM5a
 chP6ZHqJxX7RtuYxIaavURPMCbigkjA2u2TSEhL+Rdw9ZJHY5YPgNkBe3EJVsTBPO8y8v1Fjwa
 pjRUstLSTU3cm1xVScgThNBcxsjQT+zna7l9XOBw0FTCpVNjSZLvPJS+JDawNpvGLblJrrDkdQ
 +dY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 01:27:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGG7f1Tbvz1RwtC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:27:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676366829; x=1678958830; bh=6Ckkp53UAyC9U2WznllXQH3WfWvQ+d2yQVl
        YyIbkiWU=; b=iV9yNS5ZYFVB7mzxp3NevnIeRSzx5l17oS4vccRmbxFVaQ4mGp0
        /tmY2xIRXPuciHRUIpZJIU4AkIYCTpMdornPtAgoyfbK5xF928VN7hRW13q1pInf
        tR4GMh6bNFoZ+Uz31UR9/8AHf3eyE0ru7jKZE7Et7p25HWd3Ob0pHO+oBRPcvyxB
        nMuN4RfgCyxU5Sq8gz4AxO1vwvABU9+/7A/O4ncn+m8+31+ZoA/6O9KszOqVplSZ
        cn53Whj6VyQAkdYO8jtvWdDXcmwr1qMrOZuGyslpIccO6lLQMPLQJ0Vk8rp+3qZp
        auBkb7bddZd+dJaSGLyrV8MLeCa32Gk4tAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rQqddLigbiKf for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 01:27:09 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGG7c312yz1RvLy;
        Tue, 14 Feb 2023 01:27:08 -0800 (PST)
Message-ID: <dafa3a1f-3661-72d3-6423-22e8399b333f@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 18:27:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
 <51fb5b13-3e9c-785f-b96f-6f398389d434@gmail.com>
 <c67e4b38-7bec-0901-b13d-6390c1d51cd8@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c67e4b38-7bec-0901-b13d-6390c1d51cd8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 17:35, Sergei Shtylyov wrote:
> On 2/14/23 11:33 AM, Sergei Shtylyov wrote:
>> Hello!
>>
>>    Hm, why didn't you CC me?
>>
>> On 2/14/23 12:25 AM, Randy Dunlap wrote:
>>
>>> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
>>> all "/**" comments to "/*" since they are not in kernel-doc format.
>>>
>>> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
>>> Cc: David Daney <ddaney@caviumnetworks.com>
>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>> Cc: linux-ide@vger.kernel.org
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
>    Oops, replied from a wrong account... :-/
>    Damien, please let me know if you need this fixed...

Nope. That is fine. A review is a review :)
I can fix it with your usual email if you prefer though.


-- 
Damien Le Moal
Western Digital Research

