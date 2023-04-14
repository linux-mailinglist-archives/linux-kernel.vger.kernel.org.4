Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387246E2288
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNLrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:47:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74483CD;
        Fri, 14 Apr 2023 04:47:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PyZQg3tQvz6DFQG;
        Fri, 14 Apr 2023 19:46:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 12:47:03 +0100
Date:   Fri, 14 Apr 2023 12:47:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Message-ID: <20230414124702.00007fc5@Huawei.com>
In-Reply-To: <8d2690d8-9418-e2da-8834-6457a60a67cb@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
        <20230411180302.2678736-2-terry.bowman@amd.com>
        <20230413163050.00006bfb@Huawei.com>
        <8d2690d8-9418-e2da-8834-6457a60a67cb@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
> >>  				     parent_dport);  
> > As above, I'd prefer to see this refactor done in a precursor patch before the new
> > stuff is added.  I like reviewing noop patches as I don't have to think much (so
> > can do it when I'm supposedly in a meeting ;)
> >   
>  
> Ok. I'll add an earlier patch that introduces cxl_setup_rcrb() and first moves this 
> chunk into cxl_setup_rcrb(). The following patch will replace the cxl_setup_rcrb() 
> logic with the AER and RAS discovery.
> 
> My understanding is the requested refactoring changes then splits this patch into 
> the 3 patches listed below (using git log latest first order): 
> - Add RCH downstream port AER and RAS register discovery
> - Refactor RCD component discovery into separate function
> - Refactor RCRB register mapping into separate function

Spot on I think.

Thanks,

Jonathan
