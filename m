Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79EB6F934D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEFRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:18:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D615150E8;
        Sat,  6 May 2023 10:18:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pvLY9-0006AS-DS; Sat, 06 May 2023 19:18:25 +0200
Date:   Sat, 6 May 2023 19:18:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>
Cc:     Florian Westphal <fw@strlen.de>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        kuba@kernel.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, caowangbao@huawei.com
Subject: Re: BUG: KASAN: stack-out-of-bounds in __ip_options_echo
Message-ID: <20230506171825.GA21013@breakpoint.cc>
References: <05324dd2-3620-8f07-60a0-051814913ff8@huawei.com>
 <20230502165446.GA22029@breakpoint.cc>
 <9dd7ec8f-bc40-39af-febb-a7e8aabbaaed@huawei.com>
 <20230505055822.GA6126@breakpoint.cc>
 <4f3d231e-5ba8-08a9-e2d3-95edf5bb2dc7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3d231e-5ba8-08a9-e2d3-95edf5bb2dc7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fengtao (fengtao, Euler) <fengtao40@huawei.com> wrote:
> I already tested your patch for 24 hours, and the panic never happened; Could you send your commit to kernel-upstream?
> If you do not have time, I would be happy to sent this patch and add your SOB.

You can submit a patch since you did the analysis and testing. You can add:

Suggested-by: Florian Westphal <fw@strlen.de>

Thanks!
