Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B316EA91E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDULbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDULbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:31:34 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FA7A5DD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:31:32 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id B10A7E07E0; Fri, 21 Apr 2023 11:31:30 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     vbabka@suse.cz, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rppt@kernel.org,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next v2] mm: workingset: update description of the source file
Date:   Fri, 21 Apr 2023 19:31:30 +0800
Message-Id: <20230421113130.240586-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0ddb50f0-2e2d-e750-3867-3842a3ea12cc@suse.cz>
References: <0ddb50f0-2e2d-e750-3867-3842a3ea12cc@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm late but FWIW, not supper happy that while the updated calculations are
> now accurate wrt the actual code, the explanation (which was written at the
> time of page cache-only workinset) was more easier to follow in the simpler
> form. Now it's still mostly talking about page cache and explaining the
>balance between its active and inactive list only, and then suddenly the
> anon lists appear out of nowhere in the final equations.

Thanks for your reviewing! I should update the whole parts. Sorry for
hadn't do it better, please drop the patch, I will try to submit patchv3
to fix this.

> In other words, I think it would have been better to leave that explanation
> as it was, and then add a new part describing the extension to anon pages.

I read the description of the source file again carefully, and think that
there is no need to creat a new part, if we explain at the begining that
the word 'pages' include page cache and anonymous page, and do some minor 
adjustments. For example:
Per node, two kinds of clock lists are maintained for pages..
