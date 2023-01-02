Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2A65B6E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjABTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjABTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:15:31 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA31BC24;
        Mon,  2 Jan 2023 11:15:27 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 25ECF133A;
        Mon,  2 Jan 2023 20:15:26 +0100 (CET)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=dkim20160331; t=
        1672686925; x=1674501326; bh=oUKRDZlQeYLkT+rj/KCqHrRmDSfWU3eAY7b
        pPlqMpfQ=; b=6UiVEvi/UWsl1x4mZXi35Yr3Xmrt/+FGL1nsPktKrb7OeV0k5jn
        T3EHIa7n2V3b0jN0vKgs17POyCZIlBuYM1xhf8NSLT+Z4LVQ7f8rzzox1HX7BTK5
        vGHoqdYRGWjMrP6lhzEwN4mlRB9Mq1NkvgVXiIOSE+G6q9o+ny4S+r/FKaVwIPDn
        6leQfLeGE9h202bJQWV7pPpE5wgQ5TE3HQ3pi+t8TfEHVTr+Y3ovYY3YmLxK/s92
        vPCwHuWFrdZKlPYur0nB3ILCnCJ+9gqTbwh3Dr/HGFxmJS+JIgukPbkgiROlUZ2B
        78JYqyay+4GVP7FojjQ+fLvHk2xxYdq4rILz3QR6noG0vhIV6FNY87iDt+iviXe9
        8k7CAnKKT5lxK6EVkiNh17TgQl+M09ixHdpZhmRr8r6utP+JRaLwaOtLCvdS1zfj
        LHAyExcka0xiJkElLo9dD7ANu2NlBwa5k9r/MNdqK2SAWHTgmbREWwuobqNmhABa
        Im988R9/ieAk3Pc6DAHxv2jthUrw8XYT0H4FciHqp0abq+4Im7w0nPansANz/Zm9
        /4tOiAm7DeuC1HSo8uL6FB5cHioujLjBONRHSbT1joajLmI6LMjwU/KZCm7MF1MM
        OcqyRECO2dsuLZMnUumLz28mhbJyAwBzJ7DeE6Bv9URzb0bc8SJwrBV8=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HIip7B9hp-sZ; Mon,  2 Jan 2023 20:15:25 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id E21059F9;
        Mon,  2 Jan 2023 20:15:24 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id AA6B42E04;
        Mon,  2 Jan 2023 20:15:23 +0100 (CET)
Date:   Mon, 2 Jan 2023 20:15:21 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add kernel-doc comment for u64_to_user_ptr
Message-ID: <20230102191521.zbcnkfh22bftutng@numero-86.vaga.pv.it>
References: <20230102184349.10399-1-federico.vaga@vaga.pv.it>
 <Y7MqhtPMYI4e50dY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y7MqhtPMYI4e50dY@smile.fi.intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 09:03:34PM +0200, Andy Shevchenko wrote:
>On Mon, Jan 02, 2023 at 07:43:49PM +0100, Federico Vaga wrote:
>> Add a kernel-doc comment in kernel.h to document the macro
>> `u64_to_user_ptr`.
>
>We refer functions as func(), so `u64_to_user_ptr` --> u64_to_user_ptr().
>
>> As of today, this macro is mentioned in the documentation in
>> 'ioctl.rst' and 'botching-up-ioctls.rst'
>
>Missing period at the end.
>
>...
>
>> +/**
>> + * u64_to_user_ptr - convert an unsigned 64bit number into a user pointer
>
>64-bit
>
>> + * @x: the number to convert
>
>Isn't 'number' is a bit misleading here?
>It decodes the user pointer, that is encoded into unsigned 64-bit value.
>Unfortunately I am not a native speaker, I can't propose anything better.
>It might be that the 'number' is quite good choice, dunno.

I agree about the macro's purpose. However, it does its job even if the 64-bit
value isn't a valid pointer (and this is what you will get). For this reason I
used a generic "number".

>> + */
>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

-- 
Federico Vaga
