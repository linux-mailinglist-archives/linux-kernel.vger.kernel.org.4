Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0486028B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiJRJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJRJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:48:33 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C957B0B3F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:48:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VSUh59O_1666086503;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSUh59O_1666086503)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 17:48:24 +0800
Date:   Tue, 18 Oct 2022 17:48:22 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y052Zvi91NaaYm7C@B-P7TQMD6M-0146.local>
References: <20221018035536.114792-1-hsiangkao@linux.alibaba.com>
 <202210181728.gXrmc8LC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210181728.gXrmc8LC-lkp@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:22:18PM +0800, kernel test robot wrote:
> Hi Gao,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on xiang-erofs/dev-test]
> [also build test ERROR on linus/master v6.1-rc1 next-20221018]

Thanks for the report, sorry for submitting an outdated version.
I'll merge the latest update and resend.

Thanks,
Gao Xiang
