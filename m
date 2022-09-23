Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0845E7199
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIWByB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Sep 2022 21:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIWBx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:53:57 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E1F10C788;
        Thu, 22 Sep 2022 18:53:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQUYHHZ_1663898030;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VQUYHHZ_1663898030)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 09:53:52 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH RESEND v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography
 Complex) accelerator driver
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <YyRDbT0fQQwsVpKL@gondor.apana.org.au>
Date:   Fri, 23 Sep 2022 09:53:50 +0800
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>,
        xuchun.shang@linux.alibaba.com,
        "artie.ding@linux.alibaba.com" <artie.ding@linux.alibaba.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C9DB484C-4527-4E0C-9FE4-6CF7C6BA579C@linux.alibaba.com>
References: <1662435353-114812-1-git-send-email-guanjun@linux.alibaba.com>
 <1662435353-114812-2-git-send-email-guanjun@linux.alibaba.com>
 <YyRDbT0fQQwsVpKL@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2022年9月16日 下午5:35，Herbert Xu <herbert@gondor.apana.org.au> 写道：
> 
> On Tue, Sep 06, 2022 at 11:35:45AM +0800, 'Guanjun' wrote:
> .
>> +static const struct file_operations ycc_fops = {
>> +	.open = ycc_cdev_open,
>> +	.release = ycc_cdev_release,
>> +	.unlocked_ioctl = ycc_cdev_ioctl,
>> +};
> 
> What is this device for? It doesn't seem to do anything so why
> not jsut drop it?
> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Hi Herbert,
Do you have any other comments? If not, I will prepare for the next version :)

Thanks,

Regards,
Guanjun

