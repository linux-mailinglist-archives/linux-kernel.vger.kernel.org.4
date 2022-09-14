Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192EB5B7E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiINBrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINBrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:47:05 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CCE6DFB5;
        Tue, 13 Sep 2022 18:47:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VPkNDRP_1663120016;
Received: from 30.97.48.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VPkNDRP_1663120016)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 09:46:57 +0800
Message-ID: <09e0937e-2b6c-24e4-b639-9aedbe78ee3d@linux.alibaba.com>
Date:   Wed, 14 Sep 2022 09:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND][PATCH V8 2/2] clk: sprd: Add clocks support for UMS512
To:     Cixi Geng <gengcixi@gmail.com>, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220909152421.278662-1-gengcixi@gmail.com>
 <20220909152421.278662-3-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220909152421.278662-3-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/2022 11:24 PM, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Add the list of clocks for the Unisoc UMS512, along with clock
> initialization.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
