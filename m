Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B396F72C370
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjFLLvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjFLLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:50:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E32949;
        Mon, 12 Jun 2023 04:45:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QfqZZ0R4Kz6D91D;
        Mon, 12 Jun 2023 19:43:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 12:45:49 +0100
Date:   Mon, 12 Jun 2023 12:45:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <andy.shevchenko@gmail.com>
CC:     Markus Burri <markus.burri@mt.com>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: ad7192: store indio_dev into spi driver
 data
Message-ID: <20230612124548.00007778@Huawei.com>
In-Reply-To: <ZIbwUKxlhWQZYnPz@surfacebook>
References: <20230612080847.39170-1-markus.burri@mt.com>
        <ZIbwUKxlhWQZYnPz@surfacebook>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 13:15:44 +0300
<andy.shevchenko@gmail.com> wrote:

> Mon, Jun 12, 2023 at 10:08:47AM +0200, Markus Burri kirjoitti:
> > After calibration the indio_dev is used to get channel information.
> > Since the pointer is not stored into spi driver data, there is a kernel
> > null pointer dereference.
> > Store the indio_dev into spi driver data to fix this.  
> 
> This definitely deserves the Fixes tag. Can you dig the history to find the
> culprit one?

Good catch, but see

https://lore.kernel.org/all/20230530075311.400686-2-fl.scratchpad@gmail.com/

Which I think is a nicer fix for the same issue.

I sent a pull request for that fix yesterday, but given we are late in the cycle
it might go in during the merge window then get backported to stable kernels
after that.

> 
> > Add error check and slightly extend the debug messages.  
> 
> I'm not sure this will belong to the same change, so I would split this out to
> a separate one.

Definitely.  Multiple issues so multiple patches.

Thanks,

Jonathan

> 

