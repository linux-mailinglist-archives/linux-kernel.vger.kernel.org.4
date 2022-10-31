Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7861331B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJaJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJaJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:55:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B3CE12;
        Mon, 31 Oct 2022 02:55:19 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N17l60kzRz6HJCs;
        Mon, 31 Oct 2022 17:53:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 31 Oct 2022 10:55:16 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 09:55:15 +0000
Date:   Mon, 31 Oct 2022 09:55:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Saravanan Sekar <sravanhome@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the iio-fixes tree
Message-ID: <20221031095514.00003174@Huawei.com>
In-Reply-To: <20221031074006.1ca60136@canb.auug.org.au>
References: <20221031074006.1ca60136@canb.auug.org.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 07:40:06 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   a589ef35fc62 ("iio: adc: mp2629: fix potential array out of bound
> access")
> 
> Fixes tag
> 
>   Fixes: 7abd9fb6468 ("iio: adc: mp2629: Add support for mp2629 ADC
> driver")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
> 

Doh, I clearly failed to run my local checks.  Will fix within next day
or so.

Thanks,

Jonathan
