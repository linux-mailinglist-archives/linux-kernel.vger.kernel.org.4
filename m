Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021C35ED5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiI1HCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiI1HCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:02:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BE7B2A4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664348546; x=1695884546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qOEW5f8ioGdKEGmbuw9N3Q7nWNbHA0O8JWBj8guvtZQ=;
  b=QG0KOHClrdWNteFK1TEL8ZoxFqJBAEeujKIcXJqnYE1rB5GDqBA9zRnr
   H2YW6g0VVZJZrmeDxfxCOJ9u7gz+/C5bpS5opiq2xV/esaYRhq0FwjmHc
   sf1msVCAnMTq79JbCByjAtKEqxEQneHN2JxwpirmrSe0FpIOq67jiMotx
   9JVUv97oieUEAYadkgbo45+f4TdVzBweEFfkB1YNqXKETBiWd8RpHCv0I
   EGfpYZnAyzut+sIKJyO1utVF0QiJA2jOtQP2NMbf+rvYwp/RNtbkKkTWA
   JeEPEptmuc5OkFVE00tKdUBv/6NDz9p86UDS1gZFe3R4KpaRFoNDVAFGQ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217642620"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:02:25 +0800
IronPort-SDR: RfQJvdOp4+50g9Mh+mUh0bWHOUjq8knRs9x2L2E5w8Qfg7MnUNY3wbMU2GsZDRwzsh/HkHyIjX
 kGamCzDDlDzdALCtKtNd4T8WwpFKYDqDzvg0++C9vn92v9ip03gs6bjj1dPsQb8ylTmR3GR4Us
 CZ6xPds2tPGFMv1Hb3F9wjn8YDNIWthZODc6YFBRbz2a3TEuL+2Jd+yDX/CtF0iUAxCsz3hPGP
 gItAjlWizTkYefN2r5rVFYU60/Cnz0gaxGPFYX+9qdfJYHji4HlwGBo6nz/sS8FAY/QRlxBJm/
 pimtDoUIDdWsQsC1+VabFOBc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 23:16:49 -0700
IronPort-SDR: GfT28FGbPbiwaN6PMXcudoFmTi/T6lP7mWOKpxBEdhsxcpuP90LmU6ptmhYQVQfFlUb+ZQ8rWm
 PcvnlPdsLJQzPou1rQchJ41bQ0eFk6fXXruaESBiihhKHqa7KiRhfGTw2E4ry9ip7kMEREDwrd
 00CqI6/dAk07l0OUtVW6s59CGNcKOLRxBDTRCG3g/XStiDM+KZi1yMeoA8R4Zy4zx3oRL09rqq
 QTPnUaVLdNVqWTcgPQEOluJ0V199lTCrDvFb6De4/Q6817Ckt97eteuIoexWJW+AwCMayHGGBS
 MM8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 00:02:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4McnVm754nz1Rwtl
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:02:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664348544; x=1666940545; bh=qOEW5f8ioGdKEGmbuw9N3Q7nWNbHA0O8JWB
        j8guvtZQ=; b=ATjCGLQOJlxI0DE3dotUOlFGytsjJ81/2B8H1gmKwJFHH74BjxX
        AgFONfzJFyuoXw1chT41K1kkfVKD1AjDWC+TMru6/HsXyPIt2sKagOGBiC5l8v9L
        g8MAZme+A5kmR3l5rUG0Y1MlzMy2ajgwOIiML8YDV/QFUvTA0XX00PG3a1hR1PCr
        oQ+M85Wr0zzmm2OzS/bBtWyfL/lHrWofqbRDhNWdRGx7yi4YzfSWdd039hdqtKi2
        wITRws1CXGkX2bS5DoXE8W91yA1CiIGuYA789UbVXSc33wAsclofGE2KWITRn8Cg
        GDLKWUadu8NBNsWCCjGsFVBk1Whop+81fPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DGCHLTyfMAOK for <linux-kernel@vger.kernel.org>;
        Wed, 28 Sep 2022 00:02:24 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4McnVk33Jbz1RvLy;
        Wed, 28 Sep 2022 00:02:22 -0700 (PDT)
Message-ID: <e3bfbe7e-baee-9f4a-7d55-c6dc27e3eba1@opensource.wdc.com>
Date:   Wed, 28 Sep 2022 16:02:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 3/8] scsi: pm8001: use sas_find_attached_phy_id()
 instead of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-4-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220928070130.3657183-4-yanaijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 16:01, Jason Yan wrote:
> The attached phy id finding is open coded. Now we can replace it with
> sas_find_attached_phy_id(). To keep consistent, the return value of
> pm8001_dev_found_notify() is also changed to -ENODEV after calling
> sas_find_attathed_phy_id() failed.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Looks good.

Note for future patches: if you change a patch, it needs to be reviewed
again. So please drop any review tag from the patch commit message to make
that clear.

> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 8e3f2f9ddaac..b4007c4f157d 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -645,22 +645,16 @@ static int pm8001_dev_found_notify(struct domain_device *dev)
>  	pm8001_device->dcompletion = &completion;
>  	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
>  		int phy_id;
> -		struct ex_phy *phy;
> -		for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
> -		phy_id++) {
> -			phy = &parent_dev->ex_dev.ex_phy[phy_id];
> -			if (SAS_ADDR(phy->attached_sas_addr)
> -				== SAS_ADDR(dev->sas_addr)) {
> -				pm8001_device->attached_phy = phy_id;
> -				break;
> -			}
> -		}
> -		if (phy_id == parent_dev->ex_dev.num_phys) {
> +
> +		phy_id = sas_find_attached_phy_id(&parent_dev->ex_dev, dev);
> +		if (phy_id < 0) {
>  			pm8001_dbg(pm8001_ha, FAIL,
>  				   "Error: no attached dev:%016llx at ex:%016llx.\n",
>  				   SAS_ADDR(dev->sas_addr),
>  				   SAS_ADDR(parent_dev->sas_addr));
> -			res = -1;
> +			res = phy_id;
> +		} else {
> +			pm8001_device->attached_phy = phy_id;
>  		}
>  	} else {
>  		if (dev->dev_type == SAS_SATA_DEV) {

-- 
Damien Le Moal
Western Digital Research

