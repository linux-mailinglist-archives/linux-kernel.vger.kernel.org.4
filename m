Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8E16D6893
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjDDQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjDDQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:16:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944430ED;
        Tue,  4 Apr 2023 09:16:16 -0700 (PDT)
Received: from [192.168.18.39] ([45.154.89.243]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNNy-1pxSpw141i-00VSDi; Tue, 04
 Apr 2023 18:16:14 +0200
Message-ID: <022e2ef8-2a94-3109-ab90-9ee980915887@gmx.com>
Date:   Tue, 4 Apr 2023 16:16:08 +0000
MIME-Version: 1.0
Subject: Re: Introducing bugbot
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
Content-Language: en-US
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OUXkQPRmTB5NvpJ+wt+2kQLczRv7y+6H6rGxYNiEmYBBzbl9O9G
 yx+0yY7R3i//SCtCo5zEGPN/J3FdZIvhjtnR1HDBJucfpO7+fXtO36h3tZ9YCuEAn9axHJN
 oGYTkKKvjRD2rsAB0AC8QD7yhZBOFzmuezdVYqeaBSHekk9J71rquvezCdPMO1lgacqAFJs
 nzxVX0rO7tVGWUYcSlT8Q==
UI-OutboundReport: notjunk:1;M01:P0:/eXXL/h+Wxk=;0pqoJ5egTIzCZN+KY8vjhZ0/DHE
 oYN2TOVB5rjvJJOV8hhyQy+XSUgPOg2ZzJt0X7YKv2favexcIxcxj4eE6SK/JH1h45iuYVv99
 ZnRn6ObMJYjYkhjhHel2jvVhIvxSDof4jG0c9/qnMXDwQuoKME7dpShFKgdFa1sr7CMakihn4
 eIffVRbt9Y68HWVxv+TjjxMHf9ZomdZJozVJ2vvCGT7ovVVBLrHqiisK/7ilGnynBtZmY8PRo
 51dvpijcwYccKFoOY5tjswGkvc1jLu+M5CLqRSzoXWH21MHJYQjSTINfrDrGXwngmaPt7gUvc
 ZTAJjQUf6cxL3OiA62Uh9wst7r0AxQzToHl5BUjS+nb6cwz/DLuE0tlqHfuemCG/tHHllnhxQ
 oHU8hbkMR/ojmG6fWEpEHmRhCfUU4vw6CQqnGXxc/H3dYuwxBSisWsj0/1Z2w5v+VFoVC4n0y
 UvZE2+Qm10gbtn3e+1LjeXSvCSLLIP63O6wCjqOTkTO93CAM4t22ySD67TbbDHQnnq4uggiU8
 FTLUEiKqwWC7lrzz2BoEqq/jg4prqt0DAidcs0lECPe2MCCnaJvUFDD4SS78h7GbN2JPjhJaa
 AOC5c+OO7P3iTIOtsecoqUvpZiXCptes9DWn8cPTxUHzjLTLMsrQ1546pA8PkTznKYtFfu9S8
 DXHtr2vwXtS2MlZZQ9tx5MLaeoyiZX3XEYI/EP4hJmaxFaALqx0Wug4hihl9Ik8cfXHPuu+MP
 ABTeWm2jTMcr0S3Rd//plNJhxILXEW3R6+UvWJL0u9azzLCW5kwXZwG2nIDxl+FiIjpnFHKtM
 Yg7jfpLNyHhyp+sHGmzVn87U5Ri9dmY4CrQ1kSmkXi2eZT56Lz4ZUPN3lJasokHzgsUR57FBd
 w9uPTJRXa7ywjoDQddkWyM+1Cg89oQW6tKroM6f01mHmwly5/1eIt9LRAC4DqbN9uG/f5UJN8
 PG/+l5fFk9tnrMKbWQnFB1D/RDs=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 21:45, Konstantin Ryabitsev wrote:
> Hi, all:
> 
> Per our discussion last fall, I've been working on a bridge between bugzilla
> and public-inbox, which went live in the past few days. It's still a very
> early release, but it can do the following:
> 
> 1. Create bugs from mailing list discussions, with full history. For example,
>     it is sufficient for someone [1] to say "bugbot on" in a mailing list
>     discussion to request bugbot to convert that thread into a new bug. It will
>     then continue checking that thread for new messages, creating new comments
>     for any added communication. This works both ways -- any comments added on
>     bugzilla will be sent as follow-up messages to the original recipients.
> 
>     New bugs will be created in the Linux/Kernel component of Bugzilla, but
>     they can then be reassigned to any other component. As long as they remain
>     open, bugbot will continue tracking threads for new messages until either
>     the bug is closed, or it has been over 30 days since any activity on the
>     bug.
> 
>     [1] At this time, the From address of the person saying "bugbot on" has to
>     have an account on bugzilla and be part of the "editbugs" group.
> 
>     Here's me using it to turn a thread into a bug:
>     https://lore.kernel.org/lkml/CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com/
> 
> 2. Start mailing list threads from pre-triaged bugzilla bugs. This works the
>     opposite way and creates mailing list threads based on bug reports filed in
>     bugzilla. The useful things here are:
> 
>     - bugbot only gets triggered on open bugs in Linux/Kernel that have the
>       "bugbot" flag set to "+", which allows pre-triaging a bug before bugbot
>       sends it to the mailing list
>     - there is a special "cf_subsystem" field added to that component; bugbot
>       will match it verbatim to the MAINTAINERS file components and will send
>       mail to the M: and L: addresses for that subsystem
>     - bugbot will then monitor for any updates to that thread, so any mailing
>       list replies will be added as comments to the bug (thus sending a
>       bugzilla mail notification to the initial author)
>     - if the cf_subsystem is incorrect, it can be changed to a different
>       subsystem at any time, triggering a different set of recipients on the
>       next update
>     - any files added in bugzilla will trigger notification sent to the list
>       (but won't attach the actual files, so they don't clog everyone's mailbox
>       or list archives)
> 
>     Artem, I'm not sure if you're still active with bugzilla.kernel.org, but I
>     believe the cf_subsystem functionality is pretty much what you wanted so it
>     was possible to bring bugs to the attention of actual subsystem
>     maintainers.
> 
>     Here is a bug that was turned into a mailing list thread via cf_subsystem:
>     https://bugzilla.kernel.org/show_bug.cgi?id=217293
> 
> Like I said, bugbot is very young and probably full of bugs, so it will still
> see a lot of change and will likely explode a couple of times. The code behind
> it is here, woefully lacking any documentation as yet:
> https://git.kernel.org/pub/scm/utils/peebz/peebz.git/
> 
> At this time, I invite anyone with an account on bugzilla and "editbugs" group
> membership can start using bugbot in either direction and to report any bugs
> you find to the tools list.
> 
> Next features on my todo list are:
> 
> - documentation
> - tracking repositories and recording when bugs are mentioned in commits
> - whatever other feedback I receive
> 
> Best regards,
> Konstantin

Hello Konstantin,

I love everything about what you've done except I've got a minor feature 
request for the kernel bugzilla and this new workflow specifically.

Let's have a bot which polls open bug reports every 3-6 months with this 
question:

"Is this still an issue in the current kernel? Please leave a comment or 
this bug report will be closed due to inactivity".

By doing this we could make the bugzilla a whole more relevant and 
effective tool instead of having a ton of bug reports no one cares about 
or can even confirm.

I would only exclude the bug reports of type "Enhancement".

Best regards,
Artem
