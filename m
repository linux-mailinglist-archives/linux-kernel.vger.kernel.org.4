Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14D5BC241
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiISE01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiISE0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:26:25 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448017AB8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:26:22 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220919042619epoutp025e1633a9727fce7de742db345b1b9fca~WKHFbGhgq1117411174epoutp02C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:26:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220919042619epoutp025e1633a9727fce7de742db345b1b9fca~WKHFbGhgq1117411174epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663561579;
        bh=sgIory+AOqYz4fHKYWA4jQtIAXnwBKItMaAjb+fjY2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NbON8xtEDOY8cpT1CShiEvX+UiwJF+o8BI/TX0GXe5eqXEeGELfnYsLaxKawot82o
         DTRb5YaT9PPjbtPmAbWnDyjTMS1tht+7UFR0mYBPRLSU4CtpJNxxpb40E2bntHO6Nq
         J40OHXWslbo1sXlXOJz/ijxFdYgEnCvImEROV8fw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220919042619epcas1p4009247a2661187d5bb3d859c0fccd4ef~WKHE7D92u0840008400epcas1p4v;
        Mon, 19 Sep 2022 04:26:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.144]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MWBSp1SBmz4x9Q7; Mon, 19 Sep
        2022 04:26:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.49.64988.96FE7236; Mon, 19 Sep 2022 13:26:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220919042616epcas1p4e8cd2878f2293007a45846c563fa37f9~WKHC4zDcz0840308403epcas1p4T;
        Mon, 19 Sep 2022 04:26:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220919042616epsmtrp1d870f1d106a41e02c228f88d9ae51f4e~WKHC3_SI12191121911epsmtrp1M;
        Mon, 19 Sep 2022 04:26:16 +0000 (GMT)
X-AuditID: b6c32a39-681ff7000001fddc-74-6327ef696b08
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.1D.14392.86FE7236; Mon, 19 Sep 2022 13:26:16 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220919042616epsmtip232cce3c050c4b99ff07b0f14f1b06d17~WKHCtBq3B3157631576epsmtip2H;
        Mon, 19 Sep 2022 04:26:16 +0000 (GMT)
