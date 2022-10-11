Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8E15FB9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKRyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJKRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:53:59 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77640037
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:53:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 69C66604F1;
        Tue, 11 Oct 2022 19:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665510835; bh=51DdmvuAALYkdrgo3VfnoiAdxFmF/sc3TBmefjjxF38=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y3w/Hwq/Weal9Xsg6seGSsWraQOapxR5rnVli8ziCxWREFtqzH9PUG/tEkYf1hdj1
         WI4Ds8am3UeRA/x+CoRSZisYMvb+ER5OQVKtsngpDUHe3X0yEdisTYsv4l8EG59pl8
         zm9krkaXNkjxiZg9EzL3bAPOp0rjolpiLpxGlvnTrOe9h+ZwcdB/i4a2L7rNTq93AY
         LBsbO3SdRK7r+f7YkyGbuI9T82sUM5A6mZBWgZZO282+qyzVeO33iog7gAyQC1tLki
         WP+ON0oDqIXlldPO8oSf+woH+7UJC4/Cxsoaog7UNZEzdNf5NvmIuQ9Yw2OA2aplfC
         8w2HrWsvOAvZQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8hEZ3nQnrdQ9; Tue, 11 Oct 2022 19:53:53 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.196.246])
        by domac.alu.hr (Postfix) with ESMTPSA id AF824604EC;
        Tue, 11 Oct 2022 19:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665510833; bh=51DdmvuAALYkdrgo3VfnoiAdxFmF/sc3TBmefjjxF38=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kxUc+QkSwAmt7lm0m5MwrWE6KTqyW5//Sh0KSq5NH6DOrKwb8eu2r0UH7kPKxrX1P
         MdqV/Cvpl2G2CipuRobeuSKkVIlFnq/7N5cMJPRp8jV3Fz6ZiLYprVM4D/orP4R0+0
         Gi18IqmyOpc00W92mgbNApJWwpwvRU1+2X4fbPOCoI+hfc/pw42S8bW8T11f+g+XWW
         wLJO6fPQ38s405XWvE+WU/foj2jTVx04+sx7UwpVL57AA3jiRyuEhy1s5Jlfb6vxA5
         h1Ye9vs78TcBH5uwnxrrqLWN9QA2U6ZsR+YPEYkXIdnR3n5UsIegU5jozH9qKsNbuz
         efySWUhZ79+7A==
Message-ID: <4de7aabe-9c78-5f50-6662-3be99212a623@alu.unizg.hr>
Date:   Tue, 11 Oct 2022 19:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BUG reproduced: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Slade Watkins <srw@sladewatkins.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-kernel@vger.kernel.org,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
 <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
 <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr>
 <dd62210d-d095-f971-2b7b-0ec54fd189a9@leemhuis.info>
 <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr>
 <6ba15505-1c04-df2b-237f-b3060f26d2e6@leemhuis.info>
 <25cd0e21-ed8e-1836-b0ec-c052c2276cd8@alu.unizg.hr>
 <c40786ab-8b3b-9b64-683f-dac589c024df@alu.unizg.hr>
 <021de720-4a57-1a88-f456-fcaeaa3653de@leemhuis.info>
 <b5deaa2e-8867-1e0e-6090-422248310dc1@sladewatkins.net>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <b5deaa2e-8867-1e0e-6090-422248310dc1@sladewatkins.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 10. 2022. 00:45, Slade Watkins wrote:

> Hi all,
>
> On 10/9/22 at 2:45 AM, Thorsten Leemhuis wrote:
>> Yeah, then it's pretty certain that his is a regression. But it could be
>> caused by all sorts of things and I have no idea where to start. We thus
>> really could need a bisection to find the root of the problem. This will
>> be hard, as this crash only happens infrequently. Thing is: the Ubuntu
>> developers likely have a strong interest in this particular issue and
>> due to their knowledge of snap have way better chances to pin-point the
>> root case quickly. So submitting a bug report to them might be the best
>> way forward in this situation, even if the kernel is likely at fault here.
> Thorsten,
> Yeah, agreed. I haven't had time to bisect -- though it's on my list of
> things to do: I'm going to try and make time tomorrow. Wish we had more
> of an idea of what exactly was happening here.
>
> Mirsad,
> I'd be happy to help with a report to the Ubuntu folks. :-)

Hi, Slade,

Actually, I think I the project would benefit if you shared your 
experiences with
the Ubuntu folks. You know their English dialect.

This is not about the prestige, but about getting the bug fixed.

-mgt

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

