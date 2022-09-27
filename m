Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032C5EB92F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiI0EZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiI0EZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:25:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978016CD2F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664252722; x=1695788722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZX5ScZxEDRRPrjPNxZCwWnXDrfGgHDWgIXxYCuy/rXg=;
  b=YkJTfut220H0uA7cYWe5wXq9k4uq7RvBx42VdYAHp5GKdvVT70TSkMk9
   FBrQ3n/UZEk/qvKl+HN1xw0PGh/SIjHot+YxyJwoD3x9NCnPGI5i82Zxj
   A/M7ILNmRhv4Nu9eAN80B8wnGCunFvk/HjoHKMNA7kung2tFat/7/EBeu
   PM726oKHgJJcVWURmRRnDB68P2Tz0irmA3hjr9Za6l4bcrCn0VKAPuszs
   U4l/b5w8F8bnrig8kwH90hNJxqnxnlueAmgByVE2Ew/2i8hq241nhDBhg
   GYnp3gshlXiRc0Ek7EtrkCezx3UI2O++wEA1HW+0GIdiiPb5qLCBrXPLG
   w==;
X-IronPort-AV: E=Sophos;i="5.93,348,1654531200"; 
   d="scan'208";a="212767269"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 12:25:20 +0800
IronPort-SDR: arjonVyP12rHlYL9Y8De2HK4fYBRZiRJmwsjaNnW+tvx3h2qR1yIcwpAaBSNLdXgHSCCfgH16E
 eYJ4vnEJNeb1aUdxhn49o9gMKj+t/YLurCG135S04CoOjt2KeDlRNz/EA1TeT5wQP3VobIyf3Q
 KcFzD+gBtsqh5CkVJvIPYXYtfEgARdR+C7E3ZVRLSI97VEdfck8x4wvHNis1UYMxvZyks8ngCb
 6OD7HFwLxvmH5LarWktyF0sUYXDgvIcyhRC16GDGtkThidzfpD9wm7vFL70IgQBwE7lrtfCEJc
 7gM4fqLn4rla2hb/YCdohNK3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 20:39:47 -0700
IronPort-SDR: 6v3vDQiRa92y7WWO9/jN3aJhpdyJK1Xq1EH2T+X5isijwuGXyNzuq55olqO3pqKQsat+qH0AF9
 iVBmW4itjSgau7xQXhL5t7nNjkNt9Brk58CMz05O2o1wm30hDbLeRmY4pU5xNSmrblWs/4KNJo
 iMWwpj4Mu39F87BzJKCv84llae2UPWTSh75g6hr8lcV17zhu62iGyqdUk+YuHG2zzdsChVeQ7R
 7Mi9TupRlBFeNfELHqvBg4t+ABG0+VJxPpHekdREM+vqFEnqVz6dFG9rFK+I3InHNdCgWWDvsJ
 mTw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 21:25:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc6403zp8z1Rwtl
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:25:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664252719; x=1666844720; bh=ZX5ScZxEDRRPrjPNxZCwWnXDrfGgHDWgIXx
        YCuy/rXg=; b=qKcD8V6JDfpnkoO3PsUh3Du4DG9rH0NqQ6dUoy1OZ2H/GiQeOT8
        hvXeSzgbCTncSgvaGXU1dUsK6hFS7kg+zuop3RZGlhFelr8xnmpSiHmkC6JGsRoo
        WUqH+SFVWLH7HkNFmfvDuJ+J3MxBAuifozjHljJhdCDOdcAYP24q3Q1B4w89SyUH
        5LOydn75D5hsl2H6aMB4Rz+jUo8hazkr5dnAt114VizOyI4S1kRqVoiKE0+ULE9K
        nMsKo+0d0iATQO/FMv2A3AdZEqoQA9lB1VXUdwPMh/GlBzIMFureK0bSgh9c7ovS
        6WDSAKq3fsqF+sfYGRn7mIuNoVLJIuVTiBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2oO8ampItuyB for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 21:25:19 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc63x6bkyz1RvLy;
        Mon, 26 Sep 2022 21:25:17 -0700 (PDT)
