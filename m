Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF65F4672
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJDPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJDPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:18:49 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FB5F22C;
        Tue,  4 Oct 2022 08:18:33 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294C2IuG012977;
        Tue, 4 Oct 2022 17:18:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sMMWENCZwPkXYFl36theJMlNllxjxhOMt7vesXyb4G0=;
 b=yjeeHURrXl8qcKp3i0LhERtjtmO+rleHawLn+Lgluw+T1CMz4afiNZF2gZBl9Docry3g
 ofLdCgStC8qBbLICup1mahTHfHum30edT+zrG+oIDgpygKcEpDNv3bG+zxuEYrV2ylvH
 6ha/rFKugdHClIXntkxb52zvt4xU7lGNf/TkijZughfKot8d6eSm7ZnR5LIFjUQKYuvW
 iWc2srdn9CqsJgEQ5wLOD8PLgm2mNuj8oqIP1VQpJLKPVPUQ+z4MyRddQuVxFGc0MJCz
 oXGxxhxfvMbLtfdOrjjUoFRI7TIIhh3kA5ONeoGkQtYvRvyqzBx9A4rZb4M3p+A2OBVA vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxcw212y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 17:18:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B5F810002A;
        Tue,  4 Oct 2022 17:18:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E7D8F236948;
        Tue,  4 Oct 2022 17:18:19 +0200 (CEST)
Received: from [10.211.7.73] (10.75.127.119) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Tue, 4 Oct
 2022 17:18:18 +0200
Message-ID: <fa229aa5-5fb7-eb18-3b8a-59d8a98ccaba@foss.st.com>
Date:   Tue, 4 Oct 2022 17:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 4/4] remoteproc: virtio: Create platform device for the
 remoteproc_virtio
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
References: <20220921135044.917140-1-arnaud.pouliquen@foss.st.com>
 <20220921135044.917140-5-arnaud.pouliquen@foss.st.com>
 <20221004143954.GA1479221-robh@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20221004143954.GA1479221-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 10/4/22 16:39, Rob Herring wrote:
> On Wed, Sep 21, 2022 at 03:50:44PM +0200, Arnaud Pouliquen wrote:
>> Define a platform driver to manage the remoteproc virtio device as
>> a platform devices.
>>
>> The platform device allows to pass rproc_vdev_data platform data to
>> specify properties that are stored in the rproc_vdev structure.
>>
>> Such approach will allow to preserve legacy remoteproc virtio device
>> creation but also to probe the device using device tree mechanism.
>>
>> remoteproc_virtio.c update:
>>   - Add rproc_virtio_driver platform driver. The probe ops replaces
>>     the rproc_rvdev_add_device function.
>>   - All reference to the rvdev->dev has been updated to rvdev-pdev->dev.
>>   - rproc_rvdev_release is removed as associated to the rvdev device.
>>   - The use of rvdev->kref counter is replaced by get/put_device on the
>>     remoteproc virtio platform device.
>>   - The vdev device no longer increments rproc device counter.
>>     increment/decrement is done in rproc_virtio_probe/rproc_virtio_remove
>>     function in charge of the vrings allocation/free.
>>
>> remoteproc_core.c update:
>>   Migrate from the rvdev device to the rvdev platform device.
>>   From this patch, when a vdev resource is found in the resource table
>>   the remoteproc core register a platform device.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  drivers/remoteproc/remoteproc_core.c     |  12 +-
>>  drivers/remoteproc/remoteproc_internal.h |   2 -
>>  drivers/remoteproc/remoteproc_virtio.c   | 143 ++++++++++++-----------
>>  include/linux/remoteproc.h               |   6 +-
>>  4 files changed, 82 insertions(+), 81 deletions(-)
> 
> [...]
> 
>> +/* Platform driver */
>> +static const struct of_device_id rproc_virtio_match[] = {
>> +	{ .compatible = "virtio,rproc" },
> 
> This is not documented. Add a binding schema if you need DT support.


Mathieu also pointed this out to me in V8, you can see the discussion here [1]

Here is an extract:
"Yes I saw the warning, but for this first series it is not possible to declare
the associated "rproc-virtio" device in device tree.
So at this step it seems not make senses to create the devicetree bindings file.
More than that I don't know how I could justify the properties in bindings if
there is not driver code associated.

So i would be in favor of not adding the bindings in this series but to define
bindings in the first patch of my "step 2" series; as done on my github:
https://github.com/arnopo/linux/commit/9616d89a4f478cf78865a244efcde108d900f69f
"

[1] https://lore.kernel.org/lkml/20220920202201.GB1042164@p14s/ 

Regards,
Arnaud

> 
>> +	{},
>> +};
>> +
>> +static struct platform_driver rproc_virtio_driver = {
>> +	.probe		= rproc_virtio_probe,
>> +	.remove		= rproc_virtio_remove,
>> +	.driver		= {
>> +		.name	= "rproc-virtio",
>> +		.of_match_table	= rproc_virtio_match,
>> +	},
>> +};
