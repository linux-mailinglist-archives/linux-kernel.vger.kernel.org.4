Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3526174C48A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGIOCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGIOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:02:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF397;
        Sun,  9 Jul 2023 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688911368; x=1689516168; i=rwarsow@gmx.de;
 bh=A10VahtUSlruQolJWv7H2HXJIC9L1XPgk95ZAOCM6bs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=tCegJ9EMQQOm5eCTyDRN+yuRaa5STvASYWb1Oat6HaoJdwdYmYv+d2oFt9W0vWsuD+4QaKe
 lcElDQbmvaWA0a2J/UPFLAEf6SAVPRoLF09d8OHBSaORanr91qYFQF1qTraoMJTngwGeRinqL
 xJGE6kaH07+sT8qpI6Mrc/QR9xnD6/djOP6KG1ZZXt8s/NdcBxA+H8yNh1zhOXe0ZH/wVCvUH
 2/lW0moDJVKeWFmEJeQ/TKFF7huuSfxkrw+64mH0QPKPWEuP59mpHQhE2BSMIAm3WjlXjQqhb
 SxjcIEEBDoV73d9+Wi59qlOvE15jUWSJ7UalR69XTxKi0vb64LMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.75]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1pcVM03Chs-00opmM; Sun, 09
 Jul 2023 16:02:48 +0200
Message-ID: <aeef7dfa-13de-b312-8746-6ee66c2f851f@gmx.de>
Date:   Sun, 9 Jul 2023 16:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 0/8] 6.4.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:on2LAspDD3oErUNNWsl1RVPxbGgo7u8a7kJghWMgZEJ8YoJolIu
 WxLk7OBsAhLB96odUWV829EyXVDDkgS4pnBIxhnB9ELYuTugZruR+zRN3JHgc4NNkzEu76E
 WYlBJX6DWi3YzDPzTNuR61KAgDpKXJM1ttmG5WITn9gzqWCAElPgZwMpPrJtECGX5sDZi3H
 DrtoBmD/3RlXkWropT2tw==
UI-OutboundReport: notjunk:1;M01:P0:uPd8k2HADdU=;aXoi6k798EYERxl9p9THeHLB4jD
 DvVZF/++uiJpQPZMXTHhfjc8iR8w5CRinRy6c0RgAYd8ilI0QL3dXiFtWNEFm8F/NSN0cxf3B
 n2i/nZnqFKisewuC3NeIZJMhdzncnsk4lop+qBsL7qmyLQt4Qb/2dg285ocJ6mdTxmWekzuZi
 WA5Gi0e8liLMohfwePcuek/8FigG0xFwqcDKPaRl3CfvnCYz60d9uoe/5aoBjRPW3jV3fWOXF
 KtffdQyXrpLapaUvAF9WsBFk4YmrDyHjivpRr/DyyWttpxzW6UxMNrz2xvTMoOw04i7OvN07N
 6wyKOZVmbEDjtp9yIXGcK9TVBc6SA5LFAfX4ANVH7HyihoOGfgQEjw9wMeneAn3DuIUb4tFhM
 Dlx87xexVoEAfuzuq79v2CwtG3S00jQgpK/hJnmoBu5UFLdCBb0kRhwy+fB1T8AvPr9oVc6vi
 baTLlnq7VHoi1uOp3nNX4cfS3ibW70/qtmna2Z/429dADB7hQsBZ2sggfAWIKmgJ9SAjF01lS
 KQcVtVvuuLkAKLpujjR8Hi10gOH1G8pqVhRkupwmeT/WBg9FjWUjqRM29047IV4VbkVumFqSc
 eHqOHnqG7ZxJaT0td1WrKwLtc0CW5ux++QJXySlcLyo2f0ohuzVjo5jhqoZs161vYyCciOE0R
 oN3TXokibfeDIn8rFGC6QvZcq9w+uOCjmLMXYt1j3oG+hQoWPd6VczEowh0MvqKjZ1p81N0kQ
 LLn7WOXl5iijIjeaefnLWWdOi5ahKe4Zj6QxbKcis5KwPTsJwkGB/Yaxx5VrQLjOplRvKY2Re
 A08M1i77yNCH/6XI+P6ZtE6L538gcTf5qwAgSwp1pq1/sEUyrAINB/SWpZ8Wf6cCglekxk2bz
 +CSuIcd3NNKggdyxgGtitNER/j1pjs3uk897iPp5MmjncUrZuX5Jh75MlrHBSNxJVUFl/DZWg
 jhwd4c0OA1YZXoqkAlnGXfUcdL0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.3-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de