Message-ID: <390e2a2f-c54e-69f6-a0fd-27e00adcf214@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 13:25:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 6/8] scsi: libsas: use sas_phy_match_dev_addr() instead
 of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com
References: <20220927032605.78103-1-yanaijie@huawei.com>
 <20220927032605.78103-7-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927032605.78103-7-yanaijie@huawei.com>
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

On 9/27/22 12:26, Jason Yan wrote:
> The sas address comparison of domain device and expander phy is open
> coded. Now we can replace it with sas_phy_match_dev_addr().
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/libsas/sas_expander.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index df5a64ad902f..06efdfc11d2e 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -738,9 +738,7 @@ static void sas_ex_get_linkrate(struct domain_device *parent,
>  		    phy->phy_state == PHY_NOT_PRESENT)
>  			continue;
>  
> -		if (SAS_ADDR(phy->attached_sas_addr) ==
> -		    SAS_ADDR(child->sas_addr)) {
> -
> +		if (sas_phy_match_dev_addr(child, phy)) {
>  			child->min_linkrate = min(parent->min_linkrate,
>  						  phy->linkrate);
>  			child->max_linkrate = max(parent->max_linkrate,
> @@ -1012,8 +1010,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
>  		sas_add_parent_port(dev, phy_id);
>  		return 0;
>  	}
> -	if (dev->parent && (SAS_ADDR(ex_phy->attached_sas_addr) ==
> -			    SAS_ADDR(dev->parent->sas_addr))) {
> +	if (dev->parent && sas_phy_match_dev_addr(dev->parent, ex_phy)) {
>  		sas_add_parent_port(dev, phy_id);
>  		if (ex_phy->routing_attr == TABLE_ROUTING)
>  			sas_configure_phy(dev, phy_id, dev->port->sas_addr, 1);
> @@ -1312,7 +1309,7 @@ static int sas_check_parent_topology(struct domain_device *child)
>  		    parent_phy->phy_state == PHY_NOT_PRESENT)
>  			continue;
>  
> -		if (SAS_ADDR(parent_phy->attached_sas_addr) != SAS_ADDR(child->sas_addr))
> +		if (!sas_phy_match_dev_addr(child, parent_phy))
>  			continue;
>  
>  		child_phy = &child_ex->ex_phy[parent_phy->attached_phy_id];
> @@ -1522,8 +1519,7 @@ static int sas_configure_parent(struct domain_device *parent,
>  		struct ex_phy *phy = &ex_parent->ex_phy[i];
>  
>  		if ((phy->routing_attr == TABLE_ROUTING) &&
> -		    (SAS_ADDR(phy->attached_sas_addr) ==
> -		     SAS_ADDR(child->sas_addr))) {
> +		    sas_phy_match_dev_addr(child, phy)) {
>  			res = sas_configure_phy(parent, i, sas_addr, include);
>  			if (res)
>  				return res;
> @@ -1858,8 +1854,7 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>  	if (last) {
>  		list_for_each_entry_safe(child, n,
>  			&ex_dev->children, siblings) {
> -			if (SAS_ADDR(child->sas_addr) ==
> -			    SAS_ADDR(phy->attached_sas_addr)) {
> +			if (sas_phy_match_dev_addr(child, phy)) {
>  				set_bit(SAS_DEV_GONE, &child->state);
>  				if (dev_is_expander(child->dev_type))
>  					sas_unregister_ex_tree(parent->port, child);
> @@ -1941,8 +1936,7 @@ static int sas_discover_new(struct domain_device *dev, int phy_id)
>  	if (res)
>  		return res;
>  	list_for_each_entry(child, &dev->ex_dev.children, siblings) {
> -		if (SAS_ADDR(child->sas_addr) ==
> -		    SAS_ADDR(ex_phy->attached_sas_addr)) {
> +		if (sas_phy_match_dev_addr(child, ex_phy)) {
>  			if (dev_is_expander(child->dev_type))
>  				res = sas_discover_bfs_by_root(child);
>  			break;

-- 
Damien Le Moal
Western Digital Research