Date:   Mon, 19 Sep 2022 13:26:16 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        ogabbay@kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Message-Id: <20220919132616.5fc7480394c422dc8e16a942@samsung.com>
In-Reply-To: <e035ac54-35af-4e86-a74a-9a4c7f936a19@www.fastmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmgW7me/Vkg3P3eCz+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKCrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5
        xaV56Xp5qSVWhgYGRqZAhQnZGV+WPGQsaGetODFrImMDYxNLFyMHh4SAicTtcwVdjFwcQgI7
        GCU+9K1mgXA+MUrcv/KZqYuRE8j5xigx47USiA3SMPvgSTaIor2MEr+XXWaEcDqYJObs28QK
        UsUioCqx9N11ZhCbDcieOWMNO4gtIqAs8evHJFaQBmaBP4wSffu2gCWEBcwkJkydCWbzCjhK
        LLq+nwXE5hRwkfj65R4rxGoLibs9K1hB7uYVEJT4u0MYJMwsIC+x/e0cZpCZEgJTOSQmHV7P
        BFHvIvFsRRMbhC0s8eo4xC4JASmJl/1tUHa2xJSORSwQdoHEuedbmSHhYixxcUUKiMksoCmx
        fpc+RIWixM7fcxkh1vJJvPvawwpRzSvR0SYEUaIkseTPYajhEhJTZ3yDOsZDYvnVQyyQ8PzN
        KHF1v84ERoVZCL/MQvLLLIS9CxiZVzGKpRYU56anFhsWmMJjNzk/dxMjOIVqWe5gnP72g94h
        RiYOxkOMEhzMSiK8qp4qyUK8KYmVValF+fFFpTmpxYcYTYExM5FZSjQ5H5jE80riDU0sDUzM
        jIxNLAzNDJXEefW0GZOFBNITS1KzU1MLUotg+pg4OKUamBb8NGw8Yz+NZ/ec6NWXFkeq2PTE
        2PBGXeNJY89c7nOKfxdXTmN3lPRL+/jTX5X6/edau7jeyj16+ISm1nKGc3InLurr/fb3OTNt
        /7qz2yMv6OZ+XPB+Q2jJ795M/nTfP3+/PHrfza3VPMN75USllCXfa0Wm+XSrL7vZefe08+9f
        K+Xqj7jqhPJycjrpTuT/dnp5yG/j/Q6vpN9cma6X12IsuNV+142DEna3jkl/P80Z/mqr6sGl
        f5+zKn1YmsVUtXy68PSIM02BLBO1LdonK/7Yzv2gue91UynDzYNf08LFTIyfdKtr3z7juE1i
        xadXddaPMtyexi2MvsogsOPCRuOHS3Kf2eWmhhaHnJ38doUSS3FGoqEWc1FxIgCQFvQ/KgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvG7Ge/Vkg11N5hZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGlyUPGQvaWStOzJrI2MDYxNLFyMkh
        IWAiMfvgSbYuRi4OIYHdjBIvDp5khEhISGy6t5y5i5EDyBaWOHy4GKKmjUni+YazTCA1LAKq
        EkvfXWcGsdmA7Jkz1rCD2CICyhK/fkxiBWlgFvjDKPG+4ylYg7CAmcSEqTPBingFHCUWXd8P
        dgWngIvE1y/3WEFsIYHfjBJX9+tAHGEhcbdnBSvIEbwCghJ/dwiDhJkFtCQe/rrFAmHLS2x/
        O4d5AqPgLISqWUiqZiGpWsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhCtDR3
        MG5f9UHvECMTB+MhRgkOZiURXlVPlWQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQn
        lqRmp6YWpBbBZJk4OKUamDbMk7gfk67vq7irO1N0/4UJ/6S8Juk3O2bWqXRqzQlKqjFZsumK
        9sTzr8zfSc5L+S+vqfBk/5rv7iv3PS3PnDLXckON16q9Jn3ZZ3VsfzhtK0x/zM0b+OG5+6/D
        zYwPVudVFu7cdPzXvhr2bat5CqRFcuJucld0cbEb7Td+VJrxOmTm9j/c57WbTqRvvsR0TMUo
        gXHLk6er7Hpyt3ZdkKjs/XO3qtzooPYU+aw/EfXXV8Q/iQsL2RHSqf/BiOP6QVXN2y4TNufP
        E1irtJ6NSe2dt9SG2GS+kP8rtVRuJKzlqdlR/zFygQf34on2kxbMOHSbqUp99nzB7l3c5ze4
        beJV+WAiY9e8/5luWtO7TiWW4oxEQy3mouJEAO7TCdf/AgAA
X-CMS-MailID: 20220919042616epcas1p4e8cd2878f2293007a45846c563fa37f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p17b277154f0d020435417450fa0337906
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
        <20220917072356.2255620-2-jiho.chu@samsung.com>
        <e035ac54-35af-4e86-a74a-9a4c7f936a19@www.fastmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2022 09:41:13 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> 
> > +
> > +#ifndef TASK_COMM_LEN
> > +#define TASK_COMM_LEN 16
> > +#endif
> > +
> > +#define TRINITY_APP_NAME_MAX TASK_COMM_LEN
> > +#define TRINITY_APP_STAT_MAX 10
> > +#define TRINITY_REQ_STAT_MAX 10
> 
> The structure layout should not depend on whether an application
> has included a header that defines TASK_COMM_LEN.
> 
> What is the purpose of including an application name here?
> 

I agree. TASK_COMM_LEN will be removed.
app_name is current context's execuable name, and it's used for
per-app NPU statistics info.

Thanks,
Jiho Chu
