Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93901723E00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjFFJls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjFFJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:41:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F610F3;
        Tue,  6 Jun 2023 02:40:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3569ei3w057409;
        Tue, 6 Jun 2023 04:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686044444;
        bh=w8SrY+ikkcMi7SM9PmtVDxwhrCdH5GJSMEEsUmqJS5s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=o435kgmjuDhakcO6daN39eT4zwGfSCqW/SwSDOkAGMSJQOCI6EHlZ2UmStlTLX3Vr
         BBcOBOUGJiYABA1jtyugir6DcumnDp9+ftRrjDwrB7XlTluGxE1uA/hWRxB/Kb8PSq
         7piu/BwppWwgCxifx9cWwNppqZEbnYIm70XrEReU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3569eicD088715
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 04:40:44 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 04:40:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 04:40:44 -0500
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3569eeL3125049;
        Tue, 6 Jun 2023 04:40:41 -0500
Message-ID: <773f4723-65f4-9bad-6ab3-bda65e5a4319@ti.com>
Date:   Tue, 6 Jun 2023 15:10:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH] remoteproc: pru: add support for
 configuring GPMUX based on client setup
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Bjorn Andersson <andersson@kernel.org>, <rogerq@kernel.org>,
        <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230601105904.3204260-1-danishanwar@ti.com>
 <ZH4aywQoA9gy2OWU@p14s>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <ZH4aywQoA9gy2OWU@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 05/06/23 10:56 pm, Mathieu Poirier wrote:
> Hi MD,
> 
> On Thu, Jun 01, 2023 at 04:29:04PM +0530, MD Danish Anwar wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Client device node property ti,pruss-gp-mux-sel can now be used to
>> configure the GPMUX config value for PRU.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/remoteproc/pru_rproc.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> index 2874c8d324f7..29d3a5a930c1 100644
>> --- a/drivers/remoteproc/pru_rproc.c
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -109,6 +109,7 @@ struct pru_private_data {
>>   * @dbg_single_step: debug state variable to set PRU into single step mode
>>   * @dbg_continuous: debug state variable to restore PRU execution mode
>>   * @evt_count: number of mapped events
>> + * @gpmux_save: saved value for gpmux config
>>   */
>>  struct pru_rproc {
>>  	int id;
>> @@ -127,6 +128,7 @@ struct pru_rproc {
>>  	u32 dbg_single_step;
>>  	u32 dbg_continuous;
>>  	u8 evt_count;
>> +	u8 gpmux_save;
>>  };
>>  
>>  static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
>> @@ -228,6 +230,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>>  	struct device *dev;
>>  	const char *fw_name;
>>  	int ret;
>> +	u32 mux;
>>  
>>  	rproc = __pru_rproc_get(np, index);
>>  	if (IS_ERR(rproc))
>> @@ -252,6 +255,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>>  	if (pru_id)
>>  		*pru_id = pru->id;
>>  
>> +	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
>> +		goto err;
>> +	}
>> +
>> +	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
>> +					 &mux);
>> +	if (!ret) {
>> +		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
>> +		if (ret) {
>> +			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
>> +			goto err;
>> +		}
>> +	}
>> +
> 
> It would have been nice to be told in a cover letter that pruss_cfg_get_gpmux()
> is in linux-next so that I don't have to go fish for it...
> 

My bad, I should have mentioned it. This patch depends on the soc: ti: pruss
series [1] which is merged to Nishant's tree and is part of 'linux-next' but
this isn't yet part of mainline linux.

> I am fine with the code in this patch, though the changelog is cryptic and could
> be enhanced to say "why" this is needed.  The above could use some comments to
> make sure people looking at this code understand that an error from
> of_property_read_u32_index() is acceptable for backward compatibility.
> 
> Here I have to suppose pruss_cfg_get_gpmux() has been added to Nishanth's tree.
> As such the only way for me to apply your patch is if Nishanth sends me a pull
> request for the patchset that introduced pruss_cfg_get_gpmux().  You can also
> resend this in the next cycle.

I will fix the changelog and send the next revision in the next cycle.

> 
> Thanks,
> Mathieu
> 

[1] https://lore.kernel.org/all/20230414045542.3249939-1-danishanwar@ti.com/

-- 
Thanks and Regards,
Danish.
