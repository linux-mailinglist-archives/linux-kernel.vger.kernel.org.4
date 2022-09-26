Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5536E5E97BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIZBgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiIZBgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:36:22 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC69D21817;
        Sun, 25 Sep 2022 18:36:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQeBORE_1664156177;
Received: from 30.97.56.143(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQeBORE_1664156177)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 09:36:17 +0800
Message-ID: <45b4b583-d108-b8a2-eee3-3bce755f31ed@linux.alibaba.com>
Date:   Mon, 26 Sep 2022 09:36:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V6 0/7] ublk_drv: add USER_RECOVERY support
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, ming.lei@redhat.com
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20220923153919.44078-1-ZiyangZhang@linux.alibaba.com>
 <88fb97a1-23a1-9f75-a9fa-54b233e0a39e@kernel.dk>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <88fb97a1-23a1-9f75-a9fa-54b233e0a39e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/24 09:12, Jens Axboe wrote:
> 
> I'm going to apply 1-6 for 6.1, applying the doc patch is difficult as
> it only went into 6.0 past forking off the 6.1 block branch. Would you
> mind resending the 7/7 patch once the merge window opens and I've pushed
> the previous bits? I may forget otherwise...

OK, I will resend the doc patch.

Regards,
Zhang
