Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAE6F2F02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjEAHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:12:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B9E62
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 00:12:47 -0700 (PDT)
Received: from [10.5.110.30] ([98.159.234.47]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1q1JvS0ntD-009eBi for
 <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:12:45 +0200
Message-ID: <20918aee-f8d0-04ca-ee90-8059be38751b@gmx.com>
Date:   Mon, 1 May 2023 07:12:44 +0000
MIME-Version: 1.0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Very weird unexpected unannounced stuff
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Dns6sEX+pniNKn63hT6cD6iGFSFpsZxd4NUBU8Heh9oUIY6cLEF
 fMbubO80L/dgxQBhf9HgDA65pvRvw0/tzoIERdE6Hlp+FvVCwVvNEyjLCh73v9sI1pLWhZJ
 l7yqfjAPjaHlKI2CXImSk1BxCWUhcCLGgre/qFDVre/1xjxMshkHgP8ymWpl0cHiA0oVXmk
 TNHmZuVVBZqODfNoPwYvg==
UI-OutboundReport: notjunk:1;M01:P0:/8iOBml64Gs=;tTWXXtKgYd8JqcZE1gi/+IhuhLm
 lhVoFI0G6gnDsB81JJqOyHPvxHfu9riFQC48E60Ihj9lkSAvk2hu/J1tCMby60hvO+ORqR+bV
 S6GGTBF+qpNyByr6b10iXyvBipmfxGSnTDxXNot+CpEvIeXWzdQMQ2Lm85RDHf1R/M9VVuY/k
 1TKytCL5FQnj6Wj2LlPIeU1GOiFuRpq+CDYj1RKffvc7VL7XN2zJfsSX7RSLoTWnYHWNt9zqm
 UHYMlGHit7qOexHZujSkbA4+WI+Vg0cns0lQI1EN1RVum3bgSs6KL7J/zsjWA7sdZhmWAj43/
 ZtzPnPpkC8VYz9qj5K4nEoli3SbZusKg+/n9WBdUFJUdZGlDZ9ythko33jfmJDuA2ZV8Njv0m
 51iuxDmI1XiJ1nK/Z+cGWt/Yyna6F39kOE6JR8ZHojINejQI8gmwnvMW8fjPUmzWtJyuBFye9
 qiNaP80Vazg8g+p6EbLVfi1sU4tKZhSoImjKziWAV+jP5FIcfRvYCTI7kA0BbFJxFipsaElFP
 F6d2Tn5X2o6xnwXEngR1ZqC5ZPt8oRZybfp7cy3ULBUhf0aE9Wc6OtCHxeKJBZBd9mIUML44W
 SytvX9PgL7Vz3i1EC/Qf6KBLMRpaHqtQIRWmVM+/qytKLUhqZkXsfIg+K0DQhOaCFuNmpZEyS
 gZU8ytpFpZSHvNhiGFC4w/l+D41VMF7QXwjFAsc0b3auuJJzKiaBMJrQwKTbU/FjcvF3+L39t
 ppyjQbi/qXlHkgN57EyL6FnFKPHmf+y4mCLmC9z3NOT6V8KHq9ZIdAInOHEqgb7BCULrXtJLG
 uhAK3aite2RmyD0vyG7duYSCEF2xVzfYErV0Xixl9c0YTlS+9+7GqHHwhyWaQFgRp6tViYPyh
 YhSufwWuJ3hnwNhcLpU2u5JZ7jjQczEXsSCVWNaFEnPhT2FsaWxIRwly+faJs4lBjUKY2GV3C
 ad048QTwufEmEXMyIQhyRSZyNMA=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On two of my Fedora 38 systems I've noticed a very weird behavior: the 
Windows key + F1-F7 as well as Win + Left/Right Arrows switch consoles 
which I don't remember ever enabling or being announced in the kernel 
changelog.

What's going on?

I don't want it at all because in XFCE I have Win + F1-F4 changing 
virtual desktops and Win + Left/Right arrows changing the current track 
in my Audacious audio player.

Best regards,
Artem
