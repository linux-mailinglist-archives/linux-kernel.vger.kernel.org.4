Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B59714853
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjE2LI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE2LIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:08:54 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F09CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:08:50 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230529110838epoutp0156a0d2017bc413672cfe970a760f37b9~jmKS1n3Pb2902729027epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:08:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230529110838epoutp0156a0d2017bc413672cfe970a760f37b9~jmKS1n3Pb2902729027epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685358518;
        bh=dZVfotqZFrsokbs+wqGDWxA2HIP1xtUvpW9KT5S6V/g=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mSik56PfWyps25P0F27uNOkKOxyJzsXVnUURn9lmV4y5b8ai/sDKbVAoVFHQsb3WE
         lotiS4me6f9y3aDafyDvpHVV1abOM/qOM6tC+SZ4G3hAOE2CXOTkFA5kcxXoyjaYWV
         idqSz0qyNhYihTZJazdfDEInFl+6L/tvKQFvV7HY=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230529110838epcas5p2aeb7ad05e010a427b9dccb1f0866323c~jmKSLeDPK3208332083epcas5p2a;
        Mon, 29 May 2023 11:08:38 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-a7-647487b56532
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.82.04567.5B784746; Mon, 29 May 2023 20:08:37 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array
 size
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     "bcain@quicinc.com" <bcain@quicinc.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>,
        "ustavoars@kernel.org" <ustavoars@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "wedsonaf@google.com" <wedsonaf@google.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Onkarnath <onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
Date:   Mon, 29 May 2023 16:27:07 +0530
X-CMS-MailID: 20230529105707epcms5p1418eac680ebe1736196706b0db80dd39
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmlu7W9pIUg81/rSz+zt7ObvFwdwuL
        xZ1Jz9ktLp55zWhxpjvX4n3LDjaLy7vmsFn8/v6P1eLm9DfsFlsaDrFZbDgabPHzxQ0Wi5Xz
        lzNarOj5wGrx//FXIPHuCJNFx+KVjA6CHrMbLrJ4fL15jslj0csGFo8lnb+YPHbOusvusWBT
        qcemVZ1sHhMWHWD0OD9jIaPHxD11Hn1bVjF6rN9ylcXj8ya5AN4oLpuU1JzMstQifbsErozF
        h9ILfnBXHNv0ibmB8RxnFyMnh4SAicTii+9Yuxi5OIQEdjNKnFowj62LkYODV0BQ4u8OYZAa
        YYEAiQV7lzKC2EICihIXZqxhBCkRFjCQ+LVVAyTMJqAnsWrXHhYQW0TASOLa6d0sICOZBeaw
        Sdzb2s0EsYtXYkb7UxYIW1pi+/KtYHM4BQIlnn5xgQiLStxc/ZYdxn5/bD4jhC0i0XrvLDOE
        LSjx4OduqLiMxOrNvVAjqyWevj7HBrJXQqCFUWLfbpgic4n1S1aBDeUV8JV4PbkR7B4WAVWJ
        /r1NUDUuEk+uTmUFsZkF5CW2v53DDHIbs4CmxPpd+hAlshJTT61jgijhk+j9/QTurR3zYGxV
        iZabG1hhXvz88SPUbR4Sp76vYoUE4WlGiRNPRCcwKsxCBPQsJItnISxewMi8ilEytaA4Nz21
        2LTAMC+1XK84Mbe4NC9dLzk/dxMjOB1qee5gvPvgg94hRiYOxkOMEhzMSiK8tonFKUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR51W1PJgsJpCeWpGanphakFsFkmTg4pRqY8irfuT68Nf9+6Rvv
        UL03P9NfZbkcvjV33ifuro0GLMdCp6zcO8urs8FYLSLT1+2M0Idp+rXavZ8mzJbi92aUEzTx
        9Yt41etamlM6T/L45HsT7zLGfEyveFuZ9mP+tFlhs6+7vLywZd3yP81Z775+q++9cyek9Gf0
        3MRtzJMFCp9qMn5/OCPFdu67sJfFD20TXO6Wab3n2P7L1/0zd0aoZr1wnFPb3J9Wm+R++TF0
        1vdO6F5u92KW0H6fZfOmGXKI10+0LNtQc/rTVTZBtkPXohzOf3H8FPPUMcs7Mn7m41Naf15y
        mx06cbhX9FzSffcfZTmR/70e3D11vumN1U/2jm+Woaz3V388uud1/zLTw0osxRmJhlrMRcWJ
        AJjKocv2AwAA
X-CMS-RootMailID: 20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3
References: <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
        <20230529052821.58175-1-maninder1.s@samsung.com>
        <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>
>> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
>> writes on index "KSYM_NAME_LEN - 1".
>>
>> Thus array size should be KSYM_NAME_LEN.
>>
>> for powerpc and hexagon it was defined as "128" directly.
>> and commit '61968dbc2d5d' changed define value to 512,
>> So both were missed to update with new size.
>>
>> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")
>> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

> Thanks for this!
> 
> There is no `From:` at the top. Since I cannot locate the patch in
> Lore, did you mean to put both of you as authors perhaps? In that
> case, please use a `Co-developed-by` as needed.
> 

I Will add co-developed-by` tag.
because this change was identified while we were working on kallsyms some time back.
https://lore.kernel.org/lkml/YonTOL4zC4CytVrn@infradead.org/t/

this patch set is pending and we will start working on that again, so i thought better
to send bugfix first.

> Perhaps it is a good idea to submit each arch independently, too.
> 

ok, I will share 2 separate patches.

> The changes themselves look fine on a quick inspection, though the
> `xmon.c` one is a global buffer (and there is another equally-sized
> buffer in `xmon.c` with a hard-coded `128` constant that would be nice
> to clarify).

Yes, I think second buffer was not related to kallsyms, so I have not touched that.

Thanks,
Maninder Singh
