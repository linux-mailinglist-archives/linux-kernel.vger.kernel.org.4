Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DEE6E347E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDOXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:19:57 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD752117;
        Sat, 15 Apr 2023 16:19:56 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PzTmn3MP4z9sTb;
        Sun, 16 Apr 2023 01:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrJ+EPvnJojqfdTKDr8OOWr7pb40KyJSYfVJVx+s4Fc=;
        b=giClA3x2pl+CUex8wN9on47vp6QxbEpUxF77pYnha9myhbHB9w/O0i0QNcRc9/dwtQ5y0M
        CU5JC63/3AeEhTJxPvkZY9EPH6D7omEwiTYWY+C66dJrlgyCe5gKi0YLmlIC/leXB1VDdg
        W5Pj+xtn7GsbBdJctM9E5X0/IJXCEsr4lfktrjVhthLp5/Ji3Q3LElUSDgYy+w3Na55Ixh
        BWXjzoyAtg+z/+VQ4E6pbtXJlaVqWW3wELgLtxCAB6ZR5o/JaGQMQFH7fGMG5XOZIhXVL8
        Ddc6ywHXyyLZwR7U1Iuu6yBhtewFPYVllJco2kMia4d3ze3hQ2oIAXgPW8ki6w==
Message-ID: <9548504f-7075-2705-7d70-320f90581f4c@mariushoch.de>
Date:   Sun, 16 Apr 2023 01:19:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] dt-bindings: iio: st-sensors: Add LSM303D
 accelerometer+magnetometer
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <20230413024013.450165-1-mail@mariushoch.de>
 <20230413024013.450165-7-mail@mariushoch.de>
 <501892f8-cad3-d1c7-7d24-6226eefe7edd@kernel.org>
 <20230415175104.3f8f4e09@jic23-huawei>
From:   Marius Hoch <mail@mariushoch.de>
In-Reply-To: <20230415175104.3f8f4e09@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4PzTmn3MP4z9sTb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 18:51, Jonathan Cameron wrote:
> On Thu, 13 Apr 2023 10:07:04 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>> On 13/04/2023 04:40, Marius Hoch wrote:
>>> Same as the lsm9ds0, except that the lsm303d doesn't
>>> feature a gyroscope.
>>>
>>> Signed-off-by: Marius Hoch <mail@mariushoch.de>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
> Just to avoid any confusion.  Point here is that the dt-binding
> maintainers and list should be cc'd on series that touch bindings.
>
> Jonathan
Thank you for your replies. Not sure what went wrong here initially, I 
probably only ran get_maintainer.pl on some of the patches.

For v3 I used a complete and up to date list of recipients.

Cheers,
Marius
>
>> Best regards,
>> Krzysztof
>>

