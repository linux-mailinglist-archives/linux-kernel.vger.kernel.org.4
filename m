Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEFC745051
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGBTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGBTR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:17:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0199D9;
        Sun,  2 Jul 2023 12:17:13 -0700 (PDT)
Message-ID: <0c02e976-0da6-8ed8-4546-4df7af4ebed5@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688325430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcRkV1JsdAB+1QeSMkNj7SU4PliDC9ED89IW5fPJQLc=;
        b=cln18HT5XkWRzeQ6oUlGUJ234pgfk+6U1z7i3GWmYV4eQjqUZO5sz7JD65DQOEF2CqnmtE
        94waio+VxYSc7kjlSBpPuvetqEbMPgKALT6NNIV4i7W9jSBtEuQJuyfJgQf+FVpCkh73ul
        tCYh94u++ADCaAq7m02N5/rLTFXIRVZAmxOtx8JY/6VlVJyE5cBp/dzaO0kBT+Dx1Nh9B8
        DoHsN2oCZEvwAsE3e4dAOmFScSXdRUCsepnCQMGMIWuvrxLliba4C9L33C1bXBtCjYVRZm
        O3RmpbtJ6dc5fKbVSjZznDRbQirmlIDGxU8kBz6w0olg8fWZZiiEUk9jWtx53w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688325430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcRkV1JsdAB+1QeSMkNj7SU4PliDC9ED89IW5fPJQLc=;
        b=6ZF0sry1dcNvmgR8l0d/9AAjahUM5CPICbkZrcc9y8f2C+AoKOyoPfBmA4IY4encveZXmZ
        PZa+03/IJp4zUQAw==
Date:   Sun, 2 Jul 2023 21:17:01 +0200
MIME-Version: 1.0
To:     Markus Elfring <Markus.Elfring@web.de>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230619100858.116286-2-florian.kauer@linutronix.de>
 <36b57ea5-baff-f964-3088-e1b186532cfe@web.de>
Content-Language: en-US
From:   Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH net v2 1/6] igc: Rename qbv_enable to
 taprio_offload_enable
In-Reply-To: <36b57ea5-baff-f964-3088-e1b186532cfe@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 02.07.23 18:55, Markus Elfring wrote:
>> The rename should reduce this confusion.
> 
> Would the wording “Reduce this confusion by renaming a variable at three places”
> be more appropriate for a subsequent change description?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n94

Thanks for pointing that out (also in your other mail for this series).
I will be more careful regarding the use of imperative mood.

> 
>>                                          Since it is a pure
>> rename, it has no impact on functionality.
>>
>> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> 
> How does such information fit together?

The referenced commit introduced an issue into the kernel by
introducing a variable that does not exactly describe its actual purpose.
It is not only a cosmetic change, but in my view this confusion
was related to other issues (see the other patches). So, it seemed to be worth
fixing alongside with the other fixes, even if it does not directly impact
functionality if it is applied or not (until someone else comes along,
also gets confused and introduces another bug...).

Thanks,
Florian
