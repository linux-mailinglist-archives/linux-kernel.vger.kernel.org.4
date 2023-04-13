Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E016E0D24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDMLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDMLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:55:19 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576AF26BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:55:18 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pxygk0S4qzMqLhW;
        Thu, 13 Apr 2023 13:55:14 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pxygg2l8cz1Gc;
        Thu, 13 Apr 2023 13:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1681386913;
        bh=jqTqbLCrRGnxDR07aD5HoJK63GcmJcSdigP4xTx/2Fc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Illq1+mQONPKTcwWmXU3tLup5z3aONbUPhNfTF1f8nXfQKgk00oTg0xXc9tbOdYXZ
         qWk6PAu6dYsXo1A7Dou1CrLVVwjbpkiBPQClv3UaumszXbF0iZ9Mb98DmJBqn6BLRE
         PJw6l+YUTJtp/Qdku9wckq+kqRzjmkhASNqPlIUI=
Message-ID: <33452cda-cc00-9ec6-6000-846c163e6f18@digikod.net>
Date:   Thu, 13 Apr 2023 13:55:10 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-6-casey@schaufler-ca.com>
 <80cd055f-3bd9-b89a-029b-7a63924b5bde@digikod.net>
 <CAHC9VhTs=cHcsi15qFsMqtGZxm2bkTb2AOsbrERePwUT3N0uJQ@mail.gmail.com>
 <CAHC9VhS+oJ_9yy_UMV3_-J_3rtcd-KxQXMxZHv3u0CynXkx7AQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAHC9VhS+oJ_9yy_UMV3_-J_3rtcd-KxQXMxZHv3u0CynXkx7AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2023 01:38, Paul Moore wrote:
> On Mon, Apr 10, 2023 at 7:37 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Mon, Apr 3, 2023 at 8:04 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>
>>> It looks like you missed my preview reviews on these patches.
>>
>> For reference, I believe this is Mickaël's review of the associated v6 patch:
>>
>> https://lore.kernel.org/linux-security-module/1ca41f67-ffa1-56c2-b4ee-f5deece95130@digikod.net/
> 
> My apologies, I hit send too soon ... Mickaël, if there are a specific
> points you feel have not been addressed, but should be, it would be
> helpful if you could list them in this thread.

No worries, Casey replied to the original thread: 
https://lore.kernel.org/linux-security-module/8819e4eb-1e99-bb38-6501-638677d3f4cf@schaufler-ca.com/
